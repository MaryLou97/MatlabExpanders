clc

% Verify that the input is a prime number
ok=0;
for n=1:1:p-1
    if p==6*n+1 || p==6*n-1
        ok=1;
    end
end

if ok==1
        A=zeros(p,p);

        % create the neighbors
        for i=1:1:p
            for j=1:1:p
                if i==j-1
                    A(i,j)=1;
                end
                if i==j+1
                    A(i,j)=1;
                end
                if mod((i-1)*(j-1),p)==1
                    A(i,j)=A(i,j)+1;
                end
            end
        end

A(1,p)=1; A(p,1)=1;

A(1,1)=1;

G=graph(A);

% Create multiple edges where adjaciency matrix is >1

    for k=1:1:p             
        for j=k+1:1:p
            if A(k,j)>1
                for i=2:1:A(k,j)
                    G=addedge(G,j,k,1);
                end
            end
        end
    end

plot(G, 'Layout', 'circle', 'NodeLabel', 0:p-1);


end
