library(psych)
library(factoextra)
library(jmv)

#read data
data <- read.csv("C:/Users/Eusebius/Desktop/Self-Initiated Projects/Pokemon Cluster Analysis R/pokemon.csv")

#descriptive analysis
describe(data)

#drop missing data
data_clean <- na.omit(data)
describe(data_clean)

#want clustering variables to be continuous and have good spread
#clustering variables selected - height_m, weight_kg, base_egg_steps, base_happiness, capture_rate, experience_growth, hp, attack, defense, speed

#select relevant columns
data1 <- data_clean[, c("height_m", "weight_kg", "base_egg_steps", "base_happiness", "capture_rate", "experience_growth", "hp", "attack", "defense", "speed")]

#standardize all columns given the scale sensitivity of cluster analysis
#convert all non-numeric columns to numeric first (capture_rate)
data1$capture_rate <- as.numeric(data1$capture_rate)
str(data1)
data1_scaled <- scale(data1)
describe(data1_scaled)

#distance measure --> euclidean
edist <- dist(data1_scaled, method = "euclidean")

#hierarchical clustering
hc <- hclust(edist, method = "ward.D2")
plot(hc)

#visualise cluster solutions to see which one fits best
rect.hclust(hc, k=3)
rect.hclust(hc, k=2)
rect.hclust(hc, k=4)

#no cluster solution seems to generate an even number of pokemons in each cluster. Need to change linkage method/try alternative distance measure/try alternative clustering methods

#try k-means clustering

#explore 2 seeds
k2 <-kmeans(data1_scaled,centers=2,nstart=50)
fviz_cluster(k2, data = data1_scaled)
table(k2$cluster)


#explore 3 seeds
k3 <-kmeans(data1_scaled,centers=3,nstart=50)
fviz_cluster(k3, data = data1_scaled)
table(k3$cluster)


#explore 4 seeds
k4 <-kmeans(data1_scaled,centers=4,nstart=50)
fviz_cluster(k4, data = data1_scaled)
table(k4$cluster)

#from k-means clustering - 2 cluster solution seems to have the most even split of observations across the clusters

#interpretation of 2-cluster solution from k-means clustering
new_data <- cbind(data_clean, k2$cluster)
chisq.test(new_data[,"is_legendary"], new_data[,"k2$cluster"]) #significant
t.test(new_data[,"against_ice"], new_data[,"k2$cluster"]) #significant
t.test(new_data[,"against_psychic"], new_data[,"k2$cluster"]) #significant
t.test(new_data[,"against_fairy"], new_data[,"k2$cluster"]) #significant
t.test(new_data[,"against_steel"], new_data[,"k2$cluster"]) #significant
chisq.test(new_data[,"generation"], new_data[,"k2$cluster"]) #not significant

#conclusions and limitations
#2 cluster solution from k-means clustering seems to give clusters with predictive utility about status of Pokemon.
#can look to explore what other variables this cluster solution is able to discriminate on
#more work needs to be done to properly interpret the clusters