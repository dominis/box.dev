node 'box.dev' {
    class { '::ntp':
      servers => ['time.kfki.hu'],
    }

    class { '::mysql::server':
      root_password           => 'asdfgh',
      remove_default_accounts => true,
    }

    service { 'firewalld':
      ensure => stopped,
      enable => false,
    }

    class { 'redis':
      conf_port => '6379',
      conf_bind => '0.0.0.0',
    }

    class { 'python':
      version    => 'system',
      pip        => true,
      dev        => true,
      virtualenv => true,
    }

    class { 'elasticsearch':
      autoupgrade => true
    }
}
