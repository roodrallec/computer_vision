function Rates=validation(features, labels, subjects, F, k)
% VALIDATION: Validation of the classification method using F fold cross validation
% Outputs: 
% Rates, structure storing the validation rates.
if (~exist('k', 'var'))
    k=2;
end 
% Fold validation strategy
[error,FP,FN,TP,TN] = fold_validation(features, labels, subjects, F, k);

% Compute and store the mean rates of validation in 
error=mean(error);
FP=mean(FP);
FN=mean(FN);
TP=mean(TP);
TN=mean(TN);

Rates.Sens=TP/(TP+FN)*100;
Rates.Spec=TN/(TN+FP)*100;
Rates.Prec=TP/(TP+FP)*100;
Rates.FAR=FP/(FP+TN)*100;
Rates.Recall=TP/(TP+FN)*100;
Rates.Acc=(TP+TN)/(TP+TN+FP+FN)*100;
Rates.Error=error;
Rates.ConfusionMatrix=[TP FN; FP TN];



