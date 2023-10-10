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
      <xsl:variable name="returnId" select="@returns" />
      <xsl:variable name="returnType" select="key('elementById', $returnId)" />
      <xsl:choose>
        <xsl:when test="name($returnType) = 'PointerType'">
          <xsl:attribute name="returns">
            <xsl:variable name="realType" select="key('elementById', $returnType/@type)" />
            <xsl:value-of select="$realType/@name"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:attribute name="returns">
            <xsl:value-of select="$returnType/@name"/>
          </xsl:attribute>
        </xsl:otherwise>
      </xsl:choose>
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
        <xsl:variable name="argType" select="key('elementById', $typeId)" />
        <xsl:choose>
          <xsl:when test="name($argType) = 'PointerType'">
            <xsl:variable name="realType" select="key('elementById', $argType/@type)" />
            <xsl:value-of select="$realType/@name"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="argType/@name"/>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </Argument>
  </xsl:template>
</xsl:stylesheet>
