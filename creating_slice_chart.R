##########################################
####Creating the shape of our slices####
l_x <- c(0, -450, -217.38, 0)
l_y <- c(0, 450, 450, 0)

left_field <- data.frame(l_x, l_y)

lc_x <- c(0, -217.37, -68.02, 0)
lc_y <- c(0, 450, 450, 0)

left_center <- data.frame(lc_x, lc_y)

c_x <- c(0, -68.01, 68.01, 0)
c_y <- c(0, 450, 450, 0)

center <- data.frame(c_x, c_y)

rc_x <- c(0, 68.02, 217.37, 0)
rc_y <- c(0, 450, 450, 0)

right_center <- data.frame(rc_x, rc_y)

r_x <- c(0, 217.38, 450, 0)
r_y <- c(0, 450, 450, 0)

right_field <- data.frame(r_x, r_y)
###################################
#########Creating baseball field############
#(disregard the 'ddf'; part of another project lol)

ddf_left_y <- (340*cos(pi/4))
ddf_left_x <- (340*sin(pi / 4)) * -1
ddf_right_x <- (325*sin(pi / 4))
ddf_right_y <- (325*cos(pi / 4))

field <- function(...) 
{
  ggplot(...) +
    geom_segment(aes(x = 0, xend = ddf_left_x, y = 0, yend = ddf_left_y)) +
    geom_segment(aes(x = 0, xend = ddf_right_x, y = 0, yend = ddf_right_y)) +
    geom_curve(aes(x = ddf_left_x, xend = ddf_right_x, y = ddf_left_y, yend = ddf_right_y),
               curvature = -0.66) +
    geom_curve(aes(x = -(75 / cos(pi/4)), xend = (75 / cos(pi/4)),
                   y= (75 / cos(pi/4)), yend = (75 / cos(pi/4))),
               curvature = -0.66) +
    coord_fixed() +
    #scale_x_continuous(NULL, limits = c(-250, 250)) +
    scale_y_continuous(NULL, limits = c(0, 450))
}

#############################
### Loading Data ###########

Slice <- c("Left", "Left Center", "Center", "Right Center", "Right")
n <- c(13, 13, 11, 21, 29)

slices_nine <- data.frame(Slice, n)

mid <- round(mean(slices_nine$n) / sum(slices_nine$n), digits = 2)

###Creating the graphic ############

slices_nine %>%
  field() +
  theme_minimal() +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line.x = element_line(color = "black", size = 1),
        axis.line.y = element_line(color = "black", size = 1)#,
  ) +
  geom_polygon(data = center, aes(x = c_x, y = c_y,
                                  fill = round(((subset(slices_nine, Slice == "Center")$n) / sum(slices_nine$n)), digits = 2)), alpha = 0.75) +
  geom_polygon(data = left_center, aes(x = lc_x, y = lc_y,
                                       fill = round(((subset(slices_nine, Slice == "Left Center")$n) / sum(slices_nine$n)), digits = 2)), alpha = 0.75) +
  geom_polygon(data = right_center, aes(x = rc_x, y = rc_y,
                                        fill = round(((subset(slices_nine, Slice == "Right Center")$n) / sum(slices_nine$n)), digits = 2)), alpha = 0.75) +
  geom_polygon(data = left_field, aes(x = l_x, y = l_y,
                                      fill = round(((subset(slices_nine, Slice == "Left")$n) / sum(slices_nine$n)), digits = 2)), alpha = 0.75) +
  geom_polygon(data = right_field, aes(x = r_x, y = r_y,
                                       fill = round(((subset(slices_nine, Slice == "Right")$n) / sum(slices_nine$n)), digits = 2)), alpha = 0.75) +
  geom_text(aes(x = -300, y = 415, label = round(((subset(slices_nine, Slice == "Left")$n) / sum(slices_nine$n)), digits = 2)),
            size = 4,
            family = "sans serif") +
  geom_text(aes(x = -130, y = 415, label = round(((subset(slices_nine, Slice == "Left Center")$n) / sum(slices_nine$n)), digits = 2)),
            size = 4,
            family = "sans serif") +
  geom_text(aes(x = 0, y = 415, label = round(((subset(slices_nine, Slice == "Center")$n) / sum(slices_nine$n)), digits = 2)),
            size = 4,
            family = "sans serif") +
  geom_text(aes(x = 130, y = 415, label = round(((subset(slices_nine, Slice == "Right Center")$n) / sum(slices_nine$n)), digits = 2)),
            size = 4,
            family = "sans serif") +
  geom_text(aes(x = 300, y = 415, label = round(((subset(slices_nine, Slice == "Right")$n) / sum(slices_nine$n)), digits = 2)),
            size = 4,
            family = "sans serif") +
  labs(fill = "Percentage of BIP", title = paste0("Batted Balls for Hitter in Question, a LHH"),
       subtitle = paste0("BBEs: ", sum(slices_nine$n))) +
  scale_fill_gradient2(low = "lightblue", midpoint = mid, mid = "white", high = "red") +
  theme(plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
        plot.subtitle = element_text(hjust = 0.5, size = 12, face = "italic"))
