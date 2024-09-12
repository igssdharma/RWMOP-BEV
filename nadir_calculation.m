% Define a grid of points within the decision space to evaluate
theta1_vals = linspace(50, 70, 100);
theta2_vals = linspace(20, 40, 100);
L_vals = linspace(3, 12, 100);
t_vals = linspace(0.3, 2.2, 100);

[Theta1, Theta2, L, T] = ndgrid(theta1_vals, theta2_vals, L_vals, t_vals);

% Flatten the grids to pass as evaluation points
eval_points = [Theta1(:), Theta2(:), L(:), T(:)];

% Evaluate the polynomial equations at these points
CFE = 0.0001*eval_points(:,1).^3 + 0.0001*eval_points(:,1).^2.*eval_points(:,2) + 0.0001*eval_points(:,1).^2.*eval_points(:,3) - 0.0009*eval_points(:,1).^2.*eval_points(:,4) - 0.0224*eval_points(:,1).^2 - 0.0003*eval_points(:,1).*eval_points(:,2).^2 + 0.0003*eval_points(:,1).*eval_points(:,2).*eval_points(:,3) - 0.0014*eval_points(:,1).*eval_points(:,2).*eval_points(:,4) + 0.0050*eval_points(:,1).*eval_points(:,2) - 0.0003*eval_points(:,1).*eval_points(:,3).^2 + 0.0042*eval_points(:,1).*eval_points(:,3).*eval_points(:,4) - 0.0188*eval_points(:,1).*eval_points(:,3) - 0.0225*eval_points(:,1).*eval_points(:,4).^2 + 0.1788*eval_points(:,1).*eval_points(:,4) + 1.2756*eval_points(:,1) - 0.0001*eval_points(:,2).^3 + 0.0002*eval_points(:,2).^2.*eval_points(:,3) - 0.0013*eval_points(:,2).^2.*eval_points(:,4) + 0.0269*eval_points(:,2).^2 + 0.0006*eval_points(:,2).*eval_points(:,3).^2 + 0.0023*eval_points(:,2).*eval_points(:,3).*eval_points(:,4) - 0.0351*eval_points(:,2).*eval_points(:,3) - 0.0106*eval_points(:,2).*eval_points(:,4).^2 + 0.1540*eval_points(:,2).*eval_points(:,4) - 0.8966*eval_points(:,2) + 0.0014*eval_points(:,3).^3 - 0.0008*eval_points(:,3).^2.*eval_points(:,4) - 0.0308*eval_points(:,3).^2 + 0.0008*eval_points(:,3).*eval_points(:,4).^2 - 0.2771*eval_points(:,3).*eval_points(:,4) + 1.4240*eval_points(:,3) - 0.0890*eval_points(:,4).^3 + 1.9531*eval_points(:,4).^2 - 8.9196*eval_points(:,4) - 17.0998;

E = 0.0151*eval_points(:,1).^3 + 0.0379*eval_points(:,1).^2.*eval_points(:,2) + 0.1119*eval_points(:,1).^2.*eval_points(:,3) - 0.6574*eval_points(:,1).^2.*eval_points(:,4) - 4.0181*eval_points(:,1).^2 - 0.0256*eval_points(:,1).*eval_points(:,2).^2 + 0.0040*eval_points(:,1).*eval_points(:,2).*eval_points(:,3) + 1.4367*eval_points(:,1).*eval_points(:,2).*eval_points(:,4) - 4.1190*eval_points(:,1).*eval_points(:,2) - 0.0764*eval_points(:,1).*eval_points(:,3).^2 - 3.0997*eval_points(:,1).*eval_points(:,3).*eval_points(:,4) - 7.5665*eval_points(:,1).*eval_points(:,3) - 3.7894*eval_points(:,1).*eval_points(:,4).^2 + 71.3853*eval_points(:,1).*eval_points(:,4) + 285.4930*eval_points(:,1) - 0.0706*eval_points(:,2).^3 + 0.0811*eval_points(:,2).^2.*eval_points(:,3) + 3.1115*eval_points(:,2).^2.*eval_points(:,4) + 1.6589*eval_points(:,2).^2 - 0.3679*eval_points(:,2).*eval_points(:,3).^2 - 10.6363*eval_points(:,2).*eval_points(:,3).*eval_points(:,4) + 16.5895*eval_points(:,2).*eval_points(:,3) + 63.4626*eval_points(:,2).*eval_points(:,4).^2 - 358.6048*eval_points(:,2).*eval_points(:,4) + 252.6931*eval_points(:,2) - 1.0730*eval_points(:,3).^3 + 2.6734*eval_points(:,3).^2.*eval_points(:,4) + 38.1248*eval_points(:,3).^2 - 35.3495*eval_points(:,3).*eval_points(:,4).^2 + 548.9912*eval_points(:,3).*eval_points(:,4) - 724.6903*eval_points(:,3) + 535.7692*eval_points(:,4).^3 - 3396.0282*eval_points(:,4).^2 + 5206.2792*eval_points(:,4) - 6486.4304;

DeltaT = 0.0013*eval_points(:,1).^3 - 0.0003*eval_points(:,1).^2.*eval_points(:,2) + 0.0067*eval_points(:,1).^2.*eval_points(:,3) - 0.0277*eval_points(:,1).^2.*eval_points(:,4) - 0.2529*eval_points(:,1).^2 - 0.0020*eval_points(:,1).*eval_points(:,2).^2 + 0.0024*eval_points(:,1).*eval_points(:,2).*eval_points(:,3) - 0.0057*eval_points(:,1).*eval_points(:,2).*eval_points(:,4) + 0.1401*eval_points(:,1).*eval_points(:,2) + 0.0141*eval_points(:,1).*eval_points(:,3).^2 + 0.0116*eval_points(:,1).*eval_points(:,3).*eval_points(:,4) - 1.1230*eval_points(:,1).*eval_points(:,3) - 0.4040*eval_points(:,1).*eval_points(:,4).^2 + 4.3840*eval_points(:,1).*eval_points(:,4) + 15.8797*eval_points(:,1) - 0.0046*eval_points(:,2).^3 + 0.0047*eval_points(:,2).^2.*eval_points(:,3) - 0.0245*eval_points(:,2).^2.*eval_points(:,4) + 0.5215*eval_points(:,2).^2 + 0.0111*eval_points(:,2).*eval_points(:,3).^2 - 0.0712*eval_points(:,2).*eval_points(:,3).*eval_points(:,4) - 0.4792*eval_points(:,2).*eval_points(:,3) + 0.1232*eval_points(:,2).*eval_points(:,4).^2 + 2.2273*eval_points(:,2).*eval_points(:,4) - 19.3515*eval_points(:,2) + 0.0044*eval_points(:,3).^3 + 0.0442*eval_points(:,3).^2.*eval_points(:,4) - 1.3927*eval_points(:,3).^2 - 0.3302*eval_points(:,3).*eval_points(:,4).^2 + 1.3138*eval_points(:,3).*eval_points(:,4) + 51.2655*eval_points(:,3) + 2.5949*eval_points(:,4).^3 + 16.8272*eval_points(:,4).^2 - 194.4988*eval_points(:,4) - 182.6406;

% Filter out points where CFE is not between 0 and 1, or where any other objective is negative
valid_indices = (CFE >= 0) & (CFE <= 1) & (E >= 0) & (DeltaT >= 0);
CFE = CFE(valid_indices);
E = E(valid_indices);
DeltaT = DeltaT(valid_indices);

% Find the maximum values for each objective (nadir point)
nadir_CFE = min(CFE);
nadir_E = min(E);
nadir_DeltaT = min(DeltaT);

% Display the nadir point
fprintf('Nadir Point: CFE = %.4f, E = %.4f, DeltaT = %.4f\n', nadir_CFE, nadir_E, nadir_DeltaT);

