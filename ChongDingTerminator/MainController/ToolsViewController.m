//
//  SecondViewController.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/11.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import "ToolsViewController.h"
#import "CDWebView.h"
#import "Constants.h"
#import <UShareUI/UShareUI.h>
#import "CWInterfaceModel.h"
#import "extobjc.h"

@interface ToolsViewController () <CDWebViewDelegate>
@property(weak, nonatomic) IBOutlet CDWebView *webView;
@end

@implementation ToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [_webView loadURL:MAIN_PAGE];

    // Configure View Controller
    self.webView.cdDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CDWebviewDelegate

- (void)share:(id)m {
    ShareModel *model = (ShareModel *) m;
    // 创建分享的消息
    UMSocialMessageObject *object = [UMSocialMessageObject messageObject];
    UMShareObject *shareObject = NULL;
    switch ([model.shareType integerValue]) {
        case 0: // image
            shareObject = [self configImageObject:model];
            break;

        case 1: // webpage
            shareObject = [self configWebpageObject:model];
            break;

        default:
            return;
    }
    object.shareObject = shareObject;

    //显示分享面板
    @weakify(self);
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [[UMSocialManager defaultManager] shareToPlatform:platformType
                                            messageObject:object
                                    currentViewController:self
                                               completion:^(id result, NSError *error) {
                                                   @strongify(self);
                                                   [self.webView shareSuccess];
                                               }];
    }];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

}

#pragma mark - other private

- (UMShareObject *)configWebpageObject:(ShareModel *)model {
    UMShareWebpageObject *object = [UMShareWebpageObject shareObjectWithTitle:model.title
                                                                        descr:model.descript
                                                                    thumImage:model.shareImgUrl];
    return object;
}

- (UMShareObject *)configImageObject:(ShareModel *)model {
    UMShareImageObject *object = [UMShareImageObject shareObjectWithTitle:model.title
                                                                    descr:model.descript
                                                                thumImage:model.shareImgUrl];
    return object;
}

@end
