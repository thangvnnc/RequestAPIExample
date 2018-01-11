import UIKit
import RequestAPI

class UploadViewController: UIViewController
{
    // Bien lu data nhan ve
    var responseData: NSMutableData = NSMutableData()
    
    @IBOutlet weak var progressUpload: UIProgressView!
    
    @IBAction func btnUpload(_ sender: UIButton)
    {
        let reqDef: ReqDefine = ReqDefine()
        reqDef.url      = "http://127.0.0.1:3333/upload"
        reqDef.method   = ReqMethod.post
        
        let url: URL = Bundle.main.url(forResource: "demo", withExtension: "dat")!
        let reqUploadAPI = ReqUploadAPI()
        reqUploadAPI.delegate = self
        reqUploadAPI.request(reqDefine: reqDef, urlFile: url)
    }
    
    @IBAction func btnUploadComplete(_ sender: UIButton)
    {
        let reqDef: ReqDefine = ReqDefine()
        reqDef.url      = "http://127.0.0.1:3333/upload"
        reqDef.method   = ReqMethod.post
        
        let url: URL = Bundle.main.url(forResource: "demo", withExtension: "dat")!
        ReqUploadAPICompletion.intance.request(
            reqDefine: reqDef,
            urlFile: url,
            completionHandlerProcess:
            {
                (totalBytes, totalBytesExpectedToSend) in
                let uploadProgress: Float = Float(totalBytes) / Float(totalBytesExpectedToSend)
                self.progressUpload.progress = uploadProgress
            },
            completionHandler:
            {
                (error, urlResponse, data) in
                if (error != nil)
                {
                    print(error?.localizedDescription)
                    return
                }
                
                if (urlResponse != nil)
                {
                    let httpResponse: HTTPURLResponse = urlResponse as! HTTPURLResponse
                    print("response code: \(httpResponse.statusCode)")
                }
                let responseString = String(data: data!, encoding: .utf8)
                print("response data: \(responseString!)")
            }
        )
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
}

extension UploadViewController: ReqUploadAPIDelegate
{
    func didCompleteSendData(_ error: Error?, _ urlResponse: URLResponse?, _ data: Data?)
    {
        if (error != nil)
        {
            print(error?.localizedDescription)
            return
        }
        
        if (urlResponse != nil)
        {
            let httpResponse: HTTPURLResponse = urlResponse as! HTTPURLResponse
            print("response code: \(httpResponse.statusCode)")
        }
        let responseString = String(data: data!, encoding: .utf8)
        print("response data: \(responseString!)")
    }
    
    func didProcessSendData(totalBytes: Int64, totalBytesExpectedToSend: Int64)
    {
        let uploadProgress: Float = Float(totalBytes) / Float(totalBytesExpectedToSend)
        progressUpload.progress = uploadProgress
    }
    
}
