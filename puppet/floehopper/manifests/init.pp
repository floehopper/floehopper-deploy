class floehopper {
  define user($user, $key, $key_type="ssh-rsa") {
    freerange::user_without_ssh_key { $name:
      user => $user,
      shell => "/bin/bash"
    }
    freerange::append_ssh_key_to_user { $name:
      user => $user,
      key => $key,
      key_type => $key_type
    }
  }

  class users {
    floehopper::user {"james@floehopper.org":
      user => "jamesmead",
      key => "AAAAB3NzaC1yc2EAAAABIwAAAQEA2sgFVWa22MUpTC3d7rn04qhzLRc5CwwuBLGp3dm3Yg5mFpq2dQLMlWZN/uK4SK1DC8fEDCbnaq4iGUk1VAUt6tN8UxrR9P5yrxSWTLLwanpNb/G6I4sRbzJaowhEchPLvoTWpege6hX6xGzHJRspODxT+Dhhrx8RIT5ZU19IlMEzSpYXNtBk5P+poj3AwC4gBwGhtC/B/YltM6Cxpi6Tp1Jb7vilRW08GU8EkmiBhs45QF2wWV2+OMinW7QIww7c6NdrbIDWw9+FBGOUHRlyPpXMCuz8B1zgplzoFLlO13r2fPDx2pB8WodMkZie28s1tfLB4gKIHVWbf9YYyLQeTQ=="
    }

    floehopper::user {"hannah.smithson@durham.ac.uk":
      user => "hannahsmithson",
      key => "AAAAB3NzaC1yc2EAAAABIwAAAQEAvSVPEv/UNEMrdZ1FAWX5mSu8kL6W21TX81T4+2fAC6cfSOyzFRSg1H99fpeQJtXQld6VmjUoj4jrkiXRhu+d4BFCLwaYFCqFAD0WsGxLYfKDlonhUSHDZhz5yR9qic42VIqtWKzO1KY+P8I3Y2eYYgQiDVZHGIHx6Am2ZIBOw1vigrnOrhi361p0EFlyLY1Y2Kkg/x94NAUI+74mRavUj1DmxEz4jBPmj7XAWVQVQG5c9KPNbV9BgPh1ZiQlrg3mhiD5W7SFEqaKywiRMjFrLpzXq5a2hg9QqHRjIK7Jh2+8EjGEbZKUWvByBLmk3zLAUa54Nmk0I5zJijGY9kfjAw=="
    }
  }

  define webby_app($deploy_to, $domain=$name, $vhost_additions=[]) {
    include floehopper::users
    include apache

    apache::host { $name:
      content => template("floehopper/static-vhost.erb"),
      ensure => enabled
    }
  }

  define rails_app($deploy_to, $domain=$name, $vhost_additions=[]) {
    include floehopper::users
    include xml
    include rack

    rack::host { $name:
      content => template("floehopper/rails-vhost.erb"),
      ensure => enabled
    }
  }

  define rails_db($environment, $password) {
    include floehopper::users
    include freerange
    include mysql::server

    mysql::server::db { "${name}_${environment}":
      user => $name,
      password => $password
    }
  }
}