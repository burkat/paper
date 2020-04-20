library('ggplot2')

values = c(c(0.059104),c(0.059429),c(0.057694),c(0.054541),c(0.054938),c(0.054500),c(0.054167),c(0.054028))
service=c(rep(" 256", 1),rep(" 512", 1),rep("1024", 1),rep("1536", 1), rep("1792", 1), rep("2048", 1), rep("2560", 1), rep("3008", 1))
resource=rep(c("memory"),8)
data=data.frame(service,resource,values)

ggplot(data, aes(fill=resource, y=values, x=service)) + geom_bar(stat="identity") + ylab("Price [$]") + 
ylim(0, 0.15) + xlab("AWS Lambda memory [MB]") + theme (text = element_text(size=12)) +
scale_fill_manual("resource", values = c("memory" = "#7CAE00"))
ggsave(paste("ellipsoids_lambda_price.pdf"), width = 12, height = 9, units = "cm")

