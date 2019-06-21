xrdb -merge ~/.Xresources
[ -f ~/.cache/wal/colors.Xresources ] && xrdb -merge ~/.cache/wal/colors.Xresources
xrandr --dpi 166
exec i3
