#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIView (autoresizing)
//带margin的左中右层
- (void) addSubviewLeft:(UIView *)leftView middleView:(UIView *)middleView rightView:(UIView *)rightView lefWidth:(CGFloat)lefWidth rightWidth:(CGFloat)rightWidth margin:(CGRect)marginFrame;
//左中右层
- (void) addSubviewLeft:(UIView *)leftView middleView:(UIView *)middleView rightView:(UIView *)rightView lefWidth:(CGFloat)lefWidth rightWidth:(CGFloat)rightWidth;
//上中下层
- (void) addSubviewTop:(UIView *)topView middleView:(UIView *)middleView bottomView:(UIView *)bottomView topHeight:(CGFloat)topHeight bottomHeight:(CGFloat)bottomHeight;

//左上右下 自适应大小来满足margin
- (void) addSubview:(UIView *)aView margin:(CGRect)marginFrame;
//自适应margin来满足大小
- (void) addSubview:(UIView *)aView size:(CGSize)aSize;
//左上右下 自适应大小来满足margin
- (void) setSizeInView:(UIView *)aView margin:(CGRect)marginFrame;
//左上右下 自适应margin来满足大小

- (void) setCenterInView:(UIView *)aView size:(CGSize)aSize;
- (CGPoint) centerPoint;

@end
