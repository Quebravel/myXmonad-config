import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Hooks.EwmhDesktops
import XMonad.Layout.ThreeColumns
import System.IO

myLayout = tiled ||| Mirror tiled ||| Full ||| 			-- Layout
ThreeCol 1 (3/100) (1/2) ||| ThreeColMid 1 (3/100) (1/2)        -- Faz a janela
  where                                                         -- em tela cheia ficar
    tiled   = Tall 1 (3/100) (3/5)                              -- sem borda

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ defaultConfig
        { manageHook = manageDocks <+> manageHook defaultConfig
	, borderWidth        = 1
	, focusedBorderColor = "darkgray"
	, normalBorderColor  = "black"
	, startupHook = setWMName "LG3D"
	, layoutHook = avoidStruts $ smartBorders $ myLayout
	, logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , handleEventHook    = fullscreenEventHook
	, modMask = mod4Mask     -- Muda Mod para tecla Windows
        } `additionalKeys`
        [ 
          ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s") -- Win + Print = Atalho para tecla Print
        , ((0, xK_Print), spawn "scrot") -- Telca Print Screen
	, ((mod4Mask, xK_b), sendMessage ToggleStruts) -- Win + b = Esconde o xmobar atras das janelas
        , ((mod4Mask, xK_Return), spawn "xterm") -- Win + Enter = Segundo atalho para o terminal
	
-- Volume Controle
     , ((mod4Mask,               xK_F11   ), spawn "amixer set Master 5%-")
     , ((mod4Mask,               xK_F12   ), spawn "amixer set Master 5%+")
   
-- Brilho Controle
     , ((mod4Mask,               xK_F4    ), spawn "xbacklight -dec 10")
     , ((mod4Mask,               xK_F5    ), spawn "xbacklight -inc 10")
	]
