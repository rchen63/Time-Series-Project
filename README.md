# Time-Series-Project

# About
  
  University at Buffalo, Fall 2021, CSE 454 Project 2- Time Series Project
  
  More details and results are in the report.
  
  

# Author:     

  Ray Chen (rchen63@buffalo.edu)

# Project 2:  Time Series

  - Representation and classification is explored. 
  - Piecewise Aggregate Approximation (PAA) will be use to reduce
  the dimensionality.
  - Symbolic Aggregate Approximation (SAX) will be use to symbolize
  PAA, this helps visualize the data.
            
# Inputs:     
  - Synthetic Control Chart Time Series Data Set
  (https://archive.ics.uci.edu/ml/datasets/Synthetic+Control+Chart+Time+Series)
  - PAA_segmentations: User can choose the number of segments of
  PAA, this can affect the accuracy of classification. (Line 87)
            
# Outputs:    
  - PAA plot
  - SAX plot
  - Confusion matrix and accuracy of KNN classification using original dataset and
  Euclidean Distance
  - Confusion matrix and accuracy of KNN classification using original dataset and
  Manhattan Distance
  - Confusion matrix and accuracy of KNN classification using PAA dataset and
  Euclidean Distance
  - Confusion matrix and accuracy of KNN classification using PAA dataset and
  Manhattan Distance

# Subroutine: 
  - paa = PAA(numberOfSegments,data)
  - PAA_plot(i,paa,data)
  - SAX_plot(i,paa,data) 
            
# Resources/References: 
  - Synthetic Control Chart Time Series Data Set
  (https://archive.ics.uci.edu/ml/datasets/Synthetic+Control+Chart+Time+Series)
  - Eamonn Keogh and Jessica Lin, SAX 
  (https://cs.gmu.edu/~jessica/sax.htm)
  (https://www.cs.ucr.edu/~eamonn/SAX.htm)
  - fitcknn: Fit k-nearest neighbor classifier
  (https://www.mathworks.com/help/stats/fitcknn.html)
  - predict: Predict labels using k-nearest neighbor classification model
  (https://www.mathworks.com/help/stats/classificationknn.predict.html)
