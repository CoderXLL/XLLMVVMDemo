//
//  XLLReactiveObjCCodeViewController.m
//  XLLMVVMDemo
//
//  Created by xiaoll on 2021/6/2.
//

#import "XLLReactiveObjCCodeViewController.h"

@interface XLLReactiveObjCCodeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *codeLabel;

@end

@implementation XLLReactiveObjCCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    switch (self.type) {
        case 1: {
            NSMutableAttributedString *codeAttrM = [[NSMutableAttributedString alloc] initWithString:@""];
            [codeAttrM appendAttributedString:[[NSAttributedString alloc] initWithString:@"//UI\n" attributes:@{
                            NSForegroundColorAttributeName: [UIColor grayColor],
                            NSFontAttributeName: [UIFont boldSystemFontOfSize:15]
            }]];
            [codeAttrM appendAttributedString:[[NSAttributedString alloc] initWithString:@"\@interface XLLReactiveObjCViewController()\n\n\@property (weak, nonatomic) UITextField *phoneField;\n\n\@end\n\n" attributes:@{
                            NSForegroundColorAttributeName: [UIColor redColor],
                            NSFontAttributeName: [UIFont boldSystemFontOfSize:14]
            }]];
            [codeAttrM appendAttributedString:[[NSAttributedString alloc] initWithString:@"//绑定\n" attributes:@{
                            NSForegroundColorAttributeName: [UIColor grayColor],
                            NSFontAttributeName: [UIFont boldSystemFontOfSize:15]
            }]];
            [codeAttrM appendAttributedString:[[NSAttributedString alloc] initWithString:@"- (void)bindViewModel:(XLLReactiveObjCViewModel *)viewModel {\nRAC(viewModel, phone) = RACObserve(self.phoneField, text);\n}" attributes:@{
                            NSForegroundColorAttributeName: [UIColor purpleColor],
                            NSFontAttributeName: [UIFont boldSystemFontOfSize:14]
            }]];
            self.codeLabel.attributedText = codeAttrM;
        } break;
        case 2:
            break;
        case 3:
            break;
        case 4:
            break;
        default:
            break;
    }
}

@end
