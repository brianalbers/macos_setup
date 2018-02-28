# Install or update Home-brew
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew doctor
else
    brew update
fi

# Install pyenv to manage python versions
brew install pyenv
pyenv install 2.7.10
pyenv local 2.7.10
# also see 'if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi' in .zshenv

# Install QGIS
brew install gdal
pip install matplotlib
brew install postgresql # dependency needed by psycopg2
pip install psycopg2
pip install pyparsing
pip install future
pip install owslib
pip install requests
pip install jinja2
brew install json-c
brew tap osgeo/osgeo4mac
brew install qgis2 --without-grass
brew linkapps qgis2
