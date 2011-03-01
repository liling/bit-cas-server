package org.jasig.cas.web.flow;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.jasig.cas.authentication.principal.Credentials;
import org.jasig.cas.authentication.principal.CredentialsToPrincipalResolver;
import org.jasig.cas.authentication.principal.Principal;
import org.jasig.cas.ticket.TicketGrantingTicket;
import org.jasig.cas.ticket.registry.TicketRegistry;
import org.jasig.cas.web.support.WebUtils;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.simple.SimpleJdbcTemplate;
import org.springframework.webflow.action.AbstractAction;
import org.springframework.webflow.execution.Event;
import org.springframework.webflow.execution.RequestContext;

/**
 * 检查用户是否设定了密保邮箱和密保手机，若没有，则返回 unsafe，否则返回 safe
 */
public class AccountSafetyCheckAction extends AbstractAction {
	
	private SimpleJdbcTemplate jdbcTemplate;
	private DataSource dataSource;
	private TicketRegistry ticketRegistry;
	
	protected Principal getPrincipal(RequestContext context) {
        // 从TGT中获取用户名
		String tgtid = WebUtils.getTicketGrantingTicketId(context);
		TicketGrantingTicket tgt = (TicketGrantingTicket) ticketRegistry.getTicket(tgtid);
		return tgt.getAuthentication().getPrincipal();
	}
	
	protected Event doExecute(RequestContext context) 
	throws Exception {
		if (jdbcTemplate == null) 
			jdbcTemplate = new SimpleJdbcTemplate(dataSource);
		String rst = "safe";
		
		Principal principal = this.getPrincipal(context);
		//System.out.println("===========================Username is " + principal.getId());
		try {
			Map<String,Object> row = jdbcTemplate.queryForMap(
				"SELECT * FROM pf_users WHERE username=?", principal.getId());
            context.getFlowScope().put("hasSafeMail", new Boolean(
                    row.get("mail") != null && 
                    ((String) row.get("mail")).length() > 0));
            context.getFlowScope().put("hasSafeMobile", new Boolean(
                    row.get("mobile") != null && 
                    ((String) row.get("mobile")).length() > 0));
            if (!context.getFlowScope().getBoolean("hasSafeMail") ||
                !context.getFlowScope().getBoolean("hasSafeMobile"))
            {
                rst = "unsafe";
            }
		} catch (EmptyResultDataAccessException e) {
            // 如果未找到记录，则意味着用户肯定没有设置过手机或邮箱
			rst = "unsafe";
		}
		return result(rst);
	}

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void setJdbcTemplate(SimpleJdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public void setTicketRegistry(TicketRegistry ticketRegistry) {
		this.ticketRegistry = ticketRegistry;
	}
	
}
