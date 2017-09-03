Config {  font			= "-*-Fixed-Bold-R-Normal-*-13-*-*-*-*-*-*-*"
        --, additionalFonts       = [ "xft:ProFont-11" ] --[ "xft:FontAwesome:pixelsize=13" ]
	, border 		= NoBorder
        , bgColor 		= "black"
        , fgColor 		= "grey"
        , alpha                 = 255
	, position 		= TopW L 97 -- TopSize L 97 17
	, lowerOnStart 		= True
   	, hideOnStart 		= False
   	, allDesktops		= True
   	, overrideRedirect 	= True
   	, pickBroadest 		= False
   	, persistent 		= True
	, commands = [ 
       			
	-- VOLUME BASH
	--  Run Com "sh" ["/home/jonatas/.xmonad/volume.sh"] "volume" 10
	-- VOLUME NATIVO
	  Run Volume "default" "Master" [ "--template" , "<status>"
	, "--"
        , "--on", "<fc=#00ccff>Vol: <volume></fc>%"
        , "--onc", "gray"
        , "--off", "<fc=#dc322f>Vol: MUDO</fc>"
        , "--offc", "#dc322f"
        ] 10
			  
	-- BATÉRIA
	, Run Battery        	[ "--template" , "Bat: <acstatus>"
        , "--Low"      	, "10"        -- units: %
        , "--High"     	, "80"        -- units: %
        , "--low"      	, "darkred"
        , "--normal"   	, "darkorange"
        , "--high"     	, "darkcyan"
        , "--" -- battery specific options
         -- discharging status
        , "-o"	, "<left>% (<timeleft>)"
        -- AC "on" status
        , "-O"	, "<fc=yellow>AC</fc>"
        -- charged status
        , "-i"	, "<fc=darkcyan>100</fc>%"
	] 50 
                        
	-- TEMPERATURA
        , Run CoreTemp       	[ "--template" , "<core0>°C <core1>°C"
        , "--Low"      	, "60"        -- units: °C
        , "--High"     	, "80"        -- units: °C
        , "--low"      	, "blue"
        , "--normal"   	, "darkorange"
        , "--high"     	, "red"
	] 50
                         
	-- INTERNET (dynamic interface resolution)
	, Run DynNetwork     	[ "--template" , "<rx>kB/s <tx>kB/s"
        , "--Low"      	, "30000"       -- units: B/s
        , "--High"     	, "60000"       -- units: B/s
        , "--low"      	, "blueviolet"
	, "--normal"   	, "orange"
        , "--high"     	, "red"
	] 10
			
	-- SINAL WIFI
        , Run Wireless "wlp2s0"
        [ "-a", "l"
        , "-x", "-"
        , "-t", "<fc=blueviolet><essid> <quality></fc>%"
        , "-L", "40"
        , "-H", "70"
        , "-l", "red" 
        , "-n", "blueviolet"
        , "-h", "blueviolet"
	] 10
			
	-- MEMÓRIA RAM
	, Run Memory		[ "--template" ,"Mem: <used>Mb"
        , "--Low"		, "500"        -- units: %
	, "--High"		, "3000"       -- units: %
        , "--low"		, "gray"
        , "--normal"   	, "darkorange"
        , "--high"     	, "red"
	] 10

	-- CPU
	, Run MultiCpu       	[ "--template" , "<total0>% <total1>% <total2>% <total3>%"
        , "--Low"      	, "50"         -- units: %
        , "--High"     	, "85"         -- units: %
        , "--low"      	, "yellow"
        , "--normal"   	, "orange"
        , "--high"     	, "red"
	] 10
						
	-- LOCKS
	, Run Locks
			
	-- DATA
	-- , Run Date "%A %d/%m/%y %H:%M:%S " "date" 10
        -- , Run Com "sh" ["/home/jonatas/.xmonad/date.sh"] "date" 10
	, Run Com "date" ["+%A %d/%m/%y %H:%M:%S"] "mydate" 10
			
	-- BARRA TITULO/TAGS
	, Run StdinReader
                        
	]
	, sepChar = "%"
	, alignSep = "}{"
	, template = " %StdinReader% | %multicpu% | %memory% | %battery% }{ <fc=hotpink>%locks%</fc> %dynnetwork% %wlp2s0wi% | %coretemp% | %default:Master% | <fc=#ee9a00>%mydate%</fc>  " }
	--, template = " <fn=1>%StdinReader% | %multicpu% | %memory% | %battery%</fn> }{ <fn=1><fc=hotpink>%locks%</fc> | %dynnetwork% %wlp2s0wi% | %coretemp% | %default:Master% | <fc=#ee9a00>%mydate%</fc></fn>  " }
