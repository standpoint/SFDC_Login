@isTest
public with sharing class ActionContainerMock implements ActionContainer {

    public final static String ACTION_RESULT = 'switch-case mock action result';

    public String doAction() {
        
        return ACTION_RESULT;
    }
}