function PAA_plot(i,paa,data) 

% Input: 
%        i: User selected index of the data and paa
%        paa: PAA dataset
%        data: Original dataset of the PAA dataset
% Output:
%        It outputs a PAA plot with the original data.



    PAA_segmentations = size(paa,2); % Number of segments in PAA
    lengthOfSample=size(data,2);       % Length of original data


    segmentLength=ceil(lengthOfSample/PAA_segmentations); % Length of Segment need to be integer

    %-------------------------------------------
    % Create the x and y axis of PAA plot
    %-------------------------------------------

    % Initialize x and y axis
    PAA_x=zeros(1,PAA_segmentations*2-2);
    PAA_y=zeros(1,PAA_segmentations*2-2);
    PAA_x(1)=0; 
    PAA_y(1)=paa(i,1);

    % x-axis of PAA
    segment_n=1;
    for n=2:2:(PAA_segmentations-1)*2
        PAA_x(n)=segment_n*segmentLength;
        PAA_x(n+1)=segment_n*segmentLength;
        segment_n = segment_n + 1;
    end
    PAA_x(PAA_segmentations*2)=lengthOfSample;

    % y-axis of PAA
    segment_n=1;
    for n=1:2:PAA_segmentations*2

        PAA_y(n) = paa(i,segment_n);
        PAA_y(n+1) = paa(i,segment_n);
        segment_n = segment_n + 1;
    end
    paa(i,:)
    PAA_x
    PAA_y
    %-------------------------------------------
    % Plot PAA
    %-------------------------------------------
    plot(PAA_x,PAA_y,"b");
    hold on
    t=linspace(1,lengthOfSample,lengthOfSample);
    plot(t,data(i,:),'color',[0.4940 0.1840 0.5560])

end