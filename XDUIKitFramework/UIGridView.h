#import <UIKit/UIKit.h>

@class UIGridViewCell;
@class UIGridViewRowView;
@protocol UIGridViewDelegate;

@interface UIGridView : UITableView <UITableViewDataSource, UITableViewDelegate>
{
    UIGridViewCell *tempCell;
}

@property (nonatomic, assign) IBOutlet id<UIGridViewDelegate> gridViewDelegate;

- (UIGridViewCell *)dequeueReusableCell;

- (IBAction)cellPressed:(id)sender;

@end




@interface UIGridViewCell : UIButton

@property (nonatomic) int rowIndex;
@property (nonatomic) int colIndex;
@property (nonatomic, retain) IBOutlet UIView *view;

@end


@protocol UIGridViewDelegate <NSObject>

@optional
- (void)gridView:(UIGridView *)gridView didSelectRowAt:(int)rowIndex columnAt:(int)columnIndex;

@required
- (float)gridView:(UIGridView *)gridView widthForCellAtColoumn:(int)columnIndex;
- (float)gridView:(UIGridView *)gridView heightForCellAtRow:(int)rowIndex;

- (int)numberOfColumnsOfGridView:(UIGridView *)gridView;
- (int)numberOfCellsOfGridView:(UIGridView *)gridView;

- (UIGridViewCell *)gridView:(UIGridView *)gridView cellForRowAt:(int)rowIndex columnAt:(int)columnIndex;

@end
