function y=removal_cp(y_rx,L_fft,L_cp)
L=length(y_rx);
L_temp=fix(L/L_fft);
y_rmcp=[];
for i=0:(L_temp-1)
    y_rmcp(i*L_fft+1:i*L_fft+L_fft)=y_rx(i*(L_fft+L_cp)+L_cp+1:i*(L_fft+L_cp)+L_cp+L_fft);
end
%y=reshape(x_cp,(L+(L*L_cp)/L_ifft),1);
y=y_rmcp;