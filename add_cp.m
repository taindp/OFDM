function y=add_cp(x_ifft,L_ifft,L_cp)
L=length(x_ifft);
x_cp=[];
for i=0:(L/L_ifft-1)
    x_cp(i*(L_cp+L_ifft)+1:i*(L_cp+L_ifft)+L_cp)=x_ifft((i*L_ifft+L_ifft-L_cp+1):i*L_ifft+L_ifft);
    x_cp((i+1)*L_cp+i*L_ifft+1:(i+1)*L_cp+i*L_ifft+L_ifft)=x_ifft(i*L_ifft+1:i*L_ifft+L_ifft);
end
%y=reshape(x_cp,(L+(L*L_cp)/L_ifft),1);
y=x_cp;