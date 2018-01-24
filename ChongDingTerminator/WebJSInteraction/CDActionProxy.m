//
//  CDActionProxy.m
//  ChongDingTerminator
//
//  Created by Dingli on 2018/1/15.
//  Copyright © 2018年 Dingli. All rights reserved.
//

#import "CDActionProxy.h"
#import "CWInterfaceModel.h"
#import <UShareUI/UShareUI.h>
#import "extobjc.h"
#import "CDHud.h"

@implementation CDActionProxy

- (void)openOrDownloadApk:(id)jsonStr {
    NSLog(@"openOrDownloadApk : %@", jsonStr);
    OpenDownloadModel *model = [OpenDownloadModel yy_modelWithJSON:jsonStr];
    NSURL *scheme = [NSURL URLWithString:model.scheme];
    
    if ([[UIApplication sharedApplication] canOpenURL:scheme]) {
        [[UIApplication sharedApplication] openURL:scheme];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.downloadUrl]];
    }
}

- (void)shareApp:(id)jsonStr {
    NSLog(@"shareApp : share。。。。。。。。。");
    ShareModel *model = [ShareModel yy_modelWithJSON:jsonStr];

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
                                    currentViewController:nil
                                               completion:^(id result, NSError *error) {
                                                   @strongify(self);
                                                   [self.delegate shareSuccess];
                                               }];
    }];
}

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
