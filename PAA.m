function paa = PAA(numberOfSegments,data) 

% Inputs :
%           NumberOfSegments: User selected number of segments of PAA
%           Data: User input data
% Output:
%           paa: PAA dataset, it reduces the dimensionality of the original data

    dataSize=size(data);
    numberOfSample=dataSize(1);
    lengthOfSample=dataSize(2);

    segmentLength=ceil(lengthOfSample/numberOfSegments);

    paa=[];

    %Create PAA for every sample
    for i=1:numberOfSample
        for segmentN=1:numberOfSegments
            PAA_segment=[];
            PAACounter=1;
            lowerBound=(segmentN-1)*segmentLength;
            upperBound=segmentN*segmentLength;
            for j=lowerBound+1:upperBound
                if j <=lengthOfSample
                    PAA_segment(PAACounter)=data(i,j);
                    PAACounter = PAACounter + 1;
                end
            end
            if size(PAA_segment) > 0
                paa(i,segmentN)=mean(PAA_segment); 
            end
        end
    end

end