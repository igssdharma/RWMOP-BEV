classdef RWMOP_BEV < PROBLEM
    % <multi> <real> <constrained>
    % Real world multi-objective optimization problem for safery design for
    % battery electric vehicle

    methods
        %% Initialization
        function Setting(obj)
            obj.M        = 3;  % Number of objectives
            obj.D        = 4;  % Number of decision variables
            obj.lower    = [50, 20, 3, 0.3];
            obj.upper    = [70, 40, 12, 2.2];
            obj.encoding = ones(1, obj.D);
        end
        
        %% Evaluate multiple solutions
        function Population = Evaluation(obj, varargin)
            x = varargin{1};
            theta1 = x(:,1);
            theta2 = x(:,2);
            L = x(:,3);
            t = x(:,4);

            % Polynomial equations for CFE, E, and DeltaT
            CFE = 0.0001*theta1.^3 + 0.0001*theta1.^2.*theta2 + 0.0001*theta1.^2.*L - 0.0009*theta1.^2.*t - 0.0224*theta1.^2 - 0.0003*theta1.*theta2.^2 + 0.0003*theta1.*theta2.*L - 0.0014*theta1.*theta2.*t + 0.0050*theta1.*theta2 - 0.0003*theta1.*L.^2 + 0.0042*theta1.*L.*t - 0.0188*theta1.*L - 0.0225*theta1.*t.^2 + 0.1788*theta1.*t + 1.2756*theta1 - 0.0001*theta2.^3 + 0.0002*theta2.^2.*L - 0.0013*theta2.^2.*t + 0.0269*theta2.^2 + 0.0006*theta2.*L.^2 + 0.0023*theta2.*L.*t - 0.0351*theta2.*L - 0.0106*theta2.*t.^2 + 0.1540*theta2.*t - 0.8966*theta2 + 0.0014*L.^3 - 0.0008*L.^2.*t - 0.0308*L.^2 + 0.0008*L.*t.^2 - 0.2771*L.*t + 1.4240*L - 0.0890*t.^3 + 1.9531*t.^2 - 8.9196*t - 17.0998;

            E = 0.0151*theta1.^3 + 0.0379*theta1.^2.*theta2 + 0.1119*theta1.^2.*L - 0.6574*theta1.^2.*t - 4.0181*theta1.^2 - 0.0256*theta1.*theta2.^2 + 0.0040*theta1.*theta2.*L + 1.4367*theta1.*theta2.*t - 4.1190*theta1.*theta2 - 0.0764*theta1.*L.^2 - 3.0997*theta1.*L.*t - 7.5665*theta1.*L - 3.7894*theta1.*t.^2 + 71.3853*theta1.*t + 285.4930*theta1 - 0.0706*theta2.^3 + 0.0811*theta2.^2.*L + 3.1115*theta2.^2.*t + 1.6589*theta2.^2 - 0.3679*theta2.*L.^2 - 10.6363*theta2.*L.*t + 16.5895*theta2.*L + 63.4626*theta2.*t.^2 - 358.6048*theta2.*t + 252.6931*theta2 - 1.0730*L.^3 + 2.6734*L.^2.*t + 38.1248*L.^2 - 35.3495*L.*t.^2 + 548.9912*L.*t - 724.6903*L + 535.7692*t.^3 - 3396.0282*t.^2 + 5206.2792*t - 6486.4304;

            DeltaT = 0.0013*theta1.^3 - 0.0003*theta1.^2.*theta2 + 0.0067*theta1.^2.*L - 0.0277*theta1.^2.*t - 0.2529*theta1.^2 - 0.0020*theta1.*theta2.^2 + 0.0024*theta1.*theta2.*L - 0.0057*theta1.*theta2.*t + 0.1401*theta1.*theta2 + 0.0141*theta1.*L.^2 + 0.0116*theta1.*L.*t - 1.1230*theta1.*L - 0.4040*theta1.*t.^2 + 4.3840*theta1.*t + 15.8797*theta1 - 0.0046*theta2.^3 + 0.0047*theta2.^2.*L - 0.0245*theta2.^2.*t + 0.5215*theta2.^2 + 0.0111*theta2.*L.^2 - 0.0712*theta2.*L.*t - 0.4792*theta2.*L + 0.1232*theta2.*t.^2 + 2.2273*theta2.*t - 19.3515*theta2 + 0.0044*L.^3 + 0.0442*L.^2.*t - 1.3927*L.^2 - 0.3302*L.*t.^2 + 1.3138*L.*t + 51.2655*L + 2.5949*t.^3 + 16.8272*t.^2 - 194.4988*t - 182.6406;

            % Objective functions
            f(:, 1) = -CFE;
            f(:, 2) = -E;
            f(:, 3) = -DeltaT;

            % Constraints to ensure non-negativity and CFE between 0 and 1
            g(:, 1) = -CFE;    % CFE must be >= 0
            g(:, 2) = CFE - 1; % CFE must be <= 1
            g(:, 3) = -E;      % E must be >= 0
            g(:, 4) = -DeltaT; % DeltaT must be >= 0
            g(:, 5) = DeltaT - 25; % DeltaT must be <= 25

            % Create a SOLUTION object (adjust the input arguments as per your SOLUTION class definition)
            Population = SOLUTION(varargin{1}, f, g, varargin{2:end});
            obj.FE = obj.FE + length(Population);
        end
        
        %% Generate a point for hypervolume calculation
        function R = GetOptimum(obj, ~)
            R = [0.0000, 0.4269, 5.3605];
        end
    end
end
