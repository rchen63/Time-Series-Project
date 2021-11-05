function SAX_plot(i,paa,data)   

% Input: 
%        i: User selected index of the data and paa
%        paa: PAA dataset
%        data: Original dataset of the PAA dataset
% Output:
%        It outputs a SAX plot.

    % Gaussian Distrubution, there 6 sections, a, b, c, d, e, and f
    a = [-inf, -0.97];
    b = [-0.97, -0.43];
    c = [-0.43, 0];
    d = [0, 0.43];
    e = [0.43, 0.97];
    f = [0.97, inf];
    SAX = [];
    
    % Horizontal lines to indicate each section
    yline(-0.97, ':');
    yline(-0.43, ':');
    yline(0, ':');
    yline(0.43, ':');
    yline(0.97, ':');
    
    % Label the PAA base on their value
    for k = 1:size(paa,2)
        if paa(i,k)>a(1) && paa(i,k)<=a(2)
            SAX(k)=1;
        elseif paa(i,k)>b(1) && paa(i,k)<=b(2)
            SAX(k)=2;
        elseif paa(i,k)>c(1) && paa(i,k)<=c(2)
            SAX(k)=3;
        elseif paa(i,k)>d(1) && paa(i,k)<=d(2)
            SAX(k)=4;
        elseif paa(i,k)>e(1) && paa(i,k)<=e(2)
            SAX(k)=5;
        elseif paa(i,k)>f(1) && paa(i,k)<f(2)
            SAX(k)=6;
        end
    end

    % Number of segments
    PAA_segmentations = size(paa,2);
    
    % Length of the data
    lengthOfSample=size(data,2);
    
    % Length of segment
    segmentLength=ceil(lengthOfSample/PAA_segmentations);

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
    
    %-------------------------------------------
    % Plot SAX base on PAA
    %-------------------------------------------
    segment_n = 1;
    hold on
    for j = 1:2:PAA_segmentations*2
        SAX_y=[];
        SAX_x=[];
        SAX_y(1) = paa(i,segment_n);
        SAX_y(2) = paa(i,segment_n);
        SAX_x(1) = PAA_x(j);
        SAX_x(2) = PAA_x(j+1);
        if SAX(segment_n) == 1      %Label a is red
            plot(SAX_x,SAX_y, 'r','LineWidth',3);
        elseif SAX(segment_n) == 2  %Label b is green
            plot(SAX_x,SAX_y, 'g','LineWidth',3);
        elseif SAX(segment_n) == 3  %Label c is blue
            plot(SAX_x,SAX_y, 'b','LineWidth',3);
        elseif SAX(segment_n) == 4  %Label d is cyan
            plot(SAX_x,SAX_y, 'c','LineWidth',3);
        elseif SAX(segment_n) == 5  %Label e is magenta
            plot(SAX_x,SAX_y, 'm','LineWidth',3);
        elseif SAX(segment_n) == 6  %Label f is orange
            plot(SAX_x,SAX_y, 'color',[0.8500 0.3250 0.0980],'LineWidth',3);
        end
        segment_n  = segment_n + 1;
    end

    
end
