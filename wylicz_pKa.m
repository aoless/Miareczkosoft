function [dV, dpH, Vsr, dpHdV, pKa1, ind] = wylicz_pKa(num)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

i = 2:(length(num(:,1)));

dV(i-1) = num((i),2) - num(i-1,2);
dpH(i-1) = num((i),3) - num(i-1,3);
Vsr(i-1) = (num((i),2) + num(i-1,2))/2;
dpHdV = (dpH./dV);
ind = find(dpHdV == max(dpHdV));
pKa1 =  max(dpHdV)/2;
end

