import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.EwmhDesktops
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Layout.NoBorders
import XMonad.Layout.ThreeColumns
import XMonad.Actions.FloatKeys
import XMonad.Actions.NoBorders
import System.IO

myManageHook = composeAll
    	[ className =? "Gimp"        --> doFloat
    	, className =? "Steam"       --> doFloat
    	]

myLayout = tiled ||| Mirror tiled ||| Full ||| ThreeCol 1 (3/100) (1/2)
  where                                                         
    tiled   = Tall 1 (3/100) (3/5)                              

myTerminal = "xterm"

main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"

    xmonad $ defaultConfig
        { manageHook = manageDocks <+> myManageHook <+> manageHook defaultConfig
	, borderWidth = 1
	, focusedBorderColor = "darkgray"
	, normalBorderColor  = "black"
	, startupHook = setWMName "LG3D"
	, terminal = myTerminal
	, layoutHook = avoidStruts $ smartBorders $ myLayout
	, logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , handleEventHook = fullscreenEventHook		-- Ativar no Gentoo | Desativar no Arch
--      , handleEventHook = mconcat                         	-- Ativar	| Desativar
--                          [ docksEventHook			-- no		| no
--                          , handleEventHook defaultConfig ]	-- Arch 	| Gentoo
	, modMask = mod4Mask -- Muda tecla Alt pela tecla Windows
        } `additionalKeys`
        [ 
          ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s -e 'mv $f ~/Imagens/ 2>/dev/null'") -- Win + Print = Atalho para tecla Print
        , ((0, xK_Print), spawn "scrot -e 'mv $f ~/Imagens/ 2>/dev/null'") -- Telca Print Screen
	, ((mod4Mask, xK_b), sendMessage ToggleStruts) -- Win + b = Esconde o xmobar atras das janelas
        , ((mod4Mask, xK_Return), spawn myTerminal) -- Win + Enter = Segundo atalho para o terminal
	, ((mod4Mask, xK_c), kill) -- Fechar janela focada
	, ((mod4Mask, xK_r), spawn "xterm -e ranger") -- Atalho Ranger Gerenciador de arquivos
	, ((mod4Mask .|. shiftMask, xK_b), spawn "xterm -e vim ~/.xmonad/xmobar.hs") -- Editar Xmobar
	, ((mod4Mask .|. shiftMask, xK_x), spawn "xterm -e vim ~/.xmonad/xmonad.hs") -- Editar Xmonad
	, ((mod4Mask, xK_o), spawn "qutebrowser") -- Atalho para o navegador
	, ((mod4Mask .|. controlMask, xK_b), withFocused toggleBorder) -- Retira/Adiciona borda na janela
	
	-- Controle Janela
	, ((mod4Mask, xK_Left), withFocused (keysMoveWindow (-20,0)))
        , ((mod4Mask, xK_Right), withFocused (keysMoveWindow (20,0)))
        , ((mod4Mask, xK_Up), withFocused (keysMoveWindow (0,-20)))
        , ((mod4Mask, xK_Down), withFocused (keysMoveWindow (0,20)))
	
	, ((mod1Mask .|. shiftMask , xK_Left), withFocused (keysResizeWindow (20,0) (1,0)))
        , ((mod1Mask .|. shiftMask , xK_Right), withFocused (keysResizeWindow (-20,0) (1,0)))
        , ((mod1Mask .|. shiftMask , xK_Up), withFocused (keysResizeWindow (0,20) (0,1))) 
        , ((mod1Mask .|. shiftMask , xK_Down), withFocused (keysResizeWindow (0,-20) (0,1)))
	
        , ((mod1Mask .|. controlMask , xK_Left), withFocused (keysResizeWindow (-20,0) (0,0)))
        , ((mod1Mask .|. controlMask , xK_Right), withFocused (keysResizeWindow (20,0) (0,0)))
        , ((mod1Mask .|. controlMask , xK_Up), withFocused (keysResizeWindow (0,-20) (0,0)))
        , ((mod1Mask .|. controlMask , xK_Down), withFocused (keysResizeWindow (0,20) (0,0)))
	
	-- Volume Controle
	, ((mod4Mask, xK_F11), spawn "amixer set Master 5%-")
	, ((mod4Mask, xK_F12), spawn "amixer set Master 5%+")
	, ((mod4Mask, xK_F10), spawn "amixer set Master toggle")
	
	-- Brilho Controle
	, ((mod4Mask, xK_F4), spawn "xbacklight -dec 10")
	, ((mod4Mask, xK_F5), spawn "xbacklight -inc 10")
	]
	
