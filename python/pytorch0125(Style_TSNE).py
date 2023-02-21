import pandas as pd
import torch
import torch.nn as nn
import torch.optim as optim
import torch.utils as utils
import torch.utils.data as data
import torchvision.models as models
import torchvision.utils as v_utils
import torchvision.datasets as dset
import torchvision.transforms as transforms
from torch.autograd import Variable

from sklearn.manifold import TSNE
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.offsetbox import OffsetImage, AnnotationBbox
from matplotlib.cbook import get_sample_data
from PIL import ImageFile
ImageFile.LOAD_TRUNCATED_IMAGES = True

image_size = 256

style_dir = "./image/"
data = dset.ImageFolder(style_dir,transform= transforms.Compose([
        transforms.Resize(image_size),
        transforms.CenterCrop(image_size),
        transforms.ToTensor(),
        ]))

print(data.class_to_idx)
img_list = []
for i in data.imgs:
    img_list.append(i[0])

resnet = models.resnet50(pretrained=True)

class Resnet(nn.Module):
    def __init__(self):
        super(Resnet,self).__init__()
        self.layer0 = nn.Sequential(*list(resnet.children())[0:1])
        self.layer1 = nn.Sequential(*list(resnet.children())[1:4])
        self.layer2 = nn.Sequential(*list(resnet.children())[4:5])
        self.layer3 = nn.Sequential(*list(resnet.children())[5:6])
        #self.layer4 = nn.Sequential(*list(resnet.children())[6:7])
        #self.layer5 = nn.Sequential(*list(resnet.children())[7:8])

    def forward(self,x):
        out_0 = self.layer0(x)
        out_1 = self.layer1(out_0)
        out_2 = self.layer2(out_1)
        out_3 = self.layer3(out_2)
        #out_4 = self.layer4(out_3)
        #out_5 = self.layer5(out_4)

        return out_0, out_1, out_2, out_3, # out_4, out_5


class GramMatrix(nn.Module):
    def forward(self, input):
        b,c,h,w = input.size()
        F = input.view(b, c, h*w)
        G = torch.bmm(F, F.transpose(1,2))
        return G

class GramMSELoss(nn.Module):
    def forward(self, input, target):
        out = nn.MSELoss()(GramMatrix()(input), target)
        return out

device = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
print(device)
resnet = Resnet().to(device)
for param in resnet.parameters():
    param.requires_grad = False
resnet = Resnet().cuda()
for param in resnet.parameters():
    param.requires_grad = False

style_weight = [1/n**2 for n in [64,64,256,512]] # 512,1024,2048

total_arr = []
label_arr = []
for idx,(image,label) in enumerate(data):
    i = Variable(image).to(device)
    i = i.view(-1,i.size()[0],i.size()[1],i.size()[2])

    style_target = list(GramMatrix().to(device)(i) for i in resnet(i))
    arr = torch.cat([style_target[0].view(-1),style_target[1].view(-1),style_target[2].view(-1),style_target[3].view(-1)],0)
    gram = arr.cpu().data.numpy().reshape(1,-1)
    total_arr.append(gram.reshape(-1))
    label_arr.append(label)


print(label_arr)

import pandas as pd
total_arr = pd.DataFrame(total_arr)

print("\n------Starting TSNE------\n")
model = TSNE(n_components=2, init='pca',random_state=0)
result = model.fit_transform(total_arr)
print("\n------TSNE Done------\n")

def imscatter(x, y, image, ax=None, zoom=1):
    if ax is None:
        ax = plt.gca()
    try:
        image = plt.imread(image)
    except TypeError:
        # Likely already an array...
        pass
    im = OffsetImage(image, zoom=zoom)
    x, y = np.atleast_1d(x, y)
    artists = []
    for x0, y0 in zip(x, y):
        ab = AnnotationBbox(im, (x0, y0), xycoords='data', frameon=False)
        artists.append(ax.add_artist(ab))
    ax.update_datalim(np.column_stack([x, y]))
    ax.autoscale()
    return artists

for i in range(len(result)):
    print("{}/{}".format(i,len(result)))
    img_path = img_list[i]
    imscatter(result[i,0],result[i,1], image=img_path,zoom=0.2)

plt.show()