function DM = DMComp(X, DistanceIndex)

    [m, ~] = size(X);

    DM = zeros(m,m);

    parfor i=1:m-1
        %disp(i);
        rowi = X(i,:);
        tmpVector = zeros(1,m);
           for j=i+1:m
                rowj = X(j,:); 
                if DistanceIndex==1
                    tmpVector(j) = ED(rowi,rowj);
                elseif DistanceIndex==2
                    tmpVector(j) = 1-max( NCCc(rowi,rowj));
                end
           end    
        DM(i,:) = tmpVector;   
    end

    for i=1:m-1
           for j=i+1:m
                DM(j,i) = DM(i,j);
           end    
    end

    for i=1:m
        if DistanceIndex==1
            DM(i,i) = ED(X(i,:),X(i,:));
        elseif DistanceIndex==2
            DM(i,i) = 1-max( NCCc(X(i,:),X(i,:)) );
        end        
        
    end

end