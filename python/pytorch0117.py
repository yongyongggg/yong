import numpy as np
import torch
import torch.nn as nn
import torch.optim as optim
import torch.nn.init as init
from torch.autograd import Variable

from visdom import Visdom
viz = Visdom()

num_data = 1000
num_epoch = 1000
#정규분포에서 가져온다
noise = init.normal(torch.FloatTensor(num_data,1),std=1)
#균일분포에서 가져온다
x = init.uniform(torch.Tensor(num_data,1),-10,10)

y = 2*x+3
y_noise = 2*x+3+noise

input_data = torch.cat([x,y_noise],1)
win=viz.scatter(
    X = input_data,
    opts=dict(
        xtickmin=-10,
        xtickmax=10,
        xtickstep=1,
        ytickmin=-20,
        ytickmax=20,
        ytickstep=1,
        markersymbol='dot',
        markersize=2,
        markercolor=np.random.randint(0, 255, num_data),
    ),
)

viz.line(
    X = x,
    Y = y,
    win=win,update='append'
)

model = nn.Linear(1,1)
output = model(Variable(x))
loss_func = nn.MSELoss()
optimizer = optim.SGD(model.parameters(),lr=0.01)

loss_arr = []
label = Variable(y_noise)
for i in range(num_epoch):
    optimizer.zero_grad()
    output = model(Variable(x))

    loss = loss_func(output, label)
    loss.backward()
    optimizer.step()

    if i % 10 == 0:
        print(loss)

    loss_arr.append(loss.data.numpy())

param_list = list(model.parameters())
print(param_list[0].data,param_list[1].data)

win_2=viz.scatter(
    X = input_data,
    opts=dict(
        xtickmin=-10,
        xtickmax=10,
        xtickstep=1,
        ytickmin=-20,
        ytickmax=20,
        ytickstep=1,
        markersymbol='dot',
        markercolor=np.random.randint(0, 255, num_data),
        markersize=5,
    ),
)

viz.scatter(
    X = x,
    Y = output.data,
    win = win_2,
    opts=dict(
        xtickmin=-15,
        xtickmax=10,
        xtickstep=1,
        ytickmin=-300,
        ytickmax=200,
        ytickstep=1,
        markersymbol='dot',
    ), update='append'
)

