import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setupSOAppleSignIn()
    }

    func setupSOAppleSignIn(){
        let btnAuthorization = ASAuthorizationAppleIDButton()
        
        btnAuthorization.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        btnAuthorization.center = self.view.center
        btnAuthorization.addTarget(self, action: #selector(actionHandleAppleSignIn), for: .touchUpInside)
        self.view.addSubview(btnAuthorization)
    }
    
    @objc func actionHandleAppleSignIn(){
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }

}

extension ViewController: ASAuthorizationControllerDelegate {

     // ASAuthorizationControllerDelegate function for authorization failed

    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {

        print(error.localizedDescription)

    }

       // ASAuthorizationControllerDelegate function for successful authorization

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {

        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {

            // Create an account as per your requirement

            let appleId = appleIDCredential.user

            let appleUserFirstName = appleIDCredential.fullName?.givenName

            let appleUserLastName = appleIDCredential.fullName?.familyName

            let appleUserEmail = appleIDCredential.email

            //Write your code

        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {

            let appleUsername = passwordCredential.user

            let applePassword = passwordCredential.password

            //Write your code

        }

    }

}

extension ViewController: ASAuthorizationControllerPresentationContextProviding {

    //For present window

    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {

        return self.view.window!

    }

}
