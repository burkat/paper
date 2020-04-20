library('ggplot2')
library(stringr)
args = commandArgs(trailingOnly=TRUE)
tasks = read.table(args[2],header = TRUE)
min_start = min(tasks$task_fire)
tasks$task_fire=(tasks$task_fire-min_start)/1000
tasks$task_start=(tasks$task_start-min_start)/1000
tasks$task_end=(tasks$task_end-min_start)/1000
tasks = tasks[order(tasks$task_fire),]

x <- 1:nrow(tasks)
task = c()
for (val in x) {
	task <- c(task, rep(val , 2))
}

value = c()

setup = tasks$task_start-tasks$task_fire
execution = tasks$task_end-tasks$task_start

for(val in x) {
	value <- c(value, setup[val])
	value <- c(value, execution[val])
}

stage <- rep(c("setup" , "execution"), nrow(tasks))
data <- data.frame(task,stage,value)
 
# Stacked
ggplot(data, aes(fill=stage, y=value, x=task)) + 
geom_bar(position="stack", stat="identity") + coord_flip() +
scale_x_continuous(expand = c(0, 0), limits = c(-1, 201)) +
ggtitle(args[1]) + theme(plot.title = element_text(size = 12)) + theme(plot.title = element_text(hjust = 0.5)) + 
xlab("Task number") + ylab("Time [s]") + theme (text = element_text(size=12)) + theme(legend.position = "none")
ggsave(paste(str_trim(args[1]),".pdf", sep=""), width = 12.2, height = 18, units = "cm")
