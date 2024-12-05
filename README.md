R scipt doing (1) hierarhical clustering and (2) k-means clustering on Pokemon Database (https://www.kaggle.com/datasets/rounakbanik/pokemon)

Hierarhical Clustering

    1. Chose 10 continuous variables as clustering variables
    2. Standardised variables given the scale sensitivity issue in cluster analysis (euclidean distance)
    3. Explored a 2,3,4 cluter solution
    4. None of the cluser solutions could evenly divide the Pokemon - need to try alternative methods

K-means Clustering
    1. Explored 2,3,4 cluster solutions
    2. Chose 2 cluster solution as it divided Pokemon into 2 groups fairly well (357 and 327 Pokemon in Clusters 1 and 2 respectively)
    3. Used the cluster solution to predict outcomes like against_ice, is_legendary etc
    4. Cluster solution has predicitve capabilitites
    5. Recommend more work be done to interpret the cluster solution, and explore what other variables cluster solution is able to interpret
