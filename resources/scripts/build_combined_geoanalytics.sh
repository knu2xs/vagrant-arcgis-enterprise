#!/bin/bash -x

./setup_prerequisites.sh
./portal_install.sh
./server_install.sh
./data_store_install.sh
./data_store_config_relational.sh
./tomcat_install.sh
./web_adaptor_install.sh
./server_config_web_adaptor.sh
./portal_config_web_adaptor.sh