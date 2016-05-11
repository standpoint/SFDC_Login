public with sharing class SwitchCaseExample {

	public String result {get; set;}

	public static final String MSG_FROM_ACTION_1 = 'invoke action 1';
	public static final String MSG_FROM_ACTION_2 = 'invoke action 2';
	public static final String MSG_FROM_ACTION_3 = 'invoke action 3';
	public static final String MSG_FROM_ACTION_4 = 'invoke action 4';

	public void testSwitchCase(String value) {
		
		SwitchCaseHelper sch = new SwitchCaseHelper();	
		
		sch.switch(value)
			.case('value1', new Action1(this), SwitchCaseHelper.PUT_BREAK)
			.case('value2', new Action2(this), SwitchCaseHelper.PUT_CONTINUE)
			.case('value3', new Action3(this), SwitchCaseHelper.PUT_BREAK)
			.default(new Action4(this));
	}


	private class Action1 implements ActionContainer {

		private SwitchCaseExample outerCtx;

		public Action1(SwitchCaseExample outerCtx) {

			this.outerCtx = outerCtx;
		}

		public String doAction() {

			outerCtx.result = MSG_FROM_ACTION_1;
			return null; 
		}
	}

	private class Action2 implements ActionContainer {

		private SwitchCaseExample outerCtx;

		public Action2(SwitchCaseExample outerCtx) {
			
			this.outerCtx = outerCtx;
		}

		public String doAction() {

			outerCtx.result = MSG_FROM_ACTION_2;
			return null; 
		}
	}

	private class Action3 implements ActionContainer {

		private SwitchCaseExample outerCtx;

		public Action3(SwitchCaseExample outerCtx) {
			
			this.outerCtx = outerCtx;
		}

		public String doAction() {

			outerCtx.result = MSG_FROM_ACTION_3;
			return null; 
		}
	}

	private class Action4 implements ActionContainer {

		private SwitchCaseExample outerCtx;

		public Action4(SwitchCaseExample outerCtx) {
			
			this.outerCtx = outerCtx;
		}

		public String doAction() {

			outerCtx.result = MSG_FROM_ACTION_4;
			return null; 
		}
	}

}