# @summary
# This class provides for the overriding of the default user, group, and basedir
#
# @api private
class github::params (
  $user         = 'git',
  $group        = 'git',
  $wwwroot      = '/var/www/html',
  $basedir      = '/home/git',
  $vhost_name   = 'git',
  $verbose      = false,
  $http_log_dir = '/var/log/apache2',
) { }
