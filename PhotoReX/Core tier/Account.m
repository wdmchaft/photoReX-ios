//
//  Account.m
//  rlimage
//
//  Created by Ali Nouri on 7/2/11.
//  Copyright 2011 Rutgers. All rights reserved.
//

#import "Account.h"
#import "RLWebserviceClient.h" 

@implementation Account
@synthesize userIconImage=_userIconImage; 
@synthesize username=_username; 

-(void) loadSettings
{
    //---------- read user defaults for the frobKey
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults]; 
    NSDictionary* account = [ud valueForKey:self.accountName]; 
    
    if (!account) 
        return; 
    
    NSData* iconData =  [account objectForKey:@"userIconImage"]; 
    if (iconData)
        _userIconImage = [[UIImage imageWithData:iconData] retain];     

    
    _username = [[account objectForKey:@"username"] copy]; 
}

-(void) saveSettings
{
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults]; 
    NSDictionary* prevSettings = [ud valueForKey:self.accountName]; 
    NSMutableDictionary* account = [NSMutableDictionary dictionaryWithDictionary:prevSettings]; 
    
    
    NSData *dataObj = UIImageJPEGRepresentation(self.userIconImage, 1.0);
    [account setValue:dataObj forKey:@"userIconImage"]; 
    
    [account setValue:self.username forKey:@"username"]; 
    
    [ud setValue:account forKey:self.accountName]; 
    
    [self broadcastChange]; 
}


-(UIImage*) logoImage
{
    if (_logoImage != nil)
        return _logoImage; 
        
    
    //first time use, create it: 
    NSString* path = [NSString stringWithFormat:@"%@TableCell", self.accountName ]; 
    _logoImage = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:path ofType:@"png"]]; 
    
    return _logoImage; 
}

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


-(void) didReceiveMemoryWarning
{
    _logoImage = nil;       //we can lazily recreate this later! 
}


-(NSString*) accountName
{
    return @"No Account"; 
}

-(NSDictionary*) dictionaryRepresentation
{
    return nil; 
}

-(void) deactivate
{
    //tell the website 
    [[RLWebserviceClient standardClient] deregsiterAccountAsync:[self dictionaryRepresentation]]; 
    
    self.username = nil; 
    self.userIconImage = nil; 
    [self saveSettings]; 
}

-(void) activate
{
    //tell the website
    [[RLWebserviceClient standardClient] registerAccountAsync:[self dictionaryRepresentation]]; 
}

-(void) broadcastChange
{
    //publish this to the notification center 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AccountDetailsDidChange" object:self]; 
}


-(BOOL) isActive
{
    return NO; 
}

-(void) dealloc
{
    self.username = nil; 
    self.userIconImage = nil; 
    
    [super dealloc]; 
}


@end



@implementation InstagramAccount


-(NSString*) accountName
{
    return @"instagram"; 
}


-(BOOL) isActive
{
    return NO; 
}



@end





