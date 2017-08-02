NY_books = read.csv('NYC_booking.csv', sep = ';')

#Age-related data
trains = NY_books %>% filter(str_detect(Description, 'train'))
G_train = trains %>% filter(str_detect(Description, 'G train'))
Teens = all_books %>% select(.,Description) %>% filter(str_detect(Description, c('teen','teens', '10'))) %>% summarise(.,Count = n())
Twenties = all_books %>% select(.,Description) %>% filter(str_detect(Description, '20s')) %>% summarise(.,Count = n())
Thirties = all_books %>% select(.,Description) %>% filter(str_detect(Description, '30s')) %>% summarise(.,Count = n())
Fourties = all_books %>% select(.,Description) %>% filter(str_detect(Description, '40s')) %>% summarise(.,Count = n())
Fifties = all_books %>% select(.,Description) %>% filter(str_detect(Description, '50s')) %>% summarise(.,Count = n())
Sixties = all_books %>% select(.,Description) %>% filter(str_detect(Description, '60s')) %>% summarise(.,Count = n())
Seventies = all_books %>% select(.,Description) %>% filter(str_detect(Description, '70s')) %>% summarise(.,Count = n())

#Individual train description data
C = C_train %>% select(.,Title, Author) %>% group_by(.,Author) %>% summarise(.,Views = n()) %>% arrange(.,(desc(Views))) %>% head(.,5)
Six = Six_train %>% select(.,Title, Author) %>% group_by(.,Author) %>% summarise(.,Views = n()) %>% arrange(.,(desc(Views))) %>% head(.,5)
ef = F_train %>% select(.,Title, Author) %>% group_by(.,Author) %>% summarise(.,Views = n()) %>% arrange(.,(desc(Views))) %>% head(.,5)
A = A_train %>% select(.,Title, Author) %>% group_by(.,Author) %>% summarise(.,Views = n()) %>% arrange(.,(desc(Views))) %>% head(.,5)
G = G_train %>% select(.,Title, Author) %>% group_by(.,Author) %>% summarise(.,Views = n()) %>% arrange(.,(desc(Views))) %>% head(.,5)
write.xlsx(G, "G_train.xlsx")
write.xlsx(A, "A_authors.xlsx")
write.xlsx(ef, "F_train.xlsx")
