library('ggplot2')

values = c(c(0.029423,0.006461),c(0.044612,0.009797),c(0.063542,0.013954),c(0.095825,0.021044),c(0.186477,0.040953))

service=c(rep("0.25/0.5", 2),rep("0.5/1", 2),rep("1/2", 2),rep("2/4", 2), rep("4/8", 2))
resource=rep(c("vCPU", "memory"),5)
data=data.frame(service,resource,values)

ggplot(data, aes(fill=resource, y=values, x=service)) + geom_bar(stat="identity") + ylab("Price [$]") + 
ylim(0, 0.25) + xlab("AWS Fargate vCPU/memory [cores/GB]") + theme (text = element_text(size=12)) +
scale_fill_manual("resource", values = c("vCPU" = "#C77CFF", "memory" = "#7CAE00"))
ggsave(paste("vina_fargate_price.pdf"), width = 12, height = 9, units = "cm")

