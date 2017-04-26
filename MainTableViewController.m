
//
//  MainTableViewController.m
//  Washingtonpost
//
//  Created by Md Asif Huda on 3/1/16.
//  Copyright © 2016 Md Asif Huda. All rights reserved.
//

#import "MainTableViewController.h"
#import "ViewController.h"

@interface MainTableViewController (){
    
    NSMutableArray *newsArray;
    NSArray *sortDateArray;
    NSArray *sortTitleArray;
    NSString *newsContent;
}

@end

@implementation MainTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
       NSURLSession *session= [NSURLSession sharedSession];
        NSString *strURL = @"http://www.washingtonpost.com/wp-srv/simulation/simulation_test.json";
            [[session dataTaskWithURL:[NSURL URLWithString:strURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!error) {
                NSHTTPURLResponse *resp = (NSHTTPURLResponse*) response;
                if (resp.statusCode ==200) {
                    NSError *errorJson;
                    //init for the dict
                    NSDictionary *dataDict = [[NSDictionary alloc] init];
                    dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson];
                    
                    if (!errorJson) {
                        newsArray  = [dataDict objectForKey:@"posts"];
                     
                        [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                    }else{
                        NSLog(@"Error");
                    }
                    
                }else{
                    NSLog(@"Error");
                }
            }else{
                NSLog(@"Error");
                
            }
            
        }]resume];
}


- (IBAction)sortByTitle:(id)sender {

    NSURLSession *session= [NSURLSession sharedSession];
    NSString *strURL = @"http://www.washingtonpost.com/wp-srv/simulation/simulation_test.json";
    [[session dataTaskWithURL:[NSURL URLWithString:strURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSHTTPURLResponse *resp = (NSHTTPURLResponse*) response;
            if (resp.statusCode ==200) {
                NSError *errorJson;
                //init for the dict
                NSDictionary *dataDict = [[NSDictionary alloc] init];
                dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson];
                
                if (!errorJson) {
                    newsArray  = [dataDict objectForKey:@"posts"];
                    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
                  sortTitleArray = [[dataDict objectForKey:@"posts"] sortedArrayUsingDescriptors:@[sorter]];
                    [newsArray setArray:sortTitleArray];
                    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                }else{
                    //alert
                }
                
            }else{
                //alert
            }
        }else{
            //alert
            
        }
        
    }]resume];

//    for (NSDictionary *diction in newsArray){
//        NSString *titles = [diction objectForKey:@"title"];
//        NSString *dates = [diction objectForKey:@"date"];
//        [newsArray addObject:titles];
//        [newsArray addObject:dates];
//    }
//    NSArray *sortedArray;
//    sortedArray = [newsArray sortedArrayUsingComparator:^NSComparisonResult(NSString *title1, NSString *title2)
//                   {
//                       if ([title1 compare:title2] > 0)
//                           return NSOrderedAscending;
//                       else
//                           return NSOrderedDescending;
//                   }];
//    [newsArray setArray:sortedArray];
    
//    [self.tableView reloadData];
//    NSDictionary *dataDict = [[NSDictionary alloc] init];
//    newsArray  = [dataDict objectForKey:@"posts"];
//    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"id" ascending:NO];
////    newsArray = [[dataDict objectForKey:@"posts"] sortedArrayUsingDescriptors:@[sorter]];
//    [newsArray setArray:<#(nonnull NSArray *)#>]
//    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
    
}
- (IBAction)sortByDate:(id)sender {
    
    NSURLSession *session= [NSURLSession sharedSession];
    NSString *strURL = @"http://www.washingtonpost.com/wp-srv/simulation/simulation_test.json";
    [[session dataTaskWithURL:[NSURL URLWithString:strURL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            NSHTTPURLResponse *resp = (NSHTTPURLResponse*) response;
            if (resp.statusCode ==200) {
                NSError *errorJson;
                //init for the dict
                NSDictionary *dataDict = [[NSDictionary alloc] init];
                dataDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&errorJson];
                
                if (!errorJson) {
                    newsArray  = [dataDict objectForKey:@"posts"];
                    NSSortDescriptor *sorter = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
                    sortDateArray = [[dataDict objectForKey:@"posts"] sortedArrayUsingDescriptors:@[sorter]];
                    [newsArray setArray:sortDateArray];
                    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                }else{
                    //alert
                }
                
            }else{
                //alert
            }
        }else{
            //alert
            
        }
        
    }]resume];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return newsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"newsCell" forIndexPath:indexPath];
    cell.textLabel.text =  [[newsArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.detailTextLabel.text = [[newsArray objectAtIndex:indexPath.row] objectForKey:@"date"];
    
    // Configure the cell...
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    newsContent = [[newsArray objectAtIndex:indexPath.row] objectForKey:@"content"];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ViewController *svc = [segue destinationViewController];
    NSIndexPath *idPath = [self.tableView indexPathForSelectedRow];
    svc.content = [[newsArray objectAtIndex:idPath.row] objectForKey:@"content"];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
