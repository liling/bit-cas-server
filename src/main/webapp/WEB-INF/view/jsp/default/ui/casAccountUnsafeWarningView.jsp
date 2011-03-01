<%@ page pageEncoding="UTF-8" %>
<jsp:directive.include file="includes/top.jsp" />
<div class="info"><p class="account-unsafe-warning"><spring:message code="account.unsafe.message" /></p></div>
<div class="account-unsafe-buttons">
    <c:if test="${!hasSafeMail}">
        <a class="set_cookie largebutton" href="http://localhost/profile/mail_activates/setmail" rel="external"><span><spring:message code="setup.safe.email.message" /></span></a>
    </c:if>
    <c:if test="${!hasSafeMobile}">
        <a class="set_cookie largebutton" href="http://localhost/profile/mobile_activates/setmobile" rel="external"><span><spring:message code="setup.safe.mobile.message" /></span></a>
    </c:if>
</div>
<p class="account-unsafe-skip-message"><spring:message code="account.unsafe.skip.message" arguments="${fn:escapeXml(param.service)}${fn:indexOf(param.service, '?') eq -1 ? '?' : '&'}ticket=${serviceTicketId}, 20" /></p>
<script language="JavaScript">
$(document).ready(function() {
    $('a[rel="external"]').click(function() { this.target = "_blank"; });
    if ($.cookie('SKIPWARN')) {
        window.location = $('.account-unsafe-skip-message a').attr('href');
    } else {
        $('a.set_cookie').click(function() {
            $.cookie('SKIPWARN', true);
        });
    }
});
function count_down() {
    $('#countdown').text(parseInt($('#countdown').text()) - 1);
    if (parseInt($('#countdown').text()) == 0) {
        window.location = $('.account-unsafe-skip-message a').attr('href');
    }
}
setInterval(count_down, 1000);
</script>
<jsp:directive.include file="includes/bottom.jsp" />
