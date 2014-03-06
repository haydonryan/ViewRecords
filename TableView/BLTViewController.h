//
//  BLTViewController.h
//  TableView
//
//  Created by Haydon Ryan on 6/03/2014.
//  Copyright (c) 2014 Bounce Labs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BLTViewController : UIViewController<NSURLConnectionDelegate>    //had to add delegate for ASYNC callback.
{
    NSMutableData *_responseData;
    
}

- (IBAction)ClickRefresh:(id)sender;
//@property (strong, nonatomic) IBOutlet UILabel *firstName;
//@property (strong, nonatomic) IBOutlet UILabel *lastName;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;


@property (strong, nonatomic) IBOutlet UITextField *idNumber;

@property UIButton *refresh;


@end
