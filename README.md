# SwMKL
Self-weighted multi-kernel multi-label learning for potential miRNA-disease associations prediction

Method Description:
We proposed a novel Self-weighted multi-kernel multi-label learning method for potential miRNA-disease associations prediction. We used multi-views, including several gaussian matrix calculated by gaussian kernel function and the miRNA functional similarity matrix as well as the disease semantic similarity matrix based on the latest version of MeSH descriptors and HMDD. We adopted a iterative and alternative optimization algorithm, and solved each of the variables separately by fixing other variables. Finally, the predicted miRNA-disease associations matrix was obtained by combining the miRNA space and disease space together.

Method Requirements:
Our method was running in MATLAB, so we required users to install MATLAB version on their operating systems.

Usage:
Our project contained several major measurements, such as global loocv, 5-fold cv, lodocv and the ohmdd (perform on the old version HMDD v1.0 and validate on the latest version HMDD v2.0). You could simply open the corresponding M files to verify the results in MATLAB programming environment and press the "Run" button. Please make sure that the input data "datasets" folder as well as these several evaluation metrices files are under the same directory. And please set up the local working directory on your own computer, then the output files are stored in the same working directory.

The output prediction file is shown below:
miRNA disease association scores
hsa-let-7a-1   Head and Neck Neoplasms  0.999793886
hsa-let-7a-2   Head and Neck Neoplasms  0.999786375
hsa-let-7a-3   Head and Neck Neoplasms  0.999787052
hsa-let-7b     Head and Neck Neoplasms  0.999770004
hsa-let-7c     Head and Neck Neoplasms  0.999754566
hsa-let-7d     Head and Neck Neoplasms  0.999753530
hsa-let-7e     Head and Neck Neoplasms  0.999761556
hsa-let-7f-1   Head and Neck Neoplasms  0.999746466
hsa-let-7f-2   Head and Neck Neoplasms  0.999751186
hsa-let-7g     Head and Neck Neoplasms  0.999745392
......

Contact:
For any questions regarding our work, please feel free to contact us: wspzx9027@163.com.
