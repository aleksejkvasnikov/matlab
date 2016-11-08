% init
lamd = 10;
u = 3;
N = 40;
t = 1/sqrt(N);
g = 1; %  0 generation
gMax = 1000;

q = ones(1, gMax); 
q1 = ones(1, lamd); % for algorithm
y = ones(gMax, gMax); 
y1 = ones(lamd, gMax); %  for algorithm

F1 =  zeros(1,lamd);

while g<gMax % 
    
   for l = 1 : lamd %
    q1(l)=q(g) * exp(randn * t); % 
    z = transpose(mvnrnd(0, eye, gMax)); % gen Z vector
    x = q1(l)*z; % 
    y1(l,:)=y(g,:)+x; %
        for iter = 1 : N % calculating F
            somval = iter*y1(l,iter).^2; % 
            F1(l)=F1(l)+somval ; % 
        end
   end
   [F1SORT,ind] = sort(F1, 'descend'); % vector sorting
   q1Sort = q1(ind); % sorting q1 with vector sorting indexes
   %q1Sort = sort(q1);
   y1Sort = y1(ind,:); % sorting y1 with vector sorting indexes
   %y1Sort = sortrows(y1);
   q(g+1)=(1/u)*sum(q1Sort(1:u));
   y(g+1,:)=(1/u)*sum(y1Sort(1:u,:));
   F1 =  zeros(1,lamd);
    q1 = ones(1, lamd);  
   g=g+1;
end
%x1=1:1:gMax; 
%plot(y(2,:).^2,'g')
%hold on;
plot(q,'b')
%hold off;
%plot(x1,y(2,:).^2,'c',x1,y(3,:).^2,'m',x1,y(4,:).^2,'y',x1,y(11,:).^2,'r',x1,y(141,:).^2,'g');