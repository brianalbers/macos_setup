#!/bin/zsh

# Install CAC software
echo "Installing CACKey Software"
curl https://militarycac.com/files/CACKey/CACKey_0.7.8_Slandup.pkg.tar.gz | tar xz
sudo installer -pkg  CACKey_0.7.8_Slandup.pkg -target /Volumes/Macintosh\ HD
rm -rf CACKey_0.7.8_Slandup.pkg
rm -f CACKey_0.7.8_Slandup.pkg.tar.gz
echo "Done Installing CACKey"

# Install DOD CAs
echo "Installing DoD CAs"
curl -O https://militarycac.com/maccerts/AllCerts.zip
unzip -q AllCerts.zip -d DoD_CAs
export code='
  echo -n "Adding DoD CAs to Keychain"
  for i in DoD_CAs/*Root*
  do
    echo -n "."
    security add-trusted-cert -d -e hostnameMismatch -r trustRoot -k /Library/Keychains/System.keychain "$i"
  done
  for i in DoD_CAs/*DOD*
  do
    echo -n "."
    security add-trusted-cert -d -e hostnameMismatch -r unspecified -k /Library/Keychains/System.keychain "$i"
  done
'
sudo bash -c "$code"
printf "\nDone Installing DoD CAs\n"

# Install Citrix Receiver
echo "Installing Citrix Receiver"
brew cask install citrix-workspace
defaults write com.citrix.receiver.nomas PKCS11ModulePath -string /Library/CACKey/libcackey.dylib
defaults write com.citrix.receiver.nomas PKCS11ModuleEnabled YES
echo "Done Installing Citrix Receiver"

# Cleanup artifacts
echo "Removing Artifacts"
rm -f AllCerts.zip
rm -rf DoD_CAs
echo "Done Removing Artifacts"
