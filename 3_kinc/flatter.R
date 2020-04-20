library('ggplot2')
library(stringr)
args = commandArgs(trailingOnly=TRUE)
tasks = read.table(args[2],header = TRUE)
min_start = min(tasks$task_fire)
tasks$task_fire=(tasks$task_fire-min_start)/1000
tasks$task_start=(tasks$task_start-min_start)/1000
tasks$task_end=(tasks$task_end-min_start)/1000
tasks = tasks[order(tasks$task_fire),]
tasks$stage=tasks$task_name
tasks$machine = 0
maxmachine=1

for(i in 1:nrow(tasks))
{
	st = tasks$task_fire[i]
	last_tasks = aggregate(task_end ~ machine, data = tasks, max)
	busy = last_tasks[last_tasks$task_end < st & last_tasks$machine != 0,]
	if (nrow(busy)==0) 
	{
		tasks$machine[i] = maxmachine 
		maxmachine = maxmachine+1
	}
	else tasks$machine[i] = busy$machine[1] 
}


# nRow <- data.frame(task_name='setup', task_fire='1', task_start='50', task_end='300', download_start='0', download_end='0',
# 	execution_start='0', execution_end='0', upload_start='0', upload_end='0', stage='setup', machine=51)
# tasks <- rbind(tasks,nRow)


ggplot(tasks, aes(colour=stage)) + geom_segment(aes(x=task_fire, xend=task_start, y=machine, yend=machine), size=0.9, colour="#00BFC4") + 
geom_segment(aes(x=task_start, xend=task_end, y=machine, yend=machine), size=0.9) + 
scale_y_continuous(expand = c(0, 0), limits = c(-1, 101)) +
ggtitle(args[1]) + theme(plot.title = element_text(size = 12)) + theme(plot.title = element_text(hjust = 0.5)) + 
xlab("Time [s]") + ylab("Machine [count]") + theme (text = element_text(size=12)) + theme(legend.position = "none") +
ggsave(paste(str_trim(args[1]),".pdf", sep=""), width = 12.2, height = 11, units = "cm")