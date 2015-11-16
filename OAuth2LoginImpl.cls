public with sharing class OAuth2LoginImpl implements Loginable {

	static final String	ACCESS_TOKEN_EXPIRED_ERR_MSG = 'Access Token is expired.';

	public Map<String,String> properties {private set; get {
			if (properties == null) {
				properties = new Map<String,String>();
			} else {
				return properties;
			}
			Map<String, oauth2PropertiesBridgeTask__c> allMap = oauth2PropertiesBridgeTask__c.getAll();
			for (String key : allMap.keySet()) {
				properties.put(key, allMap.get(key).Value__c);
			}
			return properties;
		}
	}

	public String requestBody {private set; get {
			if (requestBody == null) {
				requestBody = 'grant_type=' + properties.get('grant_type');
			} else {
				return requestBody;
			}
			for (String key : properties.keySet()) {
				if (key == 'endpoint_uri' || key == 'instance_uri' || key == 'grant_type') {
					continue;
				} else {
					requestBody += '&' + key + '=' + properties.get(key);
				}
			}
			return requestBody;	
		}
	}

	public OAuth2LoginImpl() {}

	/**
	 * 
	 * @return AccessToken that needs for any operations with RestApi and others.
	 * (use this one inside request' header, e.g. 'Authorization: Bearer THE_ACCESS_TOKEN');
	 */
	public String login() {
		String accessToken = getAccessToken();
		if (accessToken == null) {
			throw new AuthorizationFailException('Unsuccessful trying of the authorization');
		}
		return accessToken;
	}

	private String getAccessToken() {

		String accessToken = null;
		String expiresIn = null;

		HttpRequest req = new HttpRequest();
		req.setMethod('POST');
		req.setEndpoint(properties.get('endpoint_uri'));
		req.setBody(requestBody);
		try {
			HttpResponse resp = new Http().send(req);
			String response = resp.getBody();
			JSONParser parser = JSON.createParser(response);
			while (parser.nextToken() != null) {
				if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
					String fieldName = parser.getText();
					parser.nextToken();
					if (fieldName == 'access_token') {
						accessToken = parser.getText();
					} else if (fieldName == 'expires_in') {
						expiresIn = parser.getText();
						throw new AccessTokenException(ACCESS_TOKEN_EXPIRED_ERR_MSG);
					}
				}
			}
		} catch (AccessTokenException ate) {
			System.debug(ate.getMessage() + '\n' + expiresIn);
		} catch (CalloutException ce) {
			System.debug(ce.getMessage());
		} catch (Exception e) {
			System.debug(e.getStackTraceString());
		}

		return accessToken;
	}
}