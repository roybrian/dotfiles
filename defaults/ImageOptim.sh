#!/bin/sh

defaults write net.pornel.ImageOptim SUHasLaunchedBefore -bool true
defaults write net.pornel.ImageOptim LossyUsed -bool true
defaults write net.pornel.ImageOptim LossyEnabled -bool true
defaults write net.pornel.ImageOptim JpegTranStripAll -bool false
defaults write net.pornel.ImageOptim JpegOptimMaxQuality -string 80.625
