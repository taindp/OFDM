function y=demod_16qam(z)
s=size(z);
r=s(1);
c=s(2);
amp=abs(z);
agr=angle(z);
y_dm=[];
%y_map=[1+1i 1+3i 3+1i 3+3i 1-1i 1-3i 3-1i 3-3i -1+1i -1+3i -3+1i -3+3i -1-1i -1-3i -3-1i -3-3i].*(1/sqrt(10));
for m=1:r
   for n=1:c
       y_dm(m,n)=round(z(m,n)*sqrt(10));
   end
end
y=y_dm.*(1/sqrt(10));