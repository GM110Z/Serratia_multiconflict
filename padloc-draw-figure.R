library(gggenes)
library(ggplot2)
library("RColorBrewer")
library(dplyr)
library(tidyr)
library(Polychrome)
#import prophages/defence islands regions
t <-read.csv(file = 'gggenes-input.txt',quote ="",sep = "\t",
               row.names = NULL, 
               stringsAsFactors =FALSE,header=TRUE)
# reorder the columns
GenesDF2 <- t[, c(1,2, 3, 4, 5,6,7)]
##rename columns
names(GenesDF2)[names(GenesDF2) == "add_column"] <- "molecule"
names(GenesDF2)[names(GenesDF2) == "strand"] <- "orientation"

## now make a colour palette
#n <- 20
#qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]
#col_vector = unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))
a <- read.csv(file = 'padlocforR.txt',quote = "",sep = "\t",
              stringsAsFactors = FALSE,header=TRUE)
#add padloc Ids to dataset
names(a)[names(a) == "target.name"] <- "Protein_ID"
names(a)[names(a) == "seqid"] <- "molecule"

#join the dataframes
d <-merge(GenesDF2, a, by=c("Protein_ID","molecule"), all.x=T, all.y=T)

#Select the bloody columns now of new dataframe
finaldf <- d[, c(1,2, 3, 4, 5,6,7,10)]

write.table(finaldf, file="tempR.txt", quote=F, row.names=F,sep="\t")

newfinaldf <-read.csv(file = 'tempR.txt',quote ="",sep = "\t",
                          row.names = NULL, 
                          stringsAsFactors =FALSE,header=TRUE)
#palette option1
manualcolors<-c('black','forestgreen', 'red2', 'orange', 'cornflowerblue', 
                'magenta', 'darkolivegreen4', 'indianred1', 'tan4', 'darkblue', 
                'mediumorchid1','firebrick2',  'yellowgreen', 'lightsalmon','chartreuse', 'tan3',
                "tan1",'purple', 'wheat4', '#DDAD4B', 
                'seagreen1', 'moccasin', 'mediumvioletred', 'seagreen','cadetblue1',
                "darkolivegreen1" ,"tan2" ,   "tomato3" , "#7CE3D8","white","#FFF7BC","#8C6BB1","cyan","#CB181D","yellow",
                "limegreen","#F16913","#762A83","tan1","blue","firebrick1","firebrick4","pink","pink3")

#palette option2
#cbbPalette <- c("#E5F5F9","#1D91C0","#67001F","#F7FCFD","#CB181D",
#                "#78C679","#F16913","#000000","#A6CEE3","#FD8D3C","#6A51A3",
 #               "#A6D854","#003C30","#FFF7BC","#762A83","#db6d00",
 #               "#D4B9DA","#AE017E","#F7F7F7","#C7EAE5","#FC9272",
  #              "#EF3B2C","#DF65B0","#7F0000","#8C6BB1","#C7E9B4")

#plot
g <- ggplot(newfinaldf, aes(xmin = start.x, xmax = end.x, y = molecule , fill=system,forward = orientation)) +
  geom_gene_arrow(arrowhead_height = unit(4, "mm"), arrowhead_width = unit(4, "mm")) +
  facet_wrap(~ molecule, scales = "free", ncol = 1)+
  scale_fill_manual(values = manualcolors)+theme_genes() %+replace% theme(axis.title.y = element_blank(),
                                 axis.ticks.x = element_blank(),
                                 legend.direction="vertical",
                                 legend.position="right",
                                 panel.grid.major.y =element_blank())+scale_y_discrete(expand = expand_scale(mult = c(1, 6)))

ggsave("ceoli.pdf", width = 25, height =600 , units = "cm",limitsize = FALSE)
