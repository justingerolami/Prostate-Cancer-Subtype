function res = logTransform(data)
%choose 1e-6 instead of 0 to evoid cases where value is ~ 0 (e.g. 1e-12) 
%when log(value/total) < negativeInf; this happens when computing the freq 
%of the rest of mirs

%if value > 1e-6
%  res =  log(value/total)/log(2);
%else
%  res = negativeInf;
%end
%negativeInf = -22; %   %Value used to denote -infinity obtained in log(0)
                                %Also used when zero padding is done (at the right
                                %of the expression matrix) 
%t = min(data(data>0));
%eps = t/100;
%data = data+eps;
res = log2(data);