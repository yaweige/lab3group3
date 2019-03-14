# Code for creating a hex sticker

# Load the hexSicker library
library(hexSticker)

# Make the sticker
sticker <- sticker(expression(plot.new()),
                   package = "lab3group3",
                   p_x = 1,
                   p_y = 1,
                   p_color = "lightseagreen",
                   p_size = 16,
                   p_family	= "mono",
                   h_fill = "lemonchiffon",
                   h_color = "orange1",
                   h_size = 3,
                   url = "https://github.com/yaweige/lab3group3",
                   u_size = 2.5,
                   u_family = "mono")

# Save the sticker
ggplot2::ggsave(file = "./data-raw/sticker.png", sticker, width = 3.5, height = 3.5)
