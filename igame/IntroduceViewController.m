//
//  IntroduceViewController.m
//  igame
//
//  Created by Interest on 2016/12/19.
//  Copyright © 2016年 Interest. All rights reserved.
//

#import "IntroduceViewController.h"

@interface IntroduceViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textview;
@end

@implementation IntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [ExamService shareInstenced].getChapterPracticeSuccess = ^(id obj){
        
        [self hideHud];
        NSString *html = obj[@"post_content"];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
        self.textview.attributedText = attributedString;

    };
    [ExamService shareInstenced].getChapterPracticeFailure = ^(id obj){
        
        [self hideHud];
        [self showHudWithString:obj];
        
    };
    [self showHud];
     UserModel *model = [[LoginService shareInstanced]getUserModel];

    [[ExamService shareInstenced]getChapterPracticeWithTypeId:self.type uid:model.uid];
}

@end
