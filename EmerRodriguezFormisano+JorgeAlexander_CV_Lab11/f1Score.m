function [F1,Precision,Recall] = f1Score(confus)
% -------------------------------------------------------------------------
% F1 Score (confus rows = True classes, cols = predicted classes)
% -------------------------------------------------------------------------
TP = diag(confus)';
FP = sum(confus) - diag(confus)';
FN = (sum(confus, 2) - diag(confus))';
Precision = TP./(TP+FP);
Recall = TP./(TP+FN);
F1 = 2 * (Precision.*Recall)./(Precision+Recall);
end

