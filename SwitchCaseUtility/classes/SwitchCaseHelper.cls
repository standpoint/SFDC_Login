public with sharing class SwitchCaseHelper {

    public static final Boolean PUT_BREAK = true;
    public static final Boolean PUT_CONTINUE = false;

    public class SwitchCaseException extends Exception {}

    public static final String EXCEPTION_MESSAGE = 'Switch-Case construction must have one (and only one) "switch" statement';

    @TestVisible
    private Object switchOperand;

    @TestVisible
    private Boolean isCaseAfterBreakStatement;

    @TestVisible
    private Boolean isPreviousSwitch;
    
    public SwitchCaseHelper() {

        isCaseAfterBreakStatement = false;
    }

    public SwitchCaseHelper switch(Object switchOperand) {

        if (isPreviousSwitch != null) {
            throw new SwitchCaseException(EXCEPTION_MESSAGE);
        }
        isPreviousSwitch = true;
        this.switchOperand = switchOperand;
        return this;
    }

    public SwitchCaseHelper case(Object caseOperand, ActionContainer container, Boolean hasBreak) {

        if (isPreviousSwitch == null) {
            throw new SwitchCaseException(EXCEPTION_MESSAGE);
        }

        if (isPreviousSwitch) {
            isPreviousSwitch = false;
        }

        if (isCaseAfterBreakStatement) {
            return this;
        }

        if (switchOperand.equals(caseOperand)) {
            container.doAction();
            isCaseAfterBreakStatement = hasBreak;
        }
        
        return this;
    }

    public SwitchCaseHelper default(ActionContainer container) {

        if (isPreviousSwitch == null) {
            throw new SwitchCaseException(EXCEPTION_MESSAGE);
        }

        if (!isCaseAfterBreakStatement) {
            container.doAction();
        }
        return this;
    }
}