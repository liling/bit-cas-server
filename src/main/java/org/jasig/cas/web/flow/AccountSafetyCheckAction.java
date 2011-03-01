package org.jasig.cas.web.flow;

import org.springframework.webflow.action.AbstractAction;
import org.springframework.webflow.execution.Event;
import org.springframework.webflow.execution.RequestContext;

public class AccountSafetyCheckAction extends AbstractAction {

    protected Event doExecute(RequestContext context) throws Exception {
        return result("unsafe");
    }

}