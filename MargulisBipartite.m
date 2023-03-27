
S=n^2;
A=zeros(S,S);

w=zeros(2,5);
link=zeros(S,5);

for i=1:1:S

    % relate each entry of the matrix to an element of Z_n x Z_n
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

    % associate to each element its neighbors

    w(:,1)=mod([x;y],n);
    w(:,2)=mod([x+1;y],n);
    w(:,3)=mod([x;y+1],n);
    w(:,4)=mod([x;y+x],n);
    w(:,5)=mod([-y;x],n);

    % recover the matrix entry from the element of Z_n x Z_n and create and
    % add 1 in the matrix when to entries whose corresponding elements are
    % linked
    for k=1:1:5
        s=w(1,k);
        t=w(2,k);

        if s==0
            s=n;
        end
        if t==0
            t=n;
        end

        link(i,k)=(s-1)*n+t;

        A(i,link(i,k))=A(i, link(i,k))+1;

    end
end

% create the corrispondent UNDIRECTED bipartite graph
m=S;
big_A = [zeros(m,m), A;
         A', zeros(m,m)];

G = graph(big_A);

for i=1:1:2*S
        for j=i+1:1:2*S
            if big_A(i,j)>1
                for k=2:1:big_A(i,j)
                    G=addedge(G,i,j,1);
                end
            end
        end
end

figure(1);
% Plot
h = plot(G);
% Make it pretty
h.XData(1:m) = 1;
h.XData((m+1):end) = 2;
h.YData(1:m) = linspace(0,1,m);
h.YData((m+1):end) = linspace(0,1,m);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% create the corrispondent DIRECTED bipartite graph

big_B = [zeros(m,m), A;
         zeros(S,S), zeros(m,m)];

H=digraph(big_B);

for i=1:1:2*S
        for j=i+1:1:2*S
            if big_B(i,j)>1
                for k=2:1:big_B(i,j)
                    H=addedge(H,i,j,1);
                end
            end
        end
end

figure(2)
% Plot
h = plot(H);
% Make it pretty
h.XData(1:m) = 1;
h.XData((m+1):end) = 2;
h.YData(1:m) = linspace(0,1,m);
h.YData((m+1):end) = linspace(0,1,m);
h.NodeLabel = {};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%