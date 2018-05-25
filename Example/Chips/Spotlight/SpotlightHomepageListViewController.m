//
//  SpotlightHomepageListViewController.m
//  Chips_Example
//
//  Created by Fajar on 1/28/18.
//  Copyright © 2018 fajaraw. All rights reserved.
//

#import "SpotlightHomepageListViewController.h"
#import "SpotlightSupport.h"
#import <Cips/Cips.h>

@interface SpotlightHomepageListViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation SpotlightHomepageListViewController

NSArray *data;

- (void)viewDidLoad {
    [super viewDidLoad];
    data = @[];
    [_tableView reloadData];
    Spotlight *instance = [Spotlight instance];
    switch (_type) {
        case 0:
        {
            [instance spotlightHomepageHeadlineWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
                [self responSpotligh:response];
            }];
            break;
        }
        case 1:
        {
            [instance spotlightHomepageStoryWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
                [self responSpotligh:response];
            }];
            break;
        }
        case 2:
        {
            [instance spotlightHomepageEditorChoiceWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
                [self responSpotligh:response];
            }];
            break;
        }
        case 3:
        {
            [instance spotlightHomepageNewsboostWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
                [self responSpotligh:response];
            }];
            break;
        }
        case 4:
        {
            [instance spotlightHomepageCommercialWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
                [self responSpotligh:response];
            }];
            break;
        }
        case 5:
        {
            [instance spotlightHomepageBoxTypeWithChannel:_channel onComplete:^(SpotlightResponseModel *response) {
                [self responSpotligh:response];
            }];
        }
        default:
            break;
    }
}

-(void)responSpotligh:(SpotlightResponseModel *)respon{
    if([respon.status isEqualToString:@"200"]){
//        if([respon.data isKindOfClass:[NSArray class]]){
//            NSArray *item = (NSArray *)respon.data;
//            if(self.type == 5){
//            NSMutableArray *d = [NSMutableArray new];
//            for (NSDictionary *i in item) {
//                [d addObjectsFromArray:[i valueForKey:@"listArticle"]];
//            }
//            data = d;
//            }else{
//                data = item;
//            }
//        }
        data = [respon.data valueForKey:@"list"];
        [_tableView reloadData];
    }else{
        [SpotlightSupport showMessage:@"error" msg:respon.display_message vc:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *item = data[indexPath.row];
    UILabel *articletitle = [(UILabel *)cell.contentView.subviews[0] viewWithTag:1];
    UILabel *articledesc = [(UILabel *)cell.contentView.subviews[0] viewWithTag:2];
    UILabel *articlecreator = [(UILabel *)cell.contentView.subviews[0] viewWithTag:3];
    articletitle.text = [item objectForKey:@"_title"];
    articledesc.text = [item objectForKey:@"_desc"];
    articlecreator.text = [item objectForKey:@"name"];
    
    return cell;
}

@end
