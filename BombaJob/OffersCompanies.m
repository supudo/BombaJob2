//
//  OffersCompanies.m
//  BombaJob
//
//  Created by Sergey Petrov on 6/17/13.
//  Copyright (c) 2013 BombaJob.bg. All rights reserved.
//

#import "OffersCompanies.h"
#import "BlackAlertView.h"
#import "DBManagedObjectContext.h"
#import "OfferDetails.h"

static NSString *kCellIdentifier = @"identifOffersCompanies";

@interface OffersCompanies ()
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) WebService *webService;
@end

@implementation OffersCompanies

@synthesize fetchedResultsController, webService;

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
	[self loadData];
}

- (void)loadData {
    [self getNewJobsFinished:nil];
    
	if ([[bSettings sharedbSettings] connectedToInternet]) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        if (webService == nil)
            webService = [[WebService alloc] init];
        [webService setDelegate:self];
        [webService getNewJobs];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"switchToOfferDetails"]) {
        OfferDetails *od = segue.destinationViewController;
        od.currentOffer = sender;
    }
}

- (void)openOfferDetails:(id)sender {
    [self performSegueWithIdentifier:@"switchToOfferDetails" sender:sender];
}

#pragma mark -
#pragma mark Service

- (void)serviceError:(id)sender error:(NSString *)errorMessage {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
	[BlackAlertView setBackgroundColor:[UIColor blackColor] withStrokeColor:[UIColor whiteColor]];
	BlackAlertView *alert = [[BlackAlertView alloc] initWithTitle:@"" message:[NSString stringWithFormat:@"%@.", NSLocalizedString(@"NewJobsError", @"NewJobsError")] delegate:self cancelButtonTitle:NSLocalizedString(@"UI.OK", @"UI.OK") otherButtonTitles:nil];
	alert.tag = 1;
	[alert show];
}

- (void)getNewJobsFinished:(id)sender {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
	UITabBarItem *tb = (UITabBarItem *)[[self tabBarController].tabBar.items objectAtIndex:0];
	tb.badgeValue = [NSString stringWithFormat:@"%i", [[DBManagedObjectContext sharedDBManagedObjectContext] getEntitiesCount:@"JobOffer" predicate:[NSPredicate predicateWithFormat:@"readYn = 0"]]];
    
	tb = (UITabBarItem *)[[self tabBarController].tabBar.items objectAtIndex:1];
	tb.badgeValue = [NSString stringWithFormat:@"%i", [[DBManagedObjectContext sharedDBManagedObjectContext] getEntitiesCount:@"JobOffer" predicate:[NSPredicate predicateWithFormat:@"humanYn = 0 AND readYn = 0"]]];
    
	tb = (UITabBarItem *)[[self tabBarController].tabBar.items objectAtIndex:2];
	tb.badgeValue = [NSString stringWithFormat:@"%i", [[DBManagedObjectContext sharedDBManagedObjectContext] getEntitiesCount:@"JobOffer" predicate:[NSPredicate predicateWithFormat:@"humanYn = 1 AND readYn = 0"]]];
    
	NSError *error = nil;
	if (![[self fetchedResultsController] performFetch:&error]) {
		[[bSettings sharedbSettings] LogThis: [NSString stringWithFormat:@"Unresolved error %@, %@", error, [error userInfo]]];
		abort();
	}
	[self.tableView reloadData];
}

#pragma mark -
#pragma mark Table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id <NSFetchedResultsSectionInfo> sectionInfo = [[fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
		cell.textLabel.font = [UIFont fontWithName:@"Ubuntu" size:14.0];
		cell.detailTextLabel.font = [UIFont fontWithName:@"Ubuntu" size:14.0];
	}
	dbJobOffer *ento = ((dbJobOffer *)[fetchedResultsController objectAtIndexPath:indexPath]);
    cell.imageView.image = (([ento.humanYn boolValue]) ? [UIImage imageNamed:@"icon_person.png"] : [UIImage imageNamed:@"icon_company.png"]);
	cell.textLabel.text = ento.title;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
	if (![ento.readYn boolValue])
		[cell.textLabel setFont:[UIFont fontWithName:@"Ubuntu-Bold" size:14.0]];
	else
		[cell.textLabel setFont:[UIFont fontWithName:@"Ubuntu" size:14.0]];
	cell.detailTextLabel.text = [[bSettings sharedbSettings] getOfferDate:ento.publishDate];
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
	[self.tableView deselectRowAtIndexPath:tableSelection animated:NO];
    [self openOfferDetails:[fetchedResultsController objectAtIndexPath:indexPath]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *txt = [[fetchedResultsController objectAtIndexPath:indexPath] valueForKey:@"title"];
    CGSize maximumLabelSize = CGSizeMake(225, FLT_MAX);
    CGSize expectedLabelSize = [txt sizeWithFont:[UIFont fontWithName:@"Ubuntu-Bold" size:14.0] constrainedToSize:maximumLabelSize lineBreakMode:NSLineBreakByWordWrapping];
    return expectedLabelSize.height + 26;
}

#pragma mark -
#pragma mark Fetch controllers

- (NSFetchedResultsController *)fetchedResultsController {
	DBManagedObjectContext *dbManagedObjectContext = [DBManagedObjectContext sharedDBManagedObjectContext];
    if (fetchedResultsController == nil) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"JobOffer" inManagedObjectContext:[dbManagedObjectContext managedObjectContext]];
        [fetchRequest setEntity:entity];
		
        NSSortDescriptor *sortDescriptorRead = [[NSSortDescriptor alloc] initWithKey:@"readYn" ascending:YES];
        NSSortDescriptor *sortDescriptorDate = [[NSSortDescriptor alloc] initWithKey:@"publishDate" ascending:NO];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptorRead, sortDescriptorDate, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
		NSPredicate *predicate = [NSPredicate predicateWithFormat:@"humanYn = 0"];
		[fetchRequest setPredicate:predicate];
        
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[dbManagedObjectContext managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
    }
	return fetchedResultsController;
}

#pragma mark -
#pragma mark System

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ? NO : [bSettings sharedbSettings].shouldRotate);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
