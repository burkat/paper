library('ggplot2')

logs <- c("lambda256.csv", "lambda512.csv", "lambda1024.csv", "lambda1536.csv", "lambda1792.csv", "lambda2048.csv", "lambda2560.csv", "lambda3008.csv")
values = c()

for (l in logs) {
	number_of_tasks = 20
	all_tasks = read.table(l, header = TRUE)
	ellipsoids_tasks <- subset(all_tasks, task_name == 'ellipsoids-openmp')
	ellipsoids_tasks[,c('task_name')] <- list(NULL)
	ellipsoids_tasks <- rowsum(ellipsoids_tasks, as.integer(gl(nrow(ellipsoids_tasks), number_of_tasks, nrow(ellipsoids_tasks))))
	setup = ((ellipsoids_tasks$task_start - ellipsoids_tasks$task_fire)/1000)/number_of_tasks
	execution = ((ellipsoids_tasks$task_end - ellipsoids_tasks$task_start)/1000)/number_of_tasks
	values <- c(values, setup)
	values <- c(values, execution)
}

service=c(rep(" 256", 2),rep(" 512", 2),rep("1024", 2),rep("1536", 2), rep("1792", 2), rep("2048", 2), rep("2560", 2), rep("3008", 2))
stage=rep(c("setup" , "execution"),8)
data=data.frame(service,stage,values)

ggplot(data, aes(fill=stage, y=values, x=service)) + geom_bar( stat="identity") + ylab("Time [s]") + 
ylim(0, 750) + xlab("AWS Lambda memory [MB]") + theme (text = element_text(size=12))
ggsave(paste("ellipsoids_lambda_plot.pdf"), width = 12, height = 9, units = "cm")

