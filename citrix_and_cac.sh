#!/bin/bash

# Install CAC software
curl -O https://militarycac.com/files/CACKey/CACKey_0.7.8_Slandup.pkg.tar.gz | tar -xzf
sudo installer -pkg  CACKey_0.7.8_Slandup.pkg -target /Volumes/Macintosh\ HD
rm -f CACKey_0.7.8_Slandup.pkg

# Install DOD CAs
curl -O https://militarycac.com/maccerts/AllCerts.zip

unzip AllCerts.zip -d DoD_CAs

for i in DoD_CAs/*Root*
do
  echo $i
  security add-trusted-cert -d -e hostnameMismatch -r trustRoot -k /Library/Keychains/System.keychain "$i"
done
for i in DoD_CAs/*DOD*
do
  echo $i
  security add-trusted-cert -d -e hostnameMismatch -r unspecified -k /Library/Keychains/System.keychain "$i"
done

# Install Citrix Receiver
brew cask install citrix-receiver
defaults write com.citrix.receiver.nomas PKCS11ModulePath -string /Library/CACKey/libcackey.dylib
defaults write com.citrix.receiver.nomas PKCS11ModuleEnabled YES

rm -f AllCerts.zip
rm -rf DoD_CAs
