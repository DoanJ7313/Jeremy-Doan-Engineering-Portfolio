# Jeremy Doan Engineering Portfolio

## 2022
_Pokeball Launcher Structure:_

This project was the final project of my Graphical Communication for Engineering Design course. The goal was to design a structure to launch a Pokeball (bean bag) onto target platforms.  During this project, I worked in a team with three other people. Each member was designated a role: project manager (1), manufacturing specialist (2), and CAD specialist (1). My role was the project manager, and my responsibilities were to ensure that all deadlines were met as well as distributing tasks among the team. All members had to design their own parts using Solidworks and AutoCAD. A final presentation was delivered and the structure was tested. Unfortunately, I do not have access to the testing videos. 

## 2023
_Coca-Cola Can Reinforcement:_
	
This project was the final project of my Structural Materials course. The goal of this project was to reinforce a soda can so that it could resist as much compressive force as possible. My design went through two iterations. My first design was very inefficient and actually helped increase the buckling effects of the compressive force instead of resisting it. My second design used fewer materials and provided far more effective compressive support. It turned out that my second design closely resembled stiffened panels used in aircraft, hence increased performance under compressive loads.

## 2024
_Matlab Spar Analysis:_

This project was one of two major projects in my Aerospace Structural Mechanics I course. It serves as a comprehensive analysis of an aircraft spar, such as calculating tip deflections along three axes. This assumes a thin-wall circular cross-section. The code reads loading case data from an input Excel sheet, performs all the necessary calculations and graphing, and exports everything onto an Excel output sheet. Part of the code was supplied by the professor which was just the function that allowed the code to read and export data from the input and output sheets, respectively. My responsibility was to program the graphing and calculations properly. 

_Matlab Wing Analysis:_

This project was the other of two major projects in my Aerospace Structural Mechanics I course. Like the Spar Analysis, it performs a comprehensive analysis of an aircraft wing. This assumes a symmetrical airfoil cross-section with stringers and wing skins included. The Wing Analysis also reads data from an input Excel sheet and exports all the calculations and graphs onto an output sheet. The professor provided the code for inputting and outputting data, while the rest of the code was written by me. 

_Regression ML Final Project:_

This project was the final project of my Machine Learning for Structural Engineers course. The goal was to predict soil-water retention given temperature, suction, and degree of saturation as parameters. I programmed several machine learning regression models and compared their performance in Python. Some of the models used include standard polynomial regression, k nearest neighbor (KNN), and artificial neural networks. I also used methods such as grid search to optimize model hyperparameters. The libraries primarily used were Scikit-learn and TensorFlow. Overall, my neural network models performed the best in terms of minimizing the mean square error. However, they were also the most computationally expensive and time-consuming to train compared to the simpler models. 

_Generative Adversarial Networks (GAN):_

One machine learning model that I have studied during my research with Professor Semnani is the generative adversarial network. In practice, it is used to generate images similar to whatever images are used to train the model. For my project, I used a sample architecture as a template and made adjustments to it to accommodate the dataset I was using and to improve the results of training. The model incorporated the Pytorch Python library. The datasets I used were derived from cross-sections of a fieldstone sample. The cross-sections were cropped to a particular region, and 500 random slices of the cross-sections were selected for the datasets. I experimented with many different techniques to improve the training process, such as using different loss functions. In the end, I found that using residual blocks in my generator and incorporating top-k training into my model yielded close results. I used my model for both binary (black or white) and grayscale datasets. 

_Matlab Buckling Game:_

This project combined my love for both structural engineering and Matlab. The objective of the game is to earn as many coins as possible by solving buckling problems and avoiding bankruptcy. The player is given a simple cantilever beam (fixed-free) buckling scenario with one missing parameter to solve for. The other parameters are randomized each time, as well as which parameter to solve for. Initially, the compressive load is also hidden as an additional challenge, but there is an option to reveal it and solve the problem as usual. The player can enter both their answer as well as a wager between 0 and their current score before progressing. As of version 1.1, there is an endless mode with random events for some additional fun in between problems. 

_Conditional Generative Adversarial Network (cGAN) for Binary Images:_

This project expanded upon the GAN project under Professor Semnani. The cGAN model is a more complex version of the GAN counterpart, using a specified condition or set of conditions to tailor the generated images to contain desired attributes. This adds an additional classification problem in the implementation. For this project, I conditioned my model to generate images with specific porosities and classify them based on a threshold. In this case, the dataset used contained binary images (pixel values of either 0 or 1), and higher porosity means more black pixels (values of 1). For my dataset, I used over 1000 sandstone and fieldstone images from datasets provided by digitalrocksportal.org. The main challenge I faced was ensuring that the generator produced images within the correct porosity range. 

_Composite Truss:_

This project was a collaboration with my fellow peers in my Composite Structures course. A truss was made from carbon/epoxy composites. Each truss member consisted of 4 parts that were split among two subgroups for manufacturing. Each subgroup, which consisted of 2-3 teammates, was responsible for manufacturing a C-channel using a wet layup and two connector pieces that were compression-molded with chopped carbon fibers and epoxy resin. The parts were bonded with the partnering subgroup's parts to form the complete truss member, which were sized based on the orientation (horizontal, vertical, and diagonal). The members made by each group were assembled into a truss. I was in charge of managing the scheduling of my subgroup's manufacturing, as well as molding the member connectors myself. During testing, the truss failed at 240 lbf at one of its connectors due to inadequate adhesive bonding. 
	
_Super Resolution GAN (SRGAN) for Grayscale Images:_

This project is currently a work in progress. I am working with a grayscale sandstone microstructure image dataset. For a Super Resolution GAN, the goal is to train the model to produce a high-resolution set of images using both low-resolution and high-resolution. The main challenge I am facing is to get the model to properly extract features from the training set to produce realistic images.
