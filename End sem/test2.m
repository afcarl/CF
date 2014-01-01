%%ALS Demo

%%Case I: No regularization

%%Fully specified matrix
m = 10; n = 10; f=3;

%Iterations
num_iter=100;

%Ratings matrix
R=randn(m,n);

%Initial random P matrix
P=randn(m,f);

norm_error=zeros(num_iter+1,1);
norm_error(1,1)=1;
for i=1:num_iter
    %Estimate Qt using P with least norm
    cvx_begin
    variable Q_new(f,n);
    minimize(norm(P*Q_new-R));
    cvx_end;

    Qt=Q_new;

    %Estimate P using Qt
    cvx_begin
    variable P_new(m,f);
    minimize(norm(P_new*Qt-R));
    cvx_end;

    P=P_new;
    norm_error(i+1,1)=norm(P*Qt-R);
    if norm_error(i+1,1)==norm_error(i,1)
        break
    end
    disp(sprintf('After iteration %d, the norm error is %f',i,norm(P*Qt-R)));
end

%%Now, we have the solution after solving ALS for P and Q