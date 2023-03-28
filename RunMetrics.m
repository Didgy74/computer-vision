%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Matlab code to calculate image quality metrics on the Colourlab Image
%Database: Image Quality. This code will calculate one or several metrics
%on all images in the database. If you are using the database and this code
%please cite our work. 
%Written by Marius Pedersen (marius.pedersen@hig.no)
% Version 1.0 - 23.06.14
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Citation:
%Xinwei Liu, Marius Pedersen and Jon Yngve Hardeberg. CID:IQ - A New Image 
%Quality Database. International Conference on Image and Signal Processing 
%(ICISP 2014). Vol. 8509. Cherbourg, France. Jul., 2014.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Example to run the code: 
% RunMetrics(50) %will run the code for a viewing distance of 50 cm
% RunMetircs(100) % will run the code for a viewing distance of 100 cm
%If you want to add your own metric see example on line 62. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [] = RunMetrics(d)

warning off

addpath('Metrics\'); %adding path to the metrics
dirDistortion = dir('Images\Reproduction\'); %directory to the reproductions
countDistortion = 0; %initializating counter


%%%Parameters linked with the experiment%%%
if nargin < 1 %if no viewing distance is specified set it to 50 cm
   d = 50;  
end
if(d==50) %if distance is set to 50 calculate the results for 50 cm
    distance = 50/2.54; %Distance from the monitor: cm/in. 
    SaveName = strcat('Results_CIDIQ_',date,'_',num2str(d),'.mat') ; 
elseif(d==100) %if distance is set to 100 calculate the results for 100 cm
    distance = 100/2.54; %Distance from the monitor: cm/in. 
    SaveName = strcat('Results_CIDIQ_',date,'_',num2str(d),'.mat') ; 
else
    error('Wrong viewing distance specified! Error');    
end
L=30; %ambient illumnination
dpi = 92; %Dots per inch (DPI) for the monitor
va = visualAngle(800, distance, dpi, -1); %the visual angle
SPD = visualAngle(-1, distance, dpi, 1); %pixels per degree
counter = 0; %initializing counter
mwb = MultiWaitBar(2, 1, 'Calculating image quality...', 'c'); %Initializing waitbar

for i =1:length(dirDistortion) %going through the different distortions
    if(isdir(dirDistortion(i).name) == 0) %If a folder continue
        countDistortion = countDistortion +1; %updating counter
        mwb.Update(1, 1, countDistortion/6,'Distortion...');%updating waitbar
        dirReproduction = dir(['Images\Reproduction\', dirDistortion(i).name, '\*.bmp']); %directory to the reproductions, search for BMPs
        disp(['Calculating distortion #', strrep(dirDistortion(i).name,'_' , ' '),'...']);
        for j=1:length(dirReproduction)
            counter = counter +1; %Counter to keep track of the results, updating. 
            mwb.Update(2, 1, j/length(dirReproduction),'Image...'); %updating waitbar
            %Reading files
            original2read = ['Images\Original\', dirReproduction(j).name(1:7), '.bmp']; %directory to the reproductions, search for BMPs
            IO = imread(original2read); %Reading original image
            IR = imread(['Images\Reproduction\',dirDistortion(i).name, '\', dirReproduction(j).name]); %Reading reproduction
            Results.Original_Name{counter} = [dirReproduction(j).name(1:7), '.bmp']; %Saving original name
            Results.Reproduction_Name{counter} = [dirDistortion(i).name, '\', dirReproduction(j).name]; %Saving reproduction name

            
            %%%%%Image Quality Metrics computed below this point%%%%%%%%%%%%%%%%%%%%
            
            %Example on how to add a metric%
%             a=0; %If a is set to 1 then run the metric, if set to 0, do not run it
%             if a==1 %If a ==1 then run the metric
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%             %%%METRIC NAME GOES HERE%%%  
%                 [outputvalue] = FunctionNAME(IO,IR); %running metric. Change FunctionNAME to the name of the metric function. IO is the original RGB image, IR is the reproduction RGB image.  
%                 Results.METRICNAME(counter)=outputvalue; %saving the results into a structure. Please change METRICNAME to the name of the metric. 
%                 clear outputvalue %clearing variable
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             end %end if    
            
            a=1; %If a is set to 1 then run the metric, if set to 0, do not run it
            if a==1 %If a ==1 then run the metric
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
            %%%PSNR%%%  
                [outputvalue] = PSNR(rgb2gray(IO),rgb2gray(IR)); %running PSNR metric. using RGB2gray to convert to a grayscale image. 
                Results.PSNR(counter)=outputvalue; %saving the results into a structure with the name of the metric
                clear outputvalue %clearing variable
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end %end if   
            
            a=1; %If a is set to 1 then run the metric, if set to 0, do not run it
            if a==1 %If a ==1 then run the metric
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
            %%% Saturation %%%  
                test = CV_SaturationRatio(IO, IR);
                Results.SaturationRatio(counter) = test;
                clear test;
            end %end if   

            a=1; %If a is set to 1 then run the metric, if set to 0, do not run it
            if a==1 %If a ==1 then run the metric
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
            %%% Saturation %%%  
                test = CV_SaturationRatio2(IO, IR);
                Results.SaturationRatio2(counter) = test;
                clear test;
            end %end if

            a=1; %If a is set to 1 then run the metric, if set to 0, do not run it
            if a==1 %If a ==1 then run the metric
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
            %%% Saturation %%%  
                test = CV_SaturationDiff(IO, IR);
                Results.SaturationDiff(counter) = test;
                clear test;
            end %end if

            a=1; %If a is set to 1 then run the metric, if set to 0, do not run it
            if a==1 %If a ==1 then run the metric
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
            %%% Saturation %%%  
                test = CV_SaturationDiffAbs(IO, IR);
                Results.SaturationDiffAbs(counter) = test;
                clear test;
            end %end if

            a=1; %If a is set to 1 then run the metric, if set to 0, do not run it
            if a==1 %If a ==1 then run the metric
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
            %%%Add your metric here%%%  
            
            end %end if   
            
            save(SaveName, 'Results','d'); %storing results after each image
    
        end
        
    end
end
mwb.Close(); %closing waitbar

%saving results
save(SaveName, 'Results', 'd');
disp('Finished calculating results... please run CorrCIDIQ.m to calculate the performance of the metric(s)');
end
