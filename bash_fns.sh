#! /bin/bash
source ./global_config.rc

uniqx() {
    awk '{ if (!h[$0]) { print $0; h[$0]=1 } }' "$*"
}

# Creates or replaces a file called pwinclude.xsl, which contains
# CLEARTEXT PASSWORDS FROM YOUR i2b2 SYSTEM
# Do not check in pwinclude.xsl!!!
getpws() {
echo $SSHEADER > backup_pwinclude.xsl;
for ii in `ls $JBOSS_DEPL/*-ds.xml`;
do 
  xsltproc getpws.xsl $ii; 
done|grep xsl|uniqx|sed -e "s/xmlns:xsl.*name/name/" >> pwinclude.xsl
echo "</xsl:stylesheet>" >> pwinclude.xsl  
}