% init
lamd = 10;
u = 3;
N = 40;
t = 1/sqrt(N);
gMax = 10000;
count = 50;
q = ones(1, gMax, count); 
y = ones(gMax, N, count); 
F1 =  zeros(1,lamd);

for i = 1 : count
    g = 1; %  0 generation
    y1 = ones(lamd, N); %  for algorithm
    q1 = ones(1, lamd); % for algorithm    
while g<gMax % 
    
   for l = 1 : lamd %
    q1(l)=q(1,g, i) * exp(randn * t); % 
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
   y1Sort = y1(ind,:); % sorting y1 with vector sorting indexes
   q(1,g+1, i)=(1/u)*sum(q1Sort(1:u));
   y(g+1,:, i)=(1/u)*sum(y1Sort(1:u,:));
   F1 =  zeros(1,lamd);
    q1 = ones(1, lamd);  
   g=g+1;
end

end
average1 = (y(:,1, 1).^2);
average2 = (y(:,2, 1).^2);
average3 = (y(:,3, 1).^2);
average10 = (y(:,10, 1).^2);
average40 = (y(:,40, 1).^2);
averageq = (q(:,:,1));
for i = 2 : count
    averageq = [averageq; (q(:,:,i))];
    average1 = [average1  (y(:,1, i).^2)];
    average2 = [average2  (y(:,2, i).^2)];
    average3 = [average3  (y(:,3, i).^2)];
    average10 = [average10  (y(:,10, i).^2)];
    average40 = [average40  (y(:,40, i).^2)];
end

average1 = transpose(average1);
average2 = transpose(average2);
average3 = transpose(average3);
average10 = transpose(average10);
average40 = transpose(average40);

loglog(mean(average1),'k','DisplayName',sprintf('y1\n'))
grid on;
hold on;
loglog(mean(average2),'r','DisplayName',sprintf('y2\n'))
hold on;
loglog(mean(average3),'b','DisplayName',sprintf('y3\n'))
hold on;
loglog(mean(average10),'g','DisplayName',sprintf('y10\n'))
hold on;
loglog(mean(average40),'k','DisplayName',sprintf('y40\n'))
hold on;
loglog(mean(averageq),'--k','DisplayName',sprintf('q\n'))
legend('-DynamicLegend'); 
