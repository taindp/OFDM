%Xilinx System Generator
L=12345;
fs=61.44e6;
f=15.36e6;
L_ifft=4096;
L_fft=4096;
L_cp=288;
L_sub=3000;
N_tx=8;
N_rx=8;
%generate sine wave f=15.36Mhz
%n=0:1/fs:(L-1)/(fs);
if (mod(L,N_tx)>0)
    L_pad=L+(N_tx-mod(L,N_tx));
else
    L_pad=L;
end
fpga_clock=1/fs;
master_reset = zeros(200000,2);
for t = 0:199999
    master_reset(t+1,1) = t;
    master_reset(t+1,1) = master_reset(t+1,1)/(4*fs);
end
master_reset(1,2)=1;
%master_reset(2,2)=1;
%Control ROM

k_full_data=L_sub; %6000
k_full_zero1=(ceil(((L_ifft-k_full_data)/2))+L_cp)*2;
k_full_zero2=(floor(((L_ifft-k_full_data)/2)))*2;
k_full=k_full_zero1+k_full_zero2+2*k_full_data; 

k_full_block=(floor(L_pad/(2*k_full_data)));

k_final_data=(mod(L_pad,(2*k_full_data)));    %final samples
if(k_final_data ~= 0)
    k_final_zero1=(floor(((L_ifft-(k_final_data)/2)/2))+L_cp)*2;  %final samples zero
    k_final_zero2=(ceil(((L_ifft-(k_final_data)/2)/2)))*2;
    k_final=k_final_zero1+k_final_zero2+k_final_data;
else
    k_final_zero1=0;
    k_final_zero2=0;
    k_final=2;
end
%ROM Demodulation
rom_demodulation=zeros(256,1);
r1=bin2dec('00100010')+1;
r2=bin2dec('00101101')+1;
r3=bin2dec('00100111')+1;
r4=bin2dec('00101000')+1;
r5=bin2dec('11010010')+1;
r6=bin2dec('11011101')+1;
r7=bin2dec('11010111')+1;
r8=bin2dec('11011000')+1;
r9=bin2dec('01110010')+1;
r10=bin2dec('01111101')+1;
r11=bin2dec('01110111')+1;
r12=bin2dec('01111000')+1;
r13=bin2dec('10000010')+1;
r14=bin2dec('10001101')+1;
r15=bin2dec('10000111')+1;
r16=bin2dec('10001000')+1;
rom_demodulation(r1,1)=0;
rom_demodulation(r2,1)=4;
rom_demodulation(r3,1)=1;
rom_demodulation(r4,1)=5;
rom_demodulation(r5,1)=8;
rom_demodulation(r6,1)=12;
rom_demodulation(r7,1)=9;
rom_demodulation(r8,1)=13;
rom_demodulation(r9,1)=2;
rom_demodulation(r10,1)=6;
rom_demodulation(r11,1)=3;
rom_demodulation(r12,1)=7;
rom_demodulation(r13,1)=10;
rom_demodulation(r14,1)=14;
rom_demodulation(r15,1)=11;
rom_demodulation(r16,1)=15;
rom_demodulation=reshape(rom_demodulation,1,256);
%--------------------------------------------------------------------------
%----------------------------TRANSMITTER-----------------------------------
%parameter
x=zeros(1,L_pad);
%x(1:L)=sin(2*pi*f*n);
x(1:L)=randi(16,L,1);
%parse stream 8 antenna
x1=[];
x2=[];
x3=[];
x4=[];
x5=[];
x6=[];
x7=[];
x8=[];
for k=0:(L_pad-N_tx)/N_tx
    x1(k+1)=x(8*k+1);
    x2(k+1)=x(8*k+2);
    x3(k+1)=x(8*k+3);
    x4(k+1)=x(8*k+4);
    x5(k+1)=x(8*k+5);
    x6(k+1)=x(8*k+6);
    x7(k+1)=x(8*k+7);
    x8(k+1)=x(8*k+8);
end 

x_fix1=bin(fi(x1,0,16,12));
x_fix2=bin(fi(x2,0,16,12));
x_fix3=bin(fi(x3,0,16,12));
x_fix4=bin(fi(x4,0,16,12));
x_fix5=bin(fi(x5,0,16,12));
x_fix6=bin(fi(x6,0,16,12));
x_fix7=bin(fi(x7,0,16,12));
x_fix8=bin(fi(x8,0,16,12));

%16QAM

L_qam=ceil((L_pad-N_tx)/N_tx)+1;
x_16qam1=mod_16qam(x_fix1,L_qam);
x_16qam2=mod_16qam(x_fix2,L_qam);
x_16qam3=mod_16qam(x_fix3,L_qam);
x_16qam4=mod_16qam(x_fix4,L_qam);
x_16qam5=mod_16qam(x_fix5,L_qam);
x_16qam6=mod_16qam(x_fix6,L_qam);
x_16qam7=mod_16qam(x_fix7,L_qam);
x_16qam8=mod_16qam(x_fix8,L_qam);

%x_16qam=[x_16qam1;x_16qam2;x_16qam3;x_16qam4;x_16qam5;x_16qam6;x_16qam7;x_16qam8];

x_pad1=zero_pad(x_16qam1,L_ifft,L_sub);
x_pad2=zero_pad(x_16qam2,L_ifft,L_sub);
x_pad3=zero_pad(x_16qam3,L_ifft,L_sub);
x_pad4=zero_pad(x_16qam4,L_ifft,L_sub);
x_pad5=zero_pad(x_16qam5,L_ifft,L_sub);
x_pad6=zero_pad(x_16qam6,L_ifft,L_sub);
x_pad7=zero_pad(x_16qam7,L_ifft,L_sub);
x_pad8=zero_pad(x_16qam8,L_ifft,L_sub);
%x_pad=[reshape(x_pad1,1,12288);reshape(x_pad2,1,12288);reshape(x_pad3,1,12288);reshape(x_pad4,1,12288);reshape(x_pad5,1,12288);reshape(x_pad6,1,12288);reshape(x_pad7,1,12288);reshape(x_pad8,1,12288)];

%IFFT 4096
x_ifft1=ifft_tx(x_pad1,L_ifft);
x_ifft2=ifft_tx(x_pad2,L_ifft);
x_ifft3=ifft_tx(x_pad3,L_ifft);
x_ifft4=ifft_tx(x_pad4,L_ifft);
x_ifft5=ifft_tx(x_pad5,L_ifft);
x_ifft6=ifft_tx(x_pad6,L_ifft);
x_ifft7=ifft_tx(x_pad7,L_ifft);
x_ifft8=ifft_tx(x_pad8,L_ifft);


%Add Cyclic Prefix
x_cp1=add_cp(x_ifft1,L_ifft,L_cp);
x_cp2=add_cp(x_ifft2,L_ifft,L_cp);
x_cp3=add_cp(x_ifft3,L_ifft,L_cp);
x_cp4=add_cp(x_ifft4,L_ifft,L_cp);
x_cp5=add_cp(x_ifft5,L_ifft,L_cp);
x_cp6=add_cp(x_ifft6,L_ifft,L_cp);
x_cp7=add_cp(x_ifft7,L_ifft,L_cp);
x_cp8=add_cp(x_ifft8,L_ifft,L_cp);

%Parallel to Serial
TX=[x_cp1;x_cp2;x_cp3;x_cp4;x_cp5;x_cp6;x_cp7;x_cp8];

%----------------------------Channel MMSE----------------------------------

%Channel Matrix
H=sqrt(1/2).*(randn(N_rx,N_tx)+1i.*randn(N_rx,N_tx));
%Workspace to XSG
H11_r=real(H(1,1));
H11_i=imag(H(1,1));
H12_r=real(H(1,2));
H12_i=imag(H(1,2));
H21_r=real(H(2,1));
H21_i=imag(H(2,1));
H22_r=real(H(2,2));
H22_i=imag(H(2,2));

%noise
% snr_db=20;
% snr = 10^(snr_db/10);
% At=mean(mean(TX.'.*conj(TX.')));
% An=At/snr;
% n=sqrt(An/2).*(randn(N_rx,length(x_cp1))+1i.*randn(N_rx,length(x_cp1)));

%-----------------------------RECEIVER-------------------------------------
RX=H*TX;
%Serial to Parallel
y1=RX(1,:);
y2=RX(2,:);
y3=RX(3,:);
y4=RX(4,:);
y5=RX(5,:);
y6=RX(6,:);
y7=RX(7,:);
y8=RX(8,:);
%Removal Cyclic Prefix
y_rmcp1=removal_cp(y1,L_fft,L_cp);
y_rmcp2=removal_cp(y2,L_fft,L_cp);
y_rmcp3=removal_cp(y3,L_fft,L_cp);
y_rmcp4=removal_cp(y4,L_fft,L_cp);
y_rmcp5=removal_cp(y5,L_fft,L_cp);
y_rmcp6=removal_cp(y6,L_fft,L_cp);
y_rmcp7=removal_cp(y7,L_fft,L_cp);
y_rmcp8=removal_cp(y8,L_fft,L_cp);

%FFT 4096
y_fft1=fft_rx(y_rmcp1,L_fft);
y_fft2=fft_rx(y_rmcp2,L_fft);
y_fft3=fft_rx(y_rmcp3,L_fft);
y_fft4=fft_rx(y_rmcp4,L_fft);
y_fft5=fft_rx(y_rmcp5,L_fft);
y_fft6=fft_rx(y_rmcp6,L_fft);
y_fft7=fft_rx(y_rmcp7,L_fft);
y_fft8=fft_rx(y_rmcp8,L_fft);
%MMSE Estimation 8*8
g=(H'*H)\(H');
z=g*[y_fft1;y_fft2;y_fft3;y_fft4;y_fft5;y_fft6;y_fft7;y_fft8];
y_dm=demod_16qam(z);
xh=reshape(z,length(y_fft1)*N_tx,1);
const_16qam(xh);
