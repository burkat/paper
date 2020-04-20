library('ggplot2')
library(stringr)
library(scales)
args = commandArgs(trailingOnly=TRUE)
tasks = read.table(args[2],header = TRUE)
min_start = min(tasks$task_fire)
tasks$task_fire=(tasks$task_fire-min_start)/1000
tasks$task_start=(tasks$task_start-min_start)/1000
tasks$task_end=(tasks$task_end-min_start)/1000
tasks = tasks[order(tasks$task_fire),]
tasks$machine = 0
maxmachine=1
for(i in 1:nrow(tasks))
{
	st = tasks$task_fire[i]
	last_tasks = aggregate(task_end ~ machine, data = tasks, max)
	busy = last_tasks[last_tasks$task_end < st & last_tasks$machine != 0,]
	print(st)
	print(busy)
	if (nrow(busy)==0) 
	{
		tasks$machine[i] = maxmachine 
		maxmachine = maxmachine+1
	}
	else tasks$machine[i] = busy$machine[1] 
}
tasks
ggplot(tasks, aes(colour=task_name)) + geom_segment(aes(x=task_fire, xend=task_end, y=machine, yend=machine), size=2) +
ggtitle(args[1]) + theme(plot.title = element_text(size = 12)) + theme(plot.title = element_text(hjust = 0.5)) + 
scale_y_continuous(expand = c(0, 0), limits = c(0, 51)) +
xlab("Time [s]") + ylab("Machine [count]") + theme (text = element_text(size=12)) + #theme(legend.position = "none") +
ggsave(paste(str_trim(args[1]),".pdf", sep=""), width = 17.7, height = 18, units = "cm")