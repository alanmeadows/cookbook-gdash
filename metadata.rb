name             "gdash"
maintainer       "Alan Meadows"
maintainer_email "alan.meadows@gmail.com"
license          "Apache 2.0"
description      "Installs/Configures gdash"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.1"

supports "ubuntu"
depends "python"
depends "apache2"
depends "passenger_apache2"
depends "ark"
