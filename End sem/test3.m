%%Fully specified matrix
m = 10; n = 10; f=3;

%Iterations
num_iter=10;

%Ratings matrix
R=randint(m,n);

%Initial random P matrix
P=randint(m,f);

%%

    cvx_begin
    variable Q_new(f,n);
    minimize(norm(P*Q_new-R));
    cvx_end;

    Qt=Q_new;
    
    % computing P_new from Qt
    cvx_begin
    variable P_new(m,f);
    minimize(norm(P_new*Qt-R));
    cvx_end;
    
    norm_error = norm(P_new*Qt-R);
    
    NMAE = norm(P_new*Qt-R)/(max(max(R))-min(min(R)));