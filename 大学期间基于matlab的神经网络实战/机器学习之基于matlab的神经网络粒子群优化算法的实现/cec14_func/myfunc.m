
function[gbest,gbestval,pop]=myfunc(fhd,D,N,Max_Gen,VRmin,VRmax,varargin);
%------������ʼ������----------------------------------------------
%����Ҫô�����򲿷֣�Ҫô���ٶȸ��¡�����ֻ�����ٶȹ�ʽ��ʱ���ǿ��Եõ�һ�����Եĸ��Ƶ�

clc;
rand('state',sum(100*clock));
c=[0.5+log(2),0.5+log(2)];
%c=[2 2];
%w=1/(2*log(2));
w=0.9-(1:Max_Gen).*(0.5./Max_Gen)
Vmax=50;
Vmin=-50;
%------��ʼ����Ⱥ�ĸ���------------
%pbest ������ѣ�lbest ������ѣ�gbest��ȫ�����,VRmax,���ӷ�Χ��Vmin�ٶȷ�Χ��
pop=VRmin+(VRmax-VRmin).*rand(N,D);
vel=0.5*(Vmin+(Vmax-Vmin).*rand(N,D)-pop);
%vel=Vmin+2.*Vmax.*rand(N,D)
e=feval(fhd,pop',varargin{:});


%% ���弫ֵ��Ⱥ�弫ֵ
pbest=pop; %�������
pbestval=e;%���������Ӧ��ֵ
[gbestval bestindex]=min(e);
gbest=pbest(bestindex,:);%ȫ�����
%gbestrep=repmat(gbest,N,1);
n(1)=gbestval;

k=3;
%���˽ṹ
for i=1:N;
   a1=[1:i-1,i+1:N];
   a1= a1(randperm(N-1));
   a2=a1(1:k);
   a3(i,:)=[a2,i];
   a4=a3(i,:);
   [lbestval(i),a5]=min(pbestval(a3(i,:)));
    a6=a4(a5);
   lbest(i,:)=pbest(a6,:);%����
end
%�ڸ����ٶȹ�ʽ��ʱ�򣬿��Ը�������
%gbestrep=repmat(gbest,N,1);
%aa=c(1).*rand(N,D).*(pbest-pop)+c(2).*rand(N,D).*(gbestrep-pop);
%vel=w(j).*vel+aa;
  

%% ����Ѱ��

for j=2:Max_Gen;
    %�����ٶ�
       l=pop+c(2)*rand(N,D).*(lbest-pop);%����
       p=pop+c(1)*rand(N,D).*(pbest-pop);%�������
       G=(p+l+pop)/3;
       %aa=c(1).*rand(N,D).*(pbest-pop)+c(2).*rand(N,D).*(gbestrep-pop);
       %vel=w(j).*vel+aa;
       R=abs(G-pop);
       vel=w(j).*vel+G+(-1+rand(N,D)*2).*R
       vel=(vel>Vmax).*Vmax+(vel<=Vmax).*vel;
       vel=(vel<Vmin).*Vmin+(vel>=Vmin).*vel;
      %����λ�� 
       pop=vel+pop;
       pop=((pop>=VRmin)&(pop<=VRmax)).*pop...
            +(pop<VRmin).*(VRmin+0.25.*(VRmax-VRmin).*rand(N,D))+(pop>VRmax).*(VRmax-0.25.*(VRmax-VRmin).*rand(N,D));
      %pop=((pop>=VRmin)&(pop<=VRmax)).*pop...
          %+(pop<VRmin).*(VRmin)+(pop>VRmax).*(VRmax);
       vel=((pop>=Vmin)&(pop<=Vmax)).*vel+(pop<Vmin).*0+(pop>Vmax).*0;
      %��ȡ��Ӧֵ
       e=feval(fhd,pop',varargin{:});
       %����pbest����ʷ���
       t=(e<pbestval);
       m=repmat(t',1,D);
       pbest=m.*pop+(1-m).*pbest;
       pbestval=t.*e+(1-t).*pbestval;
       %����lbest���ֲ����
       for i=1:N;
        a7=a3(i,:);
       [lbestval(i),m1]=min(pbestval(a3(i,:)))
       a8=a7(m1);
       lbest(i,:)=pbest(a8,:);
       end
      %�õ�ȫ�����
       [gbestval id]=min(pbestval);
        n(j)=gbestval;
        gbest=pbest(id,:);
        gbestrep=repmat(gbest,N,1)
        %������˽ṹ
       if isequal(n(j-1),n(j));
          for i=1:N;
          a1=[1:i-1,i+1:N];
          a1= a1(randperm(N-1));
          a2=a1(1:k);
          a3(i,:)=[a2,i];
          a4=a3(i,:);
          [lbestval(i),a5]=min(pbestval(a3(i,:)));
           a6=a4(a5);
           lbest(i,:)=pop(a6,:);
          end
       end
end
      
           
   
end




         

    
        
    
 

       
          
     
       


    