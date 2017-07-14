# Instalando xmonad no gentoo
```
$ sudo emerge -aq x11-wm/xmonad
$ sudo emerge -aq x11-wm/xmonad-contrib
$ sudo emerge -aq x11-misc/xmobar
```

# Instalando programas adicionais
```
$ sudo emerge -aq x11-misc/stalonetray
$ sudo emerge -aq app-misc/ranger
$ sudo emerge -aq media-sound/cmus
$ sudo emerge -aq media-gfx/feh
$ sudo emerge -aq media-video/mplayer
$ sudo emerge -aq x11-misc/dmenu
$ sudo emerge -aq x11-misc/nitrogen
$ sudo emerge -aq sys-fs/udiskie
$ sudo emerge -aq x11-misc/gpaste
$ sudo emerge -aq x11-terms/xfce4-terminal
$ sudo emerge -aq app-text/poppler
$ sudo emerge -aq app-arch/atool
$ sudo emerge -aq mediainfo
$ sudo emerge -aq highlight
$ sudo emerge -aq unrar
$ sudo emerge -aq odt2txt
$ sudo emerge -aq x11-apps/xbacklight
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

- Configure o arquivo `.xinitrc` para o carregar os programas `stalonetray`, `pnmixer` e `nm-applet`.

###### Exemplo
```
xbacklight -set 50 &
stalonetray &
pnmixer &
if [ -x /usr/bin/nm-applet ] ; then
   nm-applet --sm-disable &
nitrogen --restore

exec xmonad
```

# Problemas

## Xmobar fica atrás das janelas abertas

###### Configure o arquivo `xmonad.hs` na pasta `~/.xmonad`.

- Remova a linha:

 `, handleEventHook    = fullscreenEventHook`

- Adicione a linha:
```
, handleEventHook = mconcat                         	
                          [ docksEventHook			
                          , handleEventHook defaultConfig ]	
```

