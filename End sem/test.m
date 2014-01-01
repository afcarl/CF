m = 16;
n=8;
A= randint(m,n);
B= randint(m,1);

%%
x_ls = A \ B;

cvx_begin
    variable x(n)
    minimize( norm(A*x-B) )
cvx_end