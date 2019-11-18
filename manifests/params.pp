# @summary Allows for overriding defaults used within the module
#
# Allows for overriding defaults used within the module
#
# @param user
#   The user on the mirror files will be owned by
#
# @param group
#   The group on the mirror files will be owned by
#
# @param wwwroot
#   The document root for Apache
#
# @param basedir
#   The path into which repositories will be cloned
#
# @param vhost_name
#   The name of the Apache vhost for the mirror
#
# @param verbose
#   Enable verbose output from the Sinatra webapp
#
# @param http_log_dir
#   Where to store the logs from Apache
#
# @example
#   class { "github::params":
#     user       => "gitmirror",
#     group      => "gitmirror",
#     basedir    => "/home/gitmirror",
#     wwwroot    => "/var/www/gitmirror",
#     vhost_name => "git",
#   }
#
class github::params (
  String[1] $user                    = 'git',
  String[1] $group                   = 'git',
  Stdlib::Absolutepath $wwwroot      = '/var/www/html',
  Stdlib::Absolutepath $basedir      = '/home/git',
  String[1] $vhost_name              = 'git',
  Boolean $verbose                   = false,
  Stdlib::Absolutepath $http_log_dir = '/var/log/apache2',
) { }
