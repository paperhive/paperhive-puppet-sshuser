define sshuser (
  $ssh_key,
  $password_hash,
  $groups = []
) {
  user { $name:
    ensure     => present,
    managehome => true,
    shell      => '/bin/bash',
    password   => $password_hash,
    groups     => $groups,
  }

  file { "/home/${name}/.ssh":
    ensure  => directory,
    mode    => '0700',
    owner   => $name,
    require => User[$name]
  }

  ssh_authorized_key { "${name}_key":
    key     => $ssh_key,
    type    => 'ssh-rsa',
    user    => $name,
    require => File["/home/${name}/.ssh"],
  }
}
