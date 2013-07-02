#import "UIGridView.h"

@interface UIGridViewRowView : UITableViewCell
@end

@implementation UIGridViewRowView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]) {
  	self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.userInteractionEnabled = YES;
	}
	
    return self;
}

@end


@interface UIGridView ()
- (void)setUp;
@end

@implementation UIGridView

@synthesize gridViewDelegate = mGridViewDelegate;

#pragma mark - initilize
- (void)setUp
{
    self.delegate = self;
    self.dataSource = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    // 写死为plain风格的UITableView
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        [self setUp];
    }
    return self;
}

- (id)init
{
    if(self = [super init]){
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{    
    if (self = [super initWithFrame:frame]) {
		[self setUp];
    }
    return self;
}


- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}


#pragma mark - GridViewDelegate

- (UIGridViewCell *)dequeueReusableCell
{
    UIGridViewCell *cell = tempCell;
    tempCell = nil;
    return cell;
}

// UITableViewController specifics
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 0.0;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!mGridViewDelegate) return 0;
    if(!([mGridViewDelegate respondsToSelector:@selector(numberOfCellsOfGridView:)] &&
       [mGridViewDelegate respondsToSelector:@selector(numberOfColumnsOfGridView:)]))
        return 0;
    
    int residue = [mGridViewDelegate numberOfCellsOfGridView:self] % [mGridViewDelegate numberOfColumnsOfGridView:self];
    if(residue > 0) residue = 1;
    
    return ([mGridViewDelegate numberOfCellsOfGridView:self] / [mGridViewDelegate numberOfColumnsOfGridView:self] + residue);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!mGridViewDelegate) return 0;
    if(![mGridViewDelegate respondsToSelector:@selector(gridView:heightForCellAtRow:)])
        return 0;
    
    return [mGridViewDelegate gridView:self heightForCellAtRow:indexPath.row];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(!mGridViewDelegate) return nil;
    static NSString *cellIdentifier = @"gridRowIdentifier";
    UIGridViewRowView *rowView = (UIGridViewRowView *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(rowView == nil){
        rowView = [[[UIGridViewRowView alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:cellIdentifier] autorelease];
    }
    
    int numCols = [mGridViewDelegate numberOfColumnsOfGridView:self];
    int count = [mGridViewDelegate numberOfCellsOfGridView:self];
    
    float x = 0.f;
    float height = [mGridViewDelegate gridView:self heightForCellAtRow:indexPath.row];
    
    for(int i = 0; i < numCols; i++){
        
        if((i + indexPath.row * numCols) >= count){
            
            if(rowView.contentView.subviews.count > i){
                ((UIGridViewCell *)[rowView.contentView.subviews objectAtIndex:i]).hidden = YES;
            }
            continue;
        }
        
        if(rowView.contentView.subviews.count>i){
            tempCell = [rowView.contentView.subviews objectAtIndex:i];
        } else {
            tempCell = nil;
        }
        
        UIGridViewCell *cell = [mGridViewDelegate gridView:self
                                              cellForRowAt:indexPath.row
                                                  columnAt:i];
        if(cell.superview != rowView.contentView){
            [cell removeFromSuperview];
            [rowView.contentView addSubview:cell];
            [cell addTarget:self
                     action:@selector(cellPressed:) 
           forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        cell.hidden = NO;
        cell.rowIndex = indexPath.row;
        cell.colIndex = i;
        
        float cellWidth = [mGridViewDelegate gridView:self
                                widthForCellAtColoumn:i];
        
        cell.frame = CGRectMake(x,
                                0.0f,
                                cellWidth,
                                height);
        x += cellWidth;
    }
    
    rowView.frame = CGRectMake(rowView.frame.origin.x,
                               rowView.frame.origin.y,
                               x,
                               height);
    
    return rowView;
}

- (IBAction) cellPressed:(id) sender
{
	UIGridViewCell *cell = (UIGridViewCell *) sender;
	if(mGridViewDelegate && [mGridViewDelegate respondsToSelector:@selector(gridView:didSelectRowAt:columnAt:)]){
        [mGridViewDelegate gridView:self didSelectRowAt:cell.rowIndex columnAt:cell.colIndex];
    }
}

#pragma mark - dealloc
- (void)dealloc
{
    self.delegate = nil;
    self.dataSource = nil;
    self.gridViewDelegate = nil;
    
    [super dealloc];
}

@end


@interface UIGridViewCell ()
- (void)commonInit;
@end

@implementation UIGridViewCell

@synthesize rowIndex, colIndex, view;

- (void)commonInit
{
    view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self addSubview:view];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    view.frame = self.bounds;
}

- (id)init
{
    if(self = [super init]){
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder]){
        [self commonInit];
    }
    return self;
}

- (void)addSubview:(UIView *)v // 保证点击事件传递给cell
{
    [super addSubview:v];
    v.exclusiveTouch = NO;
    v.userInteractionEnabled = NO;
}

- (void)dealloc
{
    [view release];
    [super dealloc];
}

@end
