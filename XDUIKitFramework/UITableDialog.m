#import "UITableDialog.h"
#import "XDDialog.h"

#ifndef kContentViewWidth
    #define kContentViewWidth 240.0f
#endif

#ifndef __MY_MACROS_H___
#define __MY_MACROS_H___
    #ifdef __IPHONE_6_0
        #define kTextAlignmentLeft NSTextAlignmentLeft
        #define kTextAlignmentCenter NSTextAlignmentCenter
        #define kTextAlignmentRight NSTextAlignmentRight
        #define kLineBreakModeCharaterWrap NSLineBreakByCharWrapping
        #define kLineBreakModeWordWrap NSLineBreakByWordWrapping
        #define kLineBreakModeClip NSLineBreakByClipping
        #define kLineBreakModeTruncatingHead NSLineBreakByTruncatingHead
        #define kLineBreakModeTruncatingMiddle NSLineBreakByTruncatingMiddle
        #define kLineBreakModeTruncatingTail NSLineBreakByTruncatingTail
    #else
        #define kTextAlignmentLeft UITextAlignmentLeft
        #define kTextAlignmentCenter UITextAlignmentCenter
        #define kTextAlignmentRight UITextAlignmentRight
        #define kLineBreakModeCharaterWrap UILineBreakModeCharacterWrap
        #define kLineBreakModeWordWrap UILineBreakModeWordWrap
        #define kLineBreakModeClip UILineBreakModeClip
        #define kLineBreakModeTruncatingHead UILineBreakModeHeadTruncation
        #define kLineBreakModeTruncatingMiddle UILineBreakModeMiddleTruncation
        #define kLineBreakModeTruncatingTail UILineBreakModeTailTruncation
    #endif

    #define kMainScreenFrame [[UIScreen mainScreen] bounds]
    #define kMainScreenWidth kMainScreenFrame.size.width
    #define kMainScreenHeight kMainScreenFrame.size.height-20
    #define kApplicationFrame [[UIScreen mainScreen] applicationFrame]
#endif



@interface UITableDialog ()

- (void)createContentView;

@end

@implementation UITableDialog
@synthesize title = _title;
@synthesize delegate = _delegate;
@synthesize dataSource = _dataSource;
@synthesize tableView = _tableView;

- (id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self createContentView];
    }
    return self;
}

- (void)createContentView
{
    self.backgroundColor = [UIColor clearColor];
    
    _popOverWindow = [[XDDialog alloc] initWithWindow:[[UIApplication sharedApplication] keyWindow]];
    _popOverWindow.dialogStyle = XDDialogStyleCustomView;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, kContentViewWidth, self.bounds.size.height)
                                              style:UITableViewStylePlain];
    
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.backgroundView.alpha = 0.0f;
    _tableView.backgroundView.backgroundColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self addSubview:_tableView];

    _popOverWindow.customView = self;
}


#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(numberOfSectionsInTableDialog:)])
    {
        return [self.dataSource numberOfSectionsInTableDialog:self];
    }
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(tableDialog:numberOfRowsInSection:)])
    {
        return [self.dataSource tableDialog:self numberOfRowsInSection:section];
    }
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(tableDialog:cellForRowAtIndexPath:)])
    {
        return [self.dataSource tableDialog:self cellForRowAtIndexPath:indexPath];
    }
    
    return nil;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tableDialog:didSelectRowAtIndexPath:)]){
        [self.delegate tableDialog:self didSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tableDialog:heightForRowAtIndexPath:)]){
        return [self.delegate tableDialog:self heightForRowAtIndexPath:indexPath];
    }
    return 0.0f;
}

#pragma mark -
- (void)show
{
    [_popOverWindow resetLayout];
    _popOverWindow.dialogStyle = XDDialogStyleCustomView;
    _popOverWindow.customView = self;
    if(_title)_popOverWindow.title = _title;
    [_popOverWindow addButtonWithTitle:@"Ok" target:self selector:@selector(done)];
    [_popOverWindow showOrUpdateAnimated:YES];

}

- (void)cancel
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tableDialogCandel:)]){
        [self.delegate tableDialogCandel:self];
    }
    [self dismiss];
}

- (void)done
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(tableDialogDone:)]){
        [self.delegate tableDialogDone:self];
    }
    
    [self dismiss];
}

- (void)dismiss
{
    [_popOverWindow hideAnimated:YES];
}

#pragma mark - dealloc

- (void)dealloc
{
    _popOverWindow.customView = nil;
    [_popOverWindow release];
    
    [_tableView release];
    
    [super dealloc];
}

@end
