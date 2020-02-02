//
//  AppDelegate.m
//  Cocoa Outline View
//
//  Created by Nikola Grujic on 31/01/2020.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)awakeFromNib
{
    outlineViewData = [[NSMutableDictionary alloc] init];
    
    [self setDataSource];
    [self setDelegate];
    
    [self fillTestData];
}

- (void)setDataSource
{
    [_outlineView setDataSource:(id)self];
}

- (void)setDelegate
{
    [_outlineView setDelegate:self];
}

- (void)fillTestData
{
    // Item 1
    NSArray *items = [NSArray arrayWithObjects:@"Liverpool", @"Manchester City", @"Chelsea", @"Manchester United", nil];
    [outlineViewData setObject:items forKey:@"England"];
    
    // Item 2
    items = [NSArray arrayWithObjects:@"Juventus", @"Roma", @"Milan", @"Inter Milan", nil];
    [outlineViewData setObject:items forKey:@"Italy"];
    
    // Item 3
    items = [NSArray arrayWithObjects:@"Real Madrid", @"Barcelona", @"Atletico Madrid", @"Valencia", nil];
    [outlineViewData setObject:items forKey:@"Spain"];
    
    [_outlineView reloadData];
}

#pragma mark NSOutlineViewDataSource methods

// Returns the number of child items encompassed by a given item.
- (NSInteger)outlineView:(NSOutlineView *)outlineView
  numberOfChildrenOfItem:(id)item
{
    if (item == nil)
    {
        return [outlineViewData count];
    }
    
    return [item count];
}

// Returns the child item at the specified index of a given item.
- (id)outlineView:(NSOutlineView *)outlineView
            child:(NSInteger)index
           ofItem:(id)item
{
    if (item == nil)
    {
        item = outlineViewData;
    }
    
    if ([item isKindOfClass:[NSArray class]])
    {
        return [item objectAtIndex:index];
    }
    else if ([item isKindOfClass:[NSDictionary class]])
    {
        NSArray *keys = [item allKeys];
        return [item objectForKey:[keys objectAtIndex:index]];
    }
    
    return nil;
}

// Invoked by outlineView to return the data object associated with the specified item.
- (id)        outlineView:(NSOutlineView *)outline
objectValueForTableColumn:(NSTableColumn *)column
                   byItem:(id)item
{
    if ([item isKindOfClass:[NSString class]])
    {
        return item;
    }
    else if ([item isKindOfClass:[NSArray class]])
    {
        NSArray *keys = [outlineViewData allKeysForObject:item];

        return [keys objectAtIndex:0];
    }
    
    return nil;
}

// Returns a Boolean value that indicates whether the a given item is expandable.
- (BOOL)outlineView:(NSOutlineView *)outlineView
   isItemExpandable:(id)item
{
    if ([item isKindOfClass:[NSArray class]] || [item isKindOfClass:[NSDictionary class]])
    {
        if ([item count] > 0)
        {
            return YES;
        }
    }
    
    return NO;
}

@end
