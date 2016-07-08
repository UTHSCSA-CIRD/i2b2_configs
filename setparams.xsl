<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:b="http://www.jboss.org/ironjacamar/schema"
  exclude-result-prefixes="b">
  <xsl:output method="xml" indent="no"/>
  <!-- login credentials -->
  <xsl:include href='pwinclude.xsl'/>
  <xsl:variable name="hive">i2b2hive</xsl:variable>
  <xsl:variable name="imdata">i2b2imdata</xsl:variable>
  <xsl:variable name="crc">blueherondata</xsl:variable>
  <xsl:variable name="ont">blueheronmetadata</xsl:variable>
  <xsl:variable name="pm">i2b2pm</xsl:variable>
  <xsl:variable name="work">i2b2workdata</xsl:variable>
  <!-- database connectivity stuff -->
  <xsl:variable name="connection">jdbc:oracle:thin:@//localhost:1521/crcs.mi</xsl:variable>
  <xsl:variable name="driverclass">oracle.jdbc.OracleDriver</xsl:variable>
  <xsl:variable name="driverclassbean">oracle.jdbc.driver.OracleDriver</xsl:variable>
  <xsl:variable name="driver">ojdbc6.jar</xsl:variable>

<!--
This is a draft of an xslt script that will painlessly do the annoying xxx-ds.xml edits on i2b2 and shrine

actually... new usage:
xsltproc conftr.xsl FOO.xml 
-->
  
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>

  <!-- database settings -->
  
  <xsl:template match="b:connection-url">
    <xsl:copy>
      <xsl:value-of select="$connection"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="b:driver-class">
    <xsl:copy>
      <xsl:value-of select="$driverclass"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="b:driver">
    <xsl:copy>
      <xsl:value-of select="$driver"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match='bean/property[@name="driverClassName"]/@value'>
    <xsl:attribute name="value">
      <xsl:value-of select="$driverclassbean"/>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match='bean/property[@name="url"]/@value'>
    <xsl:attribute name="value">
      <xsl:value-of select="$connection"/>
    </xsl:attribute>
  </xsl:template>

  <!-- config settings for login credentials -->

  <xsl:template match='bean[@id="CRCBootstrapDS"]/property[@name="username"]/@value'>
    <xsl:attribute name="value">
      <xsl:value-of select="$hive"/>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match='bean[@id="CRCBootstrapDS"]/property[@name="password"]/@value'>
    <xsl:attribute name="value">
      <xsl:value-of select="$hivepw"/>
    </xsl:attribute>
  </xsl:template>

  <xsl:template match='bean[@id="dataSource"]/property[@name="username"]/@value'>
    <xsl:attribute name="value">
      <xsl:value-of select="$ont"/>
    </xsl:attribute>
  </xsl:template>
  <xsl:template match='bean[@id="dataSource"]/property[@name="password"]/@value'>
    <xsl:attribute name="value">
      <xsl:value-of select="$ontpw"/>
    </xsl:attribute>
  </xsl:template>
  
  <!-- deploy settings for login credentials -->

  <xsl:template match='b:datasource[@pool-name="QueryToolDemoDS"]/b:security/b:user-name'>
    <xsl:copy>
      <xsl:value-of select="$crc"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="QueryToolDemoDS"]/b:security/b:password'>
    <xsl:copy>
      <xsl:value-of select="$crcpw"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match='b:datasource[@pool-name="PMBootStrapDS"]/b:security/b:user-name'>
    <xsl:copy>
      <xsl:value-of select="$pm"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="PMBootStrapDS"]/b:security/b:password'>
    <xsl:copy>
      <xsl:value-of select="$pmpw"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match='b:datasource[@pool-name="CRCBootStrapDS"]/b:security/b:user-name'>
    <xsl:copy>
      <xsl:value-of select="$hive"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="CRCBootStrapDS"]/b:security/b:password'>
    <xsl:copy>
      <xsl:value-of select="$hivepw"/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match='b:datasource[@pool-name="IMBootStrapDS"]/b:security/b:user-name'>
    <xsl:copy>
      <xsl:value-of select="$hive"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="IMBootStrapDS"]/b:security/b:password'>
    <xsl:copy>
      <xsl:value-of select="$hivepw"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="IMDemoDS"]/b:security/b:user-name'>
    <xsl:copy>
      <xsl:value-of select="$imdata"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="IMDemoDS"]/b:security/b:password'>
    <xsl:copy>
      <xsl:value-of select="$imdatapw"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match='b:datasource[@pool-name="OntologyBootStrapDS"]/b:security/b:user-name'>
    <xsl:copy>
      <xsl:value-of select="$hive"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="OntologyBootStrapDS"]/b:security/b:password'>
    <xsl:copy>
      <xsl:value-of select="$hivepw"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="OntologyDemoDS"]/b:security/b:user-name'>
    <xsl:copy>
      <xsl:value-of select="$ont"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="OntologyDemoDS"]/b:security/b:password'>
    <xsl:copy>
      <xsl:value-of select="$ontpw"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match='b:datasource[@pool-name="WorkplaceBootStrapDS"]/b:security/b:user-name'>
    <xsl:copy>
      <xsl:value-of select="$hive"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="WorkplaceBootStrapDS"]/b:security/b:password'>
    <xsl:copy>
      <xsl:value-of select="$hivepw"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="WorkplaceDemoDS"]/b:security/b:user-name'>
    <xsl:copy>
      <xsl:value-of select="$work"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match='b:datasource[@pool-name="WorkplaceDemoDS"]/b:security/b:password'>
    <xsl:copy>
      <xsl:value-of select="$workpw"/>
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>
