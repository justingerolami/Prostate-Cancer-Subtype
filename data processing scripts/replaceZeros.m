function dataout = replaceZeros(datain, method)
%replaces zeros in the input data with:
%method: nan - with NaNs
%        lowval - with values that are 10 in the power of the (exponent-1) 
%                   of the lowest value in the datain.
%                    e.g. if the minimum value in the datain is 0.089, 
%                   then the 0s will the replaced with 0.001
%       for any other value in method - no change;
%datain format: rows - miRNAs, collumns - samples, datain is double

dataout = datain;

flag = datain>0;

if strcmpi(method, 'nan')
    %dataout(~flag) = nan;
    dataout(~flag) = 0.00001;
elseif strcmpi(method, 'lowval')
    %add very small value to the counts with 0 relative to other values
    m = min(dataout(flag));
    exponent=floor(log10(abs(m)))-1;
    dataout(~flag) = 10.^exponent;
end
