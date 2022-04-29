options(vsc.rstudioapi = TRUE)
options(redoc.wrap = 9999999999)

Sys.setenv(TERM_PROGRAM = "vscode")
source(file.path(
  Sys.getenv(
    if (.Platform$OS.type == "windows") "USERPROFILE" else "HOME"
  ),
  ".vscode-R", "init.R"
))
options(vsc.plot = FALSE)
options(vsc.use_httpgd = FALSE)
options(device = "quartz")
options(vsc.browser = FALSE)
options(languageserver.formatting_style = function(options) {
  style <- styler::tidyverse_style(indent_by = options$tabSize)
  style$token$force_assignment_op <- NULL
  style
})
options(radian.editing_mode = "vi")
options(radian.show_vi_mode_prompt = TRUE)
options(radian.vi_mode_prompt = "\033[0;34m[{}]\033[0m ")
options(radian.escape_key_map = list(
  list(key = "m", value = " |> ")
))

library(utils)
library(tidylog)
library(ggplot2)
library(ggsci)
library(ggplot2pipes)
library(ggRetro)
library(ohmyggplot)

oh_my_ggplot()
init_ggplot2_pipes("")

tidylog = function() {
  require("conflicted")
  getNamespaceExports("tidylog") %>%
    walk(conflict_prefer, "tidylog")
}

if (interactive() && Sys.getenv("RSTUDIO") == "") {
  Sys.setenv(TERM_PROGRAM = "vscode")
  if ("httpgd" %in% .packages(all.available = TRUE)) {
    options(vsc.plot = FALSE)
    options(device = function(...) {
      httpgd::hgd(silent = TRUE)
      .vsc.browser(httpgd::hgd_url(history = FALSE), viewer = F)
    })
  }
  source(file.path(Sys.getenv(if (.Platform$OS.type == "windows") "USERPROFILE" else "HOME"), ".vscode-R", "init.R"))
}

