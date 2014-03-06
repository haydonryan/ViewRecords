//
//  BLTViewController.m
//  TableView
//
//  Created by Haydon Ryan on 6/03/2014.
//  Copyright (c) 2014 Bounce Labs. All rights reserved.
//

#import "BLTViewController.h"
#import "BLTNames.h"

@interface BLTViewController ()

@end

@implementation BLTViewController


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    
    NSLog(@"initing data");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
    
    NSLog(@"Recieving Data");
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    NSLog(@"Cached response");

    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    NSLog(@"finished loading here");

    NSLog([[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding]);
    
    NSError *localError=nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:_responseData options:0 error:&localError];
    
    if(localError!=nil) {
        NSLog(@"Error parsing JSON Object");
    }
    
    BLTNames * person = [[BLTNames alloc] init];
    for (NSString * key in parsedObject)  {
        if([person respondsToSelector:NSSelectorFromString(key) ])
            [person setValue:[parsedObject valueForKey:key] forKey:key];
        
        
    }
    
    _firstName.text = person.first;
    _lastName.text = person.last;
    

    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    NSLog(@"fail! with error");

    // Check the error var
}






#pragma mark  Viewcontroller section


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ClickRefresh:(id)sender {
    // On touching refresh
    NSLog(@"Touched up");
    
    NSLog(  [NSString stringWithFormat:@"%@ %@", @"First: ",_firstName.text]);
    NSLog(  [NSString stringWithFormat:@"%@ %@", @"Last: ", _lastName.text]);
    
    
    
    NSString *num = _idNumber.text;
    int i = [num intValue];
    
    
    NSString *webService = [NSString stringWithFormat:@"%@/%@.json", @"http://hr-gettable.herokuapp.com/names", _idNumber.text];
    NSLog( webService);
    NSURL *url = [[NSURL alloc] initWithString:webService];
    //NSLog(@"%@", webService);
    
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:url] delegate:self];
    
    
    
    /*
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            NSLog(@"Failed");
          //  [self.delegate fetchingGroupsFailedWithError:error];
        } else {
            NSLog(@"Success");
            NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
            
            NSError *localError=nil;
            NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
            
            if(localError!=nil) {
                NSLog(@"Error parsing JSON Object");
            }
            
            BLTNames * person = [[BLTNames alloc] init];
            for (NSString * key in parsedObject)  {
                if([person respondsToSelector:NSSelectorFromString(key) ])
                    [person setValue:[parsedObject valueForKey:key] forKey:key];
                
               
            }
            
            NSLog(person.first);
            NSLog(person.last );
                        
            _firstName.text = person.first;
            _lastName.text = person.last;
            
            [_firstName setNeedsLayout];
            [self.view setNeedsDisplay];
            [self.view setNeedsLayout];
//            _firstName.
   
            //[self setne
            
         //   [self performselector:@selector() withObject:nil afterDelay:0];
      
        }
    }];*/
    
    _firstName.text = @"hello";
    [self.view setNeedsLayout];
    [self.view setNeedsDisplay];
    [_firstName setNeedsDisplay];
    [_lastName setNeedsDisplay];
    
}




/*
 
 
 - (IBAction)ClickRefresh:(id)sender {
 // On touching refresh
 NSLog(@"Touched up");
 
 NSLog(  [NSString stringWithFormat:@"%@ %@", @"First: ",_firstName.text]);
 NSLog(  [NSString stringWithFormat:@"%@ %@", @"Last: ", _lastName.text]);
 
 
 
 NSString *num = _idNumber.text;
 int i = [num intValue];
 
 
 NSString *webService = [NSString stringWithFormat:@"%@/%@.json", @"http://hr-gettable.herokuapp.com/names", _idNumber.text];
 NSLog( webService);
 NSURL *url = [[NSURL alloc] initWithString:webService];
 //NSLog(@"%@", webService);
 
 [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
 
 if (error) {
 NSLog(@"Failed");
 //  [self.delegate fetchingGroupsFailedWithError:error];
 } else {
 NSLog(@"Success");
 NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
 
 NSError *localError=nil;
 NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
 
 if(localError!=nil) {
 NSLog(@"Error parsing JSON Object");
 }
 
 BLTNames * person = [[BLTNames alloc] init];
 for (NSString * key in parsedObject)  {
 if([person respondsToSelector:NSSelectorFromString(key) ])
 [person setValue:[parsedObject valueForKey:key] forKey:key];
 
 
 }
 
 NSLog(person.first);
 NSLog(person.last );
 
 _firstName.text = person.first;
 _lastName.text = person.last;
 
 [_firstName setNeedsLayout];
 [self.view setNeedsDisplay];
 [self.view setNeedsLayout];
 //            _firstName.
 
 //[self setne
 
 //   [self performselector:@selector() withObject:nil afterDelay:0];
 
 }
 }];
 
 _firstName.text = @"hello";
 [self.view setNeedsLayout];
 [self.view setNeedsDisplay];
 [_firstName setNeedsDisplay];
 [_lastName setNeedsDisplay];
 
 }
*/
@end
