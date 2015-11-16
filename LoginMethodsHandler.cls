/**
 * Habdles invokation of login with different methods (OAuth2 access token, Partner WSDL, Username and password)
 */
public with sharing class LoginMethodsHandler {

	public enum AuthorizationMethod {
		OAUTH2,
		PARTNER_WSDL,
		USERNAME_PASSWORD
	}

	/**
	 * 
	 * @param  method A method of authorization (OAuth2, Partner WSDL, etc.)
	 * @return        access token or session id depends of login method
	 */
	public static String loginWith(AuthorizationMethod method) {
		try {

			if (method == AuthorizationMethod.OAUTH2) {
				OAuth2LoginImpl oAuth2 = new OAuth2LoginImpl();
				return oAuth2.login();
			}
			if (method == AuthorizationMethod.PARTNER_WSDL) {
				WsdlLoginImpl wsdl = new WsdlLoginImpl();
				return wsdl.login();
			}
			UsernamePasswordLoginImpl unpw = new UsernamePasswordLoginImpl();
			return unpw.login();

		} catch (AuthorizationFailException e) {
			System.debug(e.getStackTraceString());
			return e.getMessage();
		} catch (Exception ex) {
			System.debug(ex.getStackTraceString());
			return 'Somthing Gone Wrong!';
		}
	}
}