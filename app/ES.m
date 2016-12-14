% init
lamd = 10;
u = 3;
N = 40;
t = 1/sqrt(N);

gMax = 1000;
count = 20;
q = ones(1, gMax, count); 

y = ones(gMax, N, count); 


F1 =  zeros(1,lamd);

for i = 1 : count
    g = 1; %  0 generation
    y1 = ones(lamd, N); %  for algorithm
    q1 = ones(1, lamd); % for algorithm    
while g<gMax % 
    
   for l = 1 : lamd %
    q1(l)=q(g, i) * exp(randn * t); % 
  %   z = transpose(mvnrnd(0, eye, gMax)); % gen Z vector
    z = randn(1, N);
    x = q1(l)*z; % 
    y1(l,:)=y(g,:, i)+x; %
        for iter = 1 : N % calculating F
            somval = iter*y1(l,iter).^2; % 
            F1(l)=F1(l)+somval ; % 
        end
   end
   [F1SORT,ind] = sort(F1, 'ascend'); % vector sorting
   q1Sort = q1(ind); % sorting q1 with vector sorting indexes
   %q1Sort = sort(q1);
   y1Sort = y1(ind,:); % sorting y1 with vector sorting indexes
   %y1Sort = sortrows(y1);
   q(g+1, i)=(1/u)*sum(q1Sort(1:u));
   y(g+1,:, i)=(1/u)*sum(y1Sort(1:u,:));
   F1 =  zeros(1,lamd);
    q1 = ones(1, lamd);  
   g=g+1;
end

end
test30 = (y(:,30, 1).^2);
for i = 2 : count
    test30 = [test30  (y(:,30, i).^2)];
end
test30 = transpose(test30);
%testtest = mean(test30);
%x1=1:1:gMax; 
loglog(mean(test30),'g')
hold on;
loglog(q(:,1),'b')
%hold off;
%plot(x1,y(2,:).^2,'c',x1,y(3,:).^2,'m',x1,y(4,:).^2,'y',x1,y(11,:).^2,'r',x1,y(141,:).^2,'g');
