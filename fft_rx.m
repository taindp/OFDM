function y=fft_rx(y_rmcp,L_fft)
L=length(y_rmcp);
y_fft=[];
for i=0:(L/L_fft-1)
   y_fft(i*L_fft+1:i*L_fft+L_fft)=fft((y_rmcp(i*L_fft+1:i*L_fft+L_fft)),L_fft);
end
%y=reshape(y_fft,L,1);
y=y_fft;