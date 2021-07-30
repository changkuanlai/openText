#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import "LSYReadPageViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
    FlutterViewController * fvc = (FlutterViewController*)self.window.rootViewController;
    
        // 要与main.dart中一致
        NSString *channelName = @"com.disk.native.receive/open_txt";

        FlutterMethodChannel *messageChannel = [FlutterMethodChannel methodChannelWithName:channelName binaryMessenger:fvc.binaryMessenger];
    
    [messageChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
            
        if ([call.method isEqualToString:@"openTxt"]) {
            NSDictionary * dict =  call.arguments;
            if (!dict) {
                return;
            }
            
             [SVProgressHUD showWithStatus:@"加载中..."];
            
            NSString * path = dict[@"patch"];
            
           NSURL*fileURL = [NSURL fileURLWithPath:path];
 
            LSYReadPageViewController *pageView = [[LSYReadPageViewController alloc] init];
            pageView.modalPresentationStyle = UIModalPresentationFullScreen;

            pageView.resourceURL =  fileURL;   //文件位置
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                pageView.model = [LSYReadModel getLocalModelWithURL:fileURL];  //阅读模型
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //回调或者说是通知主线程刷新，
                        [SVProgressHUD dismiss];
                        [fvc presentViewController:pageView animated:YES completion:^{
                        }];
                    });
 
                });
          
        }else{
            result(FlutterMethodNotImplemented);

        }
    }];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
