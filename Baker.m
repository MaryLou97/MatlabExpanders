clc

A=zeros(2^n,2^n);

for k=1:1:2^n

    % neighbors of vertex k
    if k <= (2^n)/2
        k1=2*k;
        k2=2*k-1;
    else 
        k1=2*k-2^n;
        k2=(2*k-2^n)-1;
    end

    k3=ceil(k/2);
    k4=ceil((k+2^n)/2);

    % add undirected edge between k and its neighbors
    A(k,k1)=A(k,k1)+1;
    A(k,k2)=A(k,k2)+1;
    A(k,k3)=A(k,k3)+1;
    A(k,k4)=A(k,k4)+1;

end

G=graph(A);

% Create multiple edges where adjaciency matrix is >1

for i=1:1:2^n
    for j=1:1:i-1
        if A(i,j)>1
            for e=2:1:A(i,j)
                G=addedge(G,i,j,1);
            end
        end
    end
end

plot(G, 'Layout', 'circle');

