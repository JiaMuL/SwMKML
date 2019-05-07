# SwMKML

Self-weighted multi-kernel multi-label learning for potential miRNA-disease associations prediction

Please refer to the Readme.pdf file for more details.

**Method Description**

We proposed a novel Self-weighted multi-kernel multi-label learning method for potential miRNA-disease associations prediction. We used multi-views, including several gaussian matrix calculated by gaussian kernel function and the miRNA functional similarity matrix as well as the disease semantic similarity matrix based on the latest version of MeSH descriptors and HMDD. We adopted a iterative and alternative optimization algorithm, and solved each of the variables separately by fixing other variables. Finally, the predicted miRNA-disease associations matrix was obtained by combining the miRNA space and disease space together.

**Method Requirements**

Our method was running in MATLAB, so we required users to install MATLAB version on their operating systems.

**Usage**

We provided two functions, case study and global leave-one-out cross-validation (LOOCV), for users. To run the case study, please load the script 'caseStudy.m' into your MATLAB programming environment and click 'run'. To run global LOOCV, please load the script 'global_loocv.m' accordingly and other operations are the same as that of case study. Users can also run the scripts in standard command-line mode, where you should input the following commands for each function, respectively:

matlab -nodisplay -nodesktop -nosplash -r "global_loocv;exit;"

matlab -nodisplay -nodesktop -nosplash -r "caseStudy;exit;"

All the datasets used in the code, i.e. miRNA functional similarity, disease semantic similarity and miRNA-disease associations are all provided in the corresponding 'datasets/*.mat'.

**Parameters**

There are three parameters alpha, beta and gamma in SwMKML. The default values for the three parameters are 1e-4, 10, 1, respectively. Users can change their value in "MultiKernelLearning.m" file.  

**Output**

The default output directory of SwMKML is under the same directory where the scripts locate and it can be changed in the 'caseStudy.m' and 'global_loocv.m' file accordingly. All the results are stored in '.mat' file for convenience. 

**Contact**

For any questions regarding our work, please feel free to contact us: wspzx9027@163.com.
