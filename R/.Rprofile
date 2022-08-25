get_os <- function(){
  sysinf <- Sys.info()
  if (!is.null(sysinf)){
    os <- sysinf['sysname']
    if (os == 'Darwin')
      os <- "osx"
  } else { ## mystery machine
    os <- .Platform$OS.type
    if (grepl("^darwin", R.version$os))
      os <- "osx"
    if (grepl("linux-gnu", R.version$os))
      os <- "linux"
  }
  tolower(os)
}
os = get_os()
Sys.setenv(TERM_PROGRAM = "vscode")
if ("httpgd" %in% .packages(all.available = TRUE)) {
  options(vsc.plot = FALSE)
  options(device = function(...) {
    httpgd::hgd(silent = TRUE)
    .vsc.browser(httpgd::hgd_url(history = FALSE), viewer = F)
  })
}
source(file.path(Sys.getenv(if (.Platform$OS.type == "windows") "USERPROFILE" else "HOME"), ".vscode-R", "init.R"))
options(vsc.rstudioapi = TRUE)
options(redoc.wrap = 9999999999)
options(paint_n_rows = 10)
options(paint_max_width = 90)
options(vsc.plot = FALSE)
options(vsc.use_httpgd = FALSE)
if (os == "osx") {
  options(device = "quartz")
} 
options(vsc.browser = FALSE)
options(languageserver.formatting_style = function(options) {
  style <- styler::tidyverse_style(indent_by = options$tabSize)
  style$token$force_assignment_op <- NULL
  style
})
options(languageserver.link_file_size_limit=9999999999999999999999999999)
options(radian.editing_mode = "vi")
options(radian.show_vi_mode_prompt = TRUE)
options(radian.vi_mode_prompt = "\033[0;34m[{}]\033[0m ")
options(radian.escape_key_map = list(
  list(key = "m", value = " |> ")
))

library(utils)
library(tidyverse)
library(tidylog)
library(ggplot2)
library(ggsci)
library(ggplot2pipes)
library(glue)
library(patchwork)
library(rvisidata)
library(ggRetro)
library(parapurrr)
library(paint)
library(ohmyggplot)
library(tidylog)

init_ggplot2_pipes("")
oh_my_ggplot()

plot_pkg = c(
  "ggxmean",
  "ggpubr",
  "ggrepel",
  "geomtextpath",
  "ggpointdensity",
  "ggforce",
  "ggbeeswarm"
)
map(plot_pkg, require)

walk(plot_pkg, ~ library(.x, character.only = T))
init_ggplot2_pipes(packages = plot_pkg)

library(paletteer)
init_ggplot2_pipes(packages = "paletteer", func_regex = "^scale_fill|scale_color")

tidylog = function() {
  require("conflicted")
  getNamespaceExports("tidylog") %>%
    walk(conflict_prefer, "tidylog")
}

