---- MONITORS ----

hl.monitor({ output = "eDP-1",    mode = "highres@highrr", position = "0x0",     scale = 1.3333334 })
hl.monitor({ output = "HDMI-A-2", mode = "highres@highrr", position = "0x-1080", scale = 1 })

---- EXECUTABLES ----

local terminal = "foot"
local launcher = "rofi -show drun"
local browser  = "firefox"
local scripts  = "/home/frigyes/scripts"

---- AUTOSTART ----

hl.on("hyprland.start", function()
    hl.exec_cmd("waybar & hyprpaper & dunst & hypridle")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd(scripts .. "/desktop/battery_notify.sh")
    hl.exec_cmd("wl-paste --watch cliphist store")
end)

---- ENVIRONMENT VARIABLES ----

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_theme", "capitaine")
hl.env("HYPRCURSOR_SIZE", "24")

---- LOOK AND FEEL ----

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 6,
        border_size = 1,
        ["col.active_border"] = "rgba(eeeeee33)",
        ["col.inactive_border"] = "rgba(eeeeee00)",
        resize_on_border = true,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = { enabled = false, },
        blur = {
            enabled = true,
            size = 3,
            passes = 2,
            vibrancy = 0.1696,
            brightness = 0.7,
            noise = 0.06,
        },
    },
    animations = {
        enabled = true,
    },
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
    },
})

-- Animation curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1} } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1} } })
hl.curve("snappy",         { type = "bezier", points = { {0.05, 0.9},  {0.1, 1} } })

hl.animation({ leaf = "windows",          enabled = true, speed = 1.5,    bezier = "snappy", style = "popin 80%" })
hl.animation({ leaf = "windowsMove",      enabled = true, speed = 1.75, bezier = "snappy" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 1.5,  bezier = "snappy", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1.5,  bezier = "snappy", style = "slidevert" })
hl.animation({ leaf = "fade",             enabled = true, speed = 1.5,    bezier = "snappy" })

---- INPUT ----

hl.config({
    input = {
        kb_layout = "hu",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0,
        repeat_delay = 500,
        repeat_rate = 40,
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

---- KEYBINDINGS ----

-- Window launching, management and quitting
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(launcher))
hl.bind("SUPER + F", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + A", hl.dsp.exec_cmd(scripts .. "/desktop/launcher.sh"))
hl.bind("SUPER + N", hl.dsp.exec_cmd(scripts .. "/notes/notes.sh"))
hl.bind("SUPER + C", hl.dsp.window.close())
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.pseudo()) -- dwindle
hl.bind("SUPER + O", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind("SUPER + SHIFT + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

-- Moving focus and windows
hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + CTRL + H", hl.dsp.window.resize({ x = -10, y = 0 }))
hl.bind("SUPER + CTRL + L", hl.dsp.window.resize({ x = 10, y = 0 }))
hl.bind("SUPER + CTRL + K", hl.dsp.window.resize({ x = 0, y = -10 }))
hl.bind("SUPER + CTRL + J", hl.dsp.window.resize({ x = 0, y = 10 }))
hl.bind("SUPER + SHIFT + ALT + J", hl.dsp.workspace.move({ monitor = "down" }))
hl.bind("SUPER + SHIFT + ALT + K", hl.dsp.workspace.move({ monitor = "up" }))

hl.bind("SUPER + G", hl.dsp.group.toggle())
hl.bind("ALT + Tab", hl.dsp.group.next())
hl.bind("ALT + Tab", hl.dsp.layout("cyclenext"))

-- Workspaces
hl.bind("SUPER + 0", hl.dsp.focus({ workspace = "name:::" }))
for i = 1, 9 do
    hl.bind("SUPER + " .. i, hl.dsp.focus({ workspace = tostring(i) }))
    hl.bind("SUPER + SHIFT + " .. i, hl.dsp.window.move({ workspace = tostring(i) }))
end
hl.bind("SUPER + SHIFT + 0", hl.dsp.window.move({ workspace = "name:::" }))

-- Scratchpad
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind("SUPER + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind("SUPER + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind("SUPER + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media / brightness keys
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp -d)" - | wl-copy'))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim - | wl-copy"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd('mkdir -p ~/images/screenshots && grim -g "$(slurp -d)" ~/images/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png'))
hl.bind("CTRL + SHIFT + Print", hl.dsp.exec_cmd('mkdir -p ~/images/screenshots && grim ~/images/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png'))

hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -a"))

hl.bind("SUPER + comma", hl.dsp.exec_cmd("rofi -show emoji"))

---- WINDOWS AND WORKSPACES ----

hl.layer_rule({ name = "blur-rofi",   match = { namespace = "rofi" },   blur = true })
hl.layer_rule({ name = "blur-waybar", match = { namespace = "waybar" }, blur = true })

hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.workspace_rule({
    workspace = "name:::",
    layout = "monocle",
})

hl.config({
    xwayland = {
        use_nearest_neighbor = false,
        force_zero_scaling = true,
    },
})
