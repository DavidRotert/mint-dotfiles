#!/usr/bin/env python3

import re, subprocess

def cmd(cmd: list):
    return subprocess.run(cmd, capture_output=True, text=True).stdout

def get_xfconf_setting(channel: str, property: str):
    return cmd(["xfconf-query", "--channel", channel, "--property", property]).rstrip()

def set_xfconf_setting(channel: str, property: str, value: str):
    return cmd(["xfconf-query", "--channel", channel, "--property", property, "--set", value]).rstrip()

def toggle_mode_name(previous_mode: str):
    translations = {
        "light": "dark",
        "Light": "Dark",

        "dark": "light",
        "Dark": "Light"
    }
    return translations[previous_mode]

def toggle_mode(current_theme: str):
    match = re.search(r"^.*(?P<mode>[Ll]ight|[Dd]ark).*$", current_theme)
    if match:
        mode = match.group("mode")
        return current_theme.replace(mode, toggle_mode_name(mode))
    else:
        return current_theme

def toggle_xfce_setting(channel: str, property: str):
    current_setting = get_xfconf_setting(channel, property)
    new_setting = toggle_mode(current_setting)
    set_xfconf_setting(channel, property, new_setting)


if __name__ == "__main__":
    toggle_xfce_setting("xfwm4", "/general/theme")
    toggle_xfce_setting("xsettings", "/Net/ThemeName")
    toggle_xfce_setting("xsettings", "/Net/IconThemeName")
