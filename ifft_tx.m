function y=ifft_tx(x_pad,L_ifft)
L=length(x_pad);
x_ifft=[];
for i=0:(L/L_ifft-1)
   x_ifft(i*L_ifft+1:i*L_ifft+L_ifft)=ifft((x_pad(i*L_ifft+1:i*L_ifft+L_ifft)),L_ifft);
end
y=reshape(x_ifft,L,1);