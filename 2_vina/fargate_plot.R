library('ggplot2')

logs <- c("fargate025.csv", "fargate050.csv", "fargate1.csv", "fargate2.csv", "fargate4.csv")
values = c()

for (l in logs) {
	number_of_tasks = 20
	all_tasks = read.table(l, header = TRUE)
	ellipsoids_tasks <- subset(all_tasks, task_name == 'vina')
	ellipsoids_tasks[,c('task_name')] <- list(NULL)
	ellipsoids_tasks <- rowsum(ellipsoids_tasks, as.integer(gl(nrow(ellipsoids_tasks), number_of_tasks, nrow(ellipsoids_tasks))))
	setup = ((ellipsoids_tasks$task_start - ellipsoids_tasks$task_fire)/1000)/number_of_tasks
	execution = ((ellipsoids_tasks$task_end - ellipsoids_tasks$task_start)/1000)/number_of_tasks
	print(setup)
	print(execution)
	values <- c(values, setup)
	values <- c(values, execution)
}

service=c(rep("0.25/0.5", 2),rep("0.5/1", 2),rep("1/2", 2),rep("2/4", 2), rep("4/8", 2))
stage=rep(c("setup" , "execution"),5)
data=data.frame(service,stage,values)

ggplot(data, aes(fill=stage, y=values, x=service)) + geom_bar( stat="identity") + ylab("Time [s]") + 
ylim(0, 600) + xlab("AWS Fargate vCPU/memory [cores/GB]") + theme (text = element_text(size=12))
ggsave(paste("vina_fargate_plot.pdf"), width = 12, height = 9, units = "cm")

