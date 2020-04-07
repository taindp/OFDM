function y=zero_pad(x_16qam,L_ifft,L_sub)
r=ceil(length(x_16qam)/L_sub);
x_pad=zeros(L_ifft*r,1);
z1=ceil((L_ifft-L_sub)/2)+1;   %549
z2=ceil(L_sub/2);              %1500
for k=0:r-1
    if(k<r-1)
        x_pad(k*L_ifft+z1:k*L_ifft+z1+z2-1)=x_16qam(k*L_sub+1:k*L_sub+z2);
        x_pad(k*L_ifft+z1+z2+1:k*L_ifft+z1+2*z2)=x_16qam(k*L_sub+z2+1:k*L_sub+L_sub);
    else
        L_f=length(x_16qam)-k*L_sub; 
        if L_f==0
            x_pad(k*L_ifft+z1:k*L_ifft+z1+z2-1)=x_16qam(k*L_sub+1:k*L_sub+z2);
            x_pad(k*L_ifft+z1+z2+1:k*L_ifft+z1+2*z2)=x_16qam(k*L_sub+z2+1:k*L_sub+L_sub);
        else
            z3=ceil((L_ifft-L_f)/2)+1;
            z4=ceil(L_f/2);
            x_pad(k*L_ifft+z3:k*L_ifft+z3+z4-1)=x_16qam(k*L_sub+1:k*L_sub+z4);
            x_pad(k*L_ifft+z3+z4+1:k*L_ifft+z3+2*z4)=x_16qam(k*L_sub+z4+1:k*L_sub+L_f);
        end
    end
end
y=x_pad;