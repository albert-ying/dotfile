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
  list(key = "m", value = " %>% ")
))

#library(tidyverse)
library(ggplot2)
library(hrbrthemes)
library(ggsci)
library(ggtext)
library(utils)
library(tidylog)

## change global theme settings (for all following plots)

theme_set(
	theme_ipsum(plot_title_size = 28, subtitle_size = 22, base_size = 18, axis_title_size = 24, strip_text_size = 22, base_family = "Helvetica", axis_title_just = "mc") +
	  theme(
	    plot.title.position = "plot", plot.caption.position = "plot", legend.position = "right", plot.margin = margin(25, 25, 10, 25),
	    axis.ticks = element_line(color = "grey92"),
	    axis.ticks.length = unit(.5, "lines"),
	    panel.grid.minor = element_blank(),
	    legend.text = element_text(color = "grey30"),
	    plot.subtitle = element_text(color = "grey30"),
	    plot.caption = element_text(margin = margin(t = 15))
	  ) +
	theme(plot.title = element_markdown(), plot.subtitle = element_markdown(), plot.caption = element_markdown(margin = margin(t = 15)), axis.title.x = element_markdown(), axis.title.y = element_markdown())
)

better_color_legend = guides(color = guide_colorbar(title.position = 'top', title.hjust = .5, barwidth = unit(20, 'lines'), barheight = unit(.5, 'lines')))
better_fill_legend = guides(fill = guide_colorbar(title.position = 'top', title.hjust = .5, barwidth = unit(20, 'lines'), barheight = unit(.5, 'lines')))

formals(coord_cartesian)$expand = FALSE
formals(coord_cartesian)$clip = 'off'
formals(geom_point)$size = 3
formals(geom_point)$stroke = .6
scale_colour_discrete = scale_color_npg
scale_fill_discrete = scale_fill_npg
scale_colour_inferno = function(...){scale_color_viridis_c(..., option = "C")}
scale_fill_inferno = function(...){scale_fill_viridis_c(..., option = "C")}
options(ggplot2.continuous.colour = scale_colour_inferno)
options(ggplot2.continuous.fill = scale_fill_inferno)

tidylog = function() {
  require("conflicted")
  getNamespaceExports("tidylog") %>%
    walk(conflict_prefer, "tidylog")
}
