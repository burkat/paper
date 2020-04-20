library('ggplot2')

values = c(c(0.025443, 0.005587),c(0.032057, 0.007040),c(0.0435947111, 0.00957403611),c(0.05449057777, 0.0119669277777),c(0.103089066666, 0.0226398666))

service=c(rep("0.25/0.5", 2),rep("0.5/1", 2),rep("1/2", 2),rep("2/4", 2), rep("4/8", 2))
resource=rep(c("vCPU", "memory"),5)
data=data.frame(service,resource,values)

ggplot(data, aes(fill=resource, y=values, x=service)) + geom_bar(stat="identity") + ylab("Price [$]") + 
ylim(0, 0.15) + xlab("AWS Fargate vCPU/memory [cores/GB]") + theme (text = element_text(size=12)) +
scale_fill_manual("resource", values = c("vCPU" = "#C77CFF", "memory" = "#7CAE00"))
ggsave(paste("ellipsoids_fargate_price.pdf"), width = 12, height = 9, units = "cm")

