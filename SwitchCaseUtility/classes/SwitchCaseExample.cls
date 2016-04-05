public with sharing class SwitchCaseExample {

	public class Action1 implements SwitchContext {
		public String doAction() {
			System.debug('invoke action 1');
			return null; 
		}
	}

	public class Action2 implements SwitchContext {
		public String doAction() {
			System.debug('invoke action 2');
			return null;
		}
	}

	public class Action3 implements SwitchContext {
		public String doAction() {
			System.debug('invoke action 3');
			return null;
		}
	}
	

	public SwitchCaseExample() {}

	public void testSwitchCase(String value) {
		
		SwitchCaseHelper sch = new SwitchCaseHelper();	
		sch.switch(value)
			.case('value1', new Action1(), SwitchCaseHelper.HAS_BREAK)
			.case('value2', new Action2(), SwitchCaseHelper.HAS_NOT_BREAK)
			.case('value3', new Action3(), SwitchCaseHelper.HAS_BREAK)
			.default(new Action1());
	}
}