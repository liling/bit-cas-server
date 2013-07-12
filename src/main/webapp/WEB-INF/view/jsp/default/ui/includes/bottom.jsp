<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
                <hr />

                <div id="footer" class="fl-panel fl-note fl-bevel-white fl-font-size-80">
                    <a id="jasig" href="http://www.jasig.org" title="Powered by Jasig CAS <%=org.jasig.cas.CasVersion.getVersion()%>"></a>
                    <div id="copyright">
                        <p><a href="http://nsc.bit.edu.cn"><spring:message code="bit.nsc.title" text="北京理工大学网络服务中心" /></a> <spring:message code="bit.nsc.address" text="地址：信息中心三层 七号教学楼五层" /></p>
                        <p>如有疑问，请致电 68914830</p>
                    </div>
                </div>

                </div>
            </div>
        </div>
        <script type="text/javascript" src='<c:url value="/js/jquery-1.4.2.min.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/jquery-ui-1.8.5.min.js" />'></script>
        <script type="text/javascript" src='<c:url value="/js/cas.js" />'></script>
    </body>
</html>

