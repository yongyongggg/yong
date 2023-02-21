import torch
import torch.utils.data as data
import torchvision.datasets as dset
import torchvision.transforms as transforms

batch_size = 2

img_dir = "./images"
img_data = dset.ImageFolder(img_dir, transforms.Compose([
            transforms.Resize(256),
            transforms.RandomResizedCrop(224),
            transforms.RandomHorizontalFlip(),
            transforms.ToTensor(),
            ]))

img_batch = data.DataLoader(img_data, batch_size=batch_size,
                            shuffle=True,drop_last=True)

for image,label in img_batch:
    print(image.size(),label)