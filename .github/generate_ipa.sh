#!/bin/bash

mkdir -p ../deup-master/deup-master/build/ios/iphoneos/Payload
mv ../deup-master/deup-master/build/ios/iphoneos/Runner.app ../deup-master/deup-master/build/ios/iphoneos/Payload
cd ../deup-master/deup-master/build/ios/iphoneos/
zip -r app-ios.ipa Payload
