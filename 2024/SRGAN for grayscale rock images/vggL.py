# VGG19 pre-trained model implementation for SRGAN

import torch
import torch.nn as nn
from torchvision.models import vgg19

class vggL(nn.Module):
    def __init__(self):
        super().__init__()
        self.vgg = vgg19(weights='DEFAULT').features[:25].eval().to(device) # Default parameters
        self.loss = nn.MSELoss()

    def forward(self, input, target):
        vgg_input = self.vgg(input) # Super res
        vgg_target = self.vgg(target) # High-res
        perceptual_loss = self.loss(vgg_input, vgg_target)
        return perceptual_loss
