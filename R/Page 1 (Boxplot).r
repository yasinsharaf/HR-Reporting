#use AgeGroup, StartingSalary, and fill using AgeGroupType using DAX if-else statement
library(ggplot2)
ggplot(
    dataset, 
    aes(
        x=AgeGroup, 
        y=StartingSalary,
        fill = AgeGroupType)) + 
geom_boxplot() +
theme_bw() + 
theme(
    panel.border = element_blank(), 
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(), 
    axis.line = element_line(colour = "black"),
    axis.text = element_text(size = 10)) +
scale_y_continuous(labels=scales::dollar_format()) +
xlab("Age Group") +
ylab("Salary") +
theme(legend.position = "none")