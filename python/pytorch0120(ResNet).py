
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

def conv_block_1(in_dim,out_dim,act_fn):
    model = nn.Sequential(
        nn.Conv2d(in_dim,out_dim, kernel_size=1, stride=1),
        act_fn,
    )
    return model

def conv_block_1_stride_2(in_dim,out_dim,act_fn):
    model = nn.Sequential(
        nn.Conv2d(in_dim,out_dim, kernel_size=1, stride=2),
        act_fn,
    )
    return model

def conv_block_1_n(in_dim,out_dim):
    model = nn.Sequential(
        nn.Conv2d(in_dim,out_dim, kernel_size=1, stride=1),
    )
    return model

def conv_block_1_stride_2_n(in_dim,out_dim):
    model = nn.Sequential(
        nn.Conv2d(in_dim,out_dim, kernel_size=1, stride=2),
    )
    return model

def conv_block_3(in_dim,out_dim,act_fn):
    model = nn.Sequential(
        nn.Conv2d(in_dim,out_dim, kernel_size=3, stride=1, padding=1),
        act_fn,
    )
    return model


class BottleNeck(nn.Module):

    def __init__(self, in_dim, mid_dim, out_dim, act_fn):
        super(BottleNeck, self).__init__()
        self.layer = nn.Sequential(
            conv_block_1(in_dim, mid_dim, act_fn),
            conv_block_3(mid_dim, mid_dim, act_fn),
            conv_block_1_n(mid_dim, out_dim),
        )
        self.downsample = nn.Conv2d(in_dim, out_dim, 1, 1)

    def forward(self, x):
        downsample = self.downsample(x)
        out = self.layer(x)
        out = out + downsample

        return out


class BottleNeck_no_down(nn.Module):

    def __init__(self, in_dim, mid_dim, out_dim, act_fn):
        super(BottleNeck_no_down, self).__init__()
        self.layer = nn.Sequential(
            conv_block_1(in_dim, mid_dim, act_fn),
            conv_block_3(mid_dim, mid_dim, act_fn),
            conv_block_1_n(mid_dim, out_dim),
        )

    def forward(self, x):
        out = self.layer(x)
        out = out + x

        return out


class BottleNeck_stride(nn.Module):

    def __init__(self, in_dim, mid_dim, out_dim, act_fn):
        super(BottleNeck_stride, self).__init__()
        self.layer = nn.Sequential(
            conv_block_1_stride_2(in_dim, mid_dim, act_fn),
            conv_block_3(mid_dim, mid_dim, act_fn),
            conv_block_1_n(mid_dim, out_dim),
        )
        self.downsample = nn.Conv2d(in_dim, out_dim, 1, 2)

    def forward(self, x):
        downsample = self.downsample(x)
        out = self.layer(x)
        out = out + downsample

        return out


class ResNet(nn.Module):

    def __init__(self, base_dim, num_classes=2):
        super(ResNet, self).__init__()
        self.act_fn = nn.ReLU()
        self.layer_1 = nn.Sequential(
            nn.Conv2d(3, base_dim, 7, 2, 3),
            nn.ReLU(),
            nn.MaxPool2d(3, 2, 1),
        )
        self.layer_2 = nn.Sequential(
            BottleNeck(base_dim, base_dim, base_dim * 4, self.act_fn),
            BottleNeck_no_down(base_dim * 4, base_dim, base_dim * 4, self.act_fn),
            BottleNeck_stride(base_dim * 4, base_dim, base_dim * 4, self.act_fn),
        )
        self.layer_3 = nn.Sequential(
            BottleNeck(base_dim * 4, base_dim * 2, base_dim * 8, self.act_fn),
            BottleNeck_no_down(base_dim * 8, base_dim * 2, base_dim * 8, self.act_fn),
            BottleNeck_no_down(base_dim * 8, base_dim * 2, base_dim * 8, self.act_fn),
            BottleNeck_stride(base_dim * 8, base_dim * 2, base_dim * 8, self.act_fn),
        )
        self.layer_4 = nn.Sequential(
            BottleNeck(base_dim * 8, base_dim * 4, base_dim * 16, self.act_fn),
            BottleNeck_no_down(base_dim * 16, base_dim * 4, base_dim * 16, self.act_fn),
            BottleNeck_no_down(base_dim * 16, base_dim * 4, base_dim * 16, self.act_fn),
            BottleNeck_no_down(base_dim * 16, base_dim * 4, base_dim * 16, self.act_fn),
            BottleNeck_no_down(base_dim * 16, base_dim * 4, base_dim * 16, self.act_fn),
            BottleNeck_stride(base_dim * 16, base_dim * 4, base_dim * 16, self.act_fn),
        )
        self.layer_5 = nn.Sequential(
            BottleNeck(base_dim * 16, base_dim * 8, base_dim * 32, nn.ReLU()),
            BottleNeck_no_down(base_dim * 32, base_dim * 8, base_dim * 32, self.act_fn),
            BottleNeck(base_dim * 32, base_dim * 8, base_dim * 32, self.act_fn),
        )
        self.avgpool = nn.AvgPool2d(7, 1)
        self.fc_layer = nn.Linear(base_dim * 32, num_classes)

    def forward(self, x):
        out = self.layer_1(x)
        out = self.layer_2(out)
        out = self.layer_3(out)
        out = self.layer_4(out)
        out = self.layer_5(out)
        out = self.avgpool(out)
        out = out.view(batch_size, -1)
        out = self.fc_layer(out)

        return out


model = ResNet(base_dim=64).cuda()

for i in model.children():
    print(i)

loss_func = nn.CrossEntropyLoss()
optimizer = optim.Adam(model.parameters(), lr=learning_rate)

for i in range(epoch):
    for img, label in img_batch:
        img = Variable(img).cuda()
        label = Variable(label).cuda()

        optimizer.zero_grad()
        output = model(img)

        loss = loss_func(output, label)
        loss.backward()
        optimizer.step()

    if i % 10 == 0:
        print(loss)
        print(output.size())