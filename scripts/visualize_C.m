data = csvread('../work/device_parameters.csv');

resx = data(1,1);%100.000 130.000 68.000
resy = data(1,2);
resz = data(1,3);

l = data(2,1)/resx;%15;96 108 28
w = data(2,2)/resy;% 9;
h = data(2,3)/resz;%10;

T = csvread('../work/C.out');
T_n = zeros(l,w,h);
i = 1;

for z = 1:h
    for y = 1:w
        for x = 1:l
            T_n(x,y,z) = T(i);
            X(i) = x;
            Y(i) = y;
            Z(i) = z;
            i =i+1;
        end
    end
end

%Ploting temperature at eachs location
x_new = repmat(1:  w,  l, 1,  h);
y_new = repmat((1:  l)',1,  w,  h);
z_new = repmat(reshape(1:  h,1,1,  h),  l,  w,1);
f1 = figure;
colormap(jet(256));


% Create axes

%codediagram=slice(x_new, y_new, z_new, T,[1 2 ], [1 2 ], 0:k_ran);
%diagram=slice(x_new, y_new, z_new, T,[  i_ran/2-1,   i_ran/2+1,   i_ran/2+ 3 ], [  j_ran/2 ], [55, 0.56*  k_ran-20:4:0.56*  k_ran+5,110]);%k_ran);
%diagram=slice(x_new, y_new, z_new, T,[(  j_ran)/2], [(  i_ran)/3 ], [  face]);%k_ran);
diagram=slice(x_new, y_new, z_new, T_n(:,:,:),[w/3-1, w/2, 2*w/3+2], [l/5,l/3,l/2,2*l/3,4*l/5], [3*h/5-1.5]);%k_ran);

xlabel('width')
ylabel('length')
zlabel('hieght')
disp("Plotting the temperature profile...")
cb = colorbar;
cb.Label.String = "Temperature rise (K)";
colormap(jet(256));
saveas(f1, '../output/temperature_profile.png');
%exit();

