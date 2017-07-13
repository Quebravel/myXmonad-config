import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Hooks.EwmhDesktops
import System.IO

myTerminal = "xfce4-terminal"
myLayout = tiled ||| Mirror tiled ||| Full                      -- Faz a janela
  where                                                         -- em tela cheia ficar
    tiled   = Tall 1 (3/100) (3/5)                              -- sem borda

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
	, borderWidth        = 1
	, focusedBorderColor = "darkgray"
	, normalBorderColor  = "black"
	, terminal = myTerminal
	, startupHook = setWMName "LG3D"
	, layoutHook = avoidStruts $ smartBorders $ myLayout
	, logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , handleEventHook    = fullscreenEventHook
	, modMask = mod4Mask     -- Rebind Mod to the Windows key
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock; xset dpms force off")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        
-- Volume Control
     , ((mod4Mask,               xK_F11   ), spawn "amixer set Master 5%-")
     , ((mod4Mask,               xK_F12   ), spawn "amixer set Master 5%+")
   
-- Brightness Control
     , ((mod4Mask,               xK_F4    ), spawn "xbacklight -dec 10")
     , ((mod4Mask,               xK_F5    ), spawn "xbacklight -inc 10")
	]
