#!/usr/bin/env python3

import re, subprocess, os

def cmd(cmd: list):
    return subprocess.run(cmd, capture_output=True, text=True).stdout.rstrip("\n")

def get_xfconf_setting(channel: str, property: str):
    return cmd(["xfconf-query", "--channel", channel, "--property", property])

def set_xfconf_setting(channel: str, property: str, value: str):
    return cmd(["xfconf-query", "--channel", channel, "--property", property, "--set", value])

def sed(regex, file):
    return cmd(["sed", regex, "--follow-symlinks", "--in-place", file])

def read_file(file):
    with open(file, "r") as fd:
        return fd.read()

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

def toggle_setting_in_ini(setting, settings_file):
    settings_content = read_file(settings_file)
    value_mach = re.search(fr"^{setting}=(?P<value>.*)$", settings_content, re.MULTILINE)
    if value_mach:
        sed(f"s/{setting}=.*/{setting}={toggle_mode(value_mach.group("value"))}/g", settings_file)
    else:
        print(f"Could not change {setting}")

def toggle_kvantum_theme():
    kvantum_settings = os.path.join(os.path.expanduser("~"), ".config/Kvantum/kvantum.kvconfig")
    toggle_setting_in_ini("theme", kvantum_settings)

def toggle_qt_theme():
    qt6ct_config = os.path.join(os.path.expanduser("~"), ".config/qt6ct/qt6ct.conf")
    toggle_setting_in_ini("icon_theme", qt6ct_config)
    qt5ct_config = os.path.join(os.path.expanduser("~"), ".config/qt5ct/qt5ct.conf")
    toggle_setting_in_ini("icon_theme", qt5ct_config)


if __name__ == "__main__":
    toggle_xfce_setting("xfwm4", "/general/theme")
    toggle_xfce_setting("xsettings", "/Net/ThemeName")
    toggle_xfce_setting("xsettings", "/Net/IconThemeName")
    toggle_kvantum_theme()
    toggle_qt_theme()
