% Add polyfitn to path (ensure the path is correct)
addpath('C:\Users\gedes\AppData\Roaming\MathWorks\MATLAB Add-Ons\Toolboxes\polyfitn');

% Load your data from the workspace
theta1 = MLDataPLATEMO4.theta1;
theta2 = MLDataPLATEMO4.theta2;
L = MLDataPLATEMO4.L;
t = MLDataPLATEMO4.t;
CFE = MLDataPLATEMO4.CFE;
E = MLDataPLATEMO4.EJ;
DeltaT = MLDataPLATEMO4.DeltaT;

% Prepare the input matrix
X = [theta1, theta2, L, t];

% Fit polynomial models using polyfitn with order 3
model_CFE_poly = polyfitn(X, CFE, 3);
model_E_poly = polyfitn(X, E, 3);
model_DeltaT_poly = polyfitn(X, DeltaT, 3);

% Display polynomial models
disp('CFE Polynomial Model:');
disp(model_CFE_poly);
disp('E Polynomial Model:');
disp(model_E_poly);
disp('DeltaT Polynomial Model:');
disp(model_DeltaT_poly);

% Extract coefficients and terms
coeffs_CFE = model_CFE_poly.Coefficients;
coeffs_E = model_E_poly.Coefficients;
coeffs_DeltaT = model_DeltaT_poly.Coefficients;

terms_CFE = model_CFE_poly.ModelTerms;
terms_E = model_E_poly.ModelTerms;
terms_DeltaT = model_DeltaT_poly.ModelTerms;

% Variable names
var_names = {'theta1', 'theta2', 'L', 't'};

% Create polynomial equations
equation_CFE = 'CFE = ';
equation_E = 'E = ';
equation_DeltaT = 'DeltaT = ';

% Construct the equations term by term
for i = 1:length(coeffs_CFE)
    term = '';
    for j = 1:length(var_names)
        if terms_CFE(i, j) > 0
            if terms_CFE(i, j) == 1
                term = strcat(term, sprintf('*%s', var_names{j}));
            else
                term = strcat(term, sprintf('*%s^%d', var_names{j}, terms_CFE(i, j)));
            end
        end
    end
    if isempty(term)
        term = '1'; % For the constant term
    end
    equation_CFE = strcat(equation_CFE, sprintf(' + (%.4f)%s', coeffs_CFE(i), term));
end

for i = 1:length(coeffs_E)
    term = '';
    for j = 1:length(var_names)
        if terms_E(i, j) > 0
            if terms_E(i, j) == 1
                term = strcat(term, sprintf('*%s', var_names{j}));
            else
                term = strcat(term, sprintf('*%s^%d', var_names{j}, terms_E(i, j)));
            end
        end
    end
    if isempty(term)
        term = '1'; % For the constant term
    end
    equation_E = strcat(equation_E, sprintf(' + (%.4f)%s', coeffs_E(i), term));
end

for i = 1:length(coeffs_DeltaT)
    term = '';
    for j = 1:length(var_names)
        if terms_DeltaT(i, j) > 0
            if terms_DeltaT(i, j) == 1
                term = strcat(term, sprintf('*%s', var_names{j}));
            else
                term = strcat(term, sprintf('*%s^%d', var_names{j}, terms_DeltaT(i, j)));
            end
        end
    end
    if isempty(term)
        term = '1'; % For the constant term
    end
    equation_DeltaT = strcat(equation_DeltaT, sprintf(' + (%.4f)%s', coeffs_DeltaT(i), term));
end

% Display the equations
disp('Polynomial Equation for CFE:');
disp(equation_CFE);
disp('Polynomial Equation for E:');
disp(equation_E);
disp('Polynomial Equation for DeltaT:');
disp(equation_DeltaT);
