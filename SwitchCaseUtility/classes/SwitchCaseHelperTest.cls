@isTest
private class SwitchCaseHelperTest {
	

	@isTest
    private static void switchTest() {
		
        String switchOperand = 'Switch Operand';
        SwitchCaseHelper sch = new SwitchCaseHelper();
        SwitchCaseHelper res = sch.switch(switchOperand);

        System.assert(res.isPreviousSwitch);
        System.assertEquals(switchOperand, res.switchOperand);
	}


    @isTest
    private static void switchExceptionTest() {
        
        String switchOperand = 'Switch Operand';
        SwitchCaseHelper sch = new SwitchCaseHelper();
        SwitchCaseHelper sch2 = sch.switch(switchOperand);

        try {
            
            sch2.switch(switchOperand);
        
        } catch(SwitchCaseHelper.SwitchCaseException e) {
            
            System.assertEquals(SwitchCaseHelper.EXCEPTION_MESSAGE, e.getMessage());
        }
    }
	

    @isTest
    private static void caseWithBreakTest() {
        
        String switchOperand = 'Switch Operand';
        SwitchCaseHelper sch = new SwitchCaseHelper();
        SwitchCaseHelper res = sch.switch(switchOperand).case(switchOperand, new ActionContainerMock(), SwitchCaseHelper.PUT_BREAK);

        System.assert(!res.isPreviousSwitch);
        System.assert(res.isCaseAfterBreakStatement);
    }


    @isTest
    private static void caseAfterBreakTest() {
        
        String switchOperand = 'Switch Operand';
        SwitchCaseHelper sch = new SwitchCaseHelper();
        SwitchCaseHelper res = sch
            .switch(switchOperand)
            .case(switchOperand, new ActionContainerMock(), SwitchCaseHelper.PUT_BREAK)
            .case(switchOperand, new ActionContainerMock(), SwitchCaseHelper.PUT_CONTINUE);

        System.assert(!res.isPreviousSwitch);
        System.assert(res.isCaseAfterBreakStatement);
    }


    @isTest
    private static void caseWithoutBreakTest() {
        
        String switchOperand = 'Switch Operand';
        SwitchCaseHelper sch = new SwitchCaseHelper();
        SwitchCaseHelper res = sch.switch(switchOperand).case(switchOperand, new ActionContainerMock(), SwitchCaseHelper.PUT_CONTINUE);

        System.assert(!res.isPreviousSwitch);
        System.assert(!res.isCaseAfterBreakStatement);
    }


    @isTest
    private static void caseExceptionTest() {
        
        String switchOperand = 'Switch Operand';
        SwitchCaseHelper sch = new SwitchCaseHelper();
        SwitchCaseHelper sch2 = sch.switch(switchOperand);

        try {
            
            sch2.case(switchOperand, new ActionContainerMock(), SwitchCaseHelper.PUT_CONTINUE);

        } catch(SwitchCaseHelper.SwitchCaseException e) {
            
            System.assertEquals(SwitchCaseHelper.EXCEPTION_MESSAGE, e.getMessage());
        }
    }

    @isTest
    private static void defaultTest() {
        
        String switchOperand = 'Switch Operand';
        SwitchCaseHelper sch = new SwitchCaseHelper();
        SwitchCaseHelper res = sch
            .switch(switchOperand)
            .case(switchOperand, new ActionContainerMock(), SwitchCaseHelper.PUT_CONTINUE)
            .default(new ActionContainerMock());

        System.assert(!res.isPreviousSwitch);
        System.assert(!res.isCaseAfterBreakStatement);
    }


    @isTest
    private static void defaultExceptionTest() {
        
        String switchOperand = 'Switch Operand';
        SwitchCaseHelper sch = new SwitchCaseHelper();

        try {
            
            sch.default(new ActionContainerMock());

        } catch(SwitchCaseHelper.SwitchCaseException e) {
            
            System.assertEquals(SwitchCaseHelper.EXCEPTION_MESSAGE, e.getMessage());
        }
    }


    @isTest
    private static void noOneSwitchTest() {
        
        SwitchCaseHelper sch = new SwitchCaseHelper();

        try {
            
            sch.case('', new ActionContainerMock(), SwitchCaseHelper.PUT_CONTINUE);

        } catch(SwitchCaseHelper.SwitchCaseException e) {
            
            System.assertEquals(SwitchCaseHelper.EXCEPTION_MESSAGE, e.getMessage());
        }
    }

}