
//  SelectedEmailFromContact.m
//  Tracmojo
//
//  Created by macmini3 on 13/04/15.
//  Copyright (c) 2015 peerbits. All rights reserved.
//

#import "SelectedEmailFromContact.h"
#import <AddressBook/AddressBook.h>


@interface SelectedEmailFromContact ()
{
    NSMutableArray *filter_name;
    NSMutableArray *uniquearray;
    
}
@end

@implementation SelectedEmailFromContact

- (void)viewDidLoad {
    
    DELEGATE.isnavigateBack = true;
    filter_name=[[NSMutableArray alloc] init];
    tempArray=[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    if (DELEGATE.isgroup)
    {
        if (DELEGATE.ischkFollowers)
        { DELEGATE.contact_participants=[[NSMutableArray alloc] init];
            [tempArray addObjectsFromArray:DELEGATE.p_emailArray];
        }
        else
        {
            
         
            tempArray=[[NSMutableArray alloc] init];
            DELEGATE.contact_followers=[[NSMutableArray alloc] init];

            [tempArray addObjectsFromArray:DELEGATE.f_emailArray];
                   }
    }
    else
    {
        
        
        uniquearray=[[NSMutableArray alloc]init];
        
        [tempArray addObjectsFromArray:DELEGATE.p_emailArray];
    }
    isSearching=NO;
     [self addressBookValidation];
}

#pragma Tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (isSearching) {
        return [filter_name count];
        //return [filteredContentList count];
    }
    else {
        if (DELEGATE.isgroup) {
            if (DELEGATE.ischkFollowers) {
                return [DELEGATE.contact_participants count];
            }
            else
            {
                return [DELEGATE.contact_followers count];
            }
        }
        else
        {
            
         
//            
// 
//            for (int j=0; j<[DELEGATE.contact_participants count]; j++) {
//                
//                for (int g=j+1; g<[DELEGATE.contact_participants count]; g++) {
//                    
//                    
//                    //NSLog(@"%@",[[DELEGATE.contact_participants objectAtIndex:j] valueForKey:@"email"]);
//                    
//                    
//                    //NSLog(@"%@",[[DELEGATE.contact_participants objectAtIndex:g] valueForKey:@"email"]);
//                    
//                    
//                    if ([[[DELEGATE.contact_participants objectAtIndex:j] valueForKey:@"email"]isEqualToString:[[DELEGATE.contact_participants objectAtIndex:g] valueForKey:@"email"] ]) {
//                        
//                        if ([[[DELEGATE.contact_participants objectAtIndex:j] valueForKey:@"isChecked"]isEqualToString:@"Y"]) {
//                            [uniquearray addObject:[DELEGATE.contact_participants objectAtIndex:j]];
//                            
//                        }
//                        else{
//                            [uniquearray addObject:[DELEGATE.contact_participants objectAtIndex:g]];
//                            
//                        }
//                        
//                        
//                    }
//                }
//                
//                
//            }
//            
//           
//            if ([uniquearray count]>0) {
//                   DELEGATE.contact_participants=[[NSMutableArray alloc]initWithArray:uniquearray];
//            }
//            
//            else{
//                
//            }
//            
//         
            
            return [DELEGATE.contact_participants count];
        }
        
        //  return [contentList count];
    }
    
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier =  @"id1";
    UITableViewCell *cell =  [tableEmail dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    if (isSearching)
    {
        if ([[[filter_name objectAtIndex:indexPath.row] valueForKey:@"isChecked"]isEqualToString:@"Y"])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        
//        NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[filter_name objectAtIndex:indexPath.row]] mutableCopy];
//        for (int k=0; k<[tempArray count]; k++) {
//            
//            if ([[[tempArray objectAtIndex:k]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email"]]])
//            {
//                cell.accessoryType = UITableViewCellAccessoryCheckmark;
//            }
//        }
//        
        //    cell.textLabel.lineBreakMode = UILineBreakMod;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
        cell.textLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:15.0];
        
        
        cell.textLabel.text=[NSString stringWithFormat:@"%@",[[filter_name objectAtIndex:indexPath.row] valueForKey:@"name"]];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0];
        cell.detailTextLabel.textColor=[UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1.0];
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[[filter_name objectAtIndex:indexPath.row] valueForKey:@"email"]];
        
    }
    else
    {
        
        if (DELEGATE.isgroup)
        {
            if (DELEGATE.ischkFollowers)
            {
                if ([DELEGATE.contact_participants count]>0) {
                      
                if ([[[DELEGATE.contact_participants objectAtIndex:indexPath.row] valueForKey:@"isChecked"]isEqualToString:@"Y"])
                {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                else
                {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                cell.textLabel.text=[NSString stringWithFormat:@"%@",[[DELEGATE.contact_participants objectAtIndex:indexPath.row] valueForKey:@"name"]];
                cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[[DELEGATE.contact_participants objectAtIndex:indexPath.row] valueForKey:@"email"]];
                }
            }
            else
            {
                
                if ([DELEGATE.contact_followers count]>0) {
                if ([[[DELEGATE.contact_followers objectAtIndex:indexPath.row] valueForKey:@"isChecked"]isEqualToString:@"Y"])
                {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                else
                {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                cell.textLabel.text=[NSString stringWithFormat:@"%@",[[DELEGATE.contact_followers objectAtIndex:indexPath.row] valueForKey:@"name"]];
                cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[[DELEGATE.contact_followers objectAtIndex:indexPath.row] valueForKey:@"email"]];
            }
            }
        }
        else
        {
            
            
//               //NSLog(@"%@",DELEGATE.contact_participants );
//            
//            for (int j=0; j<[DELEGATE.contact_participants count]; j++) {
//                
//                for (int g=j+1; g<[DELEGATE.contact_participants count]; g++) {
//                    
//                    
//                    //NSLog(@"%@",[[DELEGATE.contact_participants objectAtIndex:j] valueForKey:@"email"]);
//                    
//                    
//                    //NSLog(@"%@",[[DELEGATE.contact_participants objectAtIndex:g] valueForKey:@"email"]);
//                    
//                    
//                    if ([[[DELEGATE.contact_participants objectAtIndex:j] valueForKey:@"email"]isEqualToString:[[DELEGATE.contact_participants objectAtIndex:g] valueForKey:@"email"] ]) {
//                        
//                        
//                        
//                        if ([[[DELEGATE.contact_participants objectAtIndex:j] valueForKey:@"isChecked"]isEqualToString:@"Y"]) {
//                            [uniquearray addObject:[DELEGATE.contact_participants objectAtIndex:j]];
//
//                        }
//                        else{
//                            [uniquearray addObject:[DELEGATE.contact_participants objectAtIndex:g]];
//
//                        }
//                        
//                        
//                        
//                    }
//                }
//                
//                
//            }
//            
//            
//            if ([uniquearray count]>0) {
//                DELEGATE.contact_participants=[[NSMutableArray alloc]initWithArray:uniquearray];
//            }
//            
//            else{
//                
//            }
//            
//            

            if ([DELEGATE.contact_participants count]>0) {
                if ([[[DELEGATE.contact_participants objectAtIndex:indexPath.row] valueForKey:@"isChecked"]isEqualToString:@"Y"])
                {
                    cell.accessoryType = UITableViewCellAccessoryCheckmark;
                }
                else
                {
                    cell.accessoryType = UITableViewCellAccessoryNone;
                }
                cell.textLabel.text=[NSString stringWithFormat:@"%@",[[DELEGATE.contact_participants objectAtIndex:indexPath.row] valueForKey:@"name"]];
                cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[[DELEGATE.contact_participants objectAtIndex:indexPath.row] valueForKey:@"email"]];
            }


            }
                         cell.textLabel.numberOfLines = 0;
    cell.textLabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0];
    cell.textLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:15.0];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Roboto-Regular" size:13.0];
    cell.detailTextLabel.textColor=[UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1.0];
    
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
#pragma Searching code
    
    if (isSearching)
    {
        
        NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[filter_name objectAtIndex:indexPath.row]] mutableCopy];
        
        if ([[dictTemp valueForKey:@"isChecked"]isEqualToString:@"N"])
        {
            [dictTemp setObject:@"Y" forKey:@"isChecked"];
            [filter_name replaceObjectAtIndex:indexPath.row withObject:dictTemp];
            
            if (DELEGATE.isgroup) {
                if (DELEGATE.ischkFollowers) {
                                [tempArray addObject:[filter_name objectAtIndex:indexPath.row]];
                }
                else
                {
                                [tempArray addObject:[filter_name objectAtIndex:indexPath.row]];
                }
            }
            else
            {
                
               
                
                            [tempArray addObject:[filter_name objectAtIndex:indexPath.row]];
                
                
            }
        }
        else
        {
            [dictTemp setObject:@"N" forKey:@"isChecked"];
            [filter_name replaceObjectAtIndex:indexPath.row withObject:dictTemp];
            
            for (int k=0; k<[tempArray count]; k++) {
                
                if ([[[tempArray objectAtIndex:k]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email"]]])
                {
                    [tempArray removeObjectAtIndex:k];
                }
            }
            
        }
        [tableEmail reloadData];
        //isSearching=NO;
    }
    else
    {
    
        if (DELEGATE.isgroup)
        {
            
            if (DELEGATE.ischkFollowers)
            {
                NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[DELEGATE.contact_participants objectAtIndex:indexPath.row]] mutableCopy];
                
                if ([[dictTemp valueForKey:@"isChecked"]isEqualToString:@"N"])
                {
                    [dictTemp setObject:@"Y" forKey:@"isChecked"];
                    [DELEGATE.contact_participants replaceObjectAtIndex:indexPath.row withObject:dictTemp];
                    [tempArray addObject:[DELEGATE.contact_participants objectAtIndex:indexPath.row]];
                }
                else
                {
                    [dictTemp setObject:@"N" forKey:@"isChecked"];
                    [DELEGATE.contact_participants replaceObjectAtIndex:indexPath.row withObject:dictTemp];
                    
                    for (int k=0; k<[tempArray count]; k++) {
                        
                        if ([[[tempArray objectAtIndex:k]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email"]]])
                        {
                            [tempArray removeObjectAtIndex:k];
                        }
                    }
                    
                }
            }
            else
            {
                NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[DELEGATE.contact_followers objectAtIndex:indexPath.row]] mutableCopy];
                
                if ([[dictTemp valueForKey:@"isChecked"]isEqualToString:@"N"])
                {
                    [dictTemp setObject:@"Y" forKey:@"isChecked"];
                    [DELEGATE.contact_followers replaceObjectAtIndex:indexPath.row withObject:dictTemp];
                    [tempArray addObject:[DELEGATE.contact_followers objectAtIndex:indexPath.row]];
                }
                else
                {
                    [dictTemp setObject:@"N" forKey:@"isChecked"];
                    [DELEGATE.contact_followers replaceObjectAtIndex:indexPath.row withObject:dictTemp];
                    
                    for (int k=0; k<[tempArray count]; k++) {
                        
                        if ([[[tempArray objectAtIndex:k]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email"]]])
                        {
                            [tempArray removeObjectAtIndex:k];
                        }
                    }
                    
                }

            }
        }
        else
        {
            NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[DELEGATE.contact_participants objectAtIndex:indexPath.row]] mutableCopy];
            
            if ([[dictTemp valueForKey:@"isChecked"]isEqualToString:@"N"])
            {
                [dictTemp setObject:@"Y" forKey:@"isChecked"];
                [DELEGATE.contact_participants replaceObjectAtIndex:indexPath.row withObject:dictTemp];
                [tempArray addObject:[DELEGATE.contact_participants objectAtIndex:indexPath.row]];
            }
            else
            {
                [dictTemp setObject:@"N" forKey:@"isChecked"];
                [DELEGATE.contact_participants replaceObjectAtIndex:indexPath.row withObject:dictTemp];
                
                for (int k=0; k<[tempArray count]; k++) {
                    
                    if ([[[tempArray objectAtIndex:k]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email"]]])
                    {
                        [tempArray removeObjectAtIndex:k];
                    }
                }
                
            }

        }
        
        
      
        
        [tableEmail reloadData];
    }
    [search resignFirstResponder];
}


-(IBAction)touch_done:(id)sender
{
    
    if (DELEGATE.isgroup)
    {
        
          DELEGATE.done=NO;
        if (DELEGATE.ischkFollowers)
        {
            DELEGATE.p_emailArray=[[NSMutableArray alloc] init];
            [DELEGATE.p_emailArray addObjectsFromArray:tempArray];
            for (int g=0; g<[DELEGATE.p_emailArray count]; g++) {
                 for (int k=0; k<[DELEGATE.f_emailArray count]; k++) {
                
                if ([[[DELEGATE.p_emailArray objectAtIndex:g] valueForKey:@"email"]isEqualToString:[[DELEGATE.f_emailArray objectAtIndex:k]valueForKey:@"email"]]) {
                    
                    [DELEGATE.f_emailArray removeObjectAtIndex:k];
                    
                }
                 }
            }

        }
        else
        {

            DELEGATE.f_emailArray=[[NSMutableArray alloc] init];
            [DELEGATE.f_emailArray addObjectsFromArray:tempArray];
        }
        
        
    }
    else
    {
          DELEGATE.done=YES;
         DELEGATE.p_emailArray=[[NSMutableArray alloc] init];
        [DELEGATE.p_emailArray addObjectsFromArray:tempArray];
    }
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)touch_back:(id)sender
{
    if (DELEGATE.isgroup)
    {
        
        DELEGATE.done=NO;
        if (DELEGATE.ischkFollowers)
        {
            [DELEGATE.p_emailArray removeAllObjects];
            DELEGATE.p_emailArray=[[NSMutableArray alloc] init];
            
             [DELEGATE.p_emailArray addObjectsFromArray:tempArray];
            
            
            for (int g=0; g<[DELEGATE.p_emailArray count]; g++) {
                for (int k=0; k<[DELEGATE.f_emailArray count]; k++) {
                    
                    if ([[[DELEGATE.p_emailArray objectAtIndex:g] valueForKey:@"email"]isEqualToString:[[DELEGATE.f_emailArray objectAtIndex:k]valueForKey:@"email"]]) {
                        
                        [DELEGATE.f_emailArray removeObjectAtIndex:k];
                        
                        
                    }
                }
            }
            

            
           
           
        }
        else
        {
            [DELEGATE.f_emailArray removeAllObjects];
            DELEGATE.f_emailArray=[[NSMutableArray alloc] init];
            [DELEGATE.f_emailArray addObjectsFromArray:tempArray];
        }
        
        
    }
    else
    {
        
        
        DELEGATE.done=YES;
        
     //   DELEGATE.contact_participants=nil;
        [DELEGATE.p_emailArray removeAllObjects];
        DELEGATE.p_emailArray=[[NSMutableArray alloc] init];
        [DELEGATE.p_emailArray addObjectsFromArray:tempArray];
    }
    

     [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
   // [filter_name removeAllObjects];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  
    
    //Remove all objects first.
   

    
    if([searchText length] != 0)
    {
         [filter_name removeAllObjects];
        isSearching = YES;
        [self searchTableList];
        [self sortContactArray];
        
        ///
        
        
        
        
        
        
        
        ///
        [tableEmail reloadData];
    }
    else
    {
        
        
           if (DELEGATE.ischkFollowers)
           {
        
        for(int i=0;i<[filter_name count];i++)
        {
            for(int j=0;j<[DELEGATE.contact_participants count];j++)
            {
                if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[DELEGATE.contact_participants  objectAtIndex:j]valueForKey:@"email"]]) {
                    
                    
                    
                    [DELEGATE.contact_participants replaceObjectAtIndex:j withObject:[filter_name objectAtIndex:i]];
                    
                }
                
                
                
                
            }
        }
        
           }
           else{
               
               for(int i=0;i<[filter_name count];i++)
               {
                   for(int j=0;j<[DELEGATE.contact_followers count];j++)
                   {
                       if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[DELEGATE.contact_followers  objectAtIndex:j]valueForKey:@"email"]]) {
                           
                           
                           
                           [DELEGATE.contact_followers replaceObjectAtIndex:j withObject:[filter_name objectAtIndex:i]];
                           
                       }
                       
                       
                       
                       
                   }
               }
               
           }
        
       [filter_name removeAllObjects];
        isSearching = NO;
        [tableEmail reloadData];
        [search resignFirstResponder];
        
    }
  //  [tableEmail reloadData];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [search resignFirstResponder];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    
    for (int i=0; i<[filter_name count]; i++) {
        
        for (int j=i+1; j<[filter_name count]; j++) {
            
            if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                
                
                [filter_name removeObjectAtIndex:j];
                
                
            }
            
        }
        
    }
    
    

    [search resignFirstResponder];
    [tableEmail reloadData];
    [self searchTableList];
}

- (void)searchTableList {
    NSString *searchString = search.text;
    
    if (DELEGATE.isgroup) {
        if (DELEGATE.ischkFollowers)
        {
            for (int i=0; i<[DELEGATE.contact_participants count]; i++)
            {
                if ([[[DELEGATE.contact_participants objectAtIndex:i] objectForKey:@"name"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound) {
                    // "a" IS in myString
                    [filter_name addObject:[DELEGATE.contact_participants objectAtIndex:i] ];
               
                    
                    for (int i=0; i<[filter_name count]; i++) {
                        
                        for (int j=i+1; j<[filter_name count]; j++) {
                            
                            if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                                
                                
                                [filter_name removeObjectAtIndex:j];
                                
                                
                            }
                            
                        }
                        
                    }
                    
                    
                    [tableEmail reloadData];
                }
            }
        }
        else
        {
            for (int i=0; i<[DELEGATE.contact_followers count]; i++)
            {
                if ([[[DELEGATE.contact_followers objectAtIndex:i] objectForKey:@"name"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound) {
                    // "a" IS in myString
                    [filter_name addObject:[DELEGATE.contact_followers objectAtIndex:i] ];
              
                    for (int i=0; i<[filter_name count]; i++) {
                        
                        for (int j=i+1; j<[filter_name count]; j++) {
                            
                            if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                                
                                
                                [filter_name removeObjectAtIndex:j];
                                
                                
                            }
                            
                        }
                        
                    }
                    
                    [tableEmail reloadData];
                  
                }
            }
        }
    }
    else
    {
        for (int i=0; i<[DELEGATE.contact_participants count]; i++)
        {
            if ([[[DELEGATE.contact_participants objectAtIndex:i] objectForKey:@"name"] rangeOfString:searchString options:NSCaseInsensitiveSearch].location != NSNotFound) {
                // "a" IS in myString
                [filter_name addObject:[DELEGATE.contact_participants objectAtIndex:i] ];
             
                for (int i=0; i<[filter_name count]; i++) {
                    
                    for (int j=i+1; j<[filter_name count]; j++) {
                        
                        if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                            
                            
                            [filter_name removeObjectAtIndex:j];
                            
                            
                        }
                        
                    }
                    
                }
                
                [tableEmail reloadData];
               
            }
        }
        for (int i=0; i<[filter_name count]; i++) {
            
            for (int j=i+1; j<[filter_name count]; j++) {
                
                if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                    
                    
                    [filter_name removeObjectAtIndex:j];
                    
                    
                }
                
            }
            
        }
        
        [tableEmail reloadData];
    }
}





-(void)addressBookValidation
{
    NSUserDefaults *prefs=[NSUserDefaults standardUserDefaults];
    // ABAddressBookRef addressbook = ABAddressBookCreate();
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(addressBook,
                                             ^(bool granted, CFErrorRef error){
                                                 dispatch_semaphore_signal(sema);
                                             });
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    __block BOOL accessGranted = NO;
    
    if (ABAddressBookRequestAccessWithCompletion != NULL)
    {
        if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined)
        {
            dispatch_semaphore_t sema = dispatch_semaphore_create(0);
            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error)
                                                     {
                                                         accessGranted = granted;
                                                         dispatch_semaphore_signal(sema);
                                                     });
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
            
        }
        else if(ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized)
        {
         
            accessGranted = YES;
        }
        else if (ABAddressBookGetAuthorizationStatus()==kABAuthorizationStatusDenied)
        {
          
            accessGranted = NO;
        }
        else if (ABAddressBookGetAuthorizationStatus()==kABAuthorizationStatusRestricted){
            
            
            accessGranted = NO;
        }
        else
        {
           
            accessGranted = YES;
        }
        
        
    }
    else
    {
      
        accessGranted = YES;
    }
    [prefs setBool:accessGranted forKey:@"addressBook"];
    
    if (accessGranted) {
        [self SyncContactData];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please allow permission from privacy setting to display contact list" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
    }
    

    [prefs synchronize];
    //    CFRelease(addressbook);
}
- (void) SyncContactData
{
    // ABAddressBookRef addressBook = ABAddressBookCreate();
    
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    ABAddressBookRequestAccessWithCompletion(addressBook,
                                             ^(bool granted, CFErrorRef error){
                                                 dispatch_semaphore_signal(sema);
                                             });
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBook);
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBook);
    CFTypeRef multival;

    

    
    for( int i = 0 ; i < nPeople ; i++ )
    {
        dicContact = [[NSMutableDictionary alloc] init];
        
        ABRecordRef ref = CFArrayGetValueAtIndex(allPeople, i );
        
        
        
        if(ABRecordCopyValue(ref, kABPersonFirstNameProperty) != nil || [[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonFirstNameProperty)] length] == 0)
        {
            [dicContact setValue:[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonFirstNameProperty)] forKey:@"firstname"];
        }else{
            [dicContact setValue:@"" forKey:@"firstname"];
        }
        
        if(ABRecordCopyValue(ref, kABPersonLastNameProperty) != nil || [[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonLastNameProperty)] length] == 0)
        {
            [dicContact setValue:[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonLastNameProperty)] forKey:@"lastname"];
        }
        else
        {
            [dicContact setValue:@"" forKey:@"lastname"];
        }
        
        if(ABRecordCopyValue(ref, kABPersonOrganizationProperty) != nil || [[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonOrganizationProperty)] length] == 0)
        {
//            [dicContact setValue:[NSString stringWithFormat:@"%@",ABRecordCopyValue(ref, kABPersonOrganizationProperty)] forKey:@"name"];
            
            [dicContact setValue:[NSString stringWithFormat:@"%@ %@",[dicContact valueForKey:@"firstname"],[dicContact valueForKey:@"lastname"]] forKey:@"name"];

        }
        else{
            [dicContact setValue:[NSString stringWithFormat:@"%@ %@",[dicContact valueForKey:@"firstname"],[dicContact valueForKey:@"lastname"]] forKey:@"name"];
        }
        

        multival = ABRecordCopyValue(ref, kABPersonPhoneProperty);
        NSArray *arrayPhone = (__bridge  NSArray *)ABMultiValueCopyArrayOfAllValues(multival);
        if([arrayPhone count] > 0)
            [dicContact setValue:[arrayPhone objectAtIndex:0] forKey:@"telephone"];
        else
            [dicContact setValue:@"" forKey:@"telephone"];
  
        multival = ABRecordCopyValue(ref, kABPersonEmailProperty);
        NSArray *arrayEmail = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(multival);
        if([arrayEmail count])//1
        {
            
            
            for (int i=0; i<[arrayEmail count]; i++) {
                
                
                if ([arrayEmail count]>1) {
                    
                    NSMutableDictionary *tmp=[[NSMutableDictionary alloc]initWithDictionary:dicContact];
                    
                    [tmp setValue:[arrayEmail objectAtIndex:i] forKey:@"email"];//doubt

                    dicContact=[[NSMutableDictionary alloc]initWithDictionary:tmp];
                    
                    
                }
                else {
                     [dicContact setValue:[arrayEmail objectAtIndex:i] forKey:@"email"];
                }
                
                
                
             
                if (DELEGATE.isgroup)
                {
                    if (DELEGATE.ischkFollowers)
                    {
                        if (DELEGATE.contact_participants==nil) {//2
                            //NSLog(@"if");
                            
                            DELEGATE.contact_participants=[[NSMutableArray alloc]initWithObjects:dicContact, nil];
                        }else{
                            //NSLog(@"else");
                            
                            [DELEGATE.contact_participants addObject:dicContact];
                            
                        }
                    }
                    else
                    {
                        
                        
                        
                     
            
                        //krish solanki
                        
                        if (DELEGATE.contact_followers==nil)
                        {
                            DELEGATE.contact_followers=[[NSMutableArray alloc]initWithObjects:dicContact, nil];
                        }
                        else
                        {
                            [DELEGATE.contact_followers addObject:dicContact];
                        }
                        
            
                        
                    }
                }
                else
                {
                    
                   

                    if (DELEGATE.contact_participants==nil)
                    {
                        DELEGATE.contact_participants=[[NSMutableArray alloc]initWithObjects:dicContact, nil];
                    }
                    else
                    {
                        
                       
                        [DELEGATE.contact_participants addObject:dicContact];
                              //NSLog(@"%@",DELEGATE.contact_participants);
                    }
                }
              
                
                //   if(arrayEmail.count==1)
                
                
            }
            dicContact =nil;
            
            
 
                   }

        
    }
    
    
    if (DELEGATE.isgroup) {
        if (DELEGATE.ischkFollowers)
        {
            for (int i=0; i<DELEGATE.contact_participants.count; i++)
            {
                NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[DELEGATE.contact_participants objectAtIndex:i]] mutableCopy];
                
                [dictTemp setObject:@"N" forKey:@"isChecked"];
                
                [DELEGATE.contact_participants replaceObjectAtIndex:i withObject:dictTemp];
                for (int i=0; i<[filter_name count]; i++) {
                    
                    for (int j=i+1; j<[filter_name count]; j++) {
                        
                        if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                            
                            
                            [filter_name removeObjectAtIndex:j];
                            
                            
                        }
                        
                    }
                    
                }
                
                [tableEmail reloadData];
            }
            
            
            for (int k=0; k<[DELEGATE.contact_participants count]; k++) {
                NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[DELEGATE.contact_participants objectAtIndex:k]] mutableCopy];
                
                for (int i=0; i<[tempArray count]; i++)
                {
                    if ([[[tempArray objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email"]]])
                    {
                        [dictTemp setObject:@"Y" forKey:@"isChecked"];
                        [DELEGATE.contact_participants replaceObjectAtIndex:k withObject:dictTemp];
                        for (int i=0; i<[filter_name count]; i++) {
                            
                            for (int j=i+1; j<[filter_name count]; j++) {
                                
                                if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                                    
                                    
                                    [filter_name removeObjectAtIndex:j];
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                                        [tableEmail reloadData];
                    }
                }
            }
    
        }
        else
        {
            for (int i=0; i<DELEGATE.contact_followers.count; i++)
            {
                NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[DELEGATE.contact_followers objectAtIndex:i]] mutableCopy];
                
                [dictTemp setObject:@"N" forKey:@"isChecked"];
                
                [DELEGATE.contact_followers replaceObjectAtIndex:i withObject:dictTemp];
                for (int i=0; i<[filter_name count]; i++) {
                    
                    for (int j=i+1; j<[filter_name count]; j++) {
                        
                        if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                            
                            
                            [filter_name removeObjectAtIndex:j];
                            
                            
                        }
                        
                    }
                    
                }
                
                                [tableEmail reloadData];
            }
            
            
            for (int k=0; k<[DELEGATE.contact_followers count]; k++) {
                NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[DELEGATE.contact_followers objectAtIndex:k]] mutableCopy];
                
                for (int i=0; i<[tempArray count]; i++)
                {
                    if ([[[tempArray objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email"]]])
                    {
                        [dictTemp setObject:@"Y" forKey:@"isChecked"];
                        [DELEGATE.contact_followers replaceObjectAtIndex:k withObject:dictTemp];
                        for (int i=0; i<[filter_name count]; i++) {
                            
                            for (int j=i+1; j<[filter_name count]; j++) {
                                
                                if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                                    
                                    
                                    [filter_name removeObjectAtIndex:j];
                                    
                                    
                                }
                                
                            }
                            
                        }
                        
                                        [tableEmail reloadData];
                    }
                }
            }

        }
    }
    else
    {
        for (int i=0; i<DELEGATE.contact_participants.count; i++)
        {
            NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[DELEGATE.contact_participants objectAtIndex:i]] mutableCopy];
            
            [dictTemp setObject:@"N" forKey:@"isChecked"];
            
            [DELEGATE.contact_participants replaceObjectAtIndex:i withObject:dictTemp];
            for (int i=0; i<[filter_name count]; i++) {
                
                for (int j=i+1; j<[filter_name count]; j++) {
                    
                    if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                        
                        
                        [filter_name removeObjectAtIndex:j];
                        
                        
                    }
                    
                }
                
            }
            
            
            
            
            if (DELEGATE.isFromReview) {
                
                
                
            }
            
            
            
                            [tableEmail reloadData];
            
        }
        
        
        for (int k=0; k<[DELEGATE.contact_participants count]; k++) {
            NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[DELEGATE.contact_participants objectAtIndex:k]] mutableCopy];
            
            for (int i=0; i<[tempArray count]; i++)
            {
                if ([[[tempArray objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email"]]])
                {
                    [dictTemp setObject:@"Y" forKey:@"isChecked"];
                    [DELEGATE.contact_participants replaceObjectAtIndex:k withObject:dictTemp];
                    for (int i=0; i<[filter_name count]; i++) {
                        
                        for (int j=i+1; j<[filter_name count]; j++) {
                            
                            if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                                
                                
                                [filter_name removeObjectAtIndex:j];
                                
                                
                            }
                            
                        }
                        
                    }
                    
                                    [tableEmail reloadData];
                }
            }
        }

    }
    
    

    if (DELEGATE.isEdit)
    {
        

        
        if (DELEGATE.isgroup)
        {
            if (DELEGATE.ischkFollowers)
            {
                for (int k=0; k<[[DELEGATE.dic_edittrac  objectForKey:@"Participants"]count]; k++)
                {
                    NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[[DELEGATE.dic_edittrac  objectForKey:@"Participants"] objectAtIndex:k]] mutableCopy];
                    
                    if (DELEGATE.isgroup)
                    {
                        if (DELEGATE.ischkFollowers)
                        {
                            for (int i=0; i<[DELEGATE.contact_participants count]; i++)
                            {
                                if ([[[DELEGATE.contact_participants objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email_id"]]])
                                {
                                    [DELEGATE.contact_participants removeObjectAtIndex:i];
                                    
                                }
                            }
                            
                        }
                        else
                        {
                          
                            for (int i=0; i<[DELEGATE.contact_followers count]; i++)
                            {
                                if ([[[DELEGATE.contact_followers objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email_id"]]])
                                {
                                    [DELEGATE.contact_followers removeObjectAtIndex:i];
                                    
                                }
                            }
                            
                        }
                    }
                    else
                    {
                        for (int i=0; i<[DELEGATE.contact_participants count]; i++)
                        {
                            if ([[[DELEGATE.contact_participants objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email_id"]]])
                            {
                                [DELEGATE.contact_participants removeObjectAtIndex:i];
                                
                            }
                        }
                        
                    }
                    
                }
            }
            else
            {
                for (int k=0; k<[[DELEGATE.dic_edittrac  objectForKey:@"Followers"]count]; k++)
                {
                    NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[[DELEGATE.dic_edittrac  objectForKey:@"Followers"] objectAtIndex:k]] mutableCopy];
                    
                    if (DELEGATE.isgroup)
                    {
                        if (DELEGATE.ischkFollowers)
                        {
                            for (int i=0; i<[DELEGATE.contact_followers count]; i++)
                            {
                                if ([[[DELEGATE.contact_followers objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email_id"]]])
                                {
                                    [DELEGATE.contact_followers removeObjectAtIndex:i];
                                    
                                }
                            }
                            
                        }
                        else
                        {
                          
                            for (int i=0; i<[DELEGATE.contact_followers count]; i++)
                            {
                                if ([[[DELEGATE.contact_followers objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email_id"]]])
                                {
                                    [DELEGATE.contact_followers removeObjectAtIndex:i];
                                    
                                }
                            }
                            
                        }
                    }
                    else
                    {
                        for (int i=0; i<[DELEGATE.contact_followers count]; i++)
                        {
                            if ([[[DELEGATE.contact_followers objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email_id"]]])
                            {
                                [DELEGATE.contact_followers removeObjectAtIndex:i];
                                
                            }
                        }
                        
                    }
                    
                }
            }

        }
        else
        {
            for (int k=0; k<[[DELEGATE.dic_edittrac  objectForKey:@"Followers"]count]; k++) {
                NSMutableDictionary *dictTemp = [[[NSMutableDictionary alloc] initWithDictionary:[[DELEGATE.dic_edittrac  objectForKey:@"Followers"] objectAtIndex:k]] mutableCopy];
                
                
                if (DELEGATE.isgroup)
                {
                    if (DELEGATE.ischkFollowers)
                    {
                        for (int i=0; i<[DELEGATE.contact_participants count]; i++)
                        {
                            if ([[[DELEGATE.contact_participants objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email_id"]]])
                            {
                                [DELEGATE.contact_participants removeObjectAtIndex:i];
                                
                            }
                        }
                    }
                    else
                    {
                        for (int i=0; i<[DELEGATE.contact_followers count]; i++)
                        {
                            if ([[[DELEGATE.contact_followers objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email_id"]]])
                            {
                                [DELEGATE.contact_followers removeObjectAtIndex:i];
                                
                            }
                        }
                    }
                    
                }
                else
                {
                    for (int i=0; i<[DELEGATE.contact_participants count]; i++)
                    {
                        if ([[[DELEGATE.contact_participants objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[dictTemp objectForKey:@"email_id"]]])
                        {
                            [DELEGATE.contact_participants removeObjectAtIndex:i];
                            
                        }
                    }
                }
            }
        }
        
        

    }
    else
    {
        
        if (DELEGATE.isgroup)
        {
            if (DELEGATE.ischkFollowers) {
                
            }
            else
            {
                for (int k=0; k<[DELEGATE.p_emailArray count]; k++)
                {
                 
                    for (int l=0; l<[DELEGATE.contact_followers count]; l++) {

                        if ([[[DELEGATE.p_emailArray objectAtIndex:k] objectForKey:@"email"] isEqualToString:[[DELEGATE.contact_followers objectAtIndex:l] objectForKey:@"email"]])
                        {
                            [DELEGATE.contact_followers removeObjectAtIndex:l];
                        }
                        
                    }
                }
            }
        }
    }
   
    if (DELEGATE.isgroup)
    {
        if (DELEGATE.ischkFollowers)
        {
            for (int i=0; i<[DELEGATE.contact_participants count]; i++)
            {
                if ([[[DELEGATE.contact_participants objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userEmail"]]])
                {
                    [DELEGATE.contact_participants removeObjectAtIndex:i];
                    
                }
            }
        }
        else
        {
            for (int i=0; i<[DELEGATE.contact_followers count]; i++)
            {
                if ([[[DELEGATE.contact_followers objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userEmail"]]])
                {
                    [DELEGATE.contact_followers removeObjectAtIndex:i];
                    
                }
            }
        }
    }
    else
    {
        NSLog(@"%@",DELEGATE.contact_participants);
        
        
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userEmail"]);
        
        
        for (int i=0; i<[DELEGATE.contact_participants count]; i++)
        {
            if ([[[DELEGATE.contact_participants objectAtIndex:i]valueForKey:@"email"] isEqualToString:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"userEmail"]]])
            {
                [DELEGATE.contact_participants removeObjectAtIndex:i];
                
            }
        }
    }
    
    [self sortContactArray];
    CFRelease(addressBook);
    CFRelease(allPeople);
    
}
-(void)sortContactArray
{
    
    if (isSearching) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        
        NSArray *sortedArray = [filter_name sortedArrayUsingDescriptors:sortDescriptors];
        
        [filter_name removeAllObjects];
        [filter_name addObjectsFromArray:sortedArray];
        for (int i=0; i<[filter_name count]; i++) {
            
            for (int j=i+1; j<[filter_name count]; j++) {
                
                if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                    
                    
                    [filter_name removeObjectAtIndex:j];
                    
                    
                }
                
            }
            
        }
        
        [tableEmail reloadData];
    }
    else
    {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];

        
        if (DELEGATE.isgroup) {
            if (DELEGATE.ischkFollowers)
            {
                NSArray *sortedArray = [DELEGATE.contact_participants sortedArrayUsingDescriptors:sortDescriptors];
                [DELEGATE.contact_participants removeAllObjects];
                [DELEGATE.contact_participants addObjectsFromArray:[NSMutableArray arrayWithArray:sortedArray]];
                for (int i=0; i<[filter_name count]; i++) {
                    
                    for (int j=i+1; j<[filter_name count]; j++) {
                        
                        if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                            
                            
                            [filter_name removeObjectAtIndex:j];
                            
                            
                        }
                        
                    }
                    
                }
                
                [tableEmail reloadData];
            }
            else
            {
                
                
                
              
                
                NSArray *sortedArray = [DELEGATE.contact_followers sortedArrayUsingDescriptors:sortDescriptors];
                [DELEGATE.contact_followers removeAllObjects];
                [DELEGATE.contact_followers addObjectsFromArray:[NSMutableArray arrayWithArray:sortedArray]];//1
                for (int i=0; i<[filter_name count]; i++) {
                    
                    for (int j=i+1; j<[filter_name count]; j++) {
                        
                        if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                            
                            
                            [filter_name removeObjectAtIndex:j];
                            
                            
                        }
                        
                    }
                    
                }
                
                
            
                
                for(int i=0;i<[DELEGATE.contact_followers count];i++)
                {
                    //may be
                    for(int k=0;k<[[DELEGATE.dic_edittrac  objectForKey:@"Participants"] count];k++)
                    {
                                              if ([[[DELEGATE.contact_followers objectAtIndex:i] valueForKey:@"email"]isEqualToString:[[[DELEGATE.dic_edittrac  objectForKey:@"Participants"] objectAtIndex:k]valueForKey:@"email_id"]]) {
                            
                            [DELEGATE.contact_followers removeObjectAtIndex:i];
                            
                            
                        }
                    }
                }
                
           

            
                [tableEmail reloadData];
            }
        }
        else
        {
            
            
        
            NSArray *sortedArray = [DELEGATE.contact_participants sortedArrayUsingDescriptors:sortDescriptors];
            
            
         
            
            [DELEGATE.contact_participants removeAllObjects];
            [DELEGATE.contact_participants addObjectsFromArray:[NSMutableArray arrayWithArray:sortedArray]];
            for (int i=0; i<[filter_name count]; i++) {
                
                for (int j=i+1; j<[filter_name count]; j++) {
                    
                    if ([[[filter_name objectAtIndex:i]valueForKey:@"email"]isEqualToString:[[filter_name objectAtIndex:j]valueForKey:@"email"]]) {
                        
                        
                        [filter_name removeObjectAtIndex:j];
                        
                        
                    }
                    
                }
                
            }
            
            
            //krish
            
           
            
            
            for (int i=0 ; i<[DELEGATE.contact_participants count]; i++) {
                
                for (int j=0 ; j<[[DELEGATE.dic_edittrac valueForKey:@"Participants" ] count]; j++) {
                    
                    if ([[[DELEGATE.contact_participants objectAtIndex:i] valueForKey:@"email"]isEqualToString:[[[DELEGATE.dic_edittrac valueForKey:@"Participants" ] objectAtIndex:j] valueForKey:@"email_id"]]) {
                        [DELEGATE.contact_participants removeObjectAtIndex:i];
                        
                    }
                    
                }
                
            }
            
            
            
            
            
            if (DELEGATE.isFromReview) {
                
                
                
            }
            
            
            
            [tableEmail reloadData];

        }
        
    }
    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
//    
//    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
//    
//    NSArray *sortedArray = [DELEGATE.contactArray sortedArrayUsingDescriptors:sortDescriptors];
//    
//    [DELEGATE.contactArray removeAllObjects];
//    [DELEGATE.contactArray addObjectsFromArray:[NSMutableArray arrayWithArray:sortedArray]];
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
