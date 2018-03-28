//
//  ViewController.m
//  jumptest
//
//  Created by pi on 26/03/2018.
//  Copyright © 2018 wxbester. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)JumpToUrlScheme:(NSString*)webUrlText{
    NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodeUrl = [webUrlText stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
    
    NSURL *url = [NSURL URLWithString:encodeUrl];
    if([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url options:nil completionHandler:nil];
        return true;
    }
    else{
        NSLog(@"未安装");
        return false;
    }
}


- (IBAction)JumpJD:(id)sender {
//    NSURL *url = [NSURL URLWithString:@"alipay://"];
    //京东签到会员活动主页
//    NSString *temp = [NSString stringWithFormat:@"openApp.jdMobile://virtual?params={\"sourceType\":\"sale-act\",\"sourceValue\":\"jumpFromShare\",\"category\":\"jump\",\"des\" : \"DM\",\"dmurl\" : \"https://ljd.m.jd.com/countersign/index.action\"}"];
    
    //京东签到
    NSString *temp = [NSString stringWithFormat:@"openapp.jdmobile://virtual?params={\"category\":\"jump\",\"des\":\"jdreactcommon\",\"modulename\":\"JDReactCollectJDBeans\",\"appname\":\"JDReactCollectJDBeans\",\"ishidden\":true,\"param\":{\"page\":\"collectJDBeansHomePage\",\"source\":\"jrsq17\",\"transparentenable\":true}}"];
    
    [self  JumpToUrlScheme:temp];
   
}

- (IBAction)jdmobileSign:(id)sender {
    //京东金融签到
    NSString *temp = [NSString stringWithFormat:@"jdmobile://share?jumpType=7&jumpUrl=243&channel=default&sourceUrl=1000*https://m.jr.jd.com/spe/downloadApp/index.html?id=94"];
    
    [self  JumpToUrlScheme:temp];
}

- (IBAction)alipayLuckyMoney:(id)sender {
    //支付宝红包 
    NSString *temp = [NSString stringWithFormat:@"alipays://platformapi/startapp?appId=20000067&__open_alipay__=YES&url=https://render.alipay.com/p/f/fd-j6lzqrgm/guiderofmklvtvw.html?shareId=2088802685431555&campStr=p1j+dzkZl018zOczaHT4Z5CLdPVCgrEXq89JsWOx1gdt05SIDMPg3PTxZbdPw9dL&sign=qDuk9wbMLAmTU17dwUZiF8m0EnUCOV6iLkYLWxzpBm8=&scene=offlinePaymentNewSns"];
    
    [self  JumpToUrlScheme:temp];
}

- (IBAction)QQnewMoney:(id)sender {
    //腾讯新闻红包
    NSString *temp = [NSString stringWithFormat:@"qqnews://article_9527?nm=RSS2017113003249400"];
    
    [self  JumpToUrlScheme:temp];
}

- (IBAction)sinaWeiboMoney:(id)sender {
    //新浪微博红包
    NSString *temp = [NSString stringWithFormat:@"sinaweibo://browser?url=https://m.weibo.cn/c/ckin?luicode=10000004&luicode=20000319&luicode=20000318"];
    [self JumpToUrlScheme:temp];
}
- (IBAction)jdMobileMoney:(id)sender {
    //盼盼 京东金融红包
    NSString *temp = [NSString stringWithFormat:@"jdmobile://share?jumpType=7&jumpUrl=512&channel=default&sourceUrl=1000*https://m.jr.jd.com/spe/downloadApp/index.html?id=599"];
    [self JumpToUrlScheme:temp];
}

- (IBAction)jdMobileTraff:(id)sender {
    //金融送流量
    NSString *temp = [NSString stringWithFormat:@"jdmobile://share?jumpType=7&jumpUrl=508&channel=default&sourceUrl=1000*https://m.jr.jd.com/spe/downloadApp/index.html?id=285"];
    [self JumpToUrlScheme:temp];
}



@end
