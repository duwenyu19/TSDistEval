function RunDMComp(DataSetStartIndex, DataSetEndIndex, DistanceIndex)

    % Distance Matrices for ED and SBD
    Methods = [cellstr('ED'), 'SBD'];

    % first 2 values are '.' and '..' - UCR Archive 2018 version has 128 datasets
    dir_struct = dir('./UCR2018-NEW/');
    Datasets = {dir_struct(3:130).name};
                     
    % Sort Datasets
    
    [Datasets, ~] = sort(Datasets);

    poolobj = gcp('nocreate');
    delete(poolobj);
    
    parpool(18);
    
    for i = 1:length(Datasets)
        
        if (i>=DataSetStartIndex && i<=DataSetEndIndex)

            disp(['Dataset being processed: ', char(Datasets(i))]);
            DS = LoadUCRdataset(char(Datasets(i)));
            
            DM = DMComp(DS.Data, DistanceIndex);
            
            %FileName = strcat( '/tartarus/jopa/Projects/TSDistEval/code/DM/',char(Datasets(i)),'/', char(Datasets(i)),'_',char(Methods(DistanceIndex)), '_distmatrix' ); 
            %ZipName = strcat( '/tartarus/jopa/Projects/TSDistEval/code/DM/',char(Datasets(i)),'/', char(Datasets(i)),'_',char(Methods(DistanceIndex)),'.zip'); 
           
            dlmwrite( strcat( '/tartarus/jopa/Projects/TSDistEval/code/DM/',char(Datasets(i)),'/', char(Datasets(i)),'_',char(Methods(DistanceIndex)), '.distmatrix' ), DM, 'delimiter', ',');
            %zip(ZipName,FileName);
            %delete strcat( '/tartarus/jopa/Projects/TSDistEval/code/DM/',char(Datasets(i)),'/', char(Datasets(i)),'_',char(Methods(DistanceIndex)), '_distmatrix' );
            
        end
        
    end
    
    poolobj = gcp('nocreate');
    delete(poolobj);

end