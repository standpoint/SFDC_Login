public with sharing class SwitchCaseExample {

	public class Action1 implements ActionContainer {
		public String doAction() {
			System.debug('invoke action 1');
			return null; 
		}
	}

	public class Action2 implements ActionContainer {
		public String doAction() {
			System.debug('invoke action 2');
			return null;
		}
	}

	public class Action3 implements ActionContainer {
		public String doAction() {
			System.debug('invoke action 3');
			return null;
		}
	}
	

	public SwitchCaseExample() {}

	public void testSwitchCase(String value) {
		
		SwitchCaseHelper sch = new SwitchCaseHelper();	
		sch.switch(value)
			.case('value1', new Action1(), SwitchCaseHelper.PUT_BREAK)
			.case('value2', new Action2(), SwitchCaseHelper.PUT_CONTINUE)
			.case('value3', new Action3(), SwitchCaseHelper.PUT_BREAK)
			.default(new Action1());
	}
}