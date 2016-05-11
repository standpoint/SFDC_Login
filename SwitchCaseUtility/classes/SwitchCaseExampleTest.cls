@isTest
private class SwitchCaseExampleTest {

    
    @isTest
    private static void firstCaseTest() {
        
        SwitchCaseExample sce = new SwitchCaseExample();
        sce.testSwitchCase('value1');
        System.assertEquals(SwitchCaseExample.MSG_FROM_ACTION_1, sce.result);
    }

    
    @isTest
    private static void secondCaseTest() {
        
        SwitchCaseExample sce = new SwitchCaseExample();
        sce.testSwitchCase('value2');
        System.assertEquals(SwitchCaseExample.MSG_FROM_ACTION_4, sce.result);
    }

	
	@isTest
    private static void thirdCaseTest() {
		
        SwitchCaseExample sce = new SwitchCaseExample();
        sce.testSwitchCase('value3');
        System.assertEquals(SwitchCaseExample.MSG_FROM_ACTION_3, sce.result);
	}


    @isTest
    private static void defaultTest() {
        
        SwitchCaseExample sce = new SwitchCaseExample();
        sce.testSwitchCase('non-switch value');
        System.assertEquals(SwitchCaseExample.MSG_FROM_ACTION_4, sce.result);
    }

	
}