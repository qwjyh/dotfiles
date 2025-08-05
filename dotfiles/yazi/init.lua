th.git = th.git or {}
th.git.untracked = ui.Style():fg("lightgreen")
th.git.untracked_sign = "N"
th.git.added_sign = "A"
th.git.modified = ui.Style():fg("blue")
th.git.modified_sign = "M"
th.git.deleted = ui.Style():fg("red"):bold()
th.git.deleted_sign = "D"
th.git.ignored_sign = "I"
require("git"):setup()
