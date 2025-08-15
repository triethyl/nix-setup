let
  nzxt-desktop = {
    system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKtnKVcdZNk3zp/XptQDtBDJig7sMEe5RLRhAO3Sx3sl root@nzxt-desktop";
    culsans = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMcc7hXixElOgv87LlY1LgCQ9oOT6Lj66wjCh1uRqpQt culsans@nzxt-desktop";
  };

  prodesk-server = {
    system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOj6+nSYDABUsNqrSuc/IIhrShez0n5vPKAUTZMoINFl root@prodesk-server";
    server = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGDHcZoKu7q28H3hf4TzkONZxt+dky/HbMEHuC2uKr5P server@prodesk-server";
  };

  thinkpad-laptop = {
    system = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINgCZw2RzdgXnW0lpgJQ2hBb+0V1fZoemJQtqDQbhFZk root@thinkpad-laptop";
    lucas = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIM/HLlWDshs3Fn4pbTrUeSdo/2/YWuBEMpQX15ZR0RNv lucas@thinkpad-laptop";
  };
in {
  "user-passwords/nzxt-desktop/culsans.age".publicKeys = [ nzxt-desktop.system nzxt-desktop.culsans ];
  "user-passwords/thinkpad-laptop/lucas.age".publicKeys = [ thinkpad-laptop.system thinkpad-laptop.lucas ];
  "user-passwords/prodesk-server/server.age".publicKeys = [ prodesk-server.system prodesk-server.server ];
}
