%{
Author:     Ray Chen (rchen63@buffalo.edu)
Project 2:  Time Series
            - Representation and classification is explored. 
            - Piecewise Aggregate Approximation (PAA) will be use to reduce
            the dimensionality.
            - Symbolic Aggregate Approximation (SAX) will be use to symbolize
            PAA, this helps visualize the data.
            
Inputs:     - Synthetic Control Chart Time Series Data Set
            (https://archive.ics.uci.edu/ml/datasets/Synthetic+Control+Chart+Time+Series)
            - PAA_segmentations: User can choose the number of segments of
            PAA, this can affect the accuracy of classification. (Line 87)
            
Outputs:    - PAA plot
            - SAX plot
            - Confusion matrix and accuracy of KNN classification using original dataset and
            Euclidean Distance
            - Confusion matrix and accuracy of KNN classification using original dataset and
            Manhattan Distance
            - Confusion matrix and accuracy of KNN classification using PAA dataset and
            Euclidean Distance
            - Confusion matrix and accuracy of KNN classification using PAA dataset and
            Manhattan Distance

Subroutine: - paa = PAA(numberOfSegments,data)
            - PAA_plot(i,paa,data)
            - SAX_plot(i,paa,data) 
            
Resources/References: 
            - Synthetic Control Chart Time Series Data Set
            (https://archive.ics.uci.edu/ml/datasets/Synthetic+Control+Chart+Time+Series)
            - Eamonn Keogh and Jessica Lin, SAX 
            (https://cs.gmu.edu/~jessica/sax.htm)
            (https://www.cs.ucr.edu/~eamonn/SAX.htm)
            - fitcknn: Fit k-nearest neighbor classifier
            (https://www.mathworks.com/help/stats/fitcknn.html)
            - predict: Predict labels using k-nearest neighbor classification model
            (https://www.mathworks.com/help/stats/classificationknn.predict.html)
%}

clc
clear
format compact
close all


 % There are 600 samples in the data.
 % Sample 1-100 is class "Normal"
 % Sample 101-200 is class "Cyclic"
 % Sample 201-300 is class "Increasing trend"
 % Sample 301-400 is class "Decreasing trend"
 % Sample 401-500 is class "Upward shift"
 % Sample 501-600 is class "Downward shift"
data=load("synthetic_control.data");

% Separate the data to train dataset and test dataset, the ratio of
% train dataset to test dataset is 7:3

% Train data
data_train(1:70,:) = data(1:70,:);
data_train(71:140,:) = data(101:170,:);
data_train(141:210,:) = data(201:270,:);
data_train(211:280,:) = data(301:370,:);
data_train(281:350,:) = data(401:470,:);
data_train(351:420,:) = data(501:570,:);
% Test data
data_test(1:30,:) = data(71:100,:);
data_test(31:60,:) = data(171:200,:);
data_test(61:90,:) = data(271:300,:);
data_test(91:120,:) = data(371:400,:);
data_test(121:150,:) = data(471:500,:);
data_test(151:180,:) = data(571:600,:);

% Create labels for train dataset
trainLabel(1:70,:) = "Normal";   %class 1 is Normal
trainLabel(71:140,:) = "Cyclic";  %class 2 is Cyclic
trainLabel(141:210,:) = "Increasing trend";  %class 3 is Increasing trend
trainLabel(211:280,:) = "Decreasing trend";  %class 4 is Decreasing trend
trainLabel(281:350,:) = "Upward shift";  %class 5 is Upward shift
trainLabel(351:420,:) = "Downward shift";  %class 6 is Downward shift

%Same labels are applied on test dataset.
testLabel(1:30,:) = "Normal";
testLabel(31:60,:) = "Cyclic";
testLabel(61:90,:) = "Increasing trend";
testLabel(91:120,:) = "Decreasing trend";
testLabel(121:150,:) = "Upward shift";
testLabel(151:180,:) = "Downward shift";

% Pre-process stage: Standardize the data
data_train = normalize(data_train,'zscore');
data_test = normalize(data_test,'zscore');

% PAA_segmentations is the number of segments in PAA
PAA_segmentations=10;         
dataSize=size(data_train);
numberOfSample=dataSize(1);
lengthOfSample=dataSize(2);

% Create PAA
paa = PAA(PAA_segmentations,data_train);

% Plot PAA
figure('Renderer', 'painters', 'Position', [100 100 1200 1200])
subplot(2,1,1)
PAA_plot(300,paa,data_train);
title("Piecewise Aggregate Approximation (PAA)",'FontSize',20)

% Plot SAX
subplot(2,1,2)
PAA_plot(300,paa,data_train);
SAX_plot(300,paa,data_train);
title("Symbolic Aggregate Approximation (SAX)",'FontSize',20)
hold off


figure('Renderer', 'painters', 'Position', [1300 100 1200 1200]) %This figure is for the confusion matrices

%  Manhattan distance function
mandist = @(p,w) sum(abs(bsxfun(@minus,p,w)),2);


% Classification using original dataset and Euclidean distance
org_mdl_eucli=fitcknn(data_train,trainLabel);   % Create the model using KNN classification, Euclidean Distance is used by default     
org_predictClass_eucli=predict(org_mdl_eucli,data_test);    % Predictction of test dataset using the model
% Calculate Accuracy
cnt=0;          
for i=1:length(org_predictClass_eucli)    
    if org_predictClass_eucli(i)==testLabel(i)
        cnt=cnt+1;
    end
end
ori_accuracy_eucli=cnt/length(org_predictClass_eucli);  %Accuracy
fprintf("The accuracy of classification using original dataset with Euclidean Distance is %0.4f \n",ori_accuracy_eucli)
c_org_eucli=confusionmat(testLabel,org_predictClass_eucli); % Create confusion matrix
subplot(2,2,1)
confusionchart(c_org_eucli);    %Display confusion matrix
title("Confusion matrix using Euclidean Distance with Original dataset")


% Classification using original dataset and Manhattan distance
org_mdl_manh=fitcknn(data_train,trainLabel,"Distance",@(p,w)mandist(p,w)); %Manhattan distance is used
org_predictClass_manh=predict(org_mdl_manh,data_test);
cnt=0;
for i=1:length(org_predictClass_manh)
    if org_predictClass_manh(i)==testLabel(i)
        cnt=cnt+1;
    end
end
ori_accuracy_manh=cnt/length(org_predictClass_manh);
fprintf("The accuracy of classification using original dataset with Manhattan Distance is %0.4f \n",ori_accuracy_manh)
c_org_manh=confusionmat(testLabel,org_predictClass_manh);
subplot(2,2,2)
confusionchart(c_org_manh);
title("Confusion matrix using Manhattan Distance with Original dataset")



% Generate paa data set
paaTest=PAA(PAA_segmentations,data_test);
paaTrainLabel=PAA(PAA_segmentations,trainLabel);
paaTrain=PAA(PAA_segmentations,data_train);


%Classification using PAA dataset and Euclidean distance
paa_mdl_eudli=fitcknn(paaTrain,trainLabel);
paa_predictClass_eudli=predict(paa_mdl_eudli,paaTest);
cnt=0;
for i=1:length(paa_predictClass_eudli)
    if paa_predictClass_eudli(i)==testLabel(i)
        cnt=cnt+1;
    end
end
paa_accuracy_eucli=cnt/length(paa_predictClass_eudli);
fprintf("The accuracy of classification using PAA dataset with Euclidean Distance is %0.4f \n",paa_accuracy_eucli)
c_paa_eudli=confusionmat(testLabel,paa_predictClass_eudli);
subplot(2,2,3)
confusionchart(c_paa_eudli);
title("Confusion matrix using Euclidean Distance with PAA dataset")


%Classification using PAA dataset and Manhattan distance
paa_mdl_manh=fitcknn(paaTrain,trainLabel,"Distance",@(p,w)mandist(p,w));
paa_predictClass_manh=predict(paa_mdl_manh,paaTest);
cnt=0;
for i=1:length(paa_predictClass_manh)
    if paa_predictClass_manh(i)==testLabel(i)
        cnt=cnt+1;
    end
end
paa_accuracy_manh=cnt/length(paa_predictClass_manh);
fprintf("The accuracy of classification using PAA dataset with Manhattan Distance is %0.4f \n",paa_accuracy_manh)
c_paa_manh=confusionmat(testLabel,paa_predictClass_manh);
subplot(2,2,4)
confusionchart(c_paa_manh);
title("Confusion matrix using Manhattan Distance with PAA dataset")






















