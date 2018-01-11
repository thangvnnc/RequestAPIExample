import UIKit
import RequestAPI
import LocalAuthentication

class ViewController: UIViewController
{
    @IBOutlet weak var txtLink: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    @IBAction func btnGotoUploadFile(_ sender: UIButton)
    {
        let uploadVC: UploadViewController
            = UploadViewController(nibName: "UploadViewController", bundle: nil)
        self.navigationController?.pushViewController(uploadVC, animated: true)
    }

    @IBAction func btnGet(_ sender: Any)
    {
        let reqDef: ReqDefine = ReqDefine()
        reqDef.url      = txtLink.text!
        reqDef.method   = ReqMethod.get

        let reqData: ReqData = ReqData()
        reqData.addParam(key: "name", value: "thangvnnc")
        reqData.addParam(key: "company", value: "sic viet nam")

        ReqAPI.intance.request(reqDefine: reqDef, reqData: reqData)
        {
            (urlError, urlResponse, recv) in

            guard let strRecv = recv, urlError == nil else
            {
                print(urlError!.code)
                return
            }
            if (urlResponse != nil)
            {
                let httpResponse: HTTPURLResponse = urlResponse as! HTTPURLResponse
                print(httpResponse.statusCode)
                print("response code: \(httpResponse.statusCode)")
            }
            print("response data: \(strRecv)")
        }
    }
    
    @IBAction func btnPost(_ sender: Any)
    {
        let reqDef: ReqDefine = ReqDefine()
        reqDef.url      = txtLink.text!
        reqDef.method   = ReqMethod.post
        
        let reqData: ReqData = ReqData()
        reqData.addParam(key: "name1", value: "thangvnnc1")
        reqData.addParam(key: "company1", value: "sic viet nam1")
        
        ReqAPI.intance.request(reqDefine: reqDef, reqData: reqData)
        {
            (urlError, urlResponse, recv) in
            
            guard let strRecv = recv, urlError == nil else
            {
                print(urlError!.code)
                
                return
            }
            if (urlResponse != nil)
            {
                let httpResponse: HTTPURLResponse = urlResponse as! HTTPURLResponse
                print(httpResponse.statusCode)
                print("response code: \(httpResponse.statusCode)")
            }
            print("response data: \(strRecv)")
        }
    }

    @IBAction func btnGetHttps(_ sender: UIButton)
    {
    }
}
