#! /bin/bash
source ./global_config.rc

uniqx() {
    awk '{ if (!h[$0]) { print $0; h[$0]=1 } }' "$*"
}

# Creates or replaces a file called pwinclude.xsl
# AND FILLS IT WITH CLEARTEXT PASSWORDS FROM YOUR i2b2 SYSTEM!!!
# Do not check in pwinclude.xsl!!!

# Usage (with getpws.xsl or a link to it, in the current directory):

# getpws
getpws() {
echo $SSHEADER >> pwinclude.xsl;
for ii in `ls $JBOSS_DEPL/*-ds.xml`;
do 
  xsltproc getpws.xsl $ii; 
done|grep xsl|uniqx|sed -e "s/xmlns:xsl.*name/name/" >> pwinclude.xsl
echo "</xsl:stylesheet>" >> pwinclude.xsl  
}


# Replaces all passwords, account-names, and connections in the xml files
# in $JBOSS_REPO_HOME with the values specified in pwinclude.xsl and 
# setparams.xsl

# Usage (with a pwinclude.xsl and setparams.xsl, or links to them, in the 
# current directory):

# satparams
setparams() {
for ii in `find $JBOSS_REPO_HOME -type f -name *.xml`;
do
  xsltproc setparams.xsl $ii > temp.xsl; 
  mv temp.xsl $ii;
done
}