function [name, PID, dataOut1, dataOut2] = Spar_Analysis_Function(dataIn);
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
% + 
% +  SE-160A:  Aerospace Structural Analysis I
% +
% +  Project: (1) Spar Analysis
% +
% +  Title:   Spar_Analysis_Function
% +  Author:  Student Name
% +  PID:     Student PID
% +  Revised: 01/29/2024
% +
% +  This function is the primary analysis function for the spar analysis 
% +  program.  All of the input data is brought into the function using 
% +  "dataIn". Next all the calculations are performed.  Finally, the 
% +  calculated results are written to "dataOut1" and "dataOut2", where 
% +  these two data sets are sent to the main program (p-code) where it is 
% +  written and plotted in an Excel output file.
% +
% +  SUMMARY OF SPAR ANALYSIS
% +
% +  A) SECTION PROPERTIES --DONE--
% +     A.1) Section Properties (EA EIyy, EIzz, EIyz)
% +     A.2) Torsion Constant (GJ)
% +  B) LOADS --DONE--
% +     B.1) Applied Concentrated Forces, Torque and Moment
% +     B.2) Distributed Aerodynamic Loads (lift, drag, moment)
% +     B.3) Spar Root Reactions - Axial, Shear, Torque, and Moment 
% +     B.4) Distributed Spar Internal Axial, Shear, Bend Moments, Torque
% +  C) INTERNAL STRESSES (Four Cross-Section Locations) --DONE--
% +     C.1) Root Spar Axial Stress (sxx) and Shear Stress (txs)
% +     C.2) Allowable Stress, and Root Margin of Safety
% +     C.3) Distributed Spar Axial Stress (sxx)
% +     C.4) Distributed Spar Shear Stress (tau)
% +  D) SPAR TIP DISPLACEMENTS, TWIST, AND BENDING SLOPES --DONE--
% +     D.1) Distributed Spar X-direction (Axial) Displacement 
% +     D.2) Distributed Spar Y-direction (Drag ) Displacement 
% +     D.3) Distributed Spar Z-direction (Lift ) Displacement 
% +     D.4) Distributed Spar Twist Rotation
% +     D.5) Distributed Spar Bending Slopes (dv/dx, dw/dx)
% +
% +  Input Data
% +     dataIn:           Packed input data (38)
% +       dataIn(01):     Number of Output Plot Data Points
% +       dataIn(02):     Spar Length (inch)
% +       dataIn(03):     Mean Cross-Section Radius (inch)
% +       dataIn(04):     Mean Cross-Section Thickness (inch)
% +       dataIn(05):     Material Density (lbf/in^3)
% +       dataIn(06):     Material Young's Modulus (Msi)
% +       dataIn(07):     Material Shear Modulus (Msi)
% +       dataIn(08):     Material Yield Strength - Tension (Ksi)
% +       dataIn(09):     Material Yield Strength - Compression (Ksi)
% +       dataIn(10):     Material Yield Strength - Shear (Ksi)
% +       dataIn(11):     Material Ultimate Strength - Tension (Ksi)
% +       dataIn(12):     Material Ultimate Strength - Compression (Ksi)
% +       dataIn(13):     Material Ultimate Strength - Shear (Ksi)
% +       dataIn(14):     Safety Factor - Yield
% +       dataIn(15):     Safety Factor - Ultimate
% +       dataIn(16):     First Load Location (x/L)
% +       dataIn(17):     Concentrated Force - X Direction (lb)
% +       dataIn(18):     Concentrated Force - Y Direction (lb)
% +       dataIn(19):     Concentrated Force - Z Direction (lb) 
% +       dataIn(20):     Concentrated Torque - About X Direction (lb-in)
% +       dataIn(21):     Concentrated Moment - About Y Direction (lb-in)
% +       dataIn(22):     Concentrated Moment - About Z Direction (lb-in)
% +       dataIn(23):     Second Load Location (x/L)
% +       dataIn(24):     Concentrated Force - X Direction (lb)
% +       dataIn(25):     Concentrated Force - Y Direction (lb)
% +       dataIn(26):     Concentrated Force - Z Direction (lb) 
% +       dataIn(27):     Concentrated Torque - About X Direction (lb-in)
% +       dataIn(28):     Concentrated Moment - About Y Direction (lb-in)
% +       dataIn(29):     Concentrated Moment - About Z Direction (lb-in)
% +       dataIn(30):     Aircraft Load Factor
% +       dataIn(31):     Drag Distribution - Constant (lb/in)
% +       dataIn(32):     Drag Distribution - rth order (lb/in)
% +       dataIn(33):     Drag Distribution - polynomial order
% +       dataIn(34):     Lift Distribution - Constant (lb/in)
% +       dataIn(35):     Lift Distribution - 2nd Order (lb/in)
% +       dataIn(36):     Lift Distribution - 4th Order (lb/in)
% +       dataIn(37):     Twist Moment Distribution - Constant (lb-in/in)
% +       dataIn(38):     Twist Moment Distribution - 1st Order (lb-in/in)
% +
% +  Output Data
% +     Name:             Name of author of this analysis function           
% +     PID:              UCSD Student ID number of author
% +     dataOut1:         Packed calculated output variable data
% +       dataOut1(01):   Axial   Stiffness EA   (lb)      --DONE--
% +       dataOut1(02):   Bending Stiffness EIyy (lb-in^2) --DONE--  
% +       dataOut1(03):   Bending Stiffness EIzz (lb-in^2) --DONE--  
% +       dataOut1(04):   Bending Stiffness EIyz (lb-in^2) --DONE--  
% +       dataOut1(05):   Torsion Stiffness GJ   (lb-in^2) --DONE--
% +       dataOut1(06):   Root Internal Force - X Direction (lb) --DONE--
% +       dataOut1(07):   Root Internal Force - Y Direction (lb) --DONE--
% +       dataOut1(08):   Root Internal Force - Z Direction (lb) --DONE--
% +       dataOut1(09):   Root Internal Moment - about X Direction (lb-in)D
% +       dataOut1(10):   Root Internal Moment - about Y Direction (lb-in)D 
% +       dataOut1(11):   Root Internal Moment - about Z Direction (lb-in)D
% +       dataOut1(12):   Allowable Stress - Tension (lb/in^2) --DONE--
% +       dataOut1(13):   Allowable Stress - Compression (lb/in^2) --DONE--
% +       dataOut1(14):   Allowable Stress - Shear (lb/in^2) --DONE--
% +       dataOut1(15):   Root Axial Stress - point A (lb/in^2) --DONE--
% +       dataOut1(16):   Root Axial Stress - point B (lb/in^2) --DONE--
% +       dataOut1(17):   Root Axial Stress - point C (lb/in^2) --DONE--
% +       dataOut1(18):   Root Axial Stress - point D (lb/in^2) --DONE--
% +       dataOut1(19):   Root Shear Stress xy - point A (lb/in^2) --DONE--
% +       dataOut1(20):   Root Shear Stress xy - point B (lb/in^2) --DONE--
% +       dataOut1(21):   Root Shear Stress xy - point C (lb/in^2) --DONE--
% +       dataOut1(22):   Root Shear Stress xy - point D (lb/in^2) --DONE--
% +       dataOut1(23):   Root Shear Stress xz - point A (lb/in^2) --DONE--
% +       dataOut1(24):   Root Shear Stress xz - point B (lb/in^2) --DONE--
% +       dataOut1(25):   Root Shear Stress xz - point C (lb/in^2) --DONE--
% +       dataOut1(26):   Root Shear Stress xz - point D (lb/in^2) --DONE--
% +       dataOut1(27):   Margin of Safety - point A --DONE--
% +       dataOut1(28):   Margin of Safety - point B --DONE--
% +       dataOut1(29):   Margin of Safety - point C --DONE--
% +       dataOut1(30):   Margin of Safety - point D --DONE--
% +       dataOut1(31):   Tip Diplacement  - X Direction (inch) --DONE--
% +       dataOut1(32):   Tip Diplacement  - Y Direction (inch) --DONE--
% +       dataOut1(33):   Tip Diplacement  - Z Direction (inch) --DONE--
% +       dataOut1(34):   Tip Twist (degree) --DONE--
% +       dataOut1(35):   Tip Bending Slope (dv/dx) (inch/inch) --DONE--
% +       dataOut1(36):   Tip Bending Slope (dw/dx) (inch/inch) --DONE--
% + 
% +     dataOut2:         Packed calculated output plot data
% +       column( 1):     X direction coordinate (inch)
% +       column( 2):     Applied distributed drag force (lb/in)   
% +       column( 3):     Aapplied distributed lift force (lb/in)   
% +       column( 4):     Applied distributed torque (lb-in/in)   
% +       column( 5):     Internal axial force  - Vx (lb)   
% +       column( 6):     Internal shear force  - Vy (lb)   
% +       column( 7):     Internal shear force  - Vz (lb)   
% +       column( 8):     Internal axial torque - Mx (lb-in)   
% +       column( 9):     Internal bending moment - My (lb-in)
% +       column(10):     Internal bending moment - Mz (lb-in) 
% +       column(11):     Axial Stress - point A (lb/in^2) 
% +       column(12):     Axial Stress - point B (lb/in^2) 
% +       column(13):     Axial Stress - point C (lb/in^2) 
% +       column(14):     Axial Stress - point D (lb/in^2) 
% +       column(15):     Shear Stress - point A (lb/in^2) 
% +       column(16):     Shear Stress - point B (lb/in^2) 
% +       column(17):     Shear Stress - point C (lb/in^2) 
% +       column(18):     Shear Stress - point D (lb/in^2)
% +       column(19):     Displacement - X Direction (inch) 
% +       column(20):     Displacement - Y Direction (inch) 
% +       column(21):     Displacement - z Direction (inch) 
% +       column(22):     Twist (degree)
% +       column(23):     Bending Slope (dv/dx) (inch/inch)
% +       column(24):     Bending Slope (dw/dx) (inch/inch)
% +
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#1): Unpack Input Data Array and Write User Name and PID
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (1) Unpack Input Data and Write User Name and PID')

   nplot = dataIn( 1);   % number of output plot data points
   Lo    = dataIn( 2);   % Spar Length (inch)
   Ro    = dataIn( 3);   % Mean Cross-Section Radius (inch)
   to    = dataIn( 4);   % Mean Cross-Section Thickness (inch)
   rho   = dataIn( 5);   % Material Density (lbf/in^3)
   Eo    = dataIn( 6);   % Material Young's Modulus (Msi)
   Go    = dataIn( 7);   % Material Shear Modulus (Msi)
   Syt   = dataIn( 8);   % Material Yield Strength - Tension (Ksi)
   Syc   = dataIn( 9);   % Material Yield Strength - Compression (Ksi)
   Sys   = dataIn(10);   % Material Yield Strength - Shear (Ksi)
   Sut   = dataIn(11);   % Material Ultimate Strength - Tension (Ksi)
   Suc   = dataIn(12);   % Material Ultimate Strength - Compression (Ksi)
   Sus   = dataIn(13);   % Material Ultimate Strength - Shear (Ksi)
   SFy   = dataIn(14);   % Safety Factor - Yield
   SFu   = dataIn(15);   % Safety Factor - Ultimate
   x1L   = dataIn(16);   % First Load Location (x/L)
   Fx1   = dataIn(17);   % Concentrated Force - X Direction (lb)
   Fy1   = dataIn(18);   % Concentrated Force - Y Direction (lb)
   Fz1   = dataIn(19);   % Concentrated Force - Z Direction (lb)   
   Mx1   = dataIn(20);   % Concentrated Torque - About X Direction (lb-in)
   My1   = dataIn(21);   % Concentrated Moment - About Y Direction (lb-in)
   Mz1   = dataIn(22);   % Concentrated Moment - About Z Direction (lb-in)
   x2L   = dataIn(23);   % Second Load Location (x/L)
   Fx2   = dataIn(24);   % Concentrated Force - X Direction (lb)
   Fy2   = dataIn(25);   % Concentrated Force - Y Direction (lb)
   Fz2   = dataIn(26);   % Concentrated Force - Z Direction (lb)   
   Mx2   = dataIn(27);   % Concentrated Torque - About X Direction (lb-in)
   My2   = dataIn(28);   % Concentrated Moment - About Y Direction (lb-in)
   Mz2   = dataIn(29);   % Concentrated Moment - About Z Direction (lb-in)
   LF    = dataIn(30);   % Aircraft Load Factor
   py0   = dataIn(31);   % Drag Distribution - Constant (lb/in)
   pyr   = dataIn(32);   % Drag Distribution - rth order (lb/in)
   rth   = dataIn(33);   % Drag Distribution - polynomial order
   pz0   = dataIn(34);   % Lift Distribution - Constant (lb/in)
   pz2   = dataIn(35);   % Lift Distribution - 2nd Order (lb/in)
   pz4   = dataIn(36);   % Lift Distribution - 4th Order (lb/in)
   mx0   = dataIn(37);   % Twist Moment Distribution - Constant (lb-in/in)
   mx1   = dataIn(38);   % Twist Moment Distribution - 1st Order (lb-in/in)

% Define author name and PID (Write in your name and PID)    
   name  = {'Jeremy Doan'};
   PID   = {'A16844657'};

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#2): Calculate the Section Properties
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (2) Calculate the Section Properties')
   Eo = Eo * 10 ^ 6;
   Go = Go * 10 ^ 6;
   Syt = Syt * 1000;
   Syc = Syc * 1000;
   Sys = Sys * 1000;   
   Sut = Sut * 1000;   
   Suc = Suc * 1000;  
   Sus = Sus * 1000;  
   
   R = Ro + (to /2);
   x1 = x1L * Lo;
   x2 = x2L * Lo;

   % Axial   Stiffness EA   (lb)
   a = Ro + (to / 2);
   b = Ro - (to / 2);
   A = pi * (a^2 - b^2);
   EA = Eo * A;

   % Bending Stiffness EIyy (lb-in^2)
   a = Ro + (to / 2);
   b = Ro - (to / 2);
   Iyy = (pi / 4) * (a^4 - b^4);
   EIyy = Eo * Iyy;

   % Bending Stiffness EIzz (lb-in^2)
   a = Ro + (to / 2);
   b = Ro - (to / 2);
   Izz = (pi / 4) * (a^4 - b^4);
   EIzz = Eo * Izz;

   % Bending Stiffness EIyz (lb-in^2)
   EIyz = 0;

   % Torsion Stiffness GJ   (lb-in^2) 
   a = Ro + (to / 2);
   b = Ro - (to / 2);
   J = (pi / 2) * (a^4 - b^4);
   GJ = Go * J;

   % Weight (lb)
   W = rho * A * Lo;
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#3): Calculate Root Internal Stress Resultants for Applied
% .                Concentrated Forces and Applied Aerodynamic Loads
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (3) Calculate Root Stress Resultants for Applied Concentrated Loads and Aero Loads')
   
   % Root Internal Force - X Direction (lb)
   Vxo = Fx1 + Fx2;

   % Root Internal Force - Y Direction (lb)
   Vyo = Fy1 + Fy2 + py0 * Lo + pyr * ((Lo ^ (rth + 1)) / ((rth + 1) * Lo ^ rth));

   % Root Internal Force - Z Direction (lb)
   Vzo = Fz1 + Fz2 + (pz0 * Lo) + (pz2/ (3 *(Lo^2)))*(Lo^3) + (pz4/(5 * (Lo^4)))*(Lo^5)...
   - (LF * W / Lo) * Lo;

   % Root Internal Moment - about X Direction (lb-in)
   Mxo = Mx1 + Mx2 + mx0 * Lo + mx1 * ((Lo ^ 2) / (2 * Lo));

   % Root Internal Moment - about Y Direction (lb-in)
   Myo = (-Fz1 * x1) + (-Fz2 * x2) + My1 + My2 - pz0 * ((Lo ^ 2) / 2) - pz2 * ((Lo ^ 4) / (4 * Lo ^ 2)) ...
   - pz4 * ((Lo ^ 6) / (6 * Lo ^ 4)) + (LF * W * Lo / 2);

   % Root Internal Moment - about Z Direction (lb-in)
   Mzo = -((Fy1 * x1) + (Fy2 * x2) + Mz1 + Mz2 - py0 * ((Lo ^ 2) / 2) - pyr *...
       ((Lo ^ (rth + 2)) / ((rth + 2) * (Lo ^ rth)))); 

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#4): Calculate Allowable Properties, Root Stresses and Margin
% .                of Safety
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (4) Calculate Allowable Properties, Root Stresses, and Margins of Safety')
 
   % Allowable Stress - Tension (lb/in^2)
   S_allow_T = (0.001) * min([(Syt / SFy), (Sut / SFu)]);

   % Allowable Stress - Compression (lb/in^2)
   S_allow_C = (0.001) * -min([abs((Syc / SFy)), abs((Suc / SFu))]);

   % Allowable Stress - Shear (lb/in^2)
   S_allow_S = (0.001) * min([(Sys / SFy), (Sus / SFu)]);

   % Root Axial Stress - point A (lb/in^2)
   Sxxo_A = (0.001) * (((-Vxo) / A) + (Myo * R) / Izz); 

   % Root Axial Stress - point B (lb/in^2)
   Sxxo_B = (0.001) * (((-Vxo ) / A) + (Mzo * R) / Iyy); 

   % Root Axial Stress - point C (lb/in^2)
   Sxxo_C = (0.001) * (((-Vxo ) / A) - (Myo * R) / Izz); 

   % Root Axial Stress - point D (lb/in^2)
   Sxxo_D = (0.001) * (((-Vxo ) / A) - (Mzo * R) / Iyy); 

   % Root Shear Stress xy - point A (lb/in^2)
   Txyo_A = (0.001) * ((Vyo / (pi * Ro * to)) - (Mxo * R / J)); 

   % Root Shear Stress xy - point B (lb/in^2)
   Txyo_B = 0; 

   % Root Shear Stress xy - point C (lb/in^2)
   Txyo_C = (0.001) * ((Vyo / (pi * Ro * to)) + (Mxo * R / J));

   % Root Shear Stress xy - point D (lb/in^2)
   Txyo_D = 0;

   % Root Shear Stress xz - point A (lb/in^2)
   Txzo_A = 0;

   % Root Shear Stress xz - point B (lb/in^2)
   Txzo_B = (0.001) * ((Vzo / (pi * Ro * to)) - (Mxo * R / J));

   % Root Shear Stress xz - point C (lb/in^2)
   Txzo_C = 0;

   % Root Shear Stress xz - point D (lb/in^2)
   Txzo_D = (0.001) * ((Vzo / (pi * Ro * to)) + (Mxo * R / J));

    % Margin of Safety - point A
   MS_A = -1 + (S_allow_T / (sqrt((Sxxo_A) ^ 2 + 3 * (Txyo_A ^ 2))));

   % Margin of Safety - point B
   MS_B = -1 + (S_allow_T / (sqrt((Sxxo_B) ^ 2 + 3 * (Txzo_B ^ 2))));
   
   % Margin of Safety - point C
   MS_C = -1 + (S_allow_T / (sqrt((Sxxo_C) ^ 2 + 3 * (Txyo_C ^ 2))));
   
   % Margin of Safety - point D
   MS_D = -1 + (S_allow_T / (sqrt((Sxxo_D) ^ 2 + 3 * (Txzo_D ^ 2))));

   % nplot
   x = linspace(0, Lo, nplot);
   % Initialize the variables
   Disp_X = zeros(1, nplot);
   Disp_Y = zeros(1, nplot);
   Disp_Z = zeros(1, nplot);
   Twist = zeros(1, nplot);
   DvDx = zeros(1, nplot);
   DwDx = zeros(1, nplot);

    
for ii = 1:nplot
   if 0 <= x(ii) & x(ii) <= x1
       
       % Tip Diplacement  - X Direction (inch)
       Disp_X(nplot) = (1 / (EA)) * (x(ii) * (-Vxo));
    
       % Tip Diplacement  - Y Direction (inch)
       Disp_Y(nplot) = (1 / EIyy) * ((-Vyo * (x(ii) .^ 3) / 6) + (Mzo * (x(ii) .^ 2) / 2) ...
           - (Mz1 * ((x(ii) .^ 2) / 2)) - (Mz2 * ((x(ii) .^ 2) / 2)) + ...
           (py0 * (x(ii) .^ 4) / 24) + pyr * ((x(ii) .^ (rth + 4)) / ((rth + 1) * (rth + 2) ...
           * (rth + 3) * (rth + 4) * Lo ^ rth)));
    
       % Tip Diplacement  - Z Direction (inch)  
       Disp_Z(nplot) = (1 / EIzz) * ((-Vzo * (x(ii) .^ 3) / 6) - (Myo * (x(ii) .^ 2) / 2) ...
           + (My1 * (x(ii) .^ 2) / 2) + (My2 * (x(ii) .^ 2) / 2) + ...
           (pz0 * (x(ii) .^ 4) / 24) + (pz2 * ((x(ii) .^ 6) / (360 * (Lo ^ 2)))) + ...
           (pz4 * (((x(ii) .^ 8) / (1680 * (Lo ^ 4))))) - (LF * W * ((x(ii) .^ 4) / (24* Lo))));
    
       % Tip Twist (degree)
       Twist(nplot) = rad2deg(1 / GJ) * (Mxo .* x(ii) - Mx1 .* x(ii) - Mx2 .* x(ii) - mx0 .*...
           ((x(ii) .^ 2) / 2) - mx1 .* ((x(ii) .^ 3) / (6 .* Lo)));  
    
       % Tip Bending Slope (dv/dx) (inch/inch)
       DvDx(nplot) = (1 / EIyy) * ((-Vyo * (x(ii) .^ 2) / 2) + (Mzo * x(ii)) ...
           - (Mz1 * x(ii)) - (Mz2 * x(ii)) + ...
           (py0 * (x(ii) .^ 3) / 6) + pyr * ((x(ii) .^ (rth + 3)) / ((rth + 1) * (rth + 2) ...
           * (rth + 3) * Lo ^ rth)));
    
       % Tip Bending Slope (dw/dx) (inch/inch)
       DwDx(nplot) = (1 / EIzz) * ((-Vzo * (x(ii) .^ 2) / 2) - (Myo * x(ii)) ...
           + (My1 * x(ii)) + (My2 * x(ii)) + (pz0 * (x(ii) .^ 3) / 6) + (pz2 * ((x(ii) .^ 5) / (60 * Lo ^ 2))) + ...
           (pz4 * ((x(ii) .^ 7 / (210 * Lo ^ 4)))) - (LF * W * ((x(ii) .^ 3) / (6 * Lo))));

   elseif x1 < x(ii) & x(ii) <= x2
       
       % Tip Diplacement  - X Direction (inch)
           Disp_X(nplot) = (1 / (EA)) * (x(ii) * (-Vxo + Fx1));
        
           % Tip Diplacement  - Y Direction (inch)
           Disp_Y(nplot) = (1 / EIyy) * ((-Vyo * (x(ii) .^ 3) / 6) + (Mzo * (x(ii) .^ 2) / 2) ...
           - (Mz1 * ((x(ii) .^ 2) / 2)) - (Mz2 * ((x(ii) .^ 2) / 2)) + (Fy1 * ((x(ii) .^ 3)/ 6) ...
           - (x1 * ((x(ii) .^ 2) / 2))) + ...
           (py0 * (x(ii) .^ 4) / 24) + pyr * ((x(ii) .^ (rth + 4)) / ((rth + 1) * (rth + 2) ...
           * (rth + 3) * (rth + 4) * Lo ^ rth)));
        
           % Tip Diplacement  - Z Direction (inch)  
           Disp_Z(nplot) = (1 / EIzz) * ((-Vzo * (x(ii) .^ 3) / 6) - (Myo * (x(ii) .^ 2) / 2) ...
           + (My1 * (x(ii) .^ 2) / 2) + (My2 * (x(ii) .^ 2) / 2) + (Fz1 * (((x(ii) .^ 3)/ 6) ...
           - x1 * (x(ii) .^ 2) / 2)) + ...
           (pz0 * (x(ii) .^ 4) / 24) + (pz2 * ((x(ii) .^ 6) / (360 * (Lo ^ 2)))) + ...
           (pz4 * (((x(ii) .^ 8) / (1680 * (Lo ^ 4))))) - (LF * W * ((x(ii) .^ 4) / (24* Lo))));
        
           % Tip Twist (degree)
           Twist(nplot) = rad2deg(1 / GJ) * (Mxo .* x(ii) - Mx1 .* x(ii) - Mx2 .* x(ii) - mx0 .*...
           ((x(ii) .^ 2) / 2) - mx1 .* ((x(ii) .^ 3) / (6 .* Lo))); 
        
           % Tip Bending Slope (dv/dx) (inch/inch)
           DvDx(nplot) = (1 / EIyy) * ((-Vyo * (x(ii) .^ 2) / 2) + (Mzo * x(ii)) ...
           - (Mz1 * x(ii)) - (Mz2 * x(ii)) + (Fy1 * (((x(ii) .^ 2)/ 2) ...
           - (x1 * x(ii)))) + ...
           (py0 * (x(ii) .^ 3) / 6) + pyr * ((x(ii) .^ (rth + 3)) / ((rth + 1) * (rth + 2) ...
           * (rth + 3) * Lo ^ rth)));
        
           % Tip Bending Slope (dw/dx) (inch/inch)
           DwDx(nplot) = (1 / EIzz) * ((-Vzo * (x(ii) .^ 2) / 2) - (Myo * x(ii)) ...
           + (My1 * x(ii)) + (My2 * x(ii)) + (Fz1 * ((x(ii) .^ 2)/ 2) ...
           - x1 * x(ii)) + (pz0 * (x(ii) .^ 3) / 6) + (pz2 * ((x(ii) .^ 5) / (60 * Lo ^ 2))) + ...
           (pz4 * ((x(ii) .^ 7 / (210 * Lo ^ 4)))) - (LF * W * ((x(ii) .^ 3) / (6 * Lo))));

   elseif x2 < x(ii) & x(ii) <= Lo

       % Tip Diplacement  - X Direction (inch)
       Disp_X(nplot) = (1 / (EA)) * (x(ii) * (-Vxo + Fx1 + Fx2));
    
       % Tip Diplacement  - Y Direction (inch)
       Disp_Y(nplot) = (1 / EIyy) * ((-Vyo * (x(ii) .^ 3) / 6) + (Mzo * (x(ii) .^ 2) / 2) ...
           - (Mz1 * ((x(ii) .^ 2) / 2)) - (Mz2 * ((x(ii) .^ 2) / 2)) + (Fy1 * ((x(ii) .^ 3)/ 6) ...
           - (x1 * ((x(ii) .^ 2) / 2))) + (Fy2 * ((x(ii) .^ 3)/ 6) - x2 * ((x(ii) .^ 2) /2)) + ...
           (py0 * (x(ii) .^ 4) / 24) + pyr * ((x(ii) .^ (rth + 4)) / ((rth + 1) * (rth + 2) ...
           * (rth + 3) * (rth + 4) * Lo ^ rth)));
    
       % Tip Diplacement  - Z Direction (inch)  
       Disp_Z(nplot) = -(1 / EIzz) * (Vzo * ((x(ii) .^ 3) / 6) + (Myo * (x(ii) .^ 2) / 2) ...
           - (My1 * (x(ii) .^ 2) / 2) - (My2 * (x(ii) .^ 2) / 2) - (Fz1 * (((x(ii) .^ 3)/ 6) ...
           + x1 * (x(ii) .^ 2) / 2)) - (Fz2 * (((x(ii) .^ 3)/ 6) + x2 * (x(ii) .^ 2) /2)) - ...
           (pz0 * (x(ii) .^ 4) / 24) - (pz2 * ((x(ii) .^ 6) / (360 * (Lo ^ 2)))) - ...
           (pz4 * (((x(ii) .^ 8) / (1680 * (Lo ^ 4))))) + (LF * W * ((x(ii) .^ 4) / (24* Lo))));
    
       % Tip Twist (degree)
       Twist(nplot) = rad2deg(1 / GJ) * (Mxo .* x(ii) - Mx1 .* x(ii) - Mx2 .* x(ii) - mx0 .*...
           ((x(ii) .^ 2) / 2) - mx1 .* ((x(ii) .^ 3) / (6 .* Lo))); 
    
       % Tip Bending Slope (dv/dx) (inch/inch)
       DvDx(nplot) = (1 / EIyy) * ((-Vyo * (x(ii) .^ 2) / 2) + (Mzo * x(ii)) ...
           - (Mz1 * x(ii)) - (Mz2 * x(ii)) + (Fy1 * (((x(ii) .^ 2)/ 2) ...
           - (x1 * x(ii)))) + (Fy2 * ((x(ii) .^ 2/ 2) - (x2 * x(ii)))) + ...
           (py0 * (x(ii) .^ 3) / 6) + pyr * ((x(ii) .^ (rth + 3)) / ((rth + 1) * (rth + 2) ...
           * (rth + 3) * Lo ^ rth)));
           
       % Tip Bending Slope (dw/dx) (inch/inch)
       DwDx(nplot) = (1 / EIzz) * ((-Vzo * (x(ii) .^ 2) / 2) - (Myo * x(ii)) ...
           + (My1 * x(ii)) + (My2 * x(ii)) + (Fz1 * ((x(ii) .^ 2)/ 2) ...
           - x1 * x(ii)) + (Fz2 * ((x(ii) .^ 2)/ 2) - x2 * x(ii)) + (pz0 * (x(ii) .^ 3) / 6) + (pz2 * ((x(ii) .^ 5) / (60 * Lo ^ 2))) + ...
           (pz4 * ((x(ii) .^ 7 / (210 * Lo ^ 4)))) - (LF * W * ((x(ii) .^ 3) / (6 * Lo))));
   end
   end
   
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#5): Calculate the Data Arrays for Plotting
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (5) Calculate the Data Arrays for Future Plotting')
   
   % initialize the variables
   x_loc = linspace(0, Lo, nplot);
   %x_loc = zeros(1, nplot);
   Vx = zeros(1, nplot);
   Vy = zeros(1, nplot);
   Vz = zeros(1, nplot);
   Mx = zeros(1, nplot);
   My = zeros(1, nplot);
   Mz = zeros(1, nplot);
   Disp_X_i = zeros(1, nplot);
   Disp_Y_i = zeros(1, nplot);
   Disp_Z_i = zeros(1, nplot);
   Twist_i = zeros(1, nplot);
   DvDx_i = zeros(1, nplot);
   DwDx_i = zeros(1, nplot);
   
   for ii = 1:nplot
        % x-location (inch)
        x_loc(ii);
        
        % drag force (lb/in)
        py(ii) = py0 + pyr * ((x_loc(ii) .^ rth) / (Lo ^ rth));         
        
        % lift force (lb/in)
        pz(ii) = pz0 + (pz2 * ((x_loc(ii) .^ 2) / (Lo ^ 2))) + (pz4 * ((x_loc(ii) .^ 4) / (Lo ^ 4)));         
        
        % distributed torque (lb-in/in)
        mx(ii) = mx0 + mx1 * (x_loc(ii) / Lo);         
 
        if 0 <= x_loc(ii) & x_loc(ii) <= x1
        
        % Internal axial force - Vx (lb) 
        Vx(ii) = -(-Vxo);         
        
        % Internal shear force - Vy (lb)
        Vy(ii) = -((-Vyo + ... 
         (py0 * x_loc(ii)) + pyr * ((x_loc(ii) .^ (rth + 1)) / ((rth + 1)  ...
          * Lo ^ rth))));         
        
        % Internal shear force - Vz (lb)
        Vz(ii) = -(-Vzo + Fz1 + Fz2 + (pz0 * x_loc(ii)) + (pz2 * ((x_loc(ii) .^ 3) / (3 * Lo ^ 2))) + ...
         (pz4 * ((x_loc(ii) .^ 5 / (5 * Lo ^ 4)))) - (LF * W * x_loc(ii) / Lo));          
        
        % Internal axial force - Mx (lb-in)
        Mx(ii) = -(- Mxo + Mx1 + Mx2 + mx0 * x_loc(ii) + mx1 * ((x_loc(ii) .^ 2) / (2 * Lo)));           
        
        % Internal shear force - My (lb-in)
        My(ii) = -((-Vyo * x_loc(ii) + Mzo ...
         - Mz1 - Mz2 + ...
         (py0 * (x_loc(ii) .^ 2) / 2) + pyr * ((x_loc(ii) .^ (rth + 2)) / ((rth + 1) * (rth + 2) ...
          * Lo ^ rth)))); 
        
        % Internal shear force - Mz (lb-in)
        Mz(ii) = ((-Vzo * x_loc(ii)) - Myo ...
         + My1 + My2 + (pz0 * ((x_loc(ii) .^ 2) / 2)) + (pz2 * ((x_loc(ii) .^ 4) / (12 * Lo ^ 2))) + ...
         (pz4 * ((x_loc(ii) .^ 6 / (30 * Lo ^ 4)))) - (LF * W * ((x_loc(ii) .^ 2) / (2 * Lo))));            
        
        % Axial Stress - Point A (Ksi)
        Sxx_A(ii) = (0.001) * ( - (Mz(ii) * R) / Izz);      
        
        % Axial Stress - Point B (Ksi)
        Sxx_B(ii) = (0.001) * (- (My(ii) * R) / Iyy);      
        
        % Axial Stress - Point C (Ksi)
        Sxx_C(ii) = (0.001) * (+ (Mz(ii) * R) / Izz);      
        
        % Axial Stress - Point D (Ksi)
        Sxx_D(ii) = (0.001) * (+ (My(ii) * R) / Iyy);

        % Shear Stress - Point A (Ksi)
        Tau_A(ii) = (0.001) *((Vy(ii) / (pi * Ro * to)) - (Mx(ii) * R / J));      
        
        % Shear Stress - Point B (Ksi)
        Tau_B(ii) = (0.001) * ((Vz(ii) / (pi * Ro * to)) - (Mx(ii) * R / J));      
        
        % Shear Stress - Point C (Ksi)
        Tau_C(ii) = (0.001) * ((Vy(ii) / (pi * Ro * to)) + (Mx(ii) * R / J));      
        
        % Shear Stress - Point D (Ksi)
        Tau_D(ii) = (0.001) * ((Vz(ii) / (pi * Ro * to)) + (Mx(ii) * R / J));  

        % Displacement - X Direction (inch)
        Disp_X_i(ii) = (1 / (EA)) * (x_loc(ii) * (-Vxo));     
        
        % Displacement - Y Direction (inch)
        Disp_Y_i(ii) = (1 / EIyy) * ((-Vyo * (x_loc(ii) .^ 3) / 6) + (Mzo * (x_loc(ii) .^ 2) /2) ...
          - (Mz1 * ((x_loc(ii) .^ 2) / 2)) - (Mz2 * ((x_loc(ii) .^ 2) / 2)) + ...
          (py0 * (x_loc(ii) .^ 4) / 24) + pyr * ((x_loc(ii) .^ (rth + 4)) / ((rth + 1) * (rth + 2) ...
          * (rth + 3) * (rth + 4) * Lo ^ rth)));     
        
        % Displacement - Z Direction (inch)
        Disp_Z_i(ii) = (1 / EIzz) * ((-Vzo * (x_loc(ii) .^ 3) / 6) - (Myo * (x_loc(ii) .^ 2) / 2) ...
          + (My1 * (x_loc(ii) .^ 2) / 2) + (My2 * (x_loc(ii) .^ 2) / 2) + ...
          (pz0 * (x_loc(ii) .^ 4) / 24) + (pz2 * ((x_loc(ii) .^ 6) / (360 * (Lo ^ 2)))) + ...
          (pz4 * (((x_loc(ii) .^ 8) / (1680 * (Lo ^ 4))))) - (LF * W * ((x_loc(ii) .^ 4) / (24* Lo))));     
        
        % Spar Twist (degree)
        Twist_i(ii) = rad2deg(1 / GJ) * (Mxo .* x_loc(ii) - Mx1 .* x_loc(ii) - Mx2 .* x_loc(ii) - mx0 .*...
          ((x_loc(ii) .^ 2) / 2) - mx1 .* ((x_loc(ii) .^ 3) / (6 .* Lo)));      
        
        % Bending Slope (dv/dx) (inch/inch)
        DvDx_i(ii) = (1 / EIyy) * ((-Vyo * (x_loc(ii) .^ 2) / 2) + (Mzo * x_loc(ii)) ...
          - (Mz1 * x_loc(ii)) - (Mz2 * x_loc(ii)) + ...
          (py0 * (x_loc(ii) .^ 3) / 6) + pyr * ((x_loc(ii) .^ (rth + 3)) / ((rth + 1) * (rth + 2) ...
          * (rth + 3) * Lo ^ rth)));       
        
        % Bending Slope (dw/dx) (inch/inch)
        DwDx_i(ii) = (1 / EIzz) * ((-Vzo * (x_loc(ii) .^ 2) / 2) - (Myo * x_loc(ii)) ...
          + (My1 * x_loc(ii)) + (My2 * x_loc(ii)) + (pz0 * (x_loc(ii) .^ 3) / 6) + (pz2 * ((x_loc(ii) .^ 5) / (60 * Lo ^ 2))) + ...
          (pz4 * ((x_loc(ii) .^ 7 / (210 * Lo ^ 4)))) - (LF * W * ((x_loc(ii) .^ 3) / (6 * Lo))));   

        elseif x1 < x_loc(ii) & x_loc(ii) <= x2

        % Internal axial force - Vx (lb) 
        Vx(ii) = -Vxo + Fx1;         
        
        % Internal shear force - Vy (lb)
        Vy(ii) = -((-Vyo ...
           + Fy1 + ...
         (py0 * x_loc(ii)) + pyr * ((x_loc(ii) .^ (rth + 1)) / ((rth + 1)  ...
          * Lo ^ rth))));         
        
        % Internal shear force - Vz (lb)
        Vz(ii) = -(-Vzo + Fz1 + (pz0 * x_loc(ii)) + (pz2 * ((x_loc(ii) .^ 3) / (3 * Lo ^ 2))) + ...
         (pz4 * ((x_loc(ii) .^ 5 / (5 * Lo ^ 4)))) - (LF * W * x_loc(ii) / Lo));          
        
        % Internal axial force - Mx (lb-in)
        Mx(ii) = -(- Mxo + Mx1 + Mx2 + mx0 * x_loc(ii) + mx1 * ((x_loc(ii) ^ 2) / (2 * Lo)));          
        
        % Internal shear force - My (lb-in)
        My(ii) = -((-Vyo * x_loc(ii) + Mzo ...
         - Mz1 - Mz2 + (Fy1 * (x_loc(ii) ...
         - x1)) + ...
         (py0 * (x_loc(ii) .^ 2) / 2) + pyr * ((x_loc(ii) .^ (rth + 2)) / ((rth + 1) * (rth + 2) ...
          * Lo ^ rth)))); 
   
        % Internal shear force - Mz (lb-in)
        Mz(ii) =  ((-Vzo * x_loc(ii)) - Myo ...
         + My1 + My2 + (Fz1 * (x_loc(ii) ...
         - x1)) + (pz0 * ((x_loc(ii) .^ 2) / 2)) + (pz2 * ((x_loc(ii) .^ 4) / (12 * Lo ^ 2))) + ...
         (pz4 * ((x_loc(ii) .^ 6 / (30 * Lo ^ 4)))) - (LF * W * ((x_loc(ii) .^ 2) / (2 * Lo))));         
        
        % Axial Stress - Point A (Ksi)
        Sxx_A(ii) = (0.001) * ((1 / A) * (Fx1) - (Mz(ii) * R) / Izz);      
        
        % Axial Stress - Point B (Ksi)
        Sxx_B(ii) = (0.001) * ((1 / A) * (Fx1) - (My(ii) * R) / Iyy);      
        
        % Axial Stress - Point C (Ksi)
        Sxx_C(ii) = (0.001) * ((1 / A) * (Fx1) + (Mz(ii) * R) / Izz);      
        
        % Axial Stress - Point D (Ksi)
        Sxx_D(ii) = (0.001) * ((1 / A) * (Fx1) + (My(ii) * R) / Iyy);

        % Shear Stress - Point A (Ksi)
        Tau_A(ii) = (0.001) *((Vy(ii) / (pi * Ro * to)) - (Mx(ii) * R / J));      
        
        % Shear Stress - Point B (Ksi)
        Tau_B(ii) = (0.001) * ((Vz(ii) / (pi * Ro * to)) - (Mx(ii) * R / J));      
        
        % Shear Stress - Point C (Ksi)
        Tau_C(ii) = (0.001) * ((Vy(ii) / (pi * Ro * to)) + (Mx(ii) * R / J));      
        
        % Shear Stress - Point D (Ksi)
        Tau_D(ii) = (0.001) * ((Vz(ii) / (pi * Ro * to)) + (Mx(ii) * R / J));  

        % Displacement - X Direction (inch)
        Disp_X_i(ii) = (1 / (EA)) * (x_loc(ii) * (-Vxo + Fx1));     
        
        % Displacement - Y Direction (inch)
        Disp_Y_i(ii) = (1 / EIyy) * ((-Vyo * (x_loc(ii) .^ 3) / 6) + (Mzo * (x_loc(ii) .^ 2) / 2) ...
          - (Mz1 * ((x_loc(ii) .^ 2) / 2)) - (Mz2 * ((x_loc(ii) .^ 2) / 2)) + (Fy1 * ((x_loc(ii) .^ 3)/ 6) ...
          - (x1 * ((x_loc(ii) .^ 2) / 2))) + ...
          (py0 * (x_loc(ii) .^ 4) / 24) + pyr * ((x_loc(ii) .^ (rth + 4)) / ((rth + 1) * (rth + 2) ...
          * (rth + 3) * (rth + 4) * Lo ^ rth)));     
        
        % Displacement - Z Direction (inch)
        Disp_Z_i(ii) = (1 / EIzz) * ((-Vzo * (x_loc(ii) .^ 3) / 6) - (Myo * (x_loc(ii) .^ 2) / 2) ...
          + (My1 * (x_loc(ii) .^ 2) / 2) + (My2 * (x_loc(ii) .^ 2) / 2) + (Fz1 * (((x_loc(ii) .^ 3)/ 6) ...
          - x1 * (x_loc(ii) .^ 2) / 2)) + ...
          (pz0 * (x_loc(ii) .^ 4) / 24) + (pz2 * ((x_loc(ii) .^ 6) / (360 * (Lo ^ 2)))) + ...
          (pz4 * (((x_loc(ii) .^ 8) / (1680 * (Lo ^ 4))))) - (LF * W * ((x_loc(ii) .^ 4) / (24* Lo))));     
        
        % Spar Twist (degree)
        Twist_i(ii) = rad2deg(1 / GJ) * (Mxo .* x_loc(ii) - Mx1 .* x_loc(ii) - Mx2 .* x_loc(ii) - mx0 .*...
          ((x_loc(ii) .^ 2) / 2) - mx1 .* ((x_loc(ii) .^ 3) / (6 .* Lo)));      
        
        % Bending Slope (dv/dx) (inch/inch)
        DvDx_i(ii) = (1 / EIyy) * ((-Vyo * (x_loc(ii) .^ 2) / 2) + (Mzo * x_loc(ii)) ...
          - (Mz1 * x_loc(ii)) - (Mz2 * x_loc(ii)) + (Fy1 * (((x_loc(ii) .^ 2)/ 2) ...
          - (x1 * x_loc(ii)))) + ...
          (py0 * (x_loc(ii) .^ 3) / 6) + pyr * ((x_loc(ii) .^ (rth + 3)) / ((rth + 1) * (rth + 2) ...
          * (rth + 3) * Lo ^ rth)));       
        
        % Bending Slope (dw/dx) (inch/inch)
        DwDx_i(ii) = (1 / EIzz) * ((-Vzo * (x_loc(ii) .^ 2) / 2) - (Myo * x_loc(ii)) ...
          + (My1 * x_loc(ii)) + (My2 * x_loc(ii)) + (Fz1 * ((x_loc(ii) .^ 2)/ 2) ...
          - x1 * x_loc(ii)) + (pz0 * (x_loc(ii) .^ 3) / 6) + (pz2 * ((x_loc(ii) .^ 5) / (60 * Lo ^ 2))) + ...
          (pz4 * ((x_loc(ii) .^ 7 / (210 * Lo ^ 4)))) - (LF * W * ((x_loc(ii) .^ 3) / (6 * Lo))));       
        
        elseif x2 < x_loc(ii) & x_loc(ii) <= Lo      
        
        % Internal axial force - Vx (lb) 
        Vx(ii) = -Vxo + Fx1 + Fx2;         
        
        % Internal shear force - Vy (lb)
        Vy(ii) = -((-Vyo ...
            + Fy1 ...
           + Fy2 + ...
          (py0 * x_loc(ii)) + pyr * ((x_loc(ii) .^ (rth + 1)) / ((rth + 1)  ...
           * Lo ^ rth))));         
        
        % Internal shear force - Vz (lb)
        Vz(ii) = -(-Vzo + Fz1 + Fz2 + (pz0 * x_loc(ii)) + (pz2 * ((x_loc(ii) .^ 3) / (3 * Lo ^ 2))) + ...
          (pz4 * ((x_loc(ii) .^ 5 / (5 * Lo ^ 4)))) - (LF * W * x_loc(ii) / Lo));         
        
        % Internal axial force - Mx (lb-in)
        Mx(ii) = -(- Mxo + Mx1 + Mx2 + mx0 * x_loc(ii) + mx1 * ((x_loc(ii) .^ 2) / (2 * Lo)));        
        
        % Internal shear force - My (lb-in)
        My(ii) = -((-Vyo * x_loc(ii) + Mzo ...
          - Mz1 - Mz2 + (Fy1 * (x_loc(ii) ...
          - x1)) + (Fy2 * (x_loc(ii) - x2)) + ...
          (py0 * (x_loc(ii) .^ 2) / 2) + pyr * ((x_loc(ii) .^ (rth + 2)) / ((rth + 1) * (rth + 2) ...
           * Lo ^ rth))));         
        
        % Internal shear force - Mz (lb-in)
        Mz(ii) = ((-Vzo * x_loc(ii)) - Myo ...
          + My1 + My2 + (Fz1 * (x_loc(ii) ...
          - x1)) + (Fz2 * (x_loc(ii) - x2)) + (pz0 * ((x_loc(ii) .^ 2) / 2)) + (pz2 * ((x_loc(ii) .^ 4) / (12 * Lo ^ 2))) + ...
          (pz4 * ((x_loc(ii) .^ 6 / (30 * Lo ^ 4)))) - (LF * W * ((x_loc(ii) .^ 2) / (2 * Lo))));         
        
        % Axial Stress - Point A (Ksi)
        Sxx_A(ii) = (0.001) * ((1 / A) * (Fx1 + Fx2) - (Mz(ii) * R) / Izz);      
        
        % Axial Stress - Point B (Ksi)
        Sxx_B(ii) = (0.001) * ((1 / A) * (Fx1 + Fx2) - (My(ii) * R) / Iyy);      
        
        % Axial Stress - Point C (Ksi)
        Sxx_C(ii) = (0.001) * ((1 / A) * (Fx1 + Fx2) + (Mz(ii) * R) / Izz);      
        
        % Axial Stress - Point D (Ksi)
        Sxx_D(ii) = (0.001) * ((1 / A) * (Fx1 + Fx2) + (My(ii) * R) / Iyy);

        % Shear Stress - Point A (Ksi)
        Tau_A(ii) = (0.001) *((Vy(ii) / (pi * Ro * to)) - (Mx(ii) * R / J));      
        
        % Shear Stress - Point B (Ksi)
        Tau_B(ii) = (0.001) * ((Vz(ii) / (pi * Ro * to)) - (Mx(ii) * R / J));      
        
        % Shear Stress - Point C (Ksi)
        Tau_C(ii) = (0.001) * ((Vy(ii) / (pi * Ro * to)) + (Mx(ii) * R / J));      
        
        % Shear Stress - Point D (Ksi)
        Tau_D(ii) = (0.001) * ((Vz(ii) / (pi * Ro * to)) + (Mx(ii) * R / J));  

        % Displacement - X Direction (inch)
        Disp_X_i(ii) = (1 / (EA)) * (x_loc(ii) * (-Vxo + Fx1 + Fx2));     
        
        % Displacement - Y Direction (inch)
        Disp_Y_i(ii) = (1 / EIyy) * ((-Vyo * (x_loc(ii) .^ 3) / 6) + (Mzo * (x_loc(ii) .^ 2) / 2) ...
          - (Mz1 * ((x_loc(ii) .^ 2) / 2)) - (Mz2 * ((x_loc(ii) .^ 2) / 2)) + (Fy1 * ((x_loc(ii) .^ 3)/ 6) ...
          - (x1 * ((x_loc(ii) .^ 2) / 2))) + (Fy2 * ((x_loc(ii) .^ 3)/ 6) - x2 * ((x_loc(ii) .^ 2) /2)) + ...
          (py0 * (x_loc(ii) .^ 4) / 24) + pyr * ((x_loc(ii) .^ (rth + 4)) / ((rth + 1) * (rth + 2) ...
          * (rth + 3) * (rth + 4) * Lo ^ rth)));     
        
        % Displacement - Z Direction (inch)
        Disp_Z_i(ii)= (1 / EIzz) * ((-Vzo * (x_loc(ii) .^ 3) / 6) - (Myo * (x_loc(ii) .^ 2) / 2) ...
          + (My1 * (x_loc(ii) .^ 2) / 2) + (My2 * (x_loc(ii) .^ 2) / 2) + (Fz1 * (((x_loc(ii) .^ 3)/ 6) ...
          - x1 * (x_loc(ii) .^ 2) / 2)) + (Fz2 * (((x_loc(ii) .^ 3)/ 6) - x2 * (x_loc(ii) .^ 2) /2)) + ...
          (pz0 * (x_loc(ii) .^ 4) / 24) + (pz2 * ((x_loc(ii) .^ 6) / (360 * (Lo ^ 2)))) + ...
          (pz4 * (((x_loc(ii) .^ 8) / (1680 * (Lo ^ 4))))) - (LF * W * ((x_loc(ii) .^ 4) / (24* Lo))));   
        
        % Spar Twist (degree)
        Twist_i(ii) = rad2deg(1 / GJ) * (Mxo .* x_loc(ii) - Mx1 .* x_loc(ii) - Mx2 .* x_loc(ii) - mx0 .*...
          ((x_loc(ii) .^ 2) / 2) - mx1 .* ((x_loc(ii) .^ 3) / (6 .* Lo)));      
        
        % Bending Slope (dv/dx) (inch/inch)
        DvDx_i(ii) = (1 / EIyy) * ((-Vyo * (x_loc(ii) .^ 2) / 2) + (Mzo * x_loc(ii)) ...
          - (Mz1 * x_loc(ii)) - (Mz2 * x_loc(ii)) + (Fy1 * (((x_loc(ii) .^ 2)/ 2) ...
          - (x1 * x_loc(ii)))) + (Fy2 * ((x_loc(ii) .^ 2/ 2) - (x2 * x_loc(ii)))) + ...
          (py0 * (x_loc(ii) .^ 3) / 6) + pyr * ((x_loc(ii) .^ (rth + 3)) / ((rth + 1) * (rth + 2) ...
          * (rth + 3) * Lo ^ rth)));       
        
        % Bending Slope (dw/dx) (inch/inch)
        DwDx_i(ii) = (1 / EIzz) * ((-Vzo * (x_loc(ii) .^ 2) / 2) - (Myo * x_loc(ii)) ...
          + (My1 * x_loc(ii)) + (My2 * x_loc(ii)) + (Fz1 * ((x_loc(ii) .^ 2)/ 2) ...
          - x1 * x_loc(ii)) + (Fz2 * ((x_loc(ii) .^ 2)/ 2) - x2 * x_loc(ii)) + (pz0 * (x_loc(ii) .^ 3) / 6) + (pz2 * ((x_loc(ii) .^ 5) / (60 * Lo ^ 2))) + ...
          (pz4 * ((x_loc(ii) .^ 7 / (210 * Lo ^ 4)))) - (LF * W * ((x_loc(ii) .^ 3) / (6 * Lo))));       
        end

    end;

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#6): Pack Calculated Data into the "dataOut1" Array size: (36)
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (6) Pack the Calculated Data into Array: dataOut1')

     dataOut1(01) = EA;              % Axial   Stiffness (lb)
     dataOut1(02) = EIyy;            % Bending Stiffness (lb-in^2)   
     dataOut1(03) = EIzz;            % Bending Stiffness (lb-in^2)   
     dataOut1(04) = EIyz;            % Bending Stiffness (lb-in^2)   
     dataOut1(05) = GJ;              % Torsion Stiffness (lb-in^2)
     dataOut1(06) = Vxo;             % Root Internal Force - X Direction (lb)
     dataOut1(07) = Vyo;             % Root Internal Force - Y Direction (lb)
     dataOut1(08) = Vzo;             % Root Internal Force - Z Direction (lb)
     dataOut1(09) = Mxo;             % Root Internal Moment - about X Direction (lb-in)
     dataOut1(10) = Myo;             % Root Internal Moment - about Y Direction (lb-in)
     dataOut1(11) = Mzo;             % Root Internal Moment - about Z Direction (lb-in)
     dataOut1(12) = S_allow_T;       % Allowable Stress - Tension (Ksi)
     dataOut1(13) = S_allow_C;       % Allowable Stress - Compression (Ksi)
     dataOut1(14) = S_allow_S;       % Allowable Stress - Shear (Ksi)
     dataOut1(15) = Sxxo_A;          % Root Axial Stress - point A (Ksi)
     dataOut1(16) = Sxxo_B;          % Root Axial Stress - point B (Ksi)
     dataOut1(17) = Sxxo_C;          % Root Axial Stress - point C (Ksi)
     dataOut1(18) = Sxxo_D;          % Root Axial Stress - point D (Ksi)
     dataOut1(19) = Txyo_A;          % Root Shear Stress xy - point A (ksi)   
     dataOut1(20) = Txyo_B;          % Root Shear Stress xy - point B (ksi)
     dataOut1(21) = Txyo_C;          % Root Shear Stress xy - point C (ksi)
     dataOut1(22) = Txyo_D;          % Root Shear Stress xy - point D (ksi)
     dataOut1(23) = Txzo_A;          % Root Shear Stress xz - point A (ksi)
     dataOut1(24) = Txzo_B;          % Root Shear Stress xz - point B (ksi)
     dataOut1(25) = Txzo_C;          % Root Shear Stress xz - point C (ksi)
     dataOut1(26) = Txzo_D;          % Root Shear Stress xz - point D (ksi)
     dataOut1(27) = MS_A;            % Margin of Safety - point A
     dataOut1(28) = MS_B;            % Margin of Safety - point B
     dataOut1(29) = MS_C;            % Margin of Safety - point C
     dataOut1(30) = MS_D;            % Margin of Safety - point D
     dataOut1(31) = Disp_X(nplot);   % Tip Diplacement - X Direction (inch)
     dataOut1(32) = Disp_Y(nplot);   % Tip Diplacement - Y Direction (inch)
     dataOut1(33) = Disp_Z(nplot);   % Tip Diplacement - Z Direction (inch)
     dataOut1(34) = Twist(nplot);    % Tip Twist (degree)
     dataOut1(35) = DvDx(nplot);     % Tip Bending Slope (dv/dx) (inch/inch)
     dataOut1(36) = DwDx(nplot);     % Tip Bending Slope (dw/dx) (inch/inch)

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#7): Pack the plot data arrays into "dataOut2" 
% .                matrix size: (nplot,23)  
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
   disp('     (7) Pack the Calculated Plot Data into Array: dataOut2')

   for ii = 1:nplot;
     dataOut2(ii, 1) = x_loc(ii);        % x-location (inch)
     dataOut2(ii, 2) = py(ii);         % drag force (lb/in)
     dataOut2(ii, 3) = pz(ii);         % lift force (lb/in)
     dataOut2(ii, 4) = mx(ii);         % distributed torque (lb-in/in)
     dataOut2(ii, 5) = Vx(ii);         % Internal axial force - Vx (lb)
     dataOut2(ii, 6) = Vy(ii);         % Internal shear force - Vy (lb)
     dataOut2(ii, 7) = Vz(ii);         % Internal shear force - Vz (lb)
     dataOut2(ii, 8) = Mx(ii);         % Internal axial force - Mx (lb-in)
     dataOut2(ii, 9) = My(ii);         % Internal shear force - My (lb-in)
     dataOut2(ii,10) = Mz(ii);         % Internal shear force - Mz (lb-in)
     dataOut2(ii,11) = Sxx_A(ii);      % Axial Stress - Point A (Ksi)
     dataOut2(ii,12) = Sxx_B(ii);      % Axial Stress - Point B (Ksi)
     dataOut2(ii,13) = Sxx_C(ii);      % Axial Stress - Point C (Ksi)
     dataOut2(ii,14) = Sxx_D(ii);      % Axial Stress - Point D (Ksi)
     dataOut2(ii,15) = Tau_A(ii);      % Shear Stress - Point A (Ksi)
     dataOut2(ii,16) = Tau_B(ii);      % Shear Stress - Point B (Ksi)
     dataOut2(ii,17) = Tau_C(ii);      % Shear Stress - Point C (Ksi)
     dataOut2(ii,18) = Tau_D(ii);      % Shear Stress - Point D (Ksi)
     dataOut2(ii,19) = Disp_X_i(ii);     % Displacement - X Direction (inch)
     dataOut2(ii,20) = Disp_Y_i(ii);     % Displacement - Y Direction (inch)
     dataOut2(ii,21) = Disp_Z_i(ii);     % Displacement - Z Direction (inch)
     dataOut2(ii,22) = Twist_i(ii);      % Spar Twist (degree)
     dataOut2(ii,23) = DvDx_i(ii);       % Bending Slope (dv/dx) (inch/inch)
     dataOut2(ii,24) = DwDx_i(ii);       % Bending Slope (dw/dx) (inch/inch)

   end;
   
end

%  End of Function: SE160A_1_sparAnalysis
%  ------------------------------------------------------------------------

