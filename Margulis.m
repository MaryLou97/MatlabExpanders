clc
close all

T1=[1, 2; 0, 1];
T2=[1, 0; 2, 1];
e1=[1, 0];
e2=[0, 1];
S=n^2;
A=zeros(S,S);

w=zeros(2,8);
link=zeros(S,8);

for i=1:1:S
    for j=1:1:n
        if (j-1)*n + 1 <= i && i <= j*n
            x=j;
            if mod(i,n)==0
                y=n;
            else
                y=mod(i,n);
            end
        end
    end
%    v=[x;y];

    w(:,1)=mod([x+y;y],n);
    w(:,2)=mod([x;y+x],n);
    w(:,3)=mod([x+(y+1);y],n);
    w(:,4)=mod([x;y+(x+1)],n);
    w(:,5)=mod([x-y;y],n);
    w(:,6)=mod([x;y-x],n);
    w(:,7)=mod([x-(y+1);y],n);
    w(:,8)=mod([x;y-(x+1)],n);
    
%     w(:,1)=mod(T1*v,n);
%     w(:,2)=mod(T2*v,n);
%     w(:,3)=mod(w(1)+e1,n);
%     w(:,4)=mod(w(2)+e2,n);
%     w(:,5)=mod(inv(T1)*v,n);
%     w(:,6)=mod(inv(T2)*v,n);
%     w(:,7)=mod(w(1)-e1,n);
%     w(:,8)=mod(w(2)-e2,n);

    
    for k=1:1:8
        s=w(1,k);
        t=w(2,k);

        if s==0
            s=n;
        end
        if t==0
            t=n;
        end

        link(i,k)=(s-1)*n+t;

        A(i,link(i,k))=1;
        A(link(i,k),i)=1;

    end
end

H=graph(A);
G=graph(A,'omitselfloops');
link_copy=link;

for i=1:1:S
    loop=0;
    for k=1:1:8
        if link(i,k)==i
            loop=loop+1;
        end
    end

    if loop>0
        A(i,i)=loop;
        for j=1:1:loop/2
            G=addedge(G,i,i,1);
        end
    end

    for k=1:1:8             
        for j=k+1:1:8
            if link(i,k)==link(i,j) && link(i,k)~=0 && link(i,k)>i
                % [i,k,j]
                 G=addedge(G,i,link(i,k),1);
                 A(i,link(i,k))=A(i,link(i,k))+1;
                 A(link(i,k),i)=A(link(i,k),i)+1;
                 link(i,j)=0;
            end
        end
    end
end

%plot(G, 'Layout', 'circle', 'NodeLabel',{})

    