-- User-level locale & input method environment overrides.
-- Loaded from ~/.config/hypr/hyprland.lua via `require("hypr.envs")`.

-- Locale: simplified Chinese system-wide.
hl.env("LANG", "zh_CN.UTF-8")
hl.env("LC_ALL", "zh_CN.UTF-8")
hl.env("LANGUAGE", "zh_CN:zh")

-- fcitx5 input method framework.
hl.env("INPUT_METHOD", "fcitx")
hl.env("IM_MODULE", "fcitx")
hl.env("GTK_IM_MODULE", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "ibus")  -- GLFW apps (some games) only support ibus
hl.env("XMODIFIERS", "@im=fcitx")
