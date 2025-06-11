let
  culsans = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMcc7hXixElOgv87LlY1LgCQ9oOT6Lj66wjCh1uRqpQt culsans@nzxt-desktop"; # culsans@nzxt-desktop
  lucas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICn8CAOpucqQvDkkEOGYYuSf8+mfrA4qkUK5u8v+WLEz lucas@ideapad-laptop"; # lucas@ideapad-laptop
  server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGDHcZoKu7q28H3hf4TzkONZxt+dky/HbMEHuC2uKr5P server@prodesk-server"; # server@ideapad-server

  nzxt-desktop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtnKVcdZNk3zp/XptQDtBDJig7sMEe5RLRhAO3Sx3sl root@nzxt-desktop";
  ideapad-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5hHZpHf/0xj4UK5091fBB9tDonfd6FDGkPr+HWlZBc root@ideapad-laptop";
  prodesk-server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOj6+nSYDABUsNqrSuc/IIhrShez0n5vPKAUTZMoINFl root@prodesk-server";
in {
  "culsans-user-password.age".publicKeys = [ nzxt-desktop culsans ];
  "lucas-user-password.age".publicKeys = [ ideapad-laptop lucas ];
  "server-user-password.age".publicKeys = [ prodesk-server server ];

  # Namecheap DDNS Password
  "namecheap-ddns-password.age".publicKeys = [ culsans lucas server prodesk-server ];
}
