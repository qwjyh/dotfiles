# Windows Terminal Settings

## Quake Mode
Alomost no animation (duration = 1ms).
Use with Fancy Zones in PowerToys to enable fullscreen dropdown (or pop up) terminal.
```json
{
    "actions":
    [
        {
            "command": 
            {
                "action": "globalSummon",
                "desktop": "toCurrent",
                "dropdownDuration": 1,
                "monitor": "toMouse",
                "name": "_quake",
                "toggleVisibility": true
            },
            "keys": "ctrl+f12"
        },
    ]
}
```

## Font
Use *Juisee HW* with Nerd Fonts.

Below is settings for stylistic sets.
Insert this to the "font".
```json
{
    "profiles":
    {
        "list":
        {
            [
                "font": 
                {
                    "face": "JuiseeHW Nerd Font",
                    "size": 11.0,
                    "features": {
                        "calt": 0, // No contextural alternates
                        "zero": 1, // slashed zero
                        "ss08": 0,
                        "ss20": 0
                    }
                },
            ]
        }
    }
}
```

### references
- https://juliamono.netlify.app/#stylistic_sets
- https://github.com/tonsky/FiraCode/wiki/How-to-enable-stylistic-sets
- https://learn.microsoft.com/en-us/windows/terminal/customize-settings/profile-appearance#font

