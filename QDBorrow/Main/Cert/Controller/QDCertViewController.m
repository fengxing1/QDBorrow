//
//  QDCertViewController.m
//  QDBorrow
//
//  Created by larou on 2017/5/10.
//  Copyright © 2017年 jinrong. All rights reserved.
//

#import "QDCertViewController.h"
#import "UIAlertView+Block.h"
#import "QDCerditModel.h"
#import "QMUITableViewCell.h"
#import "UIImageView+WebCache.h"
#import "QDWebViewController.h"
#import "QDCommonUI.h"
#import "QDCerditCell.h"
#import "MBProgressHUD+MP.h"
#import <SobotKit/SobotKit.h>

static NSString *const kReusableIdentifierCerditCell  = @"cerditCell";

@interface QDCertViewController ()
@property (nonatomic, strong) NSMutableArray *cerditList;

@end

@implementation QDCertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self configUI];
    [self configService];
    
}

- (void)configService {
    //  初始化配置信息
    ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
    
    [self setZCLibInitInfoParam:initInfo];
    
    //自定义用户参数
    [self customUserInformationWith:initInfo];
    
    ZCKitInfo *uiInfo=[ZCKitInfo new];
    
    
    // 自定义UI(设置背景颜色相关)
    [self customerUI:uiInfo];
    
    
    // 之定义商品和留言页面的相关UI
    [self customerGoodAndLeavePageWithParameter:uiInfo];
    
    // 未读消息
    //    [self customUnReadNumber:uiInfo];
    
    // 测试模式
    [ZCSobot setShowDebug:NO];
    
    [[ZCLibClient getZCLibClient] setLibInitInfo:initInfo];
    
    [ZCSobot startZCChatView:uiInfo with:self pageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
        
        if(type==ZCPageBlockGoBack){
            NSLog(@"点击了返回按钮");
        }
        // 页面UI初始化完成，可以获取UIView，自定义UI
        if(type==ZCPageBlockLoadFinish){
            // banner 返回按钮
            // [object.backButton setTitle:@" 返回" forState:UIControlStateNormal];
            // banner 标题
            // [object.titleLabel setFont:[UIFont systemFontOfSize:30]];
            // banner 底部View
            // [object.topView setBackgroundColor:[UIColor greenColor]];
            // 输入框
            // UITextView *tv=[object getChatTextView];
            // [tv setBackgroundColor:[UIColor redColor]];
        }
    } messageLinkClick:nil];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)setZCLibInitInfoParam:(ZCLibInitInfo *)initInfo{
    // 获取AppKey
    initInfo.appKey = @"976587bdd707439f8ae1b604103dc7ac";
    initInfo.skillSetId = @"";
    initInfo.skillSetName = @"";
    initInfo.receptionistId = @"";
    initInfo.robotId = @"";
    initInfo.tranReceptionistFlag = 0;
    //    initInfo.scopeTime = 0;
    initInfo.titleType = 0;
    initInfo.customTitle = @"1221";
    
}

// 设置UI部分
-(void) customerUI:(ZCKitInfo *) kitInfo{
    kitInfo.isCloseAfterEvaluation = YES;
    
    /**
     *  自定义信息
     */
    // 顶部导航条标题文字 评价标题文字 系统相册标题文字 评价客服（立即结束 取消）按钮文字
    //    kitInfo.titleFont = [UIFont systemFontOfSize:30];
    
    // 返回按钮      输入框文字   评价客服是否有以下情况 label 文字  提价评价按钮
    //    kitInfo.listTitleFont = [UIFont systemFontOfSize:22];
    
    //没有网络提醒的button 没有更多记录label的文字    语音tipLabel的文字   评价不满意（4个button）文字  占位图片的lablel文字   语音输入时间label文字   语音输入的按钮文字
    //    kitInfo.listDetailFont = [UIFont systemFontOfSize:25];
    
    // 录音按钮的文字
    //    kitInfo.voiceButtonFont = [UIFont systemFontOfSize:25];
    // 消息提醒 （转人工、客服接待等）
    //    kitInfo.listTimeFont = [UIFont systemFontOfSize:22];
    
    // 聊天气泡中的文字
    //    kitInfo.chatFont  = [UIFont systemFontOfSize:22];
    
    // 聊天的背景颜色
    //    kitInfo.backgroundColor = [UIColor redColor];
    
    // 导航、客服气泡、线条的颜色
    //        kitInfo.customBannerColor  = [UIColor redColor];
    
    // 左边气泡的颜色
    //        kitInfo.leftChatColor = [UIColor redColor];
    
    // 右边气泡的颜色
    //        kitInfo.rightChatColor = [UIColor redColor];
    
    // 底部bottom的背景颜色
    //    kitInfo.backgroundBottomColor = [UIColor redColor];
    
    // 底部bottom的输入框线条背景颜色
    //    kitInfo.bottomLineColor = [UIColor redColor];
    
    // 提示气泡的背景颜色
    //    kitInfo.BgTipAirBubblesColor = [UIColor redColor];
    
    // 顶部文字的颜色
    //    kitInfo.topViewTextColor  =  [UIColor redColor];
    
    // 提示气泡文字颜色
    //        kitInfo.tipLayerTextColor = [UIColor redColor];
    
    // 评价普通按钮选中背景颜色和边框(默认跟随主题色customBannerColor)
    //        kitInfo.commentOtherButtonBgColor=[UIColor redColor];
    
    // 评价(立即结束、取消)按钮文字颜色(默认跟随主题色customBannerColor)
    //    kitInfo.commentCommitButtonColor = [UIColor redColor];
    
    //评价提交按钮背景颜色和边框(默认跟随主题色customBannerColor)
    //    kitInfo.commentCommitButtonBgColor = [UIColor redColor];
    
    //    评价提交按钮点击后背景色，默认0x089899, 0.95
    //    kitInfo.commentCommitButtonBgHighColor = [UIColor yellowColor];
    
    // 左边气泡文字的颜色
    //    kitInfo.leftChatTextColor = [UIColor redColor];
    
    // 右边气泡文字的颜色[注意：语音动画图片，需要单独替换]
    //    kitInfo.rightChatTextColor  = [UIColor redColor];
    
    // 时间文字的颜色
    //    kitInfo.timeTextColor = [UIColor redColor];
    
    // 客服昵称颜色
    //        kitInfo.serviceNameTextColor = [UIColor redColor];
    
    
    // 提交评价按钮的文字颜色
    //    kitInfo.submitEvaluationColor = [UIColor redColor];
    
    // 相册的导航栏背景颜色
    
    //    kitInfo.imagePickerColor = _selectedColor;
    // 相册的导航栏标题的文字颜色
    //    kitInfo.imagePickerTitleColor = [UIColor redColor];
    
    // 左边超链的颜色
    //        kitInfo.chatLeftLinkColor = [UIColor blueColor];
    
    // 右边超链的颜色
    //        kitInfo.chatRightLinkColor =[UIColor redColor];
    
    // 提示客服昵称的文字颜色
    //    kitInfo.nickNameTextColor = [UIColor redColor];
    // 相册的导航栏是否设置背景图片(图片来自SobotKit.bundle中ZCIcon_navcBgImage)
    //    kitInfo.isSetPhotoLibraryBgImage = YES;
    
    // 富媒体cell中线条的背景色
    //    kitInfo.LineRichColor = [UIColor redColor];
    
    //    // 语音cell选中的背景颜色
    //    kitInfo.videoCellBgSelColor = [UIColor redColor];
    //
    //    // 商品cell中标题的文字颜色
    //    kitInfo.goodsTitleTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中摘要的文字颜色
    //    kitInfo.goodsDetTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中标签的文字颜色
    //    kitInfo.goodsTipTextColor = [UIColor redColor];
    //
    //    // 商品详情cell中发送的文字颜色
    //    kitInfo.goodsSendTextColor = [UIColor redColor];
    
    // 发送按钮的背景色
    //        kitInfo.goodSendBtnColor = [UIColor yellowColor];
    
    // “连接中。。。”  button 的背景色和文字的颜色
    //    kitInfo.socketStatusButtonBgColor  = [UIColor yellowColor];
    //    kitInfo.socketStatusButtonTitleColor = [UIColor redColor];
}

// 自定义用户信息参数
- (void)customUserInformationWith:(ZCLibInitInfo*)initInfo{
    initInfo.userId         = @"123";
    //    initInfo.customInfo = @{@"标题1":@"自定义1",@"内容1":@"我是一个自定义字段。",@"标题2":@"自定义字段2",@"内容2":@"我是一个自定义字段，我是一个自定义字段，我是一个自定义字段，我是一个自定义字段。",@"标题3":@"自定义字段字段3",@"内容3":@"<a href=\"www.baidu.com\" target=\"_blank\">www.baidu.com</a>",@"标题4":@"自定义4",@"内容4":@"我是一个自定义字段 https://www.sobot.com/chat/pc/index.html?sysNum=9379837c87d2475dadd953940f0c3bc8&partnerId=112"};
    
    NSUserDefaults *user  = [NSUserDefaults standardUserDefaults];
    initInfo.email        = [user valueForKey:@"email"];
    initInfo.avatarUrl    = [user valueForKey:@"avatarUrl"];
    initInfo.sourceURL    = [user valueForKey:@"sourceURL"];
    initInfo.sourceTitle  = [user valueForKey:@"sourceTitle"];
    initInfo.serviceMode  = 0;
    
    // 以下字段为方便测试使用，上线打包时注掉
    initInfo.phone       = [user valueForKey:@"phone"];
    initInfo.nickName    = [user valueForKey:@"nickName"];
    // 微信，微博，用户的真实昵称，生日，备注性别 QQ号
    // 生日字段用户传入的格式，例：20170323，如果不是这个格式，初始化接口会给过滤掉
    
    initInfo.qqNumber = [user valueForKey:@"qqNumber"];
    initInfo.userSex = [user valueForKey:@"userSex"];
    initInfo.realName = [user valueForKey:@"useName"];
    initInfo.weiBo = [user valueForKey:@"weiBo"];
    initInfo.weChat = [user valueForKey:@"weChat"];
    initInfo.userBirthday = [user valueForKey:@"userBirthday"];
    initInfo.userRemark = [user valueForKey:@"userRemark"];
    
    
    //    NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:initInfo.phone,@"tel",useName,@"realname",initInfo.email,@"email",initInfo.nickName,@"uname" ,weChat,@"weixin",weibo,@"weibo",sex,@"sex",userBirthday,@"birthday",userRemark,@"remark",initInfo.avatarUrl,@"face",qq,@"qq",initInfo.sourceURL,@"visitUrl",initInfo.sourceTitle,@"visitTitle",@"自定义1",@"标题1",@"<a href=\"www.baidu.com\" target=\"_blank\">www.baidu.com</a>",@"内容3",nil];
    //    initInfo.customInfo = dict;
    initInfo.customInfo = @{
                            
                            @"标题1":@"自定义1",
                            @"内容1":@"我是一个自定义字段。",
                            @"标题2":@"自定义字段2",
                            @"内容2":@"我是一个自定义字段，我是一个自定义字段，我是一个自定义字段，我是一个自定义字段。",
                            @"标题3":@"自定义字段字段3",
                            @"内容3":@"<a href=\"www.baidu.com\" target=\"_blank\">www.baidu.com</a>",
                            @"标题4":@"自定义4",
                            @"内容4":@"我是一个自定义字段 https://www.sobot.com/chat/pc/index.html?sysNum=9379837c87d2475dadd953940f0c3bc8&partnerId=112"
                            };
    
}



- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}



// 自定义参数 商品信息相关
- (void)customerGoodAndLeavePageWithParameter:(ZCKitInfo *)uiInfo{
    
    // 商品信息自定义
    //    if (_isShowGoodsSwitch.on) {
    //        ZCProductInfo *productInfo = [ZCProductInfo new];
    //        productInfo.thumbUrl = _goodsImgTF.text;
    //        productInfo.title = _goodsTitleTF.text;
    //        productInfo.desc = _goodsSummaryTF.text;
    //        productInfo.label = _goodTagTF.text;
    //        productInfo.link = _goodsSendTF.text;
    //
    //        [[NSUserDefaults standardUserDefaults] setObject:productInfo.thumbUrl forKey:@"goods_IMG"];
    //        [[NSUserDefaults standardUserDefaults] setObject:productInfo.title forKey:@"goods_Title"];
    //        [[NSUserDefaults standardUserDefaults] setObject:productInfo.desc forKey:@"goods_SENDMGS"];
    //        [[NSUserDefaults standardUserDefaults] setObject:productInfo.label forKey:@"glabel_Text"];
    //        [[NSUserDefaults standardUserDefaults] setObject:productInfo.link forKey:@"gPageUrl_Text"];
    //        uiInfo.productInfo = productInfo;
    //    }
#warning // 测试环境接口，上线demo去掉不在使用
    
    uiInfo.apiHost = @"http://test.sobot.com";
    
    // 设置电话号和昵称（留言界面的显示）
    //    uiInfo.isAddNickName = 1;
    //    uiInfo.isShowNickName = 1;
    //    if(_hostTF.text!=nil){
    //        uiInfo.apiHost = _hostTF.text;
    //    }
    //    uiInfo.apiHost = @"http://test.sobot.com";
    
}

- (void)configUI {
    self.title = @"信用卡";
//    self.tableView.contentInset = UIEdgeInsetsMake(-35, 0, 0, 0);
    self.navigationController.navigationBar.hidden = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"QDCerditCell" bundle:nil] forCellReuseIdentifier:kReusableIdentifierCerditCell];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
}


#pragma mark - <QMUITableViewDataSource,QMUITableViewDelegate>

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QDCerditCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifierCerditCell];
    QDCerditModel *cerditModel = self.cerditList[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.cerditModel = cerditModel;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.cerditList) {
        return self.cerditList.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    QDCerditModel *cerditModel = self.cerditList[indexPath.row];
    if (!cerditModel.showDetail) {
        return;
    }
    NSString *redirectUrl = cerditModel.redirectUrl;
    if (!([redirectUrl containsString:@"http"] || [redirectUrl containsString:@"https"])) {
        redirectUrl = [@"http://" stringByAppendingString:redirectUrl];
    }
    QDWebViewController *webViewController = [[QDWebViewController alloc] initWithURL:[NSURL URLWithString:redirectUrl]];
    webViewController.showsToolBar = NO;
    webViewController.navigationController.navigationBar.translucent = NO;
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webViewController animated:YES];
    self.hidesBottomBarWhenPushed = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
