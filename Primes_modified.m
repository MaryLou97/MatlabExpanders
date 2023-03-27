clc
ok=0;
for n=1:1:p-1
    if p==6*n+1 || p==6*n-1
        ok=1;
    end
end

if ok==1
        A=zeros(p-3,p-3);
        for i=3:1:p-1
            for j=3:1:p-1
                if i==j-1
                    A(i-2,j-2)=1;
                end
                if i==j+1
                    A(i-2,j-2)=1;
                end
                if mod((i-1)*(j-1),p)==1
                    A(i-2,j-2)=A(i-2,j-2)+1;
                end
            end
        end
A(1,p-3)=1; A(p-3,1)=1;
G=graph(A);

    for k=1:1:p-3             
        for j=k+1:1:p-3
            if A(k,j)>1
                for i=2:1:A(k,j)
                    G=addedge(G,j,k,1);
                end
            end
        end
    end

plot(G, 'Layout', 'circle', 'NodeLabel', {});

end
