local wezterm = require 'wezterm'

-- default Program on each machine OS
local default_prog = { "bash" }
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    default_prog = { 'pwsh' }
elseif wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
    default_prog = { 'fish' }
end

-- from manual
local launch_menu = {}
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    table.insert(launch_menu, {
        label = 'pwsh',
        args = { 'pwsh.exe' },
    })

    for _, vsvers in
    ipairs(wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files (x86)'))
    do
        local year = vsvers:gsub('Microsoft Visual Studio/', '')
        table.insert(launch_menu, {
            label = 'x64 Native Tools VS ' .. year,
            args = {
                'cmd.exe',
                '/k',
                'C:/Program Files (x86)/'
                .. vsvers
                .. '/BuildTools/VC/Auxiliary/Build/vcvars64.bat',
            },
        })
    end
end

return {
    default_prog = default_prog,
    launch_menu = launch_menu,
    --    keys = {
    --        {
    --            key = 'P',
    --            mods = 'CTRL',
    --            action = wezterm.action.ActivateCommandPalette,
    --        }
    --    },

    color_scheme = "iceberg-dark",
    use_fancy_tab_bar = false,
    tab_bar_at_bottom = true,
    window_background_opacity = 0.85,
    -- font = wezterm.font 'FirgeNerd Console'
    font = wezterm.font_with_fallback {
        {
            family = 'JuiseeHW Nerd Font',
            weight = 'Bold',
            harfbuzz_features = {
                'calt=0', -- disables ligature
                'zero=1',
                'ss08=0',
                ''
            },
        },
        { family = 'FirgeNerd Console', assume_emoji_presentation = true }, -- for japanese
        'Twemoji',
        'UniFont Regular',
    },
}
