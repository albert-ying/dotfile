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
  list(key = "m", value = " |> ")
))

#library(tidyverse)
library(ggplot2)
library(hrbrthemes)
library(ggsci)
library(ggtext)
library(utils)
library(tidylog)
library(ggthemes)

## change global theme settings (for all following plots)
## fall back theme
theme_set(
  theme_ipsum(plot_title_size = 28, subtitle_size = 22, base_size = 18, axis_title_size = 24, strip_text_size = 22, base_family = "Helvetica", axis_title_just = "mc") +
    theme(
      plot.title.position = "plot", plot.caption.position = "plot", legend.position = "right", plot.margin = margin(25, 25, 10, 25),
      axis.ticks = element_line(color = "grey92"),
      panel.grid.major = element_blank(),
      legend.text = element_text(color = "grey30"),
      plot.subtitle = element_text(color = "grey30"),
      plot.caption = element_text(margin = margin(t = 15))
    ) +
  theme(plot.title = element_markdown(), plot.subtitle = element_markdown(), plot.caption = element_markdown(margin = margin(t = 15)), axis.title.x = element_markdown(), axis.title.y = element_markdown())
)
# Mimic Base R break
base_breaks <- function(x, y, scale_x = T, scale_y = T) {
  require(ggthemes)
  if (scale_x) {
    b1 = pretty(x)
    sx = scale_x_continuous(breaks=b1)
  } else {
    b1 = as.factor(x) |> as.numeric()
    sx = NULL
  }
  if (scale_y) {
    b2 = pretty(y)
    sy = scale_y_continuous(breaks=b2)
  } else {
    b2 = as.factor(y) |> as.numeric()
    sy = NULL
  }
  d = data.frame(x=c(min(b1), max(b1)), y=c(min(b2), max(b2)))
  list(
    sx, sy, geom_rangeframe(data = d, aes(x=x, y=y), inherit.aes = FALSE), ggthemes::theme_tufte(base_size = 18, base_family = "Helvetica"), theme(axis.ticks = element_line(size = 0.25, color = "black"), axis.ticks.length = unit(.6, "lines"), panel.grid.minor = element_blank())
  )
}

base_mode = function(p, i = 1) {
  require(ggthemes)
  px = p + geom_point()
  p_tb = ggplot_build(px)$data[[length(ggplot_build(px)$data)]] |> as_tibble()
  if (class(p_tb$x)[1] != "mapped_discrete" & class(p_tb$y)[1] != "mapped_discrete") {
    print("Both numeric")
    np = p + base_breaks(p_tb$x, p_tb$y)
  } else if (class(p_tb$x)[1] != "mapped_discrete") {
    print("x numeric")
    np = p + base_breaks(p_tb$x, p_tb$y |> round(), scale_y = F)
  } else if (class(p_tb$y)[1] != "mapped_discrete") {
    print("y numeric")
    np = p + base_breaks(p_tb$x |> round(), p_tb$y, scale_x = F)
  } else {
    print("no numeric")
    np = p + geom_rangeframe()
  }
  return(np)
}

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
