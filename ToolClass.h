//
//  ToolClass.h
//  testLoadImage
//
//  Created by JellySix on 2016/12/5.
//  Copyright © 2016年 JellySix. All rights reserved.666
//

#import <Foundation/Foundation.h>

#define kAlphaNum @".0123456789"
#define kNum @"0123456789"

@interface ToolClass : NSObject


/**工具类🔧－－订单倒计时*/
+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime;
/**工具类🔧－－自动生成图片名*/
+ (NSString *)generateImageName;
/**工具类🔧－－创建头像图片地址*/
+ (NSString *)generateHeadImageName;
/**工具类🔧－－获得当前 年-月-日 时:分:秒*/
+ (NSString *)getCurrentDateAndTime;
/**工具类🔧－－获取当前时间*/
+(NSString *)dateStr;
/**工具类🔧－－获取当前时间--格式为年-月-日*/
+(NSString *)dateStrWithYMD;
/**获取当前时间--格式为MM月dd日*/
+ (NSString *)dateStrWithMD;
//把nsdate形式转化为字符串形式
+(NSString *)getTimeStr:(NSString *)timeStr and:(NSString *)Minute;
/**工具类🔧－－截取 \"> 和 </ 之间的字符串内容*/
+ (NSString *)getDataDic:(NSString *)string;
/**工具类🔧－－字符串转化为字典*/
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;
/**工具类🔧－－字符串转化为json格式*/
+ (NSString *)JSONString:(NSString *)aString;
/**工具类🔧－－把字符串转化为nsdate*/
+(NSDate *)getNSDateByString:(NSString *)timeString;
/**工具类🔧－－把字符串转化为nsdate*/
+ (NSDate *)getNSDateWithVocationByString:(NSString *)timeString;
/**工具类🔧－－把nsdate转化为字符串*/
+(NSString *)getNstringByNSDate:(NSDate *)date;

/**工具类🔧－－获取某年某月总共多少天*/
+(int)getDaysInMonth:(int)year month:(int)imonth;
/**工具类🔧－－把nsdate形式的转化为long long格式*/
+(long long)longLongFromDate:(NSDate*)date;
/**工具类🔧－－把两个日期之间所有的日期存到数组中*/
+(NSMutableArray *)getArray:(long long)startTime and:(long long)endTime;
/**工具类🔧－－判断手机号码格式是否正确*/
+ (BOOL)valiMobile:(NSString *)mobile;
/**工具类🔧－－设置textField只能输入数字用于电话号码*/
+ (BOOL)validateNumber:(NSString*)number;
/**工具类🔧－－IOS将字符串转换为日期时间double格式*/
+ (double)date:(NSString *)timeStr;
/**工具类🔧－－判断用户名满足不满足要求--用户名的要求：必须包括字母和数字，最低不能低于六位*/
+ (BOOL)isUserName:(NSString *)name;
/**工具类🔧－－将nsdate转化为秒*/
+ (double)doubleDate:(NSDate *)date ;
/**工具类🔧－－点击隐藏键盘*/
+ (void)hideKeyboardImpl:(UIView*) view;
/**工具类🔧－－接口加密*/
+ (NSString*)sha256:(NSString *)stringpass;
/**工具类🔧－－获取设备当前网络IP地址*/
+ (NSString*)getDeviceIPIpAddresses;
/**工具类🔧－－获取拼接参数请求时间create*/
+ (NSString *)getCreateString;
/**工具类🔧－－随机生成25位字符串*/
+ (NSString *)arc25string;
/**工具类🔧－－拼接校验码*/
+ (NSString *)arcCheckNumberString ;
/**工具类🔧－－字典转键值 @"a=b&c=d"*/
+ (NSString *)dicToStrWithDic:(NSDictionary *)dic;

/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy-MM-dd HH:mm:ss格式*/
+(NSString *)getTimeDateWithHMS:(NSString *)VTtimeStr;
/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy-MM-dd HH:mm格式*/
+(NSString *)getTimeDate:(NSString *)VTtimeStr;
/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy-MM-dd格式*/
+(NSString *)getTimeDateWithVocation:(NSString *)VTtimeStr;

/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy.MM.dd HH:mm:ss格式*/
+(NSString *)getNormalTimeDateWithHMS:(NSString *)VTtimeStr;
/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy.MM.dd HH:mm格式*/
+(NSString *)getNormalTimeDate:(NSString *)VTtimeStr;
/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy.MM.dd格式*/
+(NSString *)getNormalTimeDateWithVocation:(NSString *)VTtimeStr;

/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为HH:mm格式*/
+(NSString *)getTimeWithHandM:(NSString *)VTtimeStr;
/**工具类🔧－－把\/Date(1491523567720+0800)\/格式截取为1491523567720格式*/
+(double)getTimeDouble:(NSString *)VTtimeStr;
/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy年MM月dd日 HH时mm分格式*/
+(NSString *)getTimeDateWithHMSHm:(NSString *)HMSHmtimeStr;
/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy年MM月dd日格式*/
+(NSString *)getTimeWithYMD:(NSString *)ymdtimeStr;
/**工具类🔧－－把字符串\/格式转化为 HH:mm格式*/
+(NSString *)getNSDateWithHMString:(NSString *)HMtimeStr;
/**工具类🔧－－把字符串\/格式转化为 HH:mm格式*/
+(NSString *)getNSDateWithHMString2:(NSString *)HMtimeStr;
/**工具类🔧－－把字符串\/格式转化为 yyyy年MM月dd日格式*/
+(NSString *)getNSDateWithYMDString:(NSString *)HMtimeStr;
/**工具类🔧－－把字符串\/格式转化为 yyyy年MM月dd日 HH时mm分格式*/
+(NSString *)getNSDateWithYMDHMString:(NSString *)HMtimeStr;
/**工具类🔧－－把字符串 yyyy-MM-dd转化为 yyyy年MM月dd日格式*/
+ (NSString *)getChineseDate:(NSString *)dateStr;

/**工具类🔧－－无障碍 把开始时间结束时间改为 上午几点几分到下午几点几分*/
+ (NSString *)getVoiceoverTimeWithStartTime:(NSString *)startTime andEndTime:(NSString *)endTime;
/**工具类🔧－－无障碍 把HH:mm改为 几点几分*/
+ (NSString *)getVoiceOverTimeWithTime:(NSString *)time;
/**工具类🔧－－无障碍 把yyyy-MM-dd改为 yyyy年MM月dd日*/
+ (NSString *)getVoiceOverTimeWithDateStr:(NSString *)dateStr;
/**工具类🔧－－时:分:秒*/
+ (NSString *)getCurrentTime;
/**工具类🔧－－前一天*/
+(NSString *)getBeforDay:(NSString *)timeStr;
/**工具类🔧－－后一天*/
+(NSString *)getLaterDay:(NSString *)timeStr;
/**工具类🔧－－推后六天*/
+(NSString *)getLatersixDay:(NSString *)timeStr;
/**工具类🔧－－IOS将字符串转换为日期时间double格式-->日期格式是年月日*/
+ (double)dateWithYMD:(NSString *)timeStr;
/**工具类🔧－－推后一天*/
+(NSString *)getLateroneDay;
/**工具类🔧－－推后六天*/
+(NSString *)getLatersixDay;
/**工具类🔧－－获取老板店铺id*/
+ (NSString *)getBossShopId;
/**工具类🔧－－日期时间HH:mm转换成double格式*/
+ (double)HHmmToDate:(NSString *)timeStr;
/**工具类🔧－－宽高缩放*/
+ (CGFloat)autoScaleW:(CGFloat)w;
+ (CGFloat)autoScaleH:(CGFloat)h;
/**工具类🔧－－外部计算高度*/
+ (CGFloat)calculateHeightWithFont:(CGFloat)fontSize andPresetWidth:(CGFloat)width andText:(NSString *)str;
/**工具类🔧－－外部计算宽度*/
+ (CGFloat)calculateWidthWithFont:(CGFloat)fontSize andPresetHeight:(CGFloat)height andText:(NSString *)str;
/**工具类🔧－－富文本图片在前，文字在后--可设置图片大小*/
+ (NSAttributedString *)stringWithImage:(UIImage *)image andTitle:(NSString *)contentStr WithWidth:(CGFloat)width;
/**工具类🔧－－富文本文字在前，图片在后--可设置图片大小*/
+ (NSAttributedString *)stringWithTitle:(NSString *)contentStr andImage:(UIImage *)image WithWidth:(CGFloat)width;
/**工具类🔧－－获取沙盒-城市列表数据*/
+ (NSMutableArray *)getCityData;
/**工具类🔧－－获取沙盒-清除城市列表*/
+ (void)cleanCityData;
/**工具类🔧－－改变行间距*/
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;
/**工具类🔧－－改变行间距-富文本赋值*/
+ (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace;
/**工具类🔧－－改变字间距*/
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;
/**工具类🔧－－改变行间距和字间距*/
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;
/**工具类🔧－－字典转json字符串方法*/
+ (NSString *)convertToJsonData:(NSDictionary *)dict;

/**工具类🔧－－验证邮箱*/
+ (BOOL)IsEmailAdress:(NSString *)Email;
/**工具类🔧－－验证(5--24位数字字符)*/
+ (BOOL)checkUserName:(NSString *)userName;

/**工具类🔧－－隐藏tableView多余分割线*/
+ (void)setExtraCellLineHidden: (UITableView *)tableView;

/**工具类🔧－－判断输入的字符串是否全为数字*/
+ (BOOL)isNum:(NSString *)checkedNumString;

/**工具类🔧－－日期格式转字符串*/
+ (NSString *)dateToString:(NSDate *)date;

/**工具类🔧－－获取字符串日期的毫秒数*/
+ (long long)getZiFuChuan:(NSString*)time;

/**工具类🔧－－设置图片的模糊效果*/
+ (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

#pragma mark - 输入限制
/**工具类🔧－－限制输入二位小数*/
+ (BOOL)twoDecimalConstraintTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**工具类🔧－－限制输入一位小数*/
+ (BOOL)oneDecimalConstraintTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**工具类🔧－－限制输入整数*/
+ (BOOL)wholeNumberConstraintTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

/**工具类🔧－－限制输入最多两位整数*/
+ (BOOL)twoWholeNumberConstraintTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
