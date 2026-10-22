
# Set up code
suppressPackageStartupMessages({
  library(asreml)
  library(dplyr)
  library(gt)
  library(janitor)
})

AMBA<-openxlsx::read.xlsx("Fildbooks/2020/2020 AMBA LTT Field book.xlsx")

AMBA<- AMBA %>% janitor::clean_names()

AMBA$tw_b<-AMBA$test_weight_kg_hl/1.247

AMBA$y_g_sqm<-((AMBA$weight_kg*((100-AMBA$moisture)/88))*1000)/(1.524*3.63)
AMBA$Bu_ac<-((AMBA$y_g_sqm/454)*4046.86)/60

AMBA<-AMBA[order(AMBA$col, AMBA$row),]
AMBA<-AMBA[,c(1,3:5, 7, 26, 28)]
AMBA$exp<-"AMBA"
AMBA$year<-"2020"
AMBA$tw_b[AMBA$tw_b<20]<-NA
AMBA$Bu_ac[AMBA$Bu_ac<20]<-NA
FRT<-openxlsx::read.xlsx("Fildbooks/2020/2020 FRT MAD Fieldbook.xlsx")

FRT<- FRT %>% janitor::clean_names()

FRT$tw_b<-FRT$test_weight_kg_hetolitre/1.247
FRT$y_g_sqm<-((FRT$weight_kg*((100-FRT$moisture)/88))*1000)/(1.524*3.63)
FRT$Bu_ac<-((FRT$y_g_sqm/454)*4046.86)/60

FRT<-FRT[order(FRT$col, FRT$row),]
FRT<-FRT[,c(1,3:5, 7, 31, 33)]
FRT$exp<-"FRT"
FRT$year<-"2020"
FRT$tw_b[FRT$tw_b<20]<-NA
FRT$Bu_ac[FRT$Bu_ac<20]<-NA

HB<-openxlsx::read.xlsx("Fildbooks/2020/2020 HB MAD Fieldbook.xlsx")

HB<- HB%>% janitor::clean_names()
HB$tw_b<-HB$test_weight_kg_hl/1.247
HB$y_g_sqm<-((HB$plot_weight_kg*((100-HB$moisture_percent)/88))*1000)/(1.524*3.63)
HB$Bu_ac<-((HB$y_g_sqm/454)*4046.86)/60

HB<- HB[order(HB$col, HB$row),]
HB<-HB[,c(1,3:5, 7, 32, 34)]
HB$exp<-"HB"
HB$year<-"2020"
HB$tw_b[HB$tw_b<20]<-NA
HB$Bu_ac[HB$Bu_ac<20]<-NA


FRT21<-openxlsx::read.xlsx("Fildbooks/2021 FRT WNB RCBD.xlsx")

FRT21<- FRT21 %>% janitor::clean_names()

FRT21$tw_b<-((FRT21$test_weight_g_500_ml*200)/1000)/1.247
FRT21$y_g_sqm<-((FRT21$plot_weight_g*((100-FRT21$moisture_percent)/88)))/(1.524*3.2)
FRT21$Bu_ac<-((FRT21$y_g_sqm/454)*4046.86)/60

FRT21<-FRT21[order(FRT21$col, FRT21$row),]
FRT21<-FRT21[,c(1,3:6, 28, 30)]
FRT21$exp<-"FRT"
FRT21$year<-"2021"
#FRT21$tw_b[FRT21$tw_b<20]<-NA
FRT21$Bu_ac[FRT21$Bu_ac>100]<-NA



FRT23<-openxlsx::read.xlsx("Fildbooks/2023 NB FRT.xlsx")

FRT23<- FRT23 %>% janitor::clean_names()

FRT23$tw_b<-((FRT23$test_weight_g_500ml*200)/1000)/1.247
FRT23$y_g_sqm<-((FRT23$weight_kg*((100-FRT23$moisture_percent)/88))*1000)/(1.524*(FRT23$plot_length_feet*0.3048))
FRT23$Bu_ac<-((FRT23$y_g_sqm/454)*4046.86)/60

FRT23<-FRT23[order(FRT23$col, FRT23$row),]
FRT23<-FRT23[,c(1:4,6, 25, 27)]
FRT23$exp<-"FRT"
FRT23$year<-"2023"
#FRT23$tw_b[FRT23$tw_b<20]<-NA
#FRT23$Bu_ac[FRT23$Bu_ac>100]<-NA



FRT26<-openxlsx::read.xlsx("Fildbooks/2026 FRT MAD.xlsx")

FRT26<- FRT26 %>% janitor::clean_names()

FRT26$tw_b<-((FRT26$tw_g_500_m_l*200)/1000)/1.267
FRT26$y_g_sqm<-((FRT26$plot_weight_kg*1000)/(1.526*3.6))
FRT26$Bu_ac<-((FRT26$y_g_sqm/454)*4046.86)/60

FRT26<-FRT26[order(FRT26$col, FRT26$row),]
FRT26<-FRT26[,c(1:3,5:6, 17, 19)]
FRT26$exp<-"FRT"
FRT26$year<-"2026"


compare_df_cols(AMBA, HB, FRT, FRT21, FRT23, FRT26)

save(FRT, file="All years FRT.csv")

library(asreml)

asreml.options(maxit=100,extra=10) 



