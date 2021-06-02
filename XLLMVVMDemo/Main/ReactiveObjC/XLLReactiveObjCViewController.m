//
//  XLLReactiveObjCViewController.m
//  XLLMVVMDemo
//
//  Created by xiaoll on 2021/6/2.
//

#import "XLLReactiveObjCViewController.h"
#import "XLLReactiveObjCCodeViewController.h"
#import "XLLReactiveObjCViewModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface XLLReactiveObjCViewController ()

@property (nonatomic, strong) XLLReactiveObjCViewModel *viewModel;

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *combineLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end

@implementation XLLReactiveObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self bindViewModel:self.viewModel];
}

- (void)bindViewModel:(XLLReactiveObjCViewModel *)viewModel {
    //单行数据绑定 textField结束输入时绑定
    RAC(viewModel, phone) = RACObserve(self.phoneTextField, text);
    //双向数据绑定 textField改变内容时绑定
    RACChannelTerminal *textFieldChannel = self.passwordTextField.rac_newTextChannel;
    RACChannelTerminal *passwordChannel = RACChannelTo(viewModel, password);
    [textFieldChannel subscribe:passwordChannel];
    [passwordChannel subscribe:textFieldChannel];
    //组合数据绑定
    RACSignal *phoneSignal = RACObserve(self.phoneTextField, text);
    RACSignal *combineSignal = [RACSignal combineLatest:@[phoneSignal, textFieldChannel] reduce:^id _Nonnull(NSString *phone, NSString *password){
        return [NSString stringWithFormat:@"%@ -- %@", phone, password];
    }];
    [combineSignal subscribeNext:^(id  _Nullable x) {
        self.combineLabel.text = x;
    }];
    //点击事件绑定
    self.submitButton.rac_command = viewModel.clearCommand;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark - TEST ACTION
// 单向数据绑定
- (IBAction)danxiangBindClick:(id)sender {
    [self.phoneTextField resignFirstResponder];
    NSLog(@"phone = %@", self.viewModel.phone);
}

// 双向数据绑定
- (IBAction)shuangxiangBindClick:(id)sender {
    [self.passwordTextField resignFirstResponder];
    NSLog(@"password = %@", self.viewModel.password);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.viewModel.password = @"我强行给你改过来";
    });
}


#pragma mark - lazy loading
- (XLLReactiveObjCViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[XLLReactiveObjCViewModel alloc] init];
    }
    return _viewModel;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    XLLReactiveObjCCodeViewController *codeVC = (XLLReactiveObjCCodeViewController *)segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"danxiangBind"]) {
        codeVC.type = 1;
    } else if ([segue.identifier isEqualToString:@"shuangxiangBind"]) {
        codeVC.type = 2;
    } else if ([segue.identifier isEqualToString:@"combineBind"]) {
        codeVC.type = 3;
    } else if ([segue.identifier isEqualToString:@"actionBind"]) {
        codeVC.type = 4;
    }
}

@end
