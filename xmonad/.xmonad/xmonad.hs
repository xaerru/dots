  -- Base
import           System.Directory
import           System.Exit                         (exitSuccess)
import           System.IO                           (hPutStrLn)
import           XMonad
import qualified XMonad.StackSet                     as W

    -- Actions
import           XMonad.Actions.CopyWindow           (kill1)
import           XMonad.Actions.CycleWS              (Direction1D (..),
                                                      WSType (..), moveTo,
                                                      nextScreen, prevScreen,
                                                      shiftTo, toggleWS)
import           XMonad.Actions.GroupNavigation
import           XMonad.Actions.MouseResize
import           XMonad.Actions.PerWorkspaceKeys
import           XMonad.Actions.Promote
import           XMonad.Actions.RotSlaves            (rotAllDown, rotSlavesDown)
import qualified XMonad.Actions.Search               as S
import           XMonad.Actions.WindowGo             (runOrRaise)
import           XMonad.Actions.WithAll              (killAll, sinkAll)

    -- Data
import           Data.Char                           (isSpace, toUpper)
import qualified Data.Map                            as M
import           Data.Maybe                          (fromJust, isJust)
import           Data.Monoid
import           Data.Tree

    -- Hooks
import           XMonad.Hooks.DynamicLog             (PP (..), dynamicLogWithPP,
                                                      shorten, wrap,
                                                      xmobarColor, xmobarPP)
import           XMonad.Hooks.DynamicProperty
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks            (ToggleStruts (..),
                                                      avoidStruts,
                                                      docksEventHook,
                                                      manageDocks)
import           XMonad.Hooks.ManageHelpers          (doFullFloat, isFullscreen)
import           XMonad.Hooks.ServerMode
import           XMonad.Hooks.SetWMName
import           XMonad.Hooks.WorkspaceHistory

    -- Layouts
import           XMonad.Layout.Accordion
import           XMonad.Layout.GridVariants          (Grid (Grid))
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.SimplestFloat
import           XMonad.Layout.Spiral
import           XMonad.Layout.Tabbed
import           XMonad.Layout.ThreeColumns

    -- Layouts modifiers
import           XMonad.Layout.LayoutModifier
import           XMonad.Layout.LimitWindows          (decreaseLimit,
                                                      increaseLimit,
                                                      limitWindows)
import           XMonad.Layout.Magnifier
import           XMonad.Layout.MultiToggle           (EOT (EOT), mkToggle,
                                                      single, (??))
import qualified XMonad.Layout.MultiToggle           as MT (Toggle (..))
import           XMonad.Layout.MultiToggle.Instances (StdTransformers (MIRROR, NBFULL, NOBORDERS))
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Renamed
import           XMonad.Layout.Simplest
import           XMonad.Layout.Spacing
import           XMonad.Layout.SubLayouts
import qualified XMonad.Layout.ToggleLayouts         as T (ToggleLayout (Toggle),
                                                           toggleLayouts)
import           XMonad.Layout.WindowArranger        (WindowArrangerMsg (..),
                                                      windowArrange)

   -- Utilities
import           XMonad.Util.Dmenu
import           XMonad.Util.EZConfig                (additionalKeys,
                                                      additionalKeysP)
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.Run                     (runProcessWithInput,
                                                      safeSpawn, spawnPipe)
import           XMonad.Util.SpawnOnce

myFont :: String
myFont = "xft:Jetbrains Mono Nerd Font Mono:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask        -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"    -- Sets default terminal

myBrowser :: String
myBrowser = "qutebrowser "  -- Sets qutebrowser as browser

myEmacs :: String
myEmacs = "emacsclient -c -a 'emacs' "  -- Makes emacs keybindings easier to type

myEditor :: String
myEditor = myTerminal ++ " -e nvim "    -- Sets nvim as editor

myBorderWidth :: Dimension
myBorderWidth = 2           -- Sets border width for windows

myNormColor :: String
myNormColor   = "#2E3440"   -- Border color of normal windows

myFocusColor :: String
myFocusColor  = "#5E81AC"   -- Border color of focused windows

windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

myStartupHook :: X ()
myStartupHook = do
    spawnOnce "picom --experimental-backend -b&"
    spawnOnce "dunst"
    spawnOnce "$HOME/.xmonad/scripts/trayer.sh"
    --spawnOnce " hsetroot -solid '#2E3440'"
    spawnOnce "~/.fehbg"
    spawnOnce "xcape -f -t 150"
    spawnOnce "discord"
    spawnOnce "slack"
    spawnOnce "element-desktop"
    setWMName "LG3D"

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "calculator" spawnCalc findCalc manageCalc
                ]
  where
    spawnTerm  = myTerminal ++ " -t scratchpad -e tmux attach -t dev"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
               where
                 h = 0.9
                 w = 0.9
                 t = 0.95 -h
                 l = 0.95 -w
    spawnCalc  = "qalculate-gtk"
    findCalc   = className =? "Qalculate-gtk"
    manageCalc = customFloating $ W.RationalRect l t w h
               where
                 h = 0.5
                 w = 0.4
                 t = 0.75 -h
                 l = 0.70 -w

--Makes setting the spacingRaw simpler to write. The spacingRaw module adds a configurable amount of space around windows.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw False (Border i i i i) True (Border i i i i) True

-- Below is a variation of the above except no borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing' :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing' i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Defining a bunch of layouts, many that I don't use.
-- limitWindows n sets maximum number of windows displayed for layout.
-- mySpacing n sets the gap size around the windows.
tall     = renamed [Replace "tall"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 2
           $ ResizableTall 1 (3/100) (1/2) []
magnify  = renamed [Replace "magnify"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ magnifier
           $ limitWindows 12
           $ mySpacing 8
           $ ResizableTall 1 (3/100) (1/2) []
monocle  = renamed [Replace "monocle"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 20 Full
floats   = renamed [Replace "floats"]
           $ smartBorders
           $ limitWindows 20 simplestFloat
grid     = renamed [Replace "grid"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 12
           $ mySpacing 8
           $ mkToggle (single MIRROR)
           $ Grid (16/10)
spirals  = renamed [Replace "spirals"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ mySpacing' 8
           $ spiral (6/7)
threeCol = renamed [Replace "threeCol"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           $ ThreeCol 1 (3/100) (1/2)
threeRow = renamed [Replace "threeRow"]
           $ smartBorders
           $ addTabs shrinkText myTabTheme
           $ subLayout [] (smartBorders Simplest)
           $ limitWindows 7
           -- Mirror takes a layout and rotates it by 90 degrees.
           -- So we are applying Mirror to the ThreeCol layout.
           $ Mirror
           $ ThreeCol 1 (3/100) (1/2)
tabs     = renamed [Replace "tabs"]
           -- I cannot add spacing to this layout because it will
           -- add spacing between window and tabs which looks bad.
           $ tabbed shrinkText myTabTheme
tallAccordion  = renamed [Replace "tallAccordion"]
             Accordion
wideAccordion  = renamed [Replace "wideAccordion"]
           $ Mirror Accordion

-- setting colors for tabs layout and tabs sublayout.
myTabTheme = def { fontName            = myFont
                 , activeColor         = "#88C0D0"
                 , inactiveColor       = "#2E3440"
                 , activeBorderColor   = "#88C0D0"
                 , inactiveBorderColor = "#2E3440"
                 , activeTextColor     = "#2E3440"
                 , inactiveTextColor   = "#d0d0d0"
                 }

-- The layout hook
myLayoutHook = smartBorders $ avoidStruts $ mouseResize $ windowArrange $ T.toggleLayouts floats
               $ mkToggle (NBFULL ?? NOBORDERS ?? EOT) myDefaultLayout
             where
               myDefaultLayout =     withBorder myBorderWidth tall
                                 ||| magnify
                                 ||| noBorders monocle
                                 ||| floats
                                 ||| noBorders tabs
                                 ||| grid
                                 ||| spirals
                                 ||| threeCol
                                 ||| threeRow
                                 ||| tallAccordion
                                 ||| wideAccordion

-- myWorkspaces = [" 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 "]
--myWorkspaces = map show [1..9]
myWorkspaces = ["dev", "web", "test", "mtrx", "dsc", "slck", "mus", "sch", "virt"]
myWorkspaceIndices = M.fromList $ zip myWorkspaces [1..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+"++show i++">"++ws++"</action>"
    where i = fromJust $ M.lookup ws myWorkspaceIndices

myHandleEventHook = dynamicPropertyChange "WM_CLASS" $ composeAll
    [
     className =? "Spotify"            --> doShift (myWorkspaces !! 5)
    ]

myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
     -- 'doFloat' forces a window to float.  Useful for dialog boxes and such.
     -- using 'doShift ( myWorkspaces !! 7)' sends program to workspace 8!
     -- I'm doing it this way because otherwise I would have to write out the full
     -- name of my workspaces and the names would be very long if using clickable workspaces.
     [ className =? "confirm"           --> doFloat
     , className =? "file_progress"     --> doFloat
     , className =? "dialog"            --> doFloat
     , className =? "download"          --> doFloat
     , className =? "error"             --> doFloat
     , className =? "Gimp"              --> doFloat
     , className =? "notification"      --> doFloat
     , className =? "pinentry-gtk-2"    --> doFloat
     , className =? "splash"            --> doFloat
     , className =? "toolbar"           --> doFloat
     , className =? "virt-manager"      --> doFloat
     , isFullscreen                     --> doFullFloat
     , className =? "Evince"            --> doShift ( myWorkspaces !! 3 )
     , className =? "Element"           --> doShift ( myWorkspaces !! 3 )
     , className =? "discord"           --> doShift ( myWorkspaces !! 4 )
     , className =? "Slack"             --> doShift ( myWorkspaces !! 5 )
     , className =? "Audacious"         --> doShift ( myWorkspaces !! 6 )
     , className =? "zoom"              --> doShift ( myWorkspaces !! 7 )
     , className =? "Virt-manager"      --> doShift ( myWorkspaces !! 8 )
     , className =? "mpv"               --> doFullFloat
     ] <+> namedScratchpadManageHook myScratchPads

myKeys :: [(String, X ())]
myKeys =
    -- Xmonad
        [ ("M-M1-c", spawn "xmonad --recompile")  -- Recompiles xmonad
        , ("M-M1-r", spawn "xmonad --restart")    -- Restarts xmonad
        , ("M-M1-e", io exitSuccess)              -- Quits xmonad
        , ("M-S-l", spawn "$HOME/.xmonad/scripts/switchlayout.sh")

    -- Run Prompt
        , ("M-S-<Return>", spawn "dmenu_run -p 'Run:' -h 24") -- Dmenu

    -- Other Dmenu Prompts
    -- In Xmonad and many tiling window managers, M-p is the default keybinding to
    -- launch dmenu_run, so I've decided to use M-p plus KEY for these dmenu scripts.
        , ("M-p c", spawn "dmcolors")  -- pick color from our scheme
        , ("M-p e", spawn "dmconf")   -- edit config files
        , ("M-p k", spawn "dmkill")   -- kill processes
        , ("M-p m", spawn "dman")     -- manpages
        , ("M-p o", spawn "dmqute")   -- qutebrowser bookmarks/history
        , ("M-p q", spawn "dmlogout") -- logout menu
        , ("M-p r", spawn "dmred")    -- reddio (a reddit viewer)
        , ("M-p s", spawn "dmsearch") -- search various search engines
        , ("M-p p", spawn "dm-pacman")-- pacman
        , ("M-p y", spawn "dmyoutube")-- youtube

    -- Useful programs to have a keybinding for launch
        , ("M-<Return>", spawn "$HOME/.xmonad/scripts/terminal.sh")
        , ("M-\\", spawn myTerminal)
        , ("M-i", spawn myBrowser)
        , ("M-b", spawn "brave")
        , ("M-S-h", spawn (myTerminal ++ " -e htop"))
        , ("M-S-x", spawn "loginctl suspend")
        , ("M-a", spawn "xset r rate 300 50")
        , ("M-c", spawn "colorpicker --short --one-shot --preview | xclip -selection clipboard")

    -- Kill windows
        , ("M-q", kill1)     -- Kill the currently focused client
        , ("M-S-q", killAll)   -- Kill all windows on current workspace

    -- Workspaces
        , ("M-S-<KP_Add>", shiftTo Next nonNSP >> moveTo Next nonNSP)       -- Shifts focused window to next ws
        , ("M-S-<KP_Subtract>", shiftTo Prev nonNSP >> moveTo Prev nonNSP)  -- Shifts focused window to prev ws
        , ("M-u", nextMatch History (return True))-- Move to recent workspace

    -- Floating windows
        , ("M-f", sendMessage (T.Toggle "floats")) -- Toggles my 'floats' layout
        , ("M-t", withFocused $ windows . W.sink)  -- Push floating window back to tile
        , ("M-S-t", sinkAll)                       -- Push ALL floating windows to tile

    -- Increase/decrease spacing (gaps)
        , ("C-M1-j", decWindowSpacing 4)         -- Decrease window spacing
        , ("C-M1-k", incWindowSpacing 4)         -- Increase window spacing
        , ("C-M1-h", decScreenSpacing 4)         -- Decrease screen spacing
        , ("C-M1-l", incScreenSpacing 4)         -- Increase screen spacing

    -- Windows navigation
        , ("M-m", windows W.focusMaster)  -- Move focus to the master window
        , ("M-j", windows W.focusDown)    -- Move focus to the next window
        , ("M-k", windows W.focusUp)      -- Move focus to the prev window
        , ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)   -- Swap focused window with next window
        , ("M-S-k", windows W.swapUp)     -- Swap focused window with prev window
        , ("M-<Backspace>", promote)      -- Moves focused window to master, others maintain order
        , ("M-S-<Tab>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
        , ("M-C-<Tab>", rotAllDown)       -- Rotate all the windows in the current stack

    -- Layouts
        , ("M-<Tab>", sendMessage NextLayout)           -- Switch to next layout
        , ("M-<Space>", sendMessage (MT.Toggle NBFULL) >> sendMessage ToggleStruts) -- Toggles noborder/full

    -- Increase/decrease windows in the master pane or the stack
        , ("M-S-<Up>", sendMessage (IncMasterN 1))      -- Increase # of clients master pane
        , ("M-S-<Down>", sendMessage (IncMasterN (-1))) -- Decrease # of clients master pane
        , ("M-C-<Up>", increaseLimit)                   -- Increase # of windows
        , ("M-C-<Down>", decreaseLimit)                 -- Decrease # of windows

    -- Window resizing
        , ("M-h", sendMessage Shrink)                   -- Shrink horiz window width
        , ("M-l", sendMessage Expand)                   -- Expand horiz window width
        , ("M-M1-j", sendMessage MirrorShrink)          -- Shrink vert window width
        , ("M-M1-k", sendMessage MirrorExpand)          -- Expand vert window width

    -- Sublayouts
    -- This is used to push windows to tabbed sublayouts, or pull them out of it.
        , ("M-C-h", sendMessage $ pullGroup L)
        , ("M-C-l", sendMessage $ pullGroup R)
        , ("M-C-k", sendMessage $ pullGroup U)
        , ("M-C-j", sendMessage $ pullGroup D)
        , ("M-C-m", withFocused (sendMessage . MergeAll))
        , ("M-C-/", withFocused (sendMessage . UnMergeAll))
        , ("M-C-.", onGroup W.focusUp')    -- Switch focus to next tab
        , ("M-C-,", onGroup W.focusDown')  -- Switch focus to prev tab

    -- Scratchpads
    -- Toggle show/hide these programs.  They run on a hidden workspace.
    -- When you toggle them to show, it brings them to your current workspace.
    -- Toggle them to hide and it sends them back to hidden workspace (NSP).
        , ("C-s t", namedScratchpadAction myScratchPads "terminal")
        , ("C-s c", namedScratchpadAction myScratchPads "calculator")

    -- Multimedia Keys
        , ("<XF86AudioPlay>", spawn "playerctl play-pause")
        , ("M-s p", spawn "playerctl play-pause")
        , ("<XF86AudioPrev>", spawn "playerctl previous")
        , ("M-s b", spawn "playerctl previous")
        , ("<XF86AudioNext>", spawn "playerctl next")
        , ("M-s n", spawn "playerctl next")
        , ("<XF86AudioMute>", spawn "pactl set-sink-mute 0 toggle")
        , ("M-s m", spawn "pactl set-sink-mute 0 toggle")
        , ("<XF86AudioLowerVolume>", spawn "pactl -- set-sink-volume 0 -5%")
        , ("M-s d", spawn "pactl -- set-sink-volume 0 -5%")
        , ("<XF86AudioRaiseVolume>", spawn "pactl -- set-sink-volume 0 +5%")
        , ("M-s u", spawn "pactl -- set-sink-volume 0 +5%")
        , ("<XF86Calculator>", runOrRaise "qalculate-gtk" (resource =? "qalculate-gtk"))
        , ("<Print>", spawn "maim -su | xclip -selection clipboard -t image/png")
        , ("C-<Print>", spawn "maim -u -i $(xdotool getactivewindow) | xclip -selection clipboard -t image/png")
        , ("C-S-<Print>", spawn "maim -u | xclip -selection clipboard -t image/png")
        ]
    -- The following lines are needed for named scratchpads.
          where nonNSP          = WSIs (return (\ws -> W.tag ws /= "NSP"))
                nonEmptyNonNSP  = WSIs (return (\ws -> isJust (W.stack ws) && W.tag ws /= "NSP"))

workspaceBackAndForth = [((myModMask , k), bindOn [ ("", windows $ W.greedyView n), (n , toggleWS)]) |(n, k) <- zip myWorkspaces([xK_1..xK_9]++[xK_0])]

defaults xmproc0 = def
        { manageHook         = myManageHook <+> manageDocks
        , handleEventHook    = docksEventHook <+> fullscreenEventHook <+> myHandleEventHook
        , modMask            = myModMask
        , terminal           = myTerminal
        , startupHook        = myStartupHook
        , layoutHook         = myLayoutHook
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormColor
        , focusedBorderColor = myFocusColor
        , logHook = dynamicLogWithPP
                      (namedScratchpadFilterOutWorkspacePP
                         $ xmobarPP
                             {ppOutput = hPutStrLn xmproc0,
                              ppCurrent = xmobarColor "#A3BE8C" "" . wrap "[" "]" . clickable,
                              ppVisible = xmobarColor "#A3BE8C" "" . clickable,
                              ppHidden = xmobarColor "#81A1C1" "" . wrap "*" "" . clickable,
                              ppHiddenNoWindows = xmobarColor "#B48EAD" "" . clickable,
                              ppTitle = xmobarColor "#D8DEE9" "" . shorten 100,
                              ppSep = "<fc=#4C566A> <fn=1>|</fn> </fc>",
                              ppUrgent = xmobarColor "#BF616A" "" . wrap "!" "!",
                              ppExtras = [windowCount],
                              ppOrder = \ (ws : l : t : ex) -> [ws, l] ++ ex ++ [t]
                             })
                      >> historyHook
        } `additionalKeys` workspaceBackAndForth `additionalKeysP` myKeys

main :: IO ()
main = do
    -- Launching xmobar.
    xmproc0 <- spawnPipe "xmobar $HOME/.config/xmobar/xmobar.config"
    -- the xmonad, ya know...what the WM is named after!
    xmonad $ ewmh $ defaults xmproc0
