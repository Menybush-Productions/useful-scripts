scoop bucket rm *
scoop bucket known | ForEach-Object { scoop bucket add $_ }
exit 0