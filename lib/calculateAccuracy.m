function [accuracy, true_labels, CM, corLabel] = calculateAccuracy(yte, y)
%# Function for calculating clustering accuray and matching found 
%# labels with true labels. Assumes yte and y both are Nx1 vectors with
%# clustering labels. Does not support fuzzy clustering.
%#
%# Algorithm is based on trying out all reorderings of cluster labels, 
%# e.g. if yte = [1 2 2], try [1 2 2] and [2 1 1] so see witch fit 
%# the truth vector the best. Since this approach makes use of perms(),
%# the code will not run for unique(yte) greater than 10, and it will slow
%# down significantly for number of clusters greater than 7.
%#
%# Input:
%#   yte - result from clustering (y-test)
%#   y   - truth vector
%#
%# Output:
%#   accuracy    -   Overall accuracy for entire clustering (OA). For
%#                   overall error, use OE = 1 - OA.
%#   true_labels -   Vector giving the label rearangement witch best 
%#                   match the truth vector (y).
%#   CM          -   Confusion matrix. If unique(yte) = 4, produce a
%#                   4x4 matrix of the number of different errors and  
%#                   correct clusterings done.

N = length(y);
cluster_names = unique([yte' y']);
%cluster_names = unique(yte);
accuracy = 0;
maxInd = 1;

perm = perms(unique([yte' y']));
%perm = perms(unique(y));
[pN pM] = size(perm);

true_labels = y;

for i=1:pN
    if iscell(cluster_names),
        flipped_labels = {};
    else
        flipped_labels = zeros(1,N);
    end;
    for cl = 1 : pM
        if iscell(cluster_names),
            for tt=1:N,
                if strcmp(yte{tt},cluster_names(cl)),                
                    flipped_labels{tt} = perm{i,cl};
                end;
            end;
        else
            flipped_labels(yte==cluster_names(cl)) = perm(i,cl);
        end;
    end
    if iscell(cluster_names),
        testAcc=sum(strcmp(flipped_labels, y))/N;        
    else
        testAcc = sum(flipped_labels == y')/N;
    end;
    if testAcc > accuracy
        accuracy = testAcc;
        maxInd = i;
        true_labels = flipped_labels;
    end

end
corLabel=perm(maxInd,:);  % the corresponding relations between true labels and the test results.

CM = zeros(pM,pM);
% for rc = 1 : pM
%     for cc = 1 : pM
%         CM(rc,cc) = sum( ((y'==rc) .* (true_labels==cc)) );
%     end
% end