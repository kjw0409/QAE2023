getwd()

library(dplyr)
library(rvest)
library(stringr)
library(writexl)

stack <- NULL
for (i in 1:104) {
  print(i)
  URL <- paste0("http://www.cgs.or.kr/business/esg_tab04.jsp?pg=", i, "&pp=10&skey=&svalue=&sfyear=2022&styear=2022&sgtype=&sgrade=")
  res <- read_html(URL)
  tab <- res %>% 
    html_table() %>% 
    .[[1]]
  stack <- rbind(stack, tab)
}

# Convert the R code and results to character strings
r_code <- "
library(dplyr)
library(rvest)
library(stringr)
library(writexl)

stack <- NULL
for (i in 1:104) {
  print(i)
  URL <- paste0('http://www.cgs.or.kr/business/esg_tab04.jsp?pg=', i, '&pp=10&skey=&svalue=&sfyear=2022&styear=2022&sgtype=&sgrade=')
  res <- read_html(URL)
  tab <- res %>% 
    html_table() %>% 
    .[[1]]
  stack <- rbind(stack, tab)
}
"

# Convert the results to HTML table format
results <- stack %>% knitr::kable(format = "html")

# Create the HTML file with the clickable link and results
html_content <- sprintf("<html><body><p>Click <a href='results.html'>esg rating</a> to view the results.</p><p>Click <a href='https://www.moel.go.kr/info/publict/publictDataView.do?bbs_seq=20221201935'>here</a> to download additional files.</p></body></html>")
writeLines(html_content, "work_page.html")
writeLines(results, "esg_rating.html")
