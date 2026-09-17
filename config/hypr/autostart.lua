-- User-level autostart processes (loaded after Omarchy's default autostart).

-- Start fcitx5 input method daemon in the background.
hl.exec_cmd(o.launch("fcitx5 -d"))
