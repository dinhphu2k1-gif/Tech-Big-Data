#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t dinhphu/spark:1.0 .

echo ""