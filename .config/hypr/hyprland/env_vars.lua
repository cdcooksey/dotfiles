-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
-- Qt follows GTK3, which DankMaterialShell themes via adw-gtk3
hl.env("QT_QPA_PLATFORMTHEME", "gtk3")
hl.env("ADW_DISABLE_PORTAL", 1)
