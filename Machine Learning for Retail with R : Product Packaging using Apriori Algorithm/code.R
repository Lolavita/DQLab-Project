> library(arules)
> transaksi_tabular <- read.transactions(file = "transaksi_dqlab_retail.tsv", format ="single", sep="\t", cols = c(1,2), skip=1)
> topitem <- itemFrequency(transaksi_tabular, type="absolute")
> topitem <- sort(topitem, decreasing=TRUE)
> topitem <- topitem [1:10]
> topitem <- data.frame("Nama Produk" = names(topitem), "Jumlah"=topitem, row.names=NULL)
> topitem

> bottomitem <- itemFrequency(transaksi_tabular, type="absolute")
> bottomitem <- sort(bottomitem, decreasing = FALSE) 
> bottomitem <- bottomitem[1:10]
> bottomitem <-data.frame("Nama Produk"=names(bottomitem), "Jumlah"=bottomitem, row.names=NULL)
> bottomitem

comb <- apriori(transaksi_tabular, parameter = list(supp = 10/length(transaksi_tabular), confidence =0.5, minlen=2, maxlen=3))
result <- head(comb, n=10, by="lift")
result
inspect(result)

smov <- apriori(transaksi_tabular, parameter=list(supp=10/length(transaksi_tabular), confidence = 0.1, minlen=2, maxlen=3))
a <- subset(smov, rhs %in% "Tas Makeup")
a1 <- head(sort(a, by="lift", decreasing = TRUE), 3)
b <- subset(smov, rhs%in% "Baju Renang Pria Anak-anak")
b1 <-head(sort(b, by="lift", decreasing = TRUE), 3)
comb <- c(a1,b1)
inspect(comb)
