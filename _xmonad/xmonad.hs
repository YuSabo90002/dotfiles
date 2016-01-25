-- Modules
import XMonad
import XMonad.Layout
import XMonad.Layout.IM
import XMonad.Layout.Named
import XMonad.Layout.Tabbed
import XMonad.Layout.Spacing           -- this makes smart space around windows
import XMonad.Util.EZConfig            -- removeKeys, additionalKeys
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Layout.Magnifier         -- this makes window bigger
import XMonad.Layout.ResizableTile     -- Resizable Horizontal border
import XMonad.Layout.ThreeColumns      -- for many windows
import Control.Monad (liftM2)          -- myManageHookShift
import qualified XMonad.StackSet as W  -- myManageHookShift
import System.IO                       -- for xmobar
import XMonad.Hooks.DynamicLog         -- for xmobar
import XMonad.Hooks.ManageDocks        -- avoid xmobar area
import XMonad.Layout.DragPane          -- see only two window
import XMonad.Layout.ToggleLayouts     -- Full window at any time
import XMonad.Layout.NoBorders         -- In Full mode, border is no use
import XMonad.Util.EZConfig
import XMonad.Hooks.SetWMName
import XMonad.Layout.SimplestFloat
import XMonad.Layout.TwoPane
import XMonad.Layout.PerWorkspace
import XMonad.Layout.NoBorders
import XMonad.Util.Run(spawnPipe)      -- spawnPipe, hPutStrLn
import XMonad.Util.Run
import XMonad.Hooks.Place
import XMonad.Actions.Volume


-- Color Setting
colorBlue      = "#90caf9"
colorGreen     = "#a5d6a7"
colorRed       = "#ef9a9a"
colorGray      = "#9e9e9e"
colorWhite     = "#ffffff"
colorGrayAlt   = "#eceff1"
colorNormalbg  = "#212121"
colorfg        = "#9fa8b1"

-- Main
main :: IO ()
main = do
    wsbar <- spawnPipe myWsBar    
    xmonad $ defaultConfig
        { terminal           = myTerminal
        , modMask            = myModMask
        , borderWidth        = myBorderWidth
        , normalBorderColor  = "#5a908e"
        , focusedBorderColor = "#99cb81"
        , startupHook = myStartupHook
            ,  manageHook = placeHook (fixed (0.5, 0.5)) <+>
                            myManageHookFloat <+>
                            manageDocks
        -- any time Full mode, avoid xmobar area
        , layoutHook = toggleLayouts (noBorders Full) $
                              avoidStruts $
                              myLayout 
        -- xmobar setting
            ,logHook             = myLogHook wsbar
        }
     -------------------------------------------------------------------- }}}
     -- Keymap: window operations                                         {{{
     ------------------------------------------------------------------------}}}

            `removeKeys`[
        -- Unused close window binding
        (myModMask .|. shiftMask, xK_c)
        , (myModMask .|. shiftMask, xK_Return)
            , (myModMask, xK_space)
        ]
        
        `additionalKeysP`[
        -- start software
        ("M4-g", spawn "gwenview")
        , ("M4-w", spawn "firefox")
     -- handle window size
        , ("M4--", sendMessage MagnifyLess)     -- smaller window
        , ("M4-M1--", sendMessage MagnifyMore)  -- bigger window
        , ("M4-M1-h", sendMessage MirrorShrink) -- border go down
        , ("M4-M1-l", sendMessage MirrorExpand) -- border go up
        , ("M4-f", sendMessage ToggleLayout)    -- toggle Full layout, any time
        , ("M4-<Return>",spawn "urxvt")
        , ("M4-c",kill)
        , ("M4-<Space>",windows W.shiftMaster)
        ]   

            `additionalKeys`[
            -- mute button
        ((0,0x1008FF12),toggleMute >> return ())

            -- volumeup button
        , ((0,0x1008FF13),raiseVolume 5 >> return ())

            -- volumedown button
        , ((0,0x1008FF11),lowerVolume 5 >> return ())
        ]

myTerminal     = "urxvt"   -- light meight terminal
myModMask      = mod4Mask  -- Super_L
myBorderWidth  = 2

-- Handle Window behaveior
myLayout = (spacing 8 $ ResizableTall 1 (3/100) (1/2) [])
             |||  (spacing 8 $ TwoPane (1/100) (4/7))
             |||  (spacing 3 $ ThreeColMid 1 (3/100) (1/2))
             |||  (spacing 8 $ ResizableTall 2 (1/100) (1/2) [])
-- Start up (at xmonad beggining), like "wallpaper" or so on
myStartupHook = do
        spawn "fcitx"
        setWMName "LG3D"
        spawn "feh --bg-fill /home/yuta/Picture/53278396_p0.jpg"

-- some window must created there

-- new window will created in Float mode

myManageHookFloat = composeAll
        [ className =? "Gimp"             --> doFloat]
--------------------------------------------------------------------------- }}}
-- myLogHook:         loghock settings                                      {{{
-------------------------------------------------------------------------------

myLogHook h = dynamicLogWithPP $ wsPP { ppOutput = hPutStrLn h }

--------------------------------------------------------------------------- }}}
-- myWsBar:           xmobar setting                                        {{{
-------------------------------------------------------------------------------

myWsBar = "xmobar $HOME/.xmonad/xmobarrc"

wsPP = xmobarPP { ppOrder           = \(ws:l:t:_)  -> [ws,t]
                , ppCurrent         = xmobarColor  colorGreen    colorNormalbg . wrap "[" "]"
                , ppUrgent          = xmobarColor  colorWhite    colorNormalbg . wrap " " " "
                , ppVisible         = xmobarColor  colorWhite    colorNormalbg . wrap " " " "
                , ppHidden          = xmobarColor  colorWhite    colorNormalbg . wrap " " " "
                , ppHiddenNoWindows = xmobarColor  colorfg       colorNormalbg . wrap " " " "
                , ppTitle           = xmobarColor  colorGreen    colorNormalbg
                , ppOutput          = putStrLn
                , ppWsSep           = ""
                , ppSep             = " : "
                }
