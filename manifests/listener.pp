# Deploys the rack app that responds to the github post-receive hook
#
# @summary
#   deploys the rack app that responds to the github post-receive hook
#
class github::listener {
  include apache
  include apache::mod::passenger
  include github::params

  $user       = $github::params::user
  $group      = $github::params::group
  $basedir    = $github::params::basedir
  $wwwroot    = $github::params::wwwroot
  $vhost_name = $github::params::vhost_name
  $verbose    = $github::params::verbose
  $log_dir    = $github::params::http_log_dir

  file {
    "${wwwroot}/config.ru":
      ensure  => present,
      content => template('github/config.ru.erb'),
      owner   => $user,
      group   => $group,
      mode    => '0644';
    "${wwwroot}/listener.rb":
      ensure => present,
      source => 'puppet:///modules/github/listener.rb',
      owner  => $user,
      group  => $group,
      mode   => '0644';
    "${wwwroot}/public":
      ensure => directory,
      owner  => $user,
      group  => $group,
      mode   => '0755';
    "${wwwroot}/tmp":
      ensure => directory,
      owner  => $user,
      group  => $group,
      mode   => '0755';
  }

  exec { "touch ${wwwroot}/tmp/restart.txt":
    path        => [ '/usr/bin', '/bin' ],
    user        => $user,
    group       => $group,
    refreshonly => true,
    subscribe   => File[
      "${wwwroot}/config.ru",
      "${wwwroot}/listener.rb"
    ],
  }

  concat { "${basedir}/.github-allowed":
    owner => $user,
    group => $group,
    mode  => '0600',
  }

  package { 'sinatra':
    ensure   => present,
    provider => 'gem',
  }

  apache::vhost { $vhost_name:
    port        => '4567',
    priority    => '20',
    docroot     => "${wwwroot}/public",
    ssl         => false,
    directories => [
      {
        'path'    => "${wwwroot}/public",
        'allow'   => 'from all',
        'options' => '-MultiViews',
      },
    ],
    log_level   => 'warn',
    logroot     => $log_dir,
    access_log  => true,
  }
}
