library('ggplot2')

values = c(c(0.046742),c(0.046732),c(0.046752),c(0.0465511),c(0.046243),c(0.046469),c(0.047131),c(0.0469279))
service=c(rep(" 256", 1),rep(" 512", 1),rep("1024", 1),rep("1536", 1), rep("1792", 1), rep("2048", 1), rep("2560", 1), rep("3008", 1))
resource=rep(c("memory"),8)
data=data.frame(service,resource,values)

ggplot(data, aes(fill=resource, y=values, x=service)) + geom_bar(stat="identity") + ylab("Price [$]") + 
ylim(0, 0.25) + xlab("AWS Lambda memory [MB]") + theme (text = element_text(size=12)) +
scale_fill_manual("resource", values = c("memory" = "#7CAE00"))
ggsave(paste("vina_lambda_price.pdf"), width = 12, height = 9, units = "cm")

