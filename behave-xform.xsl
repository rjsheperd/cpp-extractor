<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:key name="elementById" match="*[not(self::Argument)]" use="@id" />

   <xsl:template match="/GCC_XML">
      <xsl:apply-templates select="File[starts-with(@name, 'behave')]"/>
   </xsl:template>

   <xsl:template match="File">
      <xsl:variable name="currentFile" select="@id"/>
      <xsl:apply-templates select="//Class[@file=$currentFile]"/>
   </xsl:template>

  <xsl:template match="Class">
    <xsl:variable name="classId" select="@id" />
    <Class>
      <xsl:copy-of select="@name" />
      <xsl:apply-templates select="//Method[@context=$classId]" />
    </Class>
  </xsl:template>

  <xsl:template match="Method">
    <Method>
      <xsl:attribute name="name">
        <xsl:value-of select="@name" />
      </xsl:attribute>
      <xsl:attribute name="returns">
        <xsl:variable name="returnId" select="@returns" />
        <xsl:value-of select="key('elementById', $returnId)/@name" />
      </xsl:attribute>
      <xsl:apply-templates select="Argument" />
    </Method>
  </xsl:template>

  <xsl:template match="Argument">
    <Argument>
      <xsl:attribute name="name">
        <xsl:value-of select="@name" />
      </xsl:attribute>
      <xsl:attribute name="type">
        <xsl:variable name="typeId" select="@type" />
        <xsl:value-of select="key('elementById', $typeId)/@name" />
      </xsl:attribute>
    </Argument>
  </xsl:template>
</xsl:stylesheet>
