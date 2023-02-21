import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.init as init
import torch.utils.data as data
import torchvision.datasets as dset
import torchvision.transforms as transforms
from torch.utils.data import DataLoader
from torch.autograd import Variable

batch_size= 1
learning_rate = 0.0002
epoch = 100

img_dir = "./images"
img_data = dset.ImageFolder(img_dir, transforms.Compose([
            transforms.Resize(256),
            transforms.RandomResizedCrop(224),
            transforms.RandomHorizontalFlip(),
            transforms.ToTensor(),
            ]))


img_batch = data.DataLoader(img_data, batch_size=batch_size,
                            shuffle=True, num_workers=2)

def conv_2_block(in_dim,out_dim):
    model = nn.Sequential(
        nn.Conv2d(in_dim,out_dim,kernel_size=3,padding=1),
        nn.ReLU(),
        nn.Conv2d(out_dim,out_dim,kernel_size=3,padding=1),
        nn.ReLU(),
        nn.MaxPool2d(2,2)
    )
    return model

def conv_3_block(in_dim,out_dim):
    model = nn.Sequential(
        nn.Conv2d(in_dim,out_dim,kernel_size=3,padding=1),
        nn.ReLU(),
        nn.Conv2d(out_dim,out_dim,kernel_size=3,padding=1),
        nn.ReLU(),
        nn.Conv2d(out_dim,out_dim,kernel_size=3,padding=1),
        nn.ReLU(),
        nn.MaxPool2d(2,2)
    )
    return model


class VGG(nn.Module):

    def __init__(self, base_dim, num_classes=2):
        super(VGG, self).__init__()
        self.feature = nn.Sequential(
            conv_2_block(3, base_dim),
            conv_2_block(base_dim, 2 * base_dim),
            conv_3_block(2 * base_dim, 4 * base_dim),
            conv_3_block(4 * base_dim, 8 * base_dim),
            conv_3_block(8 * base_dim, 8 * base_dim),
        )
        self.fc_layer = nn.Sequential(
            nn.Linear(8 * base_dim * 7 * 7, 100),
            nn.ReLU(),
            nn.Dropout(),
            nn.Linear(100, 20),
            nn.ReLU(),
            nn.Dropout(),
            nn.Linear(20, num_classes),
        )

    def forward(self, x):
        x = self.feature(x)
        x = x.view(x.size(0), -1)
        x = self.fc_layer(x)
        return x


model = VGG(base_dim=64).cuda()

for i in model.named_children():
    print(i)

loss_func = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(),lr=learning_rate)

for i in range(epoch):
    for img,label in img_batch:
        img = Variable(img).cuda()
        label = Variable(label).cuda()

        optimizer.zero_grad()
        output = model(img)
        loss = loss_func(output,label)
        loss.backward()
        optimizer.step()

    if i % 10 ==0:
        print(loss)
