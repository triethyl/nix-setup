{pkgs}:
pkgs.writers.writeNuBin "dfmodsync"
/*
nu
*/
''

  let workshop_dir = "~/.local/share/Steam/steamapps/workshop/content/975370"
  let df_dir = "~/.local/share/Steam/steamapps/common/Dwarf Fortress/mods"
  let df_installed_dir = "~/.local/share/Steam/steamapps/common/Dwarf Fortress/data/installed_mods"

  let workshop_dir = $workshop_dir | path expand
  let df_dir = $df_dir | path expand
  let df_installed_dir = $df_installed_dir | path expand

  glob $"($df_dir)/*" | each {rm -rf $in ; print $"deleted ($in | path basename)"}
  glob $"($df_installed_dir)/*" | each {rm -rf $in ; print $"deleted ($in | path basename)"}
  glob $"($workshop_dir)/*" | each {cp -r $in $df_dir; print $"copied ($in | path basename)"}

  print "Synced Mods!"

''
