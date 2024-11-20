function [name, PID, dataOut1, dataOut2] = Wing_Analysis_Function(dataIn);
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
% +
% +  SE-160A:  Aerospace Structural Analysis I
% +
% +  Project: (2) Wing Analysis
% +
% +  Title:   Wing_Analysis_Function
% +  Author:  Student Name
% +  PID:     Student PID
% +  Revised: 02/25/2024
% +
% +  This function is the primary analysis function for the wing analysis
% +  program.  All of the input data is brought into the function using
% +  "dataIn". Next all the calculations are performed.  Finally, the
% +  calculated results are written to "dataOut1" and "dataOut2", where
% +  these two data sets are sent to the main program (p-code) where it is
% +  written and plotted in an Excel output file.
% +
% +  SUMMARY OF WING ANALYSIS
% +
% +  A) SECTION PROPERTIES
% +     A.1) Modulus Weighted Section Properties (yc, zc, EA, EIyy, EIzz, EIyz)
% +     A.2) Torsion Constant (GJ)
% +     A.3) Shear Center Location (ysc, zsc)
% +     A.4) Total Half Span Wing Weight (lb)
% +
% +  B) LOADS
% +     B.1) Distributed Aerodynamic Loads (lift, drag, moment)
% +     B.2) Wing Root Reactions - Shear, Torque, and Moment
% +     B.3) Distributed Wing Internal Shear, Bend Moments, Torque
% +
% +  C) INTERNAL STRESSES
% +     C.1) Wing Root Axial Stress (sxx) and Shear Stress (txs)
% +     C.2) Allowable Stress, and Root Margin of Safety
% +     C.3) Distributed Wing Axial Stress (sxx) Plot
% +     C.4) Distributed Wing Shear Stress (tau) Plot
% +
% +  D) WING TIP DISPLACEMENTS, TWIST, AND BENDING SLOPES
% +     D.1) Distributed Wing Y-direction (Drag ) Displacement
% +     D.2) Distributed Wing Z-direction (Lift ) Displacement
% +     D.3) Distributed Wing Twist Rotation
% +     D.4) Distributed Wing Bending Slopes (dv/dx, dw/dx)
% +
% +  Input Data Array: dataIn (65)
% +     dataIn(01):     Number of Output Plot Data Points
% +     dataIn(02):     Wing Length (inch)
% +     dataIn(03):     Wing Chord (inch)
% +     dataIn(04):     Maximum Wing Thickness (inch)
% +     dataIn(05):     Secondary Structure Added Wing Weight (%)
% +     dataIn(06):     Wing Skin Thickness (inch)
% +     dataIn(07):     Wing Skin Weight Density (lb/in^3)
% +     dataIn(08):     Skin Material Shear Modulus (Msi)
% +     dataIn(09):     Skin Material Yield Strength - Shear (Ksi)
% +     dataIn(10):     Skin Material Ultimate Strength - Shear (Ksi)
% +     dataIn(11):     Stringer (#1) y-location (inch)
% +     dataIn(12):     Stringer (#1) Cross-Section Area (inch^2)
% +     dataIn(13):     Stringer (#1) Iyy Inertia about y-axis (inch^4)
% +     dataIn(14):     Stringer (#1) Izz Inertia about z-axis (inch^4)
% +     dataIn(15):     Stringer (#1) Iyz Product of Inertia (inch^4)
% +     dataIn(16):     Stringer (#1) Weight Density (lb/in^3)
% +     dataIn(17):     Stringer (#1) Material Young’s Modulus (Msi)
% +     dataIn(18):     Stringer (#1) Yield Strength - Tension (Ksi)
% +     dataIn(19):     Stringer (#1) Ultimate Strength - Tension (Ksi)
% +     dataIn(20):     Stringer (#1) Yield Strength - Compression (Ksi)
% +     dataIn(21):     Stringer (#1) Ultimate Strength - Compression (Ksi)
% +     dataIn(22):     Stringer (#2) y-location (inch)
% +     dataIn(23):     Stringer (#2) Cross-Section Area (inch^2)
% +     dataIn(24):     Stringer (#2) Iyy Inertia about y-axis (inch^4)
% +     dataIn(25):     Stringer (#2) Izz Inertia about z-axis (inch^4)
% +     dataIn(26):     Stringer (#2) Iyz Product of Inertia (inch^4)
% +     dataIn(27):     Stringer (#2) Weight Density (lb/in^3)
% +     dataIn(28):     Stringer (#2) Material Young’s Modulus (Msi)
% +     dataIn(29):     Stringer (#2) Yield Strength - Tension (Ksi)
% +     dataIn(30):     Stringer (#2) Ultimate Strength - Tension (Ksi)
% +     dataIn(31):     Stringer (#2) Yield Strength - Compression (Ksi)
% +     dataIn(32):     Stringer (#2) Ultimate Strength - Compression (Ksi)
% +     dataIn(33):     Stringer (#3) y-location (inch)
% +     dataIn(34):     Stringer (#3) Cross-Section Area (inch^2)
% +     dataIn(35):     Stringer (#3) Iyy Inertia about y-axis (inch^4)
% +     dataIn(36):     Stringer (#3) Izz Inertia about z-axis (inch^4)
% +     dataIn(37):     Stringer (#3) Iyz Product of Inertia (inch^4)
% +     dataIn(38):     Stringer (#3) Weight Density (lb/in^3)
% +     dataIn(39):     Stringer (#3) Material Young’s Modulus (Msi)
% +     dataIn(40):     Stringer (#3) Yield Strength - Tension (Ksi)
% +     dataIn(41):     Stringer (#3) Ultimate Strength - Tension (Ksi)
% +     dataIn(42):     Stringer (#3) Yield Strength - Compression (Ksi)
% +     dataIn(43):     Stringer (#3) Ultimate Strength - Compression (Ksi)
% +     dataIn(44):     Stringer (#4) y-location (inch)
% +     dataIn(45):     Stringer (#4) Cross-Section Area (inch^2)
% +     dataIn(46):     Stringer (#4) Iyy Inertia about y-axis (inch^4)
% +     dataIn(47):     Stringer (#4) Izz Inertia about z-axis (inch^4)
% +     dataIn(48):     Stringer (#4) Iyz Product of Inertia (inch^4)
% +     dataIn(49):     Stringer (#4) Weight Density (lb/in^3)
% +     dataIn(50):     Stringer (#4) Material Young’s Modulus (Msi)
% +     dataIn(51):     Stringer (#4) Yield Strength - Tension (Ksi)
% +     dataIn(52):     Stringer (#4) Ultimate Strength - Tension (Ksi)
% +     dataIn(53):     Stringer (#4) Yield Strength - Compression (Ksi)
% +     dataIn(54):     Stringer (#4) Ultimate Strength - Compression (Ksi)
% +     dataIn(55):     Safety Factor - Yield
% +     dataIn(56):     Safety Factor - Ultimate
% +     dataIn(57):     Aircraft Load Factor
% +     dataIn(58):     Drag Distribution - Constant (lb/in)
% +     dataIn(59):     Drag Distribution - rth order (lb/in)
% +     dataIn(60):     Drag Distribution - polynomial order
% +     dataIn(61):     Lift Distribution - Constant (lb/in)
% +     dataIn(62):     Lift Distribution - 2nd Order (lb/in)
% +     dataIn(63):     Lift Distribution - 4th Order (lb/in)
% +     dataIn(64):     Twist Moment Distribution - Constant (lb-in/in)
% +     dataIn(65):     Twist Moment Distribution - 1st Order (lb-in/in)
% +
% +  Output Data
% +   Name:             Name of author of this analysis function         
% +   PID:              UCSD Student ID number of author
% +   dataOut1:         Packed calculated output variable data
% +     dataOut1(01):   Modulus Weighted Centroid y-direction (inch) DONE
% +     dataOut1(02):   Modulus Weighted Centroid z-direction (inch) DONE
% +     dataOut1(03):   Cross-Section Weight rhoA (lb/in) DONE
% +     dataOut1(04):   Axial   Stiffness EA   (lb) DONE
% +     dataOut1(05):   Bending Stiffness EIyy (lb-in^2) DONE
% +     dataOut1(06):   Bending Stiffness EIzz (lb-in^2) DONE
% +     dataOut1(07):   Bending Stiffness EIyz (lb-in^2) DONE
% +     dataOut1(08):   Torsion Stiffness GJ   (lb-in^2) DONE
% +     dataOut1(09):   Shear Center, y-direction (inch)
% +     dataOut1(10):   Shear Center, z-direction (inch)
% +     dataOut1(11):   Total Half-Span Wing Weight including added weight
% factor (lb) DONE
% +     dataOut1(12):   Root Internal Force - X Direction (lb) DONE
% +     dataOut1(13):   Root Internal Force - Y Direction (lb) DONE
% +     dataOut1(14):   Root Internal Force - Z Direction (lb) DONE
% +     dataOut1(15):   Root Internal Moment - about X Direction (lb-in)
% DONE
% +     dataOut1(16):   Root Internal Moment - about Y Direction (lb-in)
% DONE
% +     dataOut1(17):   Root Internal Moment - about Z Direction (lb-in)
% DONE
% +     dataOut1(18):   Stringer (#1) Calculated Axial Stress (lb/in^2)
% DONE
% +     dataOut1(19):   Stringer (#1) Allowable Stress - Tension (lb/in^2)
% DONE
% +     dataOut1(20):   Stringer (#1) Allowable Stress - Compression
% (lb/in^2) DONE
% +     dataOut1(21):   Stringer (#1) Margin of Safety DONE
% +     dataOut1(22):   Stringer (#2) Calculated Axial Stress (lb/in^2)
% DONE
% +     dataOut1(23):   Stringer (#2) Allowable Stress - Tension (lb/in^2)
% DONE
% +     dataOut1(24):   Stringer (#2) Allowable Stress - Compression
% (lb/in^2) DONE
% +     dataOut1(25):   Stringer (#2) Margin of Safety DONE
% +     dataOut1(26):   Stringer (#3) Calculated Axial Stress (lb/in^2)
% DONE
% +     dataOut1(27):   Stringer (#3) Allowable Stress - Tension (lb/in^2)
% DONE
% +     dataOut1(28):   Stringer (#3) Allowable Stress - Compression
% (lb/in^2) DONE
% +     dataOut1(29):   Stringer (#3) Margin of Safety DONE
% +     dataOut1(30):   Stringer (#4) Calculated Axial Stress (lb/in^2)
% DONE
% +     dataOut1(31):   Stringer (#4) Allowable Stress - Tension (lb/in^2)
% DONE
% +     dataOut1(32):   Stringer (#4) Allowable Stress - Compression
% (lb/in^2) DONE
% +     dataOut1(33):   Stringer (#4) Margin of Safety DONE
% +     dataOut1(34):   Skin Panel (1.2) Calculated Shear Stress (lb/in^2)
% +     dataOut1(35):   Skin Panel (1.2) Allowable Stress - Shear (lb/in^2)
% DONE
% +     dataOut1(36):   Skin Panel (1.2) Margin of Safety DONE
% +     dataOut1(37):   Skin Panel (2.3) Calculated Shear Stress (lb/in^2)
% +     dataOut1(38):   Skin Panel (2.3) Allowable Stress - Shear
% (lb/in^2) DONE
% +     dataOut1(39):   Skin Panel (2.3) Margin of Safety DONE
% +     dataOut1(40):   Skin Panel (3.4) Calculated Shear Stress (lb/in^2)
% +     dataOut1(41):   Skin Panel (3.4) Allowable Stress - Shear (lb/in^2)
% DONE
% +     dataOut1(42):   Skin Panel (3.4) Margin of Safety DONE
% +     dataOut1(43):   Skin Panel (4.1) Calculated Shear Stress (lb/in^2)
% +     dataOut1(44):   Skin Panel (4.1) Allowable Stress - Shear (lb/in^2)
% DONE
% +     dataOut1(45):   Skin Panel (4.1) Margin of Safety DONE
% +     dataOut1(46):   Tip Displacement  - Y Direction (inch) DONE
% +     dataOut1(47):   Tip Displacement  - Z Direction (inch) DONE
% +     dataOut1(48):   Tip Twist (degree)
% +     dataOut1(49):   Tip Bending Slope (dv/dx) (inch/inch) DONE
% +     dataOut1(50):   Tip Bending Slope (dw/dx) (inch/inch) DONE
% +
% +   dataOut2:         Packed calculated output plot data
% +     column( 1):     X direction coordinate (inch)
% +     column( 2):     Applied distributed drag force (lb/in) 
% +     column( 3):     Applied distributed lift force (lb/in) 
% +     column( 4):     Applied distributed torque (lb-in/in) 
% +     column( 5):     Internal shear force  - Vy (lb) 
% +     column( 6):     Internal shear force  - Vz (lb) 
% +     column( 7):     Internal axial torque - Mx (lb-in)
% +     column( 8):     Internal bending moment - My (lb-in)
% +     column( 9):     Internal bending moment - Mz (lb-in)
% +     column(10):     Stringer (#1) Axial Stress (lb/in^2)
% +     column(11):     Stringer (#2) Axial Stress (lb/in^2)
% +     column(12):     Stringer (#3) Axial Stress (lb/in^2)
% +     column(13):     Stringer (#4) Axial Stress (lb/in^2)
% +     column(14):     Skin Panel (1.2) Shear Stress (lb/in^2)
% +     column(15):     Skin Panel (2.3) Shear Stress (lb/in^2)
% +     column(16):     Skin Panel (3.4) Shear Stress (lb/in^2)
% +     column(17):     Skin Panel (4.1) Shear Stress (lb/in^2)
% +     column(18):     Displacement - Y Direction (inch)
% +     column(19):     Displacement - z Direction (inch)
% +     column(20):     Twist (degree)
% +     column(21):     Bending Slope (dv/dx) (inch/inch)
% +     column(22):     Bending Slope (dw/dx) (inch/inch)
% +
% + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#1): Unpack Input Data Array and Wwrite User Name and PID
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 disp('     (1) Unpack Input Data and Write User Name and PID')
 nplot    = dataIn( 1);   % number of output plot data points
 Lo       = dataIn( 2);   % Wing Length (inch)
 Co       = dataIn( 3);   % Wing Chord (inch)
 tmax     = dataIn( 4);   % Maximum Wing Thickness (inch)
 Kaw      = dataIn( 5);   % Secondary Structure Added Weight (%)
 to_sk    = dataIn( 6);   % Wing Skin Thickness (inch)
 rho_sk   = dataIn( 7);   % Wing Skin Weight Density (lb/inch^3)
 Go_sk    = dataIn( 8);   % Skin Material Shear Modulus (Msi)
 Sys_sk   = dataIn( 9);   % Skin Material Yield Shear Strength (Ksi)
 Sus_sk   = dataIn(10);   % Skin Material Ultimate Shear Strength (Ksi)
 yo_str1  = dataIn(11);   % Stringer 1 y-location (inch)
 A_str1   = dataIn(12);   % Stringer 1 Cross-Section Area (inch^2)
 Iyy_str1 = dataIn(13);   % Stringer 1 Iyy Inertia about the y-axis (inch^4)
 Izz_str1 = dataIn(14);   % Stringer 1 Izz Inertia about the z-axis (inch^4)
 Iyz_str1 = dataIn(15);   % Stringer 1 Iyz Product of Inertia (inch^4)
 rho_str1 = dataIn(16);   % Stringer 1 Wing Skin Weight Density (lb/inch^3)
 Eo_str1  = dataIn(17);   % Stringer 1 Material Young's Modulus (Msi)
 Syt_str1 = dataIn(18);   % Stringer 1 Material Yield Strength    - Tension (Ksi)
 Sut_str1 = dataIn(19);   % Stringer 1 Material Ultimate Strength - Tension (Ksi)
 Syc_str1 = dataIn(20);   % Stringer 1 Material Yield Strength    - Compression (Ksi)
 Suc_str1 = dataIn(21);   % Stringer 1 Material Ultimate Strength - Compression (Ksi)
 yo_str2  = dataIn(22);   % Stringer 2 y-location (inch)
 A_str2   = dataIn(23);   % Stringer 2 Cross-Section Area (inch^2)
 Iyy_str2 = dataIn(24);   % Stringer 2 Iyy Inertia about the y-axis (inch^4)
 Izz_str2 = dataIn(25);   % Stringer 2 Izz Inertia about the z-axis (inch^4)
 Iyz_str2 = dataIn(26);   % Stringer 2 Iyz Product of Inertia (inch^4)
 rho_str2 = dataIn(27);   % Stringer 2 Wing Skin Weight Density (lb/inch^3)
 Eo_str2  = dataIn(28);   % Stringer 2 Material Young's Modulus (Msi)
 Syt_str2 = dataIn(29);   % Stringer 2 Material Yield Strength    - Tension (Ksi)
 Sut_str2 = dataIn(30);   % Stringer 2 Material Ultimate Strength - Tension (Ksi)
 Syc_str2 = dataIn(31);   % Stringer 2 Material Yield Strength    - Compression (Ksi)
 Suc_str2 = dataIn(32);   % Stringer 2 Material Ultimate Strength - Compression (Ksi)
 yo_str3  = dataIn(33);   % Stringer 3 y-location (inch)
 A_str3   = dataIn(34);   % Stringer 3 Cross-Section Area (inch^2)
 Iyy_str3 = dataIn(35);   % Stringer 3 Iyy Inertia about the y-axis (inch^4)
 Izz_str3 = dataIn(36);   % Stringer 3 Izz Inertia about the z-axis (inch^4)
 Iyz_str3 = dataIn(37);   % Stringer 3 Iyz Product of Inertia (inch^4)
 rho_str3 = dataIn(38);   % Stringer 3 Wing Skin Weight Density (lb/inch^3)
 Eo_str3  = dataIn(39);   % Stringer 3 Material Young's Modulus (Msi)
 Syt_str3 = dataIn(40);   % Stringer 3 Material Yield Strength    - Tension (Ksi)
 Sut_str3 = dataIn(41);   % Stringer 3 Material Ultimate Strength - Tension (Ksi)
 Syc_str3 = dataIn(42);   % Stringer 3 Material Yield Strength    - Compression (Ksi)
 Suc_str3 = dataIn(43);   % Stringer 3 Material Ultimate Strength - Compression (Ksi)
 yo_str4  = dataIn(44);   % Stringer 4 y-location (inch)
 A_str4   = dataIn(45);   % Stringer 4 Cross-Section Area (inch^2)
 Iyy_str4 = dataIn(46);   % Stringer 4 Iyy Inertia about the y-axis (inch^4)
 Izz_str4 = dataIn(47);   % Stringer 4 Izz Inertia about the z-axis (inch^4)
 Iyz_str4 = dataIn(48);   % Stringer 4 Iyz Product of Inertia (inch^4)
 rho_str4 = dataIn(49);   % Stringer 4 Wing Skin Weight Density (lb/inch^3)
 Eo_str4  = dataIn(50);   % Stringer 4 Material Young's Modulus (Msi)
 Syt_str4 = dataIn(51);   % Stringer 4 Material Yield Strength    - Tension (Ksi)
 Sut_str4 = dataIn(52);   % Stringer 4 Material Ultimate Strength - Tension (Ksi)
 Syc_str4 = dataIn(53);   % Stringer 4 Material Yield Strength    - Compression (Ksi)
 Suc_str4 = dataIn(54);   % Stringer 4 Material Ultimate Strength - Compression (Ksi)
 SFy      = dataIn(55);   % Safety Factor - Yield
 SFu      = dataIn(56);   % Safety Factor - Ultimate
 LF       = dataIn(57);   % Aircraft Load Factor
 py0      = dataIn(58);   % Drag Distribution - Constant (lb/in)
 pyr      = dataIn(59);   % Drag Distribution - rth order (lb/in)
 rth      = dataIn(60);   % Drag Distribution - polynomial order
 pz0      = dataIn(61);   % Lift Distribution - Constant (lb/in)
 pz2      = dataIn(62);   % Lift Distribution - 2nd Order (lb/in)
 pz4      = dataIn(63);   % Lift Distribution - 4th Order (lb/in)
 mx0      = dataIn(64);   % Twist Moment Distribution - Constant (lb-in/in)
 mx1      = dataIn(65);   % Twist Moment Distribution - 1st Order (lb-in/in)
% Define author name and PID (Write in your name and PID)  
 name  = {'Jeremy Doan'};
 PID   = {'A16844657'};
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#2): Calculate the Section Properties
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 disp('     (2) Calculate the Section Properties')
% +     A.1) Modulus Weighted Section Properties (yc, zc, EA, EIyy, EIzz, EIyz)
% +     A.2) Torsion Constant (GJ)
% +     A.3) Shear Center Location (ysc, zsc)
% +     A.4) Total Half Span Wing Weight (lb)
   Kaw = Kaw / 100; 
   Go_sk = Go_sk * 1e6;
  
   % Stringer Properties
   A_str = [A_str1 A_str2 A_str3 A_str4]';
   rho_str = [rho_str1 rho_str2 rho_str3 rho_str4]';
   Eo_str  = (1e6) * [Eo_str1 Eo_str2 Eo_str3 Eo_str4];
   Syt_str = [Syt_str1 Syt_str2 Syt_str3 Syt_str4]';
   Sut_str = [Sut_str1 Sut_str2 Sut_str3 Sut_str4]';
   Syc_str = [Syc_str1 Syc_str2 Syc_str3 Syc_str4]';
   Suc_str = [Suc_str1 Suc_str2 Suc_str3 Suc_str4]';
   yo_str_old = [yo_str1 yo_str2 yo_str3 yo_str4];
   zo_str1 = 0; zo_str2 = (-tmax / 2); zo_str3 = 0; zo_str4 = tmax / 2;
   zo_str_old = [zo_str1 zo_str2 zo_str3 zo_str4];
 
   yc_upper = [];
   yc_lower = [];
   zc_upper = [];
   zc_lower = [];
   for j = 1:4
   yc_upper(j) = yo_str_old(j) * A_str(j) * Eo_str(j);
   yc_lower(j) = Eo_str(j) * A_str(j);
   zc_upper(j) = zo_str_old(j) * A_str(j) * Eo_str(j);
   zc_lower(j) = Eo_str(j) * A_str(j);
   end
 
   % Modulus Weighted Centroid y-direction (inch)
   yc = sum(yc_upper) / sum(yc_lower);
  
   % Modulus Weighted Centroid z-direction (inch)
   zc = sum(zc_upper) / sum(zc_lower);
    % Vectorized Stringer Properties
   yo_str = [];
   zo_str = [];
   for j = 1:4
   yo_str(j) = yo_str_old(j) - yc;
   zo_str(j) = zo_str_old(j) - zc;
   end
   Iyy_str = [(Iyy_str1 + A_str(1) * zo_str(1) ^ 2), (Iyy_str2 + A_str(2) * zo_str(2) ^ 2), ...
       (Iyy_str3 + A_str(3) * zo_str(3) ^ 2), (Iyy_str4 + A_str(4) * zo_str(4) ^ 2)]';
   Izz_str = [(Izz_str1 + A_str(1) * yo_str(1) ^ 2), (Izz_str2 + A_str(2) * yo_str(2) ^ 2), ...
       (Izz_str3 + A_str(3) * yo_str(3) ^ 2), (Izz_str4 + A_str(4) * yo_str(4) ^ 2)]';
   Iyz_str = [(Iyz_str1 + A_str(1) * yo_str(1) * zo_str(1)) (Iyz_str2 + A_str(2) * yo_str(2) * zo_str(2))...
       (Iyz_str3 + A_str(3) * yo_str(3) * zo_str(3)) (Iyz_str4 + A_str(4) * yo_str(4) * zo_str(4))]';
   % Skin Properties
   A_ell = (pi / 2) * (tmax / 2) * (Co / 4);
   A_rect = (Co / 4) * tmax;
   A_tri = (Co / 2) * (tmax / 2);
   A_wing = A_ell + A_rect + A_tri;
   yc_ell = Co / (3 * pi);
   yc_rect = 3 * Co / 8;
   yc_tri = 2 * Co / 3;
   S_ell = 0.5 * pi * ((3 * ((tmax / 2) + (Co / 4))) - sqrt((3 * (tmax / 2) + (Co / 4)) ...
       * (3 * (Co / 4) + (tmax / 2))));
   S_rect = 2 * (Co / 4);
   S_tri = 2 * sqrt((tmax / 2) ^ 2 + (Co / 2) ^ 2);
   S_wing = S_ell + S_rect + S_tri;
   % Axial   Stiffness (lb) 
   EA = Eo_str(1) * A_str(1) + Eo_str(2) * A_str(2) + Eo_str(3) * A_str(3) + Eo_str(4) * A_str(4);
  
   % Bending Stiffness (lb-in^2)           
   EIyy = Eo_str(1) * Iyy_str(1) + Eo_str(2) * Iyy_str(2) + Eo_str(3) * Iyy_str(3) + Eo_str(4) * Iyy_str(4);
 
   % Bending Stiffness (lb-in^2)
   EIzz = Eo_str(1) * Izz_str(1) + Eo_str(2) * Izz_str(2) + Eo_str(3) * Izz_str(3) + Eo_str(4) * Izz_str(4);         
 
   % Bending Stiffness (lb-in^2)
   EIyz = Eo_str(1) * Iyz_str(1) + Eo_str(2) * Iyz_str(2) + Eo_str(3) * Iyz_str(3) + Eo_str(4) * Iyz_str(4);                
   % Total Half-Span Wing Weight (lb)
   W_wing = (S_wing * rho_sk * to_sk + ...
       (dot(rho_str, A_str)))...
   * Lo * (1 + Kaw);         
   % Cross-Section Weight (lb/inch)
   rhoA = W_wing / Lo;
   % Torsion Stiffness (lb-in^2)
   GJ = Go_sk * ((4 * A_wing ^ 2 * to_sk) / S_wing);    
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#3): Calculate Root Internal Stress Resultants for Applied
% .                Concentrated Forces and Applied Aerodynamic Loads
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 disp('     (3) Calculate Root Stress Resultants for Applied Concentrated Loads and Aero Loads')
% +     B.1) Distributed Aerodynamic Loads (lift, drag, moment)
% +     B.2) Wing Root Reactions - Shear, Torque, and Moment
% +     B.3) Distributed Wing Internal Shear, Bend Moments, Torque
    % Aerodynamic Moment
   deltaD = zc;
   deltaW = (Co / 2) - yc;
   deltaL = yc - (Co / 4);
 
   % Root Internal Force - X Direction (lb)
   Vxo = 0;         
 
   % Root Internal Force - Y Direction (lb)
   Vyo = py0 * Lo + pyr * ((Lo ^ (rth + 1)) / ((rth + 1) * Lo ^ rth));
 
   % Root Internal Force - Z Direction (lb)
   Vzo = (pz0 * Lo) + (pz2/ (3 *(Lo^2)))*(Lo^3) + (pz4/(5 * (Lo^4)))*(Lo^5)...
      - (LF * W_wing / Lo) * Lo;            
 
   % Root Internal Moment - about X Direction (lb-in)
   Mxo = mx0 * Lo + mx1 * ((Lo ^ 2) / (2 * Lo)) - ...
   (yc - (Co / 4)) * ((pz0 * Lo) + (pz2/ (3 *(Lo^2)))*(Lo^3) + (pz4/(5 * (Lo^4)))*(Lo^5)) ...
   - ((Co / 2) - yc) * LF * W_wing...
   + zc * (py0 * Lo + pyr * ((Lo ^ (rth + 1)) / ((rth + 1) * Lo ^ rth)));
 
   % Root Internal Moment - about Y Direction (lb-in)
   Myo = - pz0 * ((Lo ^ 2) / 2) - pz2 * ((Lo ^ 4) / (4 * Lo ^ 2)) ...
      - pz4 * ((Lo ^ 6) / (6 * Lo ^ 4)) + (LF * W_wing * Lo / 2);            
 
   % Root Internal Moment - about Z Direction (lb-in)
   Mzo = -(- py0 * ((Lo ^ 2) / 2) - pyr *...
    ((Lo ^ (rth + 2)) / ((rth + 2) * (Lo ^ rth))));            
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#4): Calculate Allowable Properties, Root Stresses and Margin
% .                of Safety
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 disp('     (4) Calculate Allowable Properties, Root Stresses, and Margins of Safety')
% +     C.1) Wing Root Axial Stress (sxx) and Shear Stress (txs)
% +     C.2) Allowable Stress, and Root Margin of Safety
% +     C.3) Distributed Wing Axial Stress (sxx) Plot
% +     C.4) Distributed Wing Shear Stress (tau) Plot
% +     D.1) Distributed Wing Y-direction (Drag ) Displacement
% +     D.2) Distributed Wing Z-direction (Lift ) Displacement
% +     D.3) Distributed Wing Twist Rotation
% +     D.4) Distributed Wing Bending Slopes (dv/dx, dw/dx)
Sxxo_str = zeros(4, nplot);
S_allow_T_str = [];
S_allow_C_str = [];
MS_str = [];
   % Bending Compliances
   kyy = EIyy / (EIyy * EIzz - EIyz ^ 2);
   kzz = EIzz / (EIyy * EIzz - EIyz ^ 2);
   kyz = EIyz / (EIyy * EIzz - EIyz ^ 2);
for j = 1:4
  S = [Eo_str(j) * A_str(j), 0, 0; 0, Eo_str(j) * Izz_str(j), Eo_str(j) * Iyz_str(j); 0, Eo_str(j)  * Iyz_str(j), Eo_str(j) * Iyy_str(j)];
 % Sxxo_str(j) = Eo_str(j) * [1, -yo_str(j), -zo_str(j)] * inv(S) * [Vxo; Mzo; -Myo]; % Axial stress
  Sxxo_str(j) = (1/1000) * Eo_str(j) * (-yo_str(j) * (kyy * Mzo + kyz * Myo) + zo_str(j) * (kzz * Myo + kyz * Mzo));
  S_allow_T_str(j) = min([(Syt_str(j) / SFy), (Sut_str(j) / SFu)]); % Allowable tension
  S_allow_C_str(j) = -min([abs((Syc_str(j) / SFy)), abs((Suc_str(j) / SFu))]); % Allowable compression
  if Sxxo_str(j) > 0
      MS_str(j) = -1 + (S_allow_T_str(j) / Sxxo_str(j)); % Margin of Safety for Tension
  else
      MS_str(j) = -1 + (S_allow_C_str(j) / Sxxo_str(j)); % Margin of Safety for Compression
  end
end
   Sxxo_str1 = Sxxo_str(1);         % Stringer (#1) Calculated Axial Stress (lb/in^2)
   S_allow_T_str1 = S_allow_T_str(1);   % Stringer (#1) Allowable Stress - Tension (lb/in^2)
   S_allow_C_str1 = S_allow_C_str(1);   % Stringer (#1) Allowable Stress - Compression (lb/in^2)
   MS_str1 = MS_str(1);          % Stringer (#1) Margin of Safety
 
   Sxxo_str2 = Sxxo_str(2);         % Stringer (#2) Calculated Axial Stress (lb/in^2)
   S_allow_T_str2 = S_allow_T_str(2);   % Stringer (#2) Allowable Stress - Tension (lb/in^2)
   S_allow_C_str2 = S_allow_C_str(2);   % Stringer (#2) Allowable Stress - Compression (lb/in^2)
   MS_str2 = MS_str(2);          % Stringer (#2) Margin of Safety
 
   Sxxo_str3 = Sxxo_str(3);         % Stringer (#3) Calculated Axial Stress (lb/in^2)
   S_allow_T_str3 = S_allow_T_str(3);   % Stringer (#3) Allowable Stress - Tension (lb/in^2)
   S_allow_C_str3 = S_allow_C_str(3);   % Stringer (#3) Allowable Stress - Compression (lb/in^2)
   MS_str3 = MS_str(3);          % Stringer (#3) Margin of Safety
 
   Sxxo_str4 = Sxxo_str(4);         % Stringer (#4) Calculated Axial Stress (lb/in^2)
   S_allow_T_str4 = S_allow_T_str(4);   % Stringer (#4) Allowable Stress - Tension (lb/in^2)
   S_allow_C_str4 = S_allow_C_str(4);   % Stringer (#4) Allowable Stress - Compression (lb/in^2)
   MS_str4 = MS_str(4);          % Stringer (#4) Margin of Safety
 % Initialize the variables
 x = linspace(0, Lo, nplot);
 Vy = zeros(1, nplot);
 Vz = zeros(1, nplot);
 Mx = zeros(1, nplot);
 Disp_Y = zeros(1, nplot);
 Disp_Z = zeros(1, nplot);
 Twist = zeros(1, nplot);
 DvDx = zeros(1, nplot);
 DwDx = zeros(1, nplot);
 My_int = zeros(1, nplot);
 Mz_int = zeros(1, nplot);
 My_int2 = zeros(1, nplot);
 Mz_int2 = zeros(1, nplot);
 Vy_int = zeros(1, nplot);
 Vz_int = zeros(1, nplot);
 Mx_int = zeros(1, nplot);
 M_external = zeros(1, nplot);
 % Shear stuff
% A12 = 0.5 * A_ell + 0.5 * (yo_str2 - (Co / 4)) * (tmax / 2);
% A23 = ((Co / 2) - yo_str2) * (tmax / 2) + ((yo_str2 - (Co / 4)) * (tmax / 2) * 0.5) + 0.5 * A_tri;
% A34 = ((Co / 2) - yo_str4) * (tmax / 2) + ((yo_str4 - (Co / 4)) * (tmax / 2) * 0.5) + 0.5 * A_tri;
% A41 = 0.5 * A_ell + 0.5 * (yo_str4 - (Co / 4)) * (tmax / 2);
% A_sk = [A12 A23 A34 A41];
% cstar = sqrt((Co / 2) ^ 2 + (tmax / 2) ^ 2);
% S12 = 0.5 * S_ell + yo_str_old(2) - (Co / 4);
% S23 = (Co / 2) - yo_str_old(2) + cstar;
% S34 = (Co / 2) - yo_str_old(4) + cstar;
% S41 = 0.5 * S_ell + yo_str_old(4) - (Co / 4);
S12 = pi/4*(3*(Co/4+tmax/2)-sqrt((3*Co/4+tmax/2)*(Co/4+tmax/2*3))) + (yo_str2-Co/4);
S41 = pi/4*(3*(Co/4+tmax/2)-sqrt((3*Co/4+tmax/2)*(Co/4+tmax/2*3))) + (yo_str4-Co/4);
S34 = (Co/2-yo_str4) + sqrt((tmax/2)^2+(Co/2)^2);
S23= (Co/2-yo_str2) + sqrt((tmax/2)^2+(Co/2)^2);
A12 = pi/4*(Co/4*tmax/2) + (yo_str2-Co/4)*(tmax/2)/2;
A41 = pi/4*(Co/4*tmax/2) + (yo_str4-Co/4)*(tmax/2)/2;
A34 = (Co/2-yo_str4)*(tmax/2) + (yo_str4 - Co/4)*(tmax/2)/2 + Co/2*tmax/2/2;
A23 = (Co/2-yo_str2)*(tmax/2) + (yo_str2 - Co/4)*(tmax/2)/2 + Co/2*tmax/2/2;
S_sk = [S12 S23 S34 S41];
K = [2 * A12, 2 * A23, 2 * A34, 2 * A41; 1, -1, 0, 0; ...
  0, 1, -1, 0; 0, 0, 1, -1];
fm = [1; 0; 0; 0];
inv_t = (1 / to_sk) * eye(4,4);
Tau_o_sk = zeros(4,1);
Tau_allow_S_sk = [];
MS_sk = [];
q_sk = zeros(4, nplot);
fy = zeros(4, 1);
fz = zeros(4, 1);
rhs = zeros(4,nplot);
for ii = 1:nplot
Vy(ii) = -((-Vyo + ...
       (py0 * x(ii)) + pyr * ((x(ii) .^ (rth + 1)) / ((rth + 1)  ...
        * Lo ^ rth))));       
Vz(ii) = -(-Vzo + (pz0 * x(ii)) + (pz2 * ((x(ii) .^ 3) / (3 * Lo ^ 2))) + ...
       (pz4 * ((x(ii) .^ 5 / (5 * Lo ^ 4)))) - (LF * W_wing * x(ii) / Lo));
Mx(ii) = Mxo - deltaD * ((py0 * x(ii)) + pyr * ((x(ii) .^ (rth + 1)) / ((rth + 1)  ...
        * Lo ^ rth))) + deltaL * ((pz0 * x(ii)) + (pz2 * ((x(ii) .^ 3) / (3 * Lo ^ 2))) + ...
       (pz4 * ((x(ii) .^ 5 / (5 * Lo ^ 4)))) - (LF * W_wing * x(ii) / Lo)) + deltaW * (LF * W_wing * x(ii) / Lo) ...
       - (mx0 * x(ii) + mx1 * ((x(ii) .^ 2) / (2 * Lo)));
Vy_int(ii) = -(Vyo * x(ii) - py0 * ((x(ii) .^ 2) / 2) - pyr * ((x(ii) .^ (rth + 2)) / ((rth + 1) * ...
        (rth + 2) * (Lo ^ rth))));
Vz_int(ii) = (Vzo * x(ii) - pz0 * ((x(ii) .^ 2) / 2) - pz2 * ((x(ii) .^ 4) / (12 * Lo ^ 2)) - ...
       pz4 * ((x(ii) .^ 6) / (30 * Lo ^ 4)) + (LF * W_wing) * ((x(ii) ^ 2) / (2 *Lo)));
Mx_int(ii) = Mxo * x(ii) - deltaD * (py0 * ((x(ii) .^ 2) / 2) + pyr * ((x(ii) .^ (rth + 2)) / ((rth + 1) * ...
        (rth + 2) * (Lo ^ rth)))) + deltaL * (pz0 * ((x(ii) .^ 2) / 2) + pz2 * ((x(ii) .^ 4) / (12 * Lo ^ 2))  ...
        + pz4 * ((x(ii) .^ 6) / (30 * Lo ^ 4)) - (LF * W_wing) * ((x(ii) ^ 2) / (2 *Lo))) + deltaW * (LF * W_wing * (x(ii) .^ 2) /(2 * Lo)) ...
       - (mx0 * ((x(ii) .^ 2) / 2) + mx1 * ((x(ii) .^ 3) / (6 * Lo)));
M_external(ii) = Mx(ii) - Vy(ii)*zc + Vz(ii)*(yc - Co/4);
end
for j = 1:4
  fy(j) = Eo_str(j) * A_str(j) * yo_str(j) * kyy - Eo_str(j) * A_str(j) * zo_str(j) * kyz;
  fz(j) = Eo_str(j) * A_str(j) * zo_str(j) * kzz - Eo_str(j) * A_str(j) * yo_str(j) * kyz;
end
fy(1) = -zc; fz(1) = yc - (Co/4);
for ii = 1: nplot   
rhs(:, ii) = (Vy(ii) * fy + Vz(ii) * fz + Mx(ii) * fm);
q_sk = inv(K) * rhs;
end
Tau_o_sk = (1/1000) * inv_t * q_sk;
for j = 1:4
  Tau_allow_S_sk(j) = min([(abs(Sys_sk) / SFy), ((abs(Sus_sk)) / SFu)]);
  MS_sk(j) = -1 + (Tau_allow_S_sk(j) / (abs(Tau_o_sk(j))));
end
   Tau_o_sk12 = Tau_o_sk(1,1);       % Skin Panel (1.2) Calculated Shear Stress (lb/in^2)
   Tau_allow_S_sk12 = Tau_allow_S_sk(1); % Skin Panel (1.2) Allowable Shear Stress  (lb/in^2)
   MS_sk12 = MS_sk(1);          % Skin Panel (1.2) Margin of Safety
   Tau_o_sk23 = Tau_o_sk(2,1);       % Skin Panel (2.3) Calculated Shear Stress (lb/in^2)
   Tau_allow_S_sk23 = Tau_allow_S_sk(2); % Skin Panel (2.3) Allowable Shear Stress  (lb/in^2)
   MS_sk23 = MS_sk(2);          % Skin Panel (2.3) Margin of Safety
   Tau_o_sk34 = Tau_o_sk(3,1);       % Skin Panel (3.4) Calculated Shear Stress (lb/in^2)
   Tau_allow_S_sk34 = Tau_allow_S_sk(3); % Skin Panel (3.4) Allowable Shear Stress  (lb/in^2)
   MS_sk34 = MS_sk(3);          % Skin Panel (3.4) Margin of Safety
   Tau_o_sk41 = Tau_o_sk(4,1);       % Skin Panel (4.1) Calculated Shear Stress (lb/in^2)
   Tau_allow_S_sk41 = Tau_allow_S_sk(4); % Skin Panel (4.1) Allowable Shear Stress  (lb/in^2)
   MS_sk41 = MS_sk(4);          % Skin Panel (4.1) Margin of Safety
  
   SGt =  (1 / (Go_sk * to_sk * 2 * (A12 + A23 + A34 + A41))) * [S12 S23 S34 S41];
   twistZ = SGt * inv(K) * fz;
   twistM = SGt * inv(K) * fm;
   twistY = SGt * inv(K) * fy;
   % Shear Center y-direction (inch)
   ysc = yc - ( twistZ / twistM);            
 
   % Shear Center z-direction (inch)
   zsc = zc + (twistY / twistM);          
   for ii = 1 : nplot
      % Integrated internal shear force - My (lb-in) (dv/dx)
      Mz_int(ii) = ((-Vyo * (x(ii) .^ 2) / 2) + (Mzo * x(ii)) + ...
        (py0 * (x(ii) .^ 3) / 6) + pyr * ((x(ii) .^ (rth + 3)) / ((rth + 1) * (rth + 2) ...
        * (rth + 3) * Lo ^ rth)));         
    
      % Integrated internal shear force - Mz (lb-in) (dw/dx)
      My_int(ii) = -((-Vzo * (x(ii) .^ 2) / 2) - (Myo * x(ii)) ...
      + (pz0 * (x(ii) .^ 3) / 6) + (pz2 * ((x(ii) .^ 5) / (60 * Lo ^ 2))) + ...
        (pz4 * ((x(ii) .^ 7 / (210 * Lo ^ 4)))) - (LF * W_wing * ((x(ii) .^ 3) / (6 * Lo))));
    
      % Integrated bending slope - Y Direction (inch) (v(x))
      Mz_int2(ii) = ((-Vyo * (x(ii) .^ 3) / 6) + (Mzo * (x(ii) .^ 2) / 2) + ...
        (py0 * (x(ii) .^ 4) / 24) + pyr * ((x(ii) .^ (rth + 4)) / ((rth + 1) * (rth + 2) ...
        * (rth + 3) * (rth + 4) * Lo ^ rth)));   
    
      % Integrated bending slope - Z Direction (inch) (w(x))
      My_int2(ii)= -((-Vzo * (x(ii) .^ 3) / 6) - (Myo * (x(ii) .^ 2) / 2) + ...
        (pz0 * (x(ii) .^ 4) / 24) + (pz2 * ((x(ii) .^ 6) / (360 * (Lo ^ 2)))) + ...
        (pz4 * (((x(ii) .^ 8) / (1680 * (Lo ^ 4))))) - (LF * W_wing * ((x(ii) .^ 4) / (24* Lo)))); 
     
       % Tip Diplacement - Y Direction (inch)
       Disp_Y(nplot) = kyy * Mz_int2(ii) + kyz * My_int2(ii);  
     
       % Tip Diplacement - Z Direction (inch)
       Disp_Z(nplot) = -kzz * My_int2(ii) - kyz * Mz_int2(ii);  
     
       SGt =  (1 / (Go_sk * to_sk * 2 * (A12 + A23 + A34 + A41))) * [S12 S23 S34 S41];
       % % Tip Twist (degree)
       % Twist(nplot) = (180/pi) * (SGt * inv(K) * ((Vy_int(nplot) .* fy + Vz_int(nplot) .* fz + Mx_int(nplot) .* fm)));
      
       % Tip Bending Slope (dv/dx) (inch/inch)
       DvDx(nplot) = kyy * Mz_int(ii) + kyz * My_int(ii);    
     
       % Tip Bending Slope (dw/dx) (inch/inch)
       DwDx(nplot) = -kzz * My_int(ii) - kyz * Mz_int(ii);    
   end
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#5): Calculate the Data Arrays for Plotting
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 disp('     (5) Calculate the Data Arrays for Future Plotting')
% Initialize variables
x = linspace(0, Lo, nplot);
Vy = zeros(1, nplot);
Vz = zeros(1, nplot);
Mx = zeros(1, nplot);
Disp_Y = zeros(1, nplot);
Disp_Z = zeros(1, nplot);
Twist = zeros(1, nplot);
DvDx = zeros(1, nplot);
DwDx = zeros(1, nplot);
My_int = zeros(1, nplot);
Mz_int = zeros(1, nplot);
My_int2 = zeros(1, nplot);
Mz_int2 = zeros(1, nplot);
Vy_int = zeros(1, nplot);
Vz_int = zeros(1, nplot);
Mx_int = zeros(1, nplot);

 
  % Aerodynamic Moment
  deltaD = zc;
  deltaW = (Co / 2) - yc;
  deltaL = yc - (Co / 4);
  % Root Internal Force - X Direction (lb)
  Vxo = 0;        
  % Root Internal Force - Y Direction (lb)
  Vyo = py0 * Lo + pyr * ((Lo ^ (rth + 1)) / ((rth + 1) * Lo ^ rth));
  % Root Internal Force - Z Direction (lb)
  Vzo = (pz0 * Lo) + (pz2/ (3 *(Lo^2)))*(Lo^3) + (pz4/(5 * (Lo^4)))*(Lo^5)...
     - (LF * W_wing / Lo) * Lo;           
  % Root Internal Moment - about X Direction (lb-in)
  Mxo = mx0 * Lo + mx1 * ((Lo ^ 2) / (2 * Lo)) - ...
  (yc - (Co / 4)) * ((pz0 * Lo) + (pz2/ (3 *(Lo^2)))*(Lo^3) + (pz4/(5 * (Lo^4)))*(Lo^5)) ...
  - ((Co / 2) - yc) * LF * W_wing...
  + zc * (py0 * Lo + pyr * ((Lo ^ (rth + 1)) / ((rth + 1) * Lo ^ rth)));
  % Root Internal Moment - about Y Direction (lb-in)
  Myo = - pz0 * ((Lo ^ 2) / 2) - pz2 * ((Lo ^ 4) / (4 * Lo ^ 2)) ...
     - pz4 * ((Lo ^ 6) / (6 * Lo ^ 4)) + (LF * W_wing * Lo / 2);
  % Root Internal Moment - about Z Direction (lb-in)
  Mzo = -(- py0 * ((Lo ^ 2) / 2) - pyr *...
   ((Lo ^ (rth + 2)) / ((rth + 2) * (Lo ^ rth)))); 
for ii = 1:nplot
% x-location (inch)
x(ii);          
% drag force (lb/in)
py(ii) = py0 + pyr * ((x(ii) .^ rth) / (Lo ^ rth));         
% lift force (lb/in)
pz(ii) = pz0 + (pz2 * ((x(ii) .^ 2) / (Lo ^ 2))) + (pz4 * ((x(ii) .^ 4) / (Lo ^ 4))) - (LF * W_wing / Lo);         
% distributed torque (lb-in/in)
mx(ii) = mx0 + mx1 * (x(ii) / Lo) + deltaD * py(ii) - deltaL * pz(ii) - deltaW * (LF * W_wing / Lo);        
% Internal shear force - Vy (lb)
Vy(ii) = -((-Vyo + ...
      (py0 * x(ii)) + pyr * ((x(ii) .^ (rth + 1)) / ((rth + 1)  ...
       * Lo ^ rth))));         
% Internal shear force - Vz (lb)
Vz(ii) = -(-Vzo + (pz0 * x(ii)) + (pz2 * ((x(ii) .^ 3) / (3 * Lo ^ 2))) + ...
      (pz4 * ((x(ii) .^ 5 / (5 * Lo ^ 4)))) - (LF * W_wing * x(ii) / Lo));         
% Internal axial force - Mx (lb-in)
Mx(ii) = Mxo - deltaD * ((py0 * (x(ii) .^ 2) /2) + pyr * ((x(ii) .^ (rth + 2)) / ((rth + 1)  ...
     * (rth + 2) * Lo ^ rth))) + deltaL * ((pz0 * (x(ii) .^ 2) / 2) + (pz2 * ((x(ii) .^ 4) / (12 * Lo ^ 2))) + ...
     (pz4 * ((x(ii) .^ 5 / (30 * Lo ^ 4)))) - (LF * W_wing * x(ii) / Lo)) + deltaW * (LF * W_wing * (x(ii) .^ 2) / Lo) ...
     - (mx0 * (x(ii) .^ 2) / 2 + mx1 * ((x(ii) .^ 3) / (6 * Lo)));         
% Internal shear force - My (lb-in)
Mz(ii) = ((-Vyo * x(ii) + Mzo + ...
      (py0 * (x(ii) .^ 2) / 2) + pyr * ((x(ii) .^ (rth + 2)) / ((rth + 1) * (rth + 2) ...
       * Lo ^ rth))));         
% Internal shear force - Mz (lb-in)
My(ii) = -((-Vzo * x(ii)) - Myo ...
       + (pz0 * ((x(ii) .^ 2) / 2)) + (pz2 * ((x(ii) .^ 4) / (12 * Lo ^ 2))) + ...
      (pz4 * ((x(ii) .^ 6 / (30 * Lo ^ 4)))) - (LF * W_wing * ((x(ii) .^ 2) / (2 * Lo))));         
Vy_int(ii) = (Vyo * x(ii) - py0 * ((x(ii) .^ 2) / 2) - pyr * ((x(ii) .^ (rth + 2)) / ((rth + 1) * ...
        (rth + 2) * (Lo ^ rth))));
Vz_int(ii) = (Vzo * x(ii) - pz0 * ((x(ii) .^ 2) / 2) - pz2 * ((x(ii) .^ 4) / (12 * Lo ^ 2)) - ...
       pz4 * ((x(ii) .^ 6) / (30 * Lo ^ 4)) + (LF * W_wing) * ((x(ii) ^ 2) / (2 *Lo)));
Mx_int(ii) = Mxo * x(ii) - deltaD * (py0 * ((x(ii) .^ 2) / 2) + pyr * ((x(ii) .^ (rth + 2)) / ((rth + 1) * ...
        (rth + 2) * (Lo ^ rth)))) + deltaL * (pz0 * ((x(ii) .^ 2) / 2) + pz2 * ((x(ii) .^ 4) / (12 * Lo ^ 2))  ...
        + pz4 * ((x(ii) .^ 6) / (30 * Lo ^ 4)) - (LF * W_wing) * ((x(ii) ^ 2) / (2 *Lo))) + deltaW * (LF * W_wing * (x(ii) .^ 2) /(2 * Lo)) ...
       - (mx0 * ((x(ii) .^ 2) / 2) + mx1 * ((x(ii) .^ 3) / (6 * Lo)));
      % Integrated internal shear force - My (lb-in) (dv/dx)
      Mz_int(ii) = ((-Vyo * (x(ii) .^ 2) / 2) + (Mzo * x(ii)) + ...
        (py0 * (x(ii) .^ 3) / 6) + pyr * ((x(ii) .^ (rth + 3)) / ((rth + 1) * (rth + 2) ...
        * (rth + 3) * Lo ^ rth)));         
    
      % Integrated internal shear force - Mz (lb-in) (dw/dx)
      My_int(ii) = -((-Vzo * (x(ii) .^ 2) / 2) - (Myo * x(ii)) ...
      + (pz0 * (x(ii) .^ 3) / 6) + (pz2 * ((x(ii) .^ 5) / (60 * Lo ^ 2))) + ...
        (pz4 * ((x(ii) .^ 7 / (210 * Lo ^ 4)))) - (LF * W_wing * ((x(ii) .^ 3) / (6 * Lo))));
    
      % Integrated bending slope - Y Direction (inch) (v(x))
      Mz_int2(ii) = ((-Vyo * (x(ii) .^ 3) / 6) + (Mzo * (x(ii) .^ 2) / 2) + ...
        (py0 * (x(ii) .^ 4) / 24) + pyr * ((x(ii) .^ (rth + 4)) / ((rth + 1) * (rth + 2) ...
        * (rth + 3) * (rth + 4) * Lo ^ rth)));   
    
      % Integrated bending slope - Z Direction (inch) (w(x))
      My_int2(ii)= -((-Vzo * (x(ii) .^ 3) / 6) - (Myo * (x(ii) .^ 2) / 2) + ...
        (pz0 * (x(ii) .^ 4) / 24) + (pz2 * ((x(ii) .^ 6) / (360 * (Lo ^ 2)))) + ...
        (pz4 * (((x(ii) .^ 8) / (1680 * (Lo ^ 4))))) - (LF * W_wing * ((x(ii) .^ 4) / (24* Lo)))); 
     
% Bending Compliances
  kyy = EIyy / (EIyy * EIzz - EIyz ^ 2);
  kzz = EIzz / (EIyy * EIzz - EIyz ^ 2);
  kyz = EIyz / (EIyy * EIzz - EIyz ^ 2);  
% Axial stress
  for j = 1:4
   S = [Eo_str(j) * A_str(j), 0, 0; 0, Eo_str(j) * Izz_str(j), Eo_str(j) * Iyz_str(j); 0, Eo_str(j)  * Iyz_str(j), Eo_str(j) * Iyy_str(j)];

  end
 
properties = inv([EA 0 0; 0 EIzz EIyz; 0 EIyz EIyy]) * [Vxo; Mz(ii); -My(ii)];
Sxx_str1(ii) = Eo_str1 * [1, -(yo_str1-yc), zc] * properties * 1000;
Sxx_str2(ii) = Eo_str2 * [1, -(yo_str2-yc), -(-tmax/2-zc)] * properties * 1000;
Sxx_str3(ii) = Eo_str3 * [1, -(yo_str3-yc), zc] * properties * 1000;
Sxx_str4(ii) = Eo_str4 * [1, -(yo_str4-yc), -(tmax/2-zc)] * properties * 1000;

   
fz = [ yc - Co/4;  Eo_str2 *10^6 *A_str2*((-tmax/2 -zc)*kzz -(yo_str2-yc)*kyz); Eo_str3*10^6*A_str3*(( -zc)*kzz -(yo_str3-yc)*kyz); Eo_str4*10^6*A_str4*((tmax/2 -zc)*kzz -(yo_str4-yc)*kyz)];
fm = [ -zc; Eo_str2*10^6*A_str2*((yo_str2-yc)*kyy - (-tmax/2 -zc)*kyz) ;Eo_str3*10^6*A_str3*((yo_str3-yc)*kyy - (-zc)*kyz) ; Eo_str4*10^6*A_str4*((yo_str4-yc)*kyy - (tmax/2 -zc)*kyz)];
fm = [1; 0; 0; 0];

for ii = 1:nplot
Vy(ii) = -((-Vyo + ...
      (py0 * x(ii)) + pyr * ((x(ii) .^ (rth + 1)) / ((rth + 1)  ...
       * Lo ^ rth))));      
Vz(ii) = -(-Vzo + (pz0 * x(ii)) + (pz2 * ((x(ii) .^ 3) / (3 * Lo ^ 2))) + ...
      (pz4 * ((x(ii) .^ 5 / (5 * Lo ^ 4)))) - (LF * W_wing * x(ii) / Lo));
Mx(ii) = Mxo - deltaD * ((py0 * x(ii)) + pyr * ((x(ii) .^ (rth + 1)) / ((rth + 1)  ...
       * Lo ^ rth))) + deltaL * ((pz0 * x(ii)) + (pz2 * ((x(ii) .^ 3) / (3 * Lo ^ 2))) + ...
      (pz4 * ((x(ii) .^ 5 / (5 * Lo ^ 4))))) + deltaW * (LF * W_wing * x(ii) / Lo) ...
      - (mx0 * x(ii) + mx1 * ((x(ii) .^ 2) / (2 * Lo)));
M_external(ii) = Mx(ii) - Vy(ii)*zc + Vz(ii)*(yc - Co/4);
end
  
rhs = [Vy .* fy + Vz .* fz + Mx .* fm];
q_sk = inv(K) * rhs;
Tau_sk = (1/1000) * inv_t * q_sk;

for ii = 1:nplot
% Skin Panel (1.2) Shear Stress (lb/in^2)
Tau_sk12(ii) = Tau_sk(1,ii);  
% Skin Panel (2.3) Shear Stress (lb/in^2)
Tau_sk23(ii) = Tau_sk(2,ii);   
% Skin Panel (3.4) Shear Stress (lb/in^2)
Tau_sk34(ii) = Tau_sk(3,ii); 
% Skin Panel (4.1) Shear Stress (lb/in^2)
Tau_sk41(ii) = Tau_sk(4,ii);   
end
% Displacements and Slopes
for ii = 1:nplot
% Displacement - Y Direction (inch)
Disp_Y(ii) = kyy * Mz_int2(ii) + kyz * My_int2(ii);    
% Displacement - Z Direction (inch)
Disp_Z(ii) = -kzz * My_int2(ii) - kyz * Mz_int2(ii);     

% Bending Slope (dv/dx) (inch/inch)
DvDx(ii) = kyy * Mz_int(ii) + kyz * My_int(ii);       
% Bending Slope (dw/dx) (inch/inch)
DwDx(ii) = -kzz * My_int(ii) - kyz * Mz_int(ii);
end
% Wing Twist

Vy_int = Vyo.*x - (py0.*x.^2/2 +pyr.*x.^(rth+2)/(Lo^rth*(rth+1)*(rth+2)));
Vz_int =Vzo .*x + (W_wing/Lo*LF).*x.^2/2-pz0.*x.^2/2-pz2.*x.^4/(12*Lo^2)...
-pz4.*x.^6/(30*Lo^4);
Mx_int = Mxo.*x - mx0.*x.^2/2-mx1*(x.^3)./(6*Lo) - (pz0.*x.^2/2 + pz2.*x.^4/(12*Lo^2)+pz4.*x.^6/(30*Lo^4))*(Co/4-yc)...
+rhoA*(LF).*x.^2/2 .*(Co/2-yc) - (py0.*x.^2/2 +pyr.*x.^(rth+2)/(Lo^rth*(rth+1)*(rth+2)))*(zc);
SGt = [S12 S23 S34 S41]/(Go_sk*to_sk*2* (A12 +A23 + A34 + A41));
Twist = SGt * inv(K) * [Vy_int.*fy + Vz_int .* fz + Mx_int .*fm] * (180/pi);

end
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#6): Pack Calculated Data into the "dataOut1" Array size: (50)
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 disp('     (6) Pack the Calculated Data into Array: dataOut1')
   dataOut1(01) = yc;               % Modulus Weighted Centroid y-direction (inch)
   dataOut1(02) = zc;               % Modulus Weighted Centroid z-direction (inch)
   dataOut1(03) = rhoA;             % Cross-Section Weight (lb/inch)
   dataOut1(04) = EA;               % Axial   Stiffness (lb)
   dataOut1(05) = EIyy;             % Bending Stiffness (lb-in^2) 
   dataOut1(06) = EIzz;             % Bending Stiffness (lb-in^2) 
   dataOut1(07) = EIyz;             % Bending Stiffness (lb-in^2) 
   dataOut1(08) = GJ;               % Torsion Stiffness (lb-in^2)
   dataOut1(09) = ysc;              % Shear Center y-direction (inch)
   dataOut1(10) = zsc;              % Shear Center z-direction (inch)
   dataOut1(11) = W_wing;           % Total Half-Span Wing Weight (lb)
   dataOut1(12) = Vxo;              % Root Internal Force - X Direction (lb)
   dataOut1(13) = Vyo;              % Root Internal Force - Y Direction (lb)
   dataOut1(14) = Vzo;              % Root Internal Force - Z Direction (lb)
   dataOut1(15) = Mxo;              % Root Internal Moment - about X Direction (lb-in)
   dataOut1(16) = Myo;              % Root Internal Moment - about Y Direction (lb-in)
   dataOut1(17) = Mzo;              % Root Internal Moment - about Z Direction (lb-in)
   dataOut1(18) = Sxxo_str1;         % Stringer (#1) Calculated Axial Stress (lb/in^2)
   dataOut1(19) = S_allow_T_str1;   % Stringer (#1) Allowable Stress - Tension (lb/in^2)
   dataOut1(20) = S_allow_C_str1;   % Stringer (#1) Allowable Stress - Compression (lb/in^2)
   dataOut1(21) = MS_str1;          % Stringer (#1) Margin of Safety
   dataOut1(22) = Sxxo_str2;         % Stringer (#2) Calculated Axial Stress (lb/in^2)
   dataOut1(23) = S_allow_T_str2;   % Stringer (#2) Allowable Stress - Tension (lb/in^2)
   dataOut1(24) = S_allow_C_str2;   % Stringer (#2) Allowable Stress - Compression (lb/in^2)
   dataOut1(25) = MS_str2;          % Stringer (#2) Margin of Safety
   dataOut1(26) = Sxxo_str3;         % Stringer (#3) Calculated Axial Stress (lb/in^2)
   dataOut1(27) = S_allow_T_str3;   % Stringer (#3) Allowable Stress - Tension (lb/in^2)
   dataOut1(28) = S_allow_C_str3;   % Stringer (#3) Allowable Stress - Compression (lb/in^2)
   dataOut1(29) = MS_str3;          % Stringer (#3) Margin of Safety
   dataOut1(30) = Sxxo_str4;         % Stringer (#4) Calculated Axial Stress (lb/in^2)
   dataOut1(31) = S_allow_T_str4;   % Stringer (#4) Allowable Stress - Tension (lb/in^2)
   dataOut1(32) = S_allow_C_str4;   % Stringer (#4) Allowable Stress - Compression (lb/in^2)
   dataOut1(33) = MS_str4;          % Stringer (#4) Margin of Safety
   dataOut1(34) = Tau_o_sk12;       % Skin Panel (1.2) Calculated Shear Stress (lb/in^2)
   dataOut1(35) = Tau_allow_S_sk12; % Skin Panel (1.2) Allowable Shear Stress  (lb/in^2)
   dataOut1(36) = MS_sk12;          % Skin Panel (1.2) Margin of Safety
   dataOut1(37) = Tau_o_sk23;       % Skin Panel (2.3) Calculated Shear Stress (lb/in^2)
   dataOut1(38) = Tau_allow_S_sk23; % Skin Panel (2.3) Allowable Shear Stress  (lb/in^2)
   dataOut1(39) = MS_sk23;          % Skin Panel (2.3) Margin of Safety
   dataOut1(40) = Tau_o_sk34;       % Skin Panel (3.4) Calculated Shear Stress (lb/in^2)
   dataOut1(41) = Tau_allow_S_sk34; % Skin Panel (3.4) Allowable Shear Stress  (lb/in^2)
   dataOut1(42) = MS_sk34;          % Skin Panel (3.4) Margin of Safety
   dataOut1(43) = Tau_o_sk41;       % Skin Panel (4.1) Calculated Shear Stress (lb/in^2)
   dataOut1(44) = Tau_allow_S_sk41; % Skin Panel (4.1) Allowable Shear Stress  (lb/in^2)
   dataOut1(45) = MS_sk41;          % Skin Panel (4.1) Margin of Safety
   dataOut1(46) = Disp_Y(nplot);    % Tip Diplacement - Y Direction (inch)
   dataOut1(47) = Disp_Z(nplot);    % Tip Diplacement - Z Direction (inch)
   dataOut1(48) = Twist(nplot);     % Tip Twist (degree)
   dataOut1(49) = DvDx(nplot);      % Tip Bending Slope (dv/dx) (inch/inch)
   dataOut1(50) = DwDx(nplot);      % Tip Bending Slope (dw/dx) (inch/inch)
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% .  SECTION (#7): Pack the plot data arrays into "dataOut2"
% .                matrix size: (nplot,22)
% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 disp('     (7) Pack the Calculated Plot Data into Array: dataOut2')
 for ii = 1:nplot;
   dataOut2(ii, 1) = x(ii);           % x-location (inch)
   dataOut2(ii, 2) = py(ii);          % drag force (lb/in)
   dataOut2(ii, 3) = pz(ii);          % lift force (lb/in)
   dataOut2(ii, 4) = mx(ii);          % distributed torque (lb-in/in)
   dataOut2(ii, 5) = Vy(ii);          % Internal shear force - Vy (lb)
   dataOut2(ii, 6) = Vz(ii);          % Internal shear force - Vz (lb)
   dataOut2(ii, 7) = Mx(ii);          % Internal axial force - Mx (lb-in)
   dataOut2(ii, 8) = My(ii);          % Internal shear force - My (lb-in)
   dataOut2(ii, 9) = Mz(ii);          % Internal shear force - Mz (lb-in)
   dataOut2(ii,10) = Sxx_str1(ii);    % Stringer (#1) Axial Stress (lb/in^2)
   dataOut2(ii,11) = Sxx_str2(ii);    % Stringer (#2) Axial Stress (lb/in^2)
   dataOut2(ii,12) = Sxx_str3(ii);    % Stringer (#3) Axial Stress (lb/in^2)
   dataOut2(ii,13) = Sxx_str4(ii);    % Stringer (#4) Axial Stress (lb/in^2)
   dataOut2(ii,14) = Tau_sk12(ii);    % Skin Panel (1.2) Shear Stress (lb/in^2)
   dataOut2(ii,15) = Tau_sk23(ii);    % Skin Panel (2.3) Shear Stress (lb/in^2)
   dataOut2(ii,16) = Tau_sk34(ii);    % Skin Panel (3.4) Shear Stress (lb/in^2)
   dataOut2(ii,17) = Tau_sk41(ii);    % Skin Panel (4.1) Shear Stress (lb/in^2)
   dataOut2(ii,18) = Disp_Y(ii);      % Displacement - Y Direction (inch)
   dataOut2(ii,19) = Disp_Z(ii);      % Displacement - Z Direction (inch)
   dataOut2(ii,20) = Twist(ii);       % Wing Twist (degree)
   dataOut2(ii,21) = DvDx(ii);        % Bending Slope (dv/dx) (inch/inch)
   dataOut2(ii,22) = DwDx(ii);        % Bending Slope (dw/dx) (inch/inch)
 end;
end
%  End of Function: Wing_Analysis_Function
%  ------------------------------------------------------------------------

