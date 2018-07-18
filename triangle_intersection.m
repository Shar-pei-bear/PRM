function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

% ax + by +c = 0

delta1 = P1 - circshift(P1,1,1);
delta2 = P2 - circshift(P2,1,1); 

a1 = delta1(:,2);
a2 = delta2(:,2);

b1 =-delta1(:,1);
b2 =-delta2(:,1);

c1 = -a1.*P1(:,1) - b1.*P1(:,2);
c2 = -a2.*P2(:,1) - b2.*P2(:,2);

P1_shift = circshift(P1,-1,1);
P2_shift = circshift(P2,-1,1);

sign1 = (a1.*P1_shift(:,1) + b1.*P1_shift(:,2) +c1) > 0;
sign2 = (a2.*P2_shift(:,1) + b2.*P2_shift(:,2) +c2) > 0;

sign3 = (a1*P2_shift(:,1)' + b1*P2_shift(:,2)' +c1*[1,1,1]) > 0;
sign4 = (a2*P1_shift(:,1)' + b2*P1_shift(:,2)' +c2*[1,1,1]) > 0;

if any(all(xor(sign1, sign3),2)) || any(all(xor(sign2, sign4),2))
    flag = false;
else
    flag = true;     
end
end