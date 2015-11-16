public with sharing class WsdlLoginImpl implements Loginable {

	public Map<String,String> properties {private set; get {
			if (properties == null) {
				properties = new Map<String,String>();
			} else {
				return properties;
			}
			Map<String, remoteUserSettings__c> allMap = remoteUserSettings__c.getAll();
			for (String key : allMap.keySet()) {
				properties.put(key, allMap.get(key).Value__c);
			}
			return properties;
		}
	}

	private final String username;
	private final String password;
	private final String token;
	
	public WsdlLoginImpl() {

		username = properties.get('username');
		password = properties.get('password');
		token = properties.get('token');
	}

	/**
	 * 
	 * @return Session Id (sid) that needs for any operations with RestApi and others 
	 * (use this one inside request' header, e.g. 'Authorization: Bearer THE_SESSION_ID');
	 */
	public String login() {

		PartnerSoapSforceCom.Soap s = new PartnerSoapSforceCom.Soap();
		PartnerSoapSforceCom.LoginResult lr = s.login(username, password+token);
		s.SessionHeader = new PartnerSoapSforceCom.SessionHeader_element();
		s.endpoint_x = lr.serverurl;
		s.Sessionheader.sessionid = lr.sessionid;
		s.getUserInfo();
		return lr.sessionid;
	}
}