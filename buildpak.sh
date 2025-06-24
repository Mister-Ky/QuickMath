
#!/bin/bash
RESPATH=$(grep '^-D resourcesPath=' build.hxml | cut -d'=' -f2)
[ -n "$1" ] && RESPATH="$1"
haxe -hl hxd.fmt.pak.Build.hl -lib heaps -main hxd.fmt.pak.Build
hl hxd.fmt.pak.Build.hl -res "$RESPATH" -out "$RESPATH"
