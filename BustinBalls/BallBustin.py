from telnetlib import IAC, DO, WILL, SB, SE, TTYPE, ECHO#, DONT, WONT, NAOFFD
import telnetlib
import socket
import time
import threading
import os
import matlab.engine
import cv2
import pyzed.sl as sl
from PIL import Image
import scipy.io as sio
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import matplotlib
import time
eng=matlab.engine.start_matlab()   

#GetImg(camIP="192.168.1.7",camPort=30000):

camIP="192.168.1.7"
camPort=30000

# Set the input from stream
init = sl.InitParameters()
# Specify the IP and port of the sender 
init.set_from_stream(camIP, camPort) 
#cameras resolution 1242x2208x4 RGBalpha
init.camera_resolution = sl.RESOLUTION.RESOLUTION_HD2K
#depthmode for 3D space calcs
init.depth_mode = sl.DEPTH_MODE.DEPTH_MODE_PERFORMANCE
#sets zeds units to mm
init.coordinate_units=sl.UNIT.UNIT_MILLIMETER
#cause our camera is mounted upside down
init.camera_image_flip=True

zed = sl.Camera()
#cam.find_floor_plane(sl.Plane)
zed.open(init)
#Set variables for clearer image, if false it takes user input if true uses ZEDSDK default
zed.set_camera_settings(sl.CAMERA_SETTINGS.CAMERA_SETTINGS_HUE, 0, False)
zed.set_camera_settings(sl.CAMERA_SETTINGS.CAMERA_SETTINGS_BRIGHTNESS, 3, False)
zed.set_camera_settings(sl.CAMERA_SETTINGS.CAMERA_SETTINGS_GAIN, -1, True)
zed.set_camera_settings(sl.CAMERA_SETTINGS.CAMERA_SETTINGS_WHITEBALANCE, 3000, False)
zed.set_camera_settings(sl.CAMERA_SETTINGS.CAMERA_SETTINGS_EXPOSURE, -1, True)
zed.set_camera_settings(sl.CAMERA_SETTINGS.CAMERA_SETTINGS_CONTRAST, 3, False)
zed.set_camera_settings(sl.CAMERA_SETTINGS.CAMERA_SETTINGS_SATURATION, 3, False)


runtime = sl.RuntimeParameters()
mat = sl.Mat()
err = zed.grab(runtime)
if (err == sl.ERROR_CODE.SUCCESS) :
    print('connected')
    #Gets image from left camera
    zed.retrieve_image(mat, sl.VIEW.VIEW_LEFT)
    #resizes to get rid of BS alpha parameter
    leftImgArry=mat.get_data()[:,:,0:3]
    #saves as matlab variable
    sio.savemat('imgLeft.mat', dict(leftImgArry=leftImgArry))

    #Same Shit but now for right camera
    zed.retrieve_image(mat, sl.VIEW.VIEW_RIGHT)
    rightImgArry=mat.get_data()[:,:,0:3]
    sio.savemat('imgRight.mat', dict(rightImgArry=rightImgArry))
    eng.VisionControl(nargout=0)
    

#closes stream and camera    
zed.disable_streaming()
zed.close()
   
 