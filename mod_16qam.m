function y = mod_16qam(x_fix,L)
x_16qam=[];
for a=0:L-1
    for b=0:3
         if strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'0000')
            x_16qam(b+1,a+1)=1/sqrt(10)+1i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'0001')
            x_16qam(b+1,a+1)=1/sqrt(10)+3*1i/sqrt(10);
        
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'0010')
            x_16qam(b+1,a+1)=3/sqrt(10)+1i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'0011')
            x_16qam(b+1,a+1)=3/sqrt(10)+3*1i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'0100')
            x_16qam(b+1,a+1)=1/sqrt(10)-1i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'0101')
            x_16qam(b+1,a+1)=1/sqrt(10)-3i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'0110')
            x_16qam(b+1,a+1)=3/sqrt(10)-1i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'0111')
            x_16qam(b+1,a+1)=3/sqrt(10)-3i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'1000')
            x_16qam(b+1,a+1)=-1/sqrt(10)+1i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'1001')
            x_16qam(b+1,a+1)=-1/sqrt(10)+3i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'1010')
            x_16qam(b+1,a+1)=-3/sqrt(10)+1i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'1011')
            x_16qam(b+1,a+1)=-3/sqrt(10)+3i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'1100')
            x_16qam(b+1,a+1)=-1/sqrt(10)-1i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'1101')
            x_16qam(b+1,a+1)=-1/sqrt(10)-3i/sqrt(10);
            
        elseif strcmp(x_fix(19*a+1+4*b:19*a+4+4*b),'1110')
            x_16qam(b+1,a+1)=-3/sqrt(10)-1i/sqrt(10);
            
        else x_16qam(b+1,a+1)=-3/sqrt(10)-3i/sqrt(10);
        end
    end
end
y=reshape(x_16qam,4*L,1);