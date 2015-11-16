public with sharing class UsernamePasswordLoginImpl implements Loginable {

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

	public UsernamePasswordLoginImpl() {
		username = properties.get('username');
		password = properties.get('password');
	}

	/**
	 * 
	 * @return Session Id (sid) that needs for any operations with RestApi and others 
	 * (use this one inside request' header, e.g. 'Authorization: Bearer THE_SESSION_ID');
	 */
	public String login() {

		List<String> cookies = new List<String>();
		Http http = new Http();
		HttpRequest req = new HttpRequest();
		HttpResponse res = new HttpResponse();

		req.setMethod('GET');
		req.setEndpoint('https://login.salesforce.com/?un=' + username + '&pw=' + password);
		res = http.send(req);

		boolean redirect = false;

		if(res.getStatusCode() >= 300 && res.getStatusCode() <= 307 && res.getStatusCode() != 306) {
		    do {
		        redirect = false;
		        String loc = res.getHeader('Location');
		        if(loc == null) {
		            redirect = false;
		            continue;
		        }
		        req = new HttpRequest();
		        req.setEndpoint(loc);
		        req.setMethod('GET');
		        res = http.send(req);
		        if(res.getStatusCode() != 500) {
		            if(res.getStatusCode() >=300 && res.getStatusCode() <= 307 && res.getStatusCode() != 306) {
		                redirect= true;
		            }
		            cookies.add(res.getHeader('Set-Cookie'));
		        }
		    } while (redirect && Limits.getCallouts() != Limits.getLimitCallouts());
		}

		String sid;
		for (String cookie : cookies) {
			if (cookie != null && cookie.contains('sid=')) {
				sid = cookie.substringBetween('sid=','; path=');
				break;
			}
		}
		return sid;
	}
}