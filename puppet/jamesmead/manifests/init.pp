class jamesmead {
  define user($user, $key, $key_type="ssh-rsa") {
    freerange::user_without_ssh_key { $name:
      user => $user,
      shell => "/bin/zsh"
    }
    freerange::append_ssh_key_to_user { $name:
      user => $user,
      key => $key,
      key_type => $key_type
    }
  }

  class users {
    jamesmead::user {"james@floehopper.org":
      user => "jamesmead",
      key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA2sgFVWa22MUpTC3d7rn04qhzLRc5CwwuBLGp3dm3Yg5mFpq2dQLMlWZN/uK4SK1DC8fEDCbnaq4iGUk1VAUt6tN8UxrR9P5yrxSWTLLwanpNb/G6I4sRbzJaowhEchPLvoTWpege6hX6xGzHJRspODxT+Dhhrx8RIT5ZU19IlMEzSpYXNtBk5P+poj3AwC4gBwGhtC/B/YltM6Cxpi6Tp1Jb7vilRW08GU8EkmiBhs45QF2wWV2+OMinW7QIww7c6NdrbIDWw9+FBGOUHRlyPpXMCuz8B1zgplzoFLlO13r2fPDx2pB8WodMkZie28s1tfLB4gKIHVWbf9YYyLQeTQ=="
    }
  }

  define app($deploy_to, $domain=$name, $vhost_additions=[]) {
    include jamesmead::users
    include apache

    apache::host { $name:
      content => template("jamesmead/vhost.erb"),
      ensure => enabled
    }
  }

  define db($environment, $password) {
    include jamesmead::users
    include freerange
    include mysql::server

    mysql::server::db { "$name_$environment":
      user => $name,
      password => $password
    }
  }
}