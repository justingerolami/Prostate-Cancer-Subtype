function mark2remove = markLowCounts(datain, cutoff, percent)
%rows - features, columns - samples

if (~exist('percent')) || isempty(percent)
    numToCut = 1;
else
    [~,n] = size(datain);
    numToCut = (percent*n)/100;
end

mark2remove = false(size(datain, 1), 1);

if cutoff>1
    disp('wrong input, the least %of reads should be a number betwee 0-1');
    return
end
%keep miRNAs with at least 85% of reads in at least one sample - all data
t = reshape(datain, [1 size(datain,1)*size(datain,2)]);

readTop = quantile(t, cutoff)

ind = datain >= readTop;
sum(ind(1,:))
for i=1:size(datain, 1)
    if sum(ind(i,:)) < numToCut
        mark2remove(i) = true;
    end
end
