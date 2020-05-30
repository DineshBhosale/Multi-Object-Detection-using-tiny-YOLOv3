# Multi-Object-Detection-using-tiny-YOLOv3
The tiny YOLOv3 model was trained and tested on Berkeley Deepdrive dataset.



Download BDD Dataset from - https://bdd-data.berkeley.edu/



To install all dependencies, run
```bash
pip install -r requirements.txt
```
Convert the annotations of the BDD dataset from json to xml format.


Specify the location of the json file and the directory where the images are stored.


```bash
python convert.py
```
Make sure the images are sorted accordingly.

+ train_image_folder <= the folder that contains the train images.

+ train_annot_folder <= the folder that contains the train annotations in VOC format.

+ valid_image_folder <= the folder that contains the validation images.

+ valid_annot_folder <= the folder that contains the validation annotations in VOC format.

```python
{
    "model" : {
        "min_input_size":       416,
        "max_input_size":       416,
        "anchors":              [6,10,  14,24,  29,42,  54,72,  88,125,  138,212],
        "labels":               ["car","person","traffic light","traffic sign"]
    },

    "train": {
        "train_image_folder":   "/home/dbhosal/FinalProject/Images/train/",
        "train_annot_folder":   "/home/dbhosal/FinalProject/Labels/xml/train/",      
        "cache_name": "car_train.pkl",
         
        "train_times":          1,             # the number of time to cycle through the training set, useful for small datasets
        "pretrained_weights":   "",             # specify the path of the pretrained weights, but it's fine to start from scratch
        "batch_size":           16,             # the number of images to read in each batch
        "learning_rate":        1e-4,           # the base learning rate of the default Adam rate scheduler
        "nb_epoch":             26,             # number of epoches
        "warmup_epochs":        4,              # the number of initial epochs during which the sizes of the 5 boxes in each cell is forced to match the sizes of the 5 anchors, this trick seems to improve precision emperically
        "ignore_thresh":        0.7,
        "gpus":                 "1",
        
        "grid_scales": [ 1, 0.1 ],              # if error for scale is large, can be reduced to ignore the predictions from that scale 
        "obj_scale": 5,                         # scales while computing loss
        "noobj_scale": 1,                       # scales while computing loss
        "xywh_scale": 1,                        # scales while computing loss
        "class_scale": 1,                       # scales while computing loss

        "tensorboard_dir": "logs",
        "saved_weights_name":   "car_person_sign.h5",
        "debug":                false            # turn on/off the line that prints current confidence, position, size, class losses and recall
    },

    "valid": {
        "valid_image_folder":   "/home/dbhosal/FinalProject/Images/val/",
        "valid_annot_folder":   "/home/dbhosal/FinalProject/Labels/xml/val/",
        "cache_name":           "car_val.pkl",
        "valid_times":          1
    }
}
```
To generate anchors for dataset


`python gen_anchors.py -c config.json`.

Copy the generated anchors printed on the terminal to the ```anchors``` setting in ```config.json```.

To train your model

`python train.py -c config.json`

The code will save the weights to a h5 file.

To perform prediction

`python predict.py -c config.json -i /path/to/image/or/video`

The predicted image will be saved to the output folder.



The base of the project was referred from experiencor. 

Github Link - https://github.com/experiencor/keras-yolo3
