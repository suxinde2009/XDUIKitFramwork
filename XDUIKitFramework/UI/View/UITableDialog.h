#import <UIKit/UIKit.h>

@class XDDialog;
@class UITableDialog;

@protocol UITableDialogDelegate <NSObject>
@optional
- (void)tableDialog:(UITableDialog *)tableDialog didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableDialogDone:(UITableDialog *)tableDialog;
- (void)tableDialogCandel:(UITableDialog *)tableDialog;
- (CGFloat)tableDialog:(UITableDialog *)tableDialog heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableDialog:(UITableDialog *)tableDialog didDismissWithButtonIndex:(NSInteger)buttonIndex;
@end

@protocol UITableDialogDatasource <NSObject>

- (UITableViewCell *)tableDialog:(UITableDialog *)tableDialog cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableDialog:(UITableDialog *)tableDialog numberOfRowsInSection:(NSInteger)section;

@optional

- (NSInteger)numberOfSectionsInTableDialog:(UITableDialog *)tableDialog; // default 1
- (NSString *)tableDialog:(UITableDialog *)tableDialog titleForHeaderInSection:(NSInteger)section;

@end


@interface UITableDialog : UIView <UITableViewDelegate, UITableViewDataSource>
{
    NSString       *_title;
    UITableView    *_tableView;
    XDDialog       *_popOverWindow;
    id<UITableDialogDelegate> _delegate;
    id<UITableDialogDatasource> _dataSource;
}
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, assign) id<UITableDialogDelegate> delegate;
@property (nonatomic, assign) id<UITableDialogDatasource> dataSource;
@property (nonatomic, retain) UITableView    *tableView;

- (void)show;

@end
