<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:b="http://www.jboss.org/ironjacamar/schema"
  exclude-result-prefixes="b">

<!--
This one is supposed to scan through all the *-ds.xml files as an xsl
document for inclusion in the main one that sets passwords and other 
variables elswehere

Usage:
echo "<xsl:stylesheet xmlns:xsl=\"http://www.w3.org/1999/XSL/Transform\" version=\"1.0\">" > pwinclude.xsl && for ii in `ls opt/jboss-as-7.1.1.Final/standalone/deployments/*-ds.xml`; do xsltproc contxedit.xsl $ii; done|grep xsl|uniq|sed -e "s/xmlns:xsl.*name/name/" >> pwinclude.xsl && echo "</xsl:stylesheet>" >> pwinclude.xsl
-->

<xsl:template match="node()|@*">
  <xsl:apply-templates select="node()|@*"/>
</xsl:template>

<xsl:template 
match="b:datasources/b:datasource[@pool-name='IMBootStrapDS']/b:security">
<xsl:element name="xsl:variable">
  <xsl:attribute name='name'>hivepw</xsl:attribute>
<xsl:value-of select="./b:password"/>
</xsl:element><xsl:text>
</xsl:text>
</xsl:template>

<xsl:template 
match="b:datasources/b:datasource[@pool-name='IMDemoDS']/b:security">
<xsl:element name="xsl:variable">
  <xsl:attribute name='name'>imdatapw</xsl:attribute>
<xsl:value-of select="./b:password"/>
</xsl:element>
</xsl:template>

<xsl:template 
match="b:datasources/b:datasource[@pool-name='OntologyDemoDS']/b:security">
<xsl:element name="xsl:variable">
  <xsl:attribute name='name'>ontpw</xsl:attribute>
<xsl:value-of select="./b:password"/>
</xsl:element>
</xsl:template>

<xsl:template 
match="b:datasources/b:datasource[@pool-name='PMBootStrapDS']/b:security">
<xsl:element name="xsl:variable">
  <xsl:attribute name='name'>pmpw</xsl:attribute>
<xsl:value-of select="./b:password"/>
</xsl:element>
</xsl:template>

<xsl:template 
match="b:datasources/b:datasource[@pool-name='QueryToolDemoDS']/b:security">
<xsl:text>
</xsl:text>
<xsl:element name="xsl:variable">
  <xsl:attribute name='name'>crcpw</xsl:attribute>
<xsl:value-of select="./b:password"/>
</xsl:element>
</xsl:template>

<xsl:template 
match="b:datasources/b:datasource[@pool-name='WorkplaceDemoDS']/b:security">
<xsl:element name="xsl:variable">
  <xsl:attribute name='name'>workpw</xsl:attribute>
<xsl:value-of select="./b:password"/>
</xsl:element>
</xsl:template>
</xsl:stylesheet>
