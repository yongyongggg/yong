import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.init as init
import torchvision.datasets as dset
import torchvision.transforms as transforms
from torch.utils.data import DataLoader
from torch.autograd import Variable

batch_size = 16
learning_rate = 0.0002
num_epoch = 10

mnist_train = dset.MNIST("./", train=True, transform=transforms.ToTensor(), target_transform=None, download=True)
mnist_test = dset.MNIST("./", train=False, transform=transforms.ToTensor(), target_transform=None, download=True)

print(mnist_train.__getitem__(0)[1], mnist_train.__len__())
mnist_test.__getitem__(0)[1], mnist_test.__len__()

train_loader = torch.utils.data.DataLoader(mnist_train,batch_size=batch_size, shuffle=True,num_workers=2,drop_last=True)
test_loader = torch.utils.data.DataLoader(mnist_test,batch_size=batch_size, shuffle=False,num_workers=2,drop_last=True)


class CNN(nn.Module):
    def __init__(self):
        super(CNN, self).__init__()
        self.layer_1 = nn.Conv2d(1, 16, 5)
        self.act_1 = nn.ReLU()

        self.layer_2 = nn.Conv2d(16, 32, 5)
        self.act_2 = nn.ReLU()
        self.max_2 = nn.MaxPool2d(2, 2)

        self.layer_3 = nn.Conv2d(32, 64, 5)
        self.act_3 = nn.ReLU()
        self.max_3 = nn.MaxPool2d(2, 2)

        self.fc_layer_1 = nn.Linear(64 * 3 * 3, 100)
        self.act_4 = nn.ReLU()
        self.fc_layer_2 = nn.Linear(100, 10)

    def forward(self, x):
        out = self.layer_1(x)
        out = self.act_1(out)
        for module in list(self.modules())[2:-3]:
            out = module(out)
        out = out.view(batch_size, -1)
        for module in list(self.modules())[-3:]:
            out = module(out)

        return out

model = CNN().cuda()

loss_func = nn.CrossEntropyLoss()
optimizer = torch.optim.SGD(model.parameters(), lr=learning_rate)

for i in range(num_epoch):
    for j, [image, label] in enumerate(train_loader):
        x = Variable(image).cuda()
        y_ = Variable(label).cuda()

        optimizer.zero_grad()
        output = model.forward(x)
        loss = loss_func(output, y_)
        loss.backward()
        optimizer.step()

        if j % 1000 == 0:
            print(loss)

correct = 0
total = 0

for image, label in test_loader:
    x = Variable(image, volatile=True).cuda()
    y_ = Variable(label).cuda()

    output = model.forward(x)
    _, output_index = torch.max(output, 1)

    total += label.size(0)
    correct += (output_index == y_).sum().float()

print("Accuracy of Test Data: {}".format(100 * correct / total))