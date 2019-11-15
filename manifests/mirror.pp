# Defined type that creates a github mirror for a given repo
#
# @summary Defined type that creates a github mirror for a given repo
#
# @param ensure
#   Can be either `present` or `absent`. Create the resource or ensure its absence. Defaults to `present`
#
# @param private
#   Whether or not the repo will be public or private. Deafults to `false`
#
# @param exportable
#   Can be `true` / `false`. Whether or not to add the file `git-daemon-export-ok` and allow exports
define github::mirror (
  Enum['present','absent'] $ensure = present,
  Boolean $private                 = false,
  Boolean $exportable              = false
) {
  include github::listener

  $user    = $github::params::user
  $group   = $github::params::group
  $basedir = $github::params::basedir

  $github_user   = regsubst($name, '^(.*?)/.*$', '\1')
  $repo_name     = regsubst($name, '^.*/(.*$)', '\1')
  $fragment_name = regsubst($name, '/', '_', 'G')

  # The location of the repository on the disk
  $repo_path = "${basedir}/${github_user}-${repo_name}.git"
  $repo_url  = $private ? {
    true  => "git@github.com:${github_user}/${repo_name}.git",
    false => "git://github.com/${github_user}/${repo_name}.git",
  }

  case $ensure {
    'present': {

      exec { "git clone --mirror ${repo_url} ${repo_path}":
        path      => [ '/bin', '/usr/bin', '/opt/local/bin' ],
        cwd       => $basedir,
        creates   => $repo_path,
        user      => $user,
        group     => $group,
        logoutput => on_failure,
      }

      if $exportable {
        file { "${repo_path}/git-daemon-export-ok": ensure => file }
      }

      concat::fragment { $fragment_name:
        content => "${name}\n",
        target  => "${basedir}/.github-allowed",
      }
    }
    'absent': {
      file { $repo_path:
        ensure  => absent,
        force   => true,
        recurse => true,
        backup  => false,
      }

      concat::fragment { $fragment_name:
        content => "${name}\n",
        target  => "${basedir}/.github-allowed",
      }
    }

    default: {
      fail("Invalid ensure value ${ensure} on github::mirror ${name}")
    }
  }
}
