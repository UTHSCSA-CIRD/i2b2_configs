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
# downstream from the path set by the mandatory first argument with the 
# values specified in pwinclude.xsl and setparams.xsl
# Warning: as yet this ignores non-xml files, those may need manual changes

# Usage (with a pwinclude.xsl and setparams.xsl, or links to them, in the 
# current directory):

# setparams MyFooDir
setparams() {
for ii in `find confs/$1 -type f -name *.xml`;
do
  xsltproc setparams.xsl $ii > temp.xsl; 
  mv temp.xsl $ii;
done
}

# Copies configuration files needing frequent changes down to a subdirectory
# of the directory 'confs'. The name of the subdirectory is specified by the
# mandatory first argument.

# Usage: 

# confget MyFooDir

confget() {
  if [ -z "$1" ]; then
    echo 'Give a short name under which to save the configuration files';
    exit ;
  fi;
  savedir=$1;
  mkdir -p confs/"$savedir";
  eval grep -rlZ \
    --exclude="$fexclude" \
    --exclude-dir="$dexclude" \
    '"<datasource\|username\|password\|user-name"' \
    "$CONFDIRS"/* | xargs -0 -I {} cp --parents '{}' confs/"$savedir" ;
}
