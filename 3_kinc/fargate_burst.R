library('ggplot2')
library(stringr)
set.seed(955)
# Make some noisily increasing data
dat <- data.frame(xvar = c("0.25/0.5","0.5/1","1/2","2/4","4/8"),
                  yvar = c(
                  c(30,32,27,24,50),
                  c(26,45,45,43,44),
                  c(47,49,41,33,30),
                  c(46,45,37,48,41),
                  c(25,37,23,40,36),
                  c(37,29,32,45,46),
                  c(34,47,43,44,33),
                  c(49,46,43,30,30),
                  c(37,28,39,43,39),
                  c(48,26,38,25,44)))

ggplot(dat, aes(x=as.factor(xvar), y=yvar)) +
geom_jitter(position = position_jitter(w = 0.1, h = 0)) +
xlab("vCPU/memory [cores/GB]") + ylab("Burst rate [count]") + theme (text = element_text(size=10)) + theme(legend.position = "none") +
ggsave("fargate-burst.pdf", width = 8, height = 8, units = "cm")