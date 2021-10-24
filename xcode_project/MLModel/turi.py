#!/usr/bin/env python

import sys
import os

import turicreate as tc


folder = sys.argv[1]
folder_abs = os.path.abspath(folder)

images = tc.load_images(folder)
images['label'] = images['path'].element_slice(len(folder_abs)+1, -4)
print(images)

model = tc.one_shot_object_detector.create(images, 'label')
model.export_coreml('model.mlmodel')
