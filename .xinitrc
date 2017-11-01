[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xbacklight -set 50 &
stalonetray &
#pnmixer &
#if [ -x /usr/bin/nm-applet ] ; then
#   nm-applet --sm-disable &
#fi   
feh --bg-scale ~/Imagens/c1da89958e00883166c79187929208d0.jpg &
numlockx &
xsetroot -cursor_name left_ptr &

exec xmonad
