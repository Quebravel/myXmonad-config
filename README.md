![2017-07-24-215407_1366x768_scrot](https://user-images.githubusercontent.com/15035135/28550940-fcda0d16-70ba-11e7-9111-c7dd9f8189e9.png)

# Instalando xmonad no gentoo/arch
```
$ sudo emerge -aq x11-wm/xmonad                          $ sudo pacman -S community/xmonad
$ sudo emerge -aq x11-wm/xmonad-contrib                  $ sudo pacman -S community/xmonad-contrib
$ sudo emerge -aq x11-misc/xmobar                        $ sudo pacman -S community/xmobar
$ sudo emerge -aq x11-misc/stalonetray                   $ sudo pacman -S community/stalonetray
```

# Instalando programas adicionais
```
$ sudo emerge -aq app-misc/ranger                        $ sudo pacman -S community/ranger
$ sudo emerge -aq app-text/highlight                     $ sudo pacman -S community/highlight
$ sudo emerge -aq app-text/odt2txt                       $ sudo pacman -S community/odt2txt
$ sudo emerge -aq app-text/poppler                       $ sudo pacman -S extra/poppler
$ sudo emerge -aq app-arch/unrar                         $ sudo pacman -S extra/unrar
$ sudo emerge -aq app-arch/rar                           $ yaourt -S aur/rar
$ sudo emerge -aq app-arch/unzip                         $ sudo pacman -S extra/unzip
$ sudo emerge -aq app-arch/zip                           $ sudo pacman -S extra/zip
$ sudo emerge -aq app-arch/p7zip                         $ sudo pacman -S extra/p7zip
$ sudo emerge -aq app-arch/atool                         $ sudo pacman -S community/atool
$ sudo emerge -aq www-client/w3m                         $ sudo pacman -S extra/w3m
$ sudo emerge -aq www-client/qutebrowser                 $ sudo pacman -S community/qutebrowser
$ sudo emerge -aq media-sound/moc                        $ sudo pacman -S extra/moc
$ sudo emerge -aq media-gfx/feh                          $ sudo pacman -S extra/feh
$ sudo emerge -aq media-video/mplayer                    $ sudo pacman -S extra/mplayer
$ sudo emerge -aq x11-misc/dmenu                         $ sudo pacman -S community/dmenu
$ sudo emerge -aq x11-misc/numlockx                      $ sudo pacman -S community/numlockx
$ sudo emerge -aq x11-misc/gpaste                        $ sudo pacman -S extra/gpaste
$ sudo emerge -aq x11-terms/xterm                        $ sudo pacman -S extra/xterm
$ sudo emerge -aq x11-apps/xbacklight                    $ sudo pacman -S extra/xorg-xbacklight
$ sudo emerge -aq media-sound/pnmixer                    $ yaourt -S aur/pnmixer
$ sudo emerge -aq x11-apps/xfd                           $ sudo pacman -S extra/xorg-xfd
```
# Copiando/Colando arquivos para a configuração do xmonad

- Cole o arquivo de configuração do Xmobar `.xmobarrc` na pasta principal do usuário.

> `~/.xmobarrc`

- Cole o arquivo de configuração do Stalonetray `.stalonetrayrc` na pasta principal do usuário.

> `~/.stalonetrayrc`

- Cole o arquivo de configuração e execução do `volume.sh` volume dentro da pasta `.xmonad`.

> `~/.xmonad/volume.sh`

- Cole o arquivo principal de configuração do xmonad `xmonad.hs` dentro da pasta `.xmonad`.

> `~/.xmonad/xmonad.hs`

# Recompile o xmonad
Recompile o xmonad com o comando:

> `xmonad --recompile`

###### OBS 
Quando for recompilar com xmonad já iniciado não carregue os programas adicionais com o `.xinitrc`.

# Iniciando com startx

- Configure o arquivo `.xinitrc` para o carregar os programas `stalonetray`, `pnmixer` e `nm-applet`.

###### Exemplo
```
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xbacklight -set 50 &
stalonetray &
pnmixer &
if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
fi   
feh --bg-scale ~/Wallpapers/papeldeParede-1366x768.jpg &
numlockx &

exec xmonad
```

# Problemas

## Xmobar fica atrás das janelas abertas

###### Configure o arquivo `xmonad.hs` na pasta `~/.xmonad`.

- Remova a linha:
```
 , handleEventHook    = fullscreenEventHook`
```
- Adicione a linha:
```
, handleEventHook = mconcat                         	
                          [ docksEventHook			
                          , handleEventHook defaultConfig ]	
```

