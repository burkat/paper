library('ggplot2')

logs <- c("res_100.csv", "res_300.csv", "res_500.csv", "res_1000.csv")
values = c()

for (l in logs) {
	all_tasks = read.table(l, header = TRUE)
	vina_tasks <- subset(all_tasks, task_name == 'kinc-wrapper')
	number_of_tasks = nrow(vina_tasks)
	print(number_of_tasks)
	vina_tasks[,c('task_name')] <- list(NULL)
	vina_tasks <- rowsum(vina_tasks, as.integer(gl(nrow(vina_tasks), number_of_tasks, nrow(vina_tasks))))
	setup = ((vina_tasks$task_start - vina_tasks$task_fire)/1000)/number_of_tasks
	execution = ((vina_tasks$task_end - vina_tasks$task_start)/1000)/number_of_tasks
	values <- c(values, setup)
	values <- c(values, execution)
}

service=c(rep(" 100", 2),rep(" 300", 2),rep(" 500", 2),rep("1000", 2))
stage=rep(c("setup" , "execution"),4)
data=data.frame(service,stage,values)

ggplot(data, aes(fill=stage, y=values, x=service)) + geom_bar( stat="identity") + ylab("Time [s]") + 
ggtitle("CloudRun-2048MB-2vCPU") + theme(plot.title = element_text(size = 12)) + theme(plot.title = element_text(hjust = 0.5)) + 
ylim(0, 500) + xlab("Tasks [count]") + theme (text = element_text(size=12))
ggsave(paste("kinc_cloudrun_plot.pdf"), width = 12, height = 8, units = "cm")

