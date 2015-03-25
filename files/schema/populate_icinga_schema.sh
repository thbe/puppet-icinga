#! /bin/sh
#
# Populate database schema for icinga and icinga_web
#

# Stop on error
set -e

# Set MySQL parameter
MYSQL_COMMAND="/usr/bin/mysql"
MYSQL_USER="root"
MYSQL_PASSWORD=${1:-0nly4install}

# Define schema
SCHEMA_IDO=$(ls -1 /usr/share/icinga2-ido-mysql/schema/mysql.sql)
SCHEMA_WEB2=$(ls -1 /usr/share/doc/icingaweb2/schema/mysql.schema.sql)

# Populate icinga ido schema and write status to sysconfig
if [ ! -f /etc/sysconfig/mysqldb_icinga ]; then
  ${MYSQL_COMMAND} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} icinga < ${SCHEMA_IDO}
  if [ ${?} -eq 0 ]; then
    echo "Icinga database schema created" > /etc/sysconfig/mysqldb_icinga
  else
    ${MYSQL_COMMAND} -u ${MYSQL_USER} icinga < ${SCHEMA_IDO}
    if [ ${?} -eq 0 ]; then
      echo "Icinga database schema created" > /etc/sysconfig/mysqldb_icinga
    else
      echo "Can not create Icinga schema"; exit 1
    fi
  fi
fi

# Populate icinga web2 schema and write status to sysconfig
if [ ! -f /etc/sysconfig/mysqldb_icingaweb2 ]; then
  ${MYSQL_COMMAND} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} icingaweb_db < ${SCHEMA_WEB2}
  if [ ${?} -eq 0 ]; then
    echo "Icinga web2 database schema created" > /etc/sysconfig/mysqldb_icingaweb2
  else
    ${MYSQL_COMMAND} -u ${MYSQL_USER} icingaweb_db < ${SCHEMA_WEB2}
    if [ ${?} -eq 0 ]; then
      echo "Icinga web2 database schema created" > /etc/sysconfig/mysqldb_icingaweb2
    else
      echo "Can not create Icinga web2 schema"; exit 1
    fi
  fi
fi
