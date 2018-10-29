
//
//  ToolClass.m
//  testLoadImage
//
//  Created by JellySix on 2016/12/5.
//  Copyright © 2016年 JellySix. All rights reserved.
//

#import "ToolClass.h"
//#import "UserModel.h"
#import <CommonCrypto/CommonDigest.h>
#import  <sys/socket.h>
#import  <sys/sockio.h>
#import  <sys/ioctl.h>
#import  <net/if.h>
#import  <arpa/inet.h>

@implementation ToolClass

+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate *startD =[date dateFromString:startTime];
    
    NSDate *date1 = [NSDate date]; // 获得时间对象
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
    NSTimeInterval time = [zone secondsFromGMTForDate:date1];// 以秒为单位返回当前时间与系统格林尼治时间的差
    
    NSDate *endD = [date1 dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
//    NSDate *endD = [NSDate;
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value%60;//秒
    int minute = (int)value/60%60;
    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    NSString *str;
//    if (day != 0) {
//        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
//    }else if (day==0 && house != 0) {
//        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
//    }else if (day== 0 && house== 0 && minute!=0) {
//        str = [NSString stringWithFormat:@"%d分%d秒",30-minute-1,60-second];
//    }else{
//        str = [NSString stringWithFormat:@"%d秒",60-second];
//    }
//
    
    if (day >= 0 && house== 0 && 30-minute > 1) {
        str = [NSString stringWithFormat:@"%d分%d秒",30-minute-1,60-second];
    }else if(day== 0 && house== 0 && 30-minute == 1) {
        str = [NSString stringWithFormat:@"%d秒",60-second];
    }else{
        str = @"0";
    }
    
//    if (day >= 0 && house== 0 && 1-minute > 1) {
//        str = [NSString stringWithFormat:@"%d分%d秒",30-minute-1,60-second];
//    }else if(day== 0 && house== 0 && 1-minute == 1) {
//        str = [NSString stringWithFormat:@"%d秒",60-second];
//    }else{
//        str = @"0";
//    }

    return str;
}

+ (NSString *)generateImageName {
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS_"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    int num = (arc4random() % 10000);
    dateString = [dateString stringByAppendingString:[NSString stringWithFormat:@"%.4d.jpg", num]];
    
    return dateString;
    
}
+ (NSString *)generateHeadImageName {
    
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS_"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    
    NSDateComponents*comps;
    
    
    
    // 年月日获得
    
    comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
            
                       fromDate:currentDate];
    
    NSInteger year = [comps year];
    
    NSInteger month = [comps month];
    
    int num = (arc4random() % 10000);
    
    
    NSString *str = [NSString stringWithFormat:@"/%ld/%.2ld/%@%.4d.jpg",year,month,dateString,num];
    
    return str;
    
}
+ (NSString *)getCurrentDateAndTime {
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    return DateTime;
    
}

+ (NSString *)getCurrentTime {
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    return DateTime;
    
}

+ (NSString *)getBeforDay:(NSString *)timeStr {
    NSDate *date =  [ToolClass getNSDateByString:timeStr];
    NSDate *lastDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:date];//前一天
    
    return [ToolClass getNstringByNSDate:lastDay];
}

+ (NSString *)getLaterDay:(NSString *)timeStr {
    NSDate *date =  [ToolClass getNSDateByString:timeStr];
    NSDate *nextDat = [NSDate dateWithTimeInterval:24*60*60 sinceDate:date];//后一天
    
    return [ToolClass getNstringByNSDate:nextDat];
}
+ (NSString *)getLatersixDay:(NSString *)timeStr {
    NSDate *date =  [ToolClass getNSDateByString:timeStr];
    NSDate *nextDat = [NSDate dateWithTimeInterval:24*60*60*6 sinceDate:date];//推后六天
    
    return [ToolClass getNstringByNSDate:nextDat];
}
+ (NSString *)getLatersixDay {
    NSDate *date=[NSDate date];
    NSDate *nextDat = [NSDate dateWithTimeInterval:24*60*60*6 sinceDate:date];//推后六天
    
    return [ToolClass getNstringByNSDate:nextDat];
}
+ (NSString *)getLateroneDay {
    NSDate *date=[NSDate date];
    NSDate *nextDat = [NSDate dateWithTimeInterval:24*60*60*2 sinceDate:date];//推后一天
    
    return [ToolClass getNstringByNSDate:nextDat];
}

//获取当前时间
+ (NSString *)dateStr {
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    return dateStr;
}
//获取当前时间--格式为年月日
+ (NSString *)dateStrWithYMD {
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"YYYY-MM-dd"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    return dateStr;
}

/**获取当前时间--格式为MM月dd日*/
+ (NSString *)dateStrWithMD {
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"MM月dd日"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    return dateStr;
}

//把nsdate形式转化为字符串形式
+ (NSString *)getTimeStr:(NSString *)timeStr and:(NSString *)Minute {
    double endTime=[ToolClass date:timeStr]+[Minute integerValue]*60;
    NSString *timeStamp=[NSString stringWithFormat:@"%f",endTime];
    long long int date1 = (long long int)[timeStamp intValue];
    NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:date1];
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"YYYY-MM-dd HH:mm"];//设定时间格式
    
    NSString *dateString = [dateFormat stringFromDate:date2];
    return dateString;
}

// 要截取 \"> 和 </ 之间的字符串内容
+ (NSString *)getDataDic:(NSString *)string {
    
    NSRange startRange = [string rangeOfString:@"\">"];
    NSRange endRange = [string rangeOfString:@"</"];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    NSString *result = [string substringWithRange:range];
    
    return result;
}

// 把字符串转化为字典
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString {
    
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    
    return responseJSON;
    
}
//字符串转json格式
+ (NSString *)JSONString:(NSString *)aString {
    NSMutableString *s = [NSMutableString stringWithString:aString];
    [s replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"/" withString:@"\\/" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\n" withString:@"\\n" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\b" withString:@"\\b" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\f" withString:@"\\f" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\r" withString:@"\\r" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    [s replaceOccurrencesOfString:@"\t" withString:@"\\t" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [s length])];
    return [NSString stringWithString:s];
}

//把nsdate转化为字符串
+ (NSString *)getNstringByNSDate:(NSDate *)date {
    //用于格式化NSDate对象
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    //NSDate转NSString
    NSString*currentDateString=[dateFormatter stringFromDate:date];
    //输出currentDateString
    return currentDateString;
}

// 获取某年某月总共多少天
+ (int)getDaysInMonth:(int)year month:(int)imonth {
    // imonth == 0的情况是应对在CourseViewController里month-1的情况
    if((imonth == 0)||(imonth == 1)||(imonth == 3)||(imonth == 5)||(imonth == 7)||(imonth == 8)||(imonth == 10)||(imonth == 12))
        return 31;
    if((imonth == 4)||(imonth == 6)||(imonth == 9)||(imonth == 11))
        return 30;
    if((year%4 == 1)||(year%4 == 2)||(year%4 == 3))
    {
        return 28;
    }
    if(year%400 == 0)
        return 29;
    if(year%100 == 0)
        return 28;
    return 29;
}
// 把nsdate形式的转化为long long格式
+ (long long)longLongFromDate:(NSDate*)date {
    return [date timeIntervalSince1970];
}
// 把两个日期之间所有的日期存到数组中
+ (NSMutableArray *)getArray:(long long)startTime and:(long long)endTime {
    NSMutableArray *dates = [NSMutableArray array];
//    long long nowTime = 1471491674, //开始时间
//    endTime = 1472528474,//结束时间
    long long dayTime = 24*60*60,
    time = startTime - startTime%dayTime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    while (time <=endTime) {
        NSString *showOldDate = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time]];
        [dates addObject:showOldDate];
        time += dayTime;
    }
    return dates;
}

//判断手机号码格式是否正确
//+ (BOOL)valiMobile:(NSString *)mobile
//{
//    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
//    if (mobile.length != 11)
//    {
//        return NO;
//    }else{
//        /**
//         * 移动号段正则表达式
//         */
//        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
//        /**
//         * 联通号段正则表达式
//         */
//        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
//        /**
//         * 电信号段正则表达式
//         */
//        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
//
//        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
//        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
//        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
//        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
//        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
//        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
//
//        if (isMatch1 || isMatch2 || isMatch3 ) {
//            return YES;
//        }else{
//            return NO;
//        }
//    }
//}
+ (BOOL)valiMobile:(NSString *)mobile
{
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (mobile.length != 11)
    {
        return NO;
    }else{
        NSString *regexStr = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
        NSError *error;
        NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
        if (error) return NO;
        NSInteger count = [regular numberOfMatchesInString:mobile options:NSMatchingReportCompletion range:NSMakeRange(0, mobile.length)];
        if (count > 0) {
            return YES;
        } else {
            return NO;
        }
        
    }
}

//设置textField只能输入数字用于电话号码
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//把字符串转化为nsdate
+ (NSDate *)getNSDateByString:(NSString *)timeString {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:timeString];
    return inputDate;
}
//把字符串转化为nsdate
+ (NSDate *)getNSDateWithVocationByString:(NSString *)timeString {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:timeString];
    return inputDate;
}

//将nsdate转化为秒
+ (double)doubleDate:(NSDate *)date {
    //时间格式转化为秒
    NSTimeInterval timeStamp= [date timeIntervalSince1970];
    return timeStamp;
}

//IOS将字符串转换为日期时间double格式
+ (double)date:(NSString *)timeStr {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:timeStr];
    //时间格式转化为秒
    NSTimeInterval timeStamp= [inputDate timeIntervalSince1970];
    return timeStamp;
}

//IOS将字符串转换为日期时间HH:mm  转换成double格式
+ (double)HHmmToDate:(NSString *)timeStr {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:timeStr];
    //时间格式转化为秒
    NSTimeInterval timeStamp= [inputDate timeIntervalSince1970];
    return timeStamp;
}

//IOS将字符串转换为日期时间double格式-->日期格式是年月日
+ (double)dateWithYMD:(NSString *)timeStr {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate* inputDate = [inputFormatter dateFromString:timeStr];
    //时间格式转化为秒
    NSTimeInterval timeStamp= [inputDate timeIntervalSince1970];
    return timeStamp;
}

//判断用户名满足不满足要求--用户名的要求：必须包括字母和数字，最低不能低于六位
+ (BOOL)isUserName:(NSString *)name {
    
    NSString *      regex = @"^(?=[a-zA-Z0-9]*(?:[a-zA-Z][0-9]|[0-9][a-zA-Z]))[a-zA-Z0-9]{6,12}$";
    NSPredicate *   pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:name];
}
//点击隐藏键盘
+ (void) hideKeyboardImpl:(UIView*) view
{
    [ToolClass findResponderAndResign:view];
}
+ (BOOL) findResponderAndResign:(UIView*) view
{
    if (view)
    {
        if ([view isFirstResponder])
        {
            [view resignFirstResponder];
            return YES;
        }
        NSArray *children = [view subviews];
        for (int i = 0; i < children.count; ++i)
        {
            UIView *child = children[i];
            if ([self findResponderAndResign:child])
            {
                return YES;
            }
        }
    }
    return NO;
}
//接口加密
+ (NSString*) sha256:(NSString *)stringpass
{
    const char *cstr = [stringpass UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:stringpass.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes,data.length, digest);
    
    NSData *da=[[NSData alloc]initWithBytes:digest length:CC_SHA256_DIGEST_LENGTH];
    
    NSString *output = [da base64EncodedStringWithOptions:0];
    
    return output;
}

#pragma mark - 获取设备当前网络IP地址
+ (NSString*)getDeviceIPIpAddresses {
    
    int sockfd =socket(AF_INET,SOCK_DGRAM,0);
    
    // if (sockfd < 0) return nil;
    
    NSMutableArray*ips = [NSMutableArray array];
    
    int BUFFERSIZE =4096;
    
    struct ifconf ifc;
    
    char buffer[BUFFERSIZE], *ptr, lastname[IFNAMSIZ], *cptr;
    
    struct ifreq *ifr, ifrcopy;
    
    ifc.ifc_len= BUFFERSIZE;
    
    ifc.ifc_buf= buffer;
    
    if(ioctl(sockfd,SIOCGIFCONF, &ifc) >=0){
        
        for(ptr = buffer; ptr < buffer + ifc.ifc_len; ){
            
            ifr = (struct ifreq*)ptr;
            
            int len =sizeof(struct sockaddr);
            
            if(ifr->ifr_addr.sa_len> len) {
                
                len = ifr->ifr_addr.sa_len;
                
            }
            
            ptr +=sizeof(ifr->ifr_name) + len;
            
            if(ifr->ifr_addr.sa_family!=AF_INET)continue;
            
            if((cptr = (char*)strchr(ifr->ifr_name,':')) !=NULL) *cptr =0;
            
            if(strncmp(lastname, ifr->ifr_name,IFNAMSIZ) ==0)continue;
            
            memcpy(lastname, ifr->ifr_name,IFNAMSIZ);
            
            ifrcopy = *ifr;
            
            ioctl(sockfd,SIOCGIFFLAGS, &ifrcopy);
            
            if((ifrcopy.ifr_flags&IFF_UP) ==0)continue;
            
            NSString*ip = [NSString stringWithFormat:@"%s",inet_ntoa(((struct sockaddr_in*)&ifr->ifr_addr)->sin_addr)];
            
            [ips addObject:ip];
            
        }
        
    }
    
    close(sockfd);
    
    NSString*deviceIP =@"";
    
    for(int i=0; i < ips.count; i++)
        
    {
        
        if(ips.count>0)
            
        {
            
            deviceIP = [NSString stringWithFormat:@"%@",ips.lastObject];
            
        }
        
    }
    
    return deviceIP;
    
}
+ (NSString *)getCreateString {
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    NSArray *timeArray = [DateTime componentsSeparatedByString:@" "];
    NSString *createString=[NSString stringWithFormat:@"%@T%@Z",[timeArray firstObject],[timeArray lastObject]];
    
    return createString;
    
}

+ (NSString *)arc25string {
    
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 25; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    
    return string;
    
}
+ (NSString *)arcCheckNumberString {
    NSString *AppKey=@"dbc28ee158e145119585c796834fdc29";
    NSString *AppSecret=@"AC099D5E99413586A37C27009A33EA64";
    NSString *arc25string=[ToolClass arc25string];
    NSString *create=[ToolClass getCreateString];
    
    NSString *passwordDigest=[NSString stringWithFormat:@"%@%@%@",arc25string,create,AppSecret];
    
    NSString *arc256string=[ToolClass sha256:passwordDigest];
    
    NSString *checkNumberString=[NSString stringWithFormat:@"AppKey=\"%@\",notice=\"%@\",create=\"%@\",PasswordDigest=\"%@\"",AppKey,arc25string,create,arc256string];
    return checkNumberString;
}

+ (NSString *)dicToStrWithDic:(NSDictionary *)dic {
    
    NSString *str = @"";
    for (NSString *key in [dic allKeys]) {
        str = [str stringByAppendingFormat:@"%@=%@&",key,[dic objectForKey:key]];
    }
    str = [str substringToIndex:[str length] - 1];
    return str;
}
+ (NSString *)getTimeDateWithHMS:(NSString *)VTtimeStr {
    NSArray *array = [VTtimeStr componentsSeparatedByString:@"("];
    NSArray *array1 =  [[array lastObject] componentsSeparatedByString:@"+"];
    NSString *timeStr = [array1 firstObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制]
    double timeDouble=[timeStr doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}

+ (NSString *)getTimeDate:(NSString *)VTtimeStr {
    NSArray *array = [VTtimeStr componentsSeparatedByString:@"("];
    NSArray *array1 =  [[array lastObject] componentsSeparatedByString:@"+"];
    NSString *timeStr = [array1 firstObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制]
    double timeDouble=[timeStr doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;

}
+ (NSString *)getTimeWithHandM:(NSString *)VTtimeStr {
    NSArray *array = [VTtimeStr componentsSeparatedByString:@"("];
    NSArray *array1 =  [[array lastObject] componentsSeparatedByString:@"+"];
    NSString *timeStr = [array1 firstObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制]
    double timeDouble=[timeStr doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}

+ (NSString *)getTimeDateWithVocation:(NSString *)VTtimeStr {
    NSArray *array = [VTtimeStr componentsSeparatedByString:@"("];
    NSArray *array1 =  [[array lastObject] componentsSeparatedByString:@"+"];
    NSString *timeStr = [array1 firstObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制]
    double timeDouble=[timeStr doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}

/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy.MM.dd HH:mm:ss格式*/
+(NSString *)getNormalTimeDateWithHMS:(NSString *)VTtimeStr {
    
    NSArray *array = [VTtimeStr componentsSeparatedByString:@"("];
    NSArray *array1 =  [[array lastObject] componentsSeparatedByString:@"+"];
    NSString *timeStr = [array1 firstObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制]
    double timeDouble=[timeStr doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}
/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy.MM.dd HH:mm格式*/
+(NSString *)getNormalTimeDate:(NSString *)VTtimeStr {
    
    NSArray *array = [VTtimeStr componentsSeparatedByString:@"("];
    NSArray *array1 =  [[array lastObject] componentsSeparatedByString:@"+"];
    NSString *timeStr = [array1 firstObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制]
    double timeDouble=[timeStr doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}
/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy.MM.dd格式*/
+(NSString *)getNormalTimeDateWithVocation:(NSString *)VTtimeStr {
    
    NSArray *array = [VTtimeStr componentsSeparatedByString:@"("];
    NSArray *array1 =  [[array lastObject] componentsSeparatedByString:@"+"];
    NSString *timeStr = [array1 firstObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy.MM.dd"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制]
    double timeDouble=[timeStr doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
    
}

+ (double)getTimeDouble:(NSString *)VTtimeStr {
    NSArray *array = [VTtimeStr componentsSeparatedByString:@"("];
    NSArray *array1 =  [[array lastObject] componentsSeparatedByString:@"+"];
    NSString *timeStr = [array1 firstObject];
    return [timeStr doubleValue]/1000;
}
/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy年MM月dd日 HH时mm分格式*/
+(NSString *)getTimeDateWithHMSHm:(NSString *)HMSHmtimeStr{
    NSArray *array = [HMSHmtimeStr componentsSeparatedByString:@"("];
    NSArray *array1 =  [[array lastObject] componentsSeparatedByString:@"+"];
    NSString *timeStr = [array1 firstObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日 HH时mm分"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制]
    double timeDouble=[timeStr doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    NSString *confromTimespStr= [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

/**工具类🔧－－把\/Date(1491523567720+0800)\/格式转化为yyyy年MM月dd日格式*/
+(NSString *)getTimeWithYMD:(NSString *)ymdtimeStr{
    NSArray *array = [ymdtimeStr componentsSeparatedByString:@"("];
    NSArray *array1 =  [[array lastObject] componentsSeparatedByString:@"+"];
    NSString *timeStr = [array1 firstObject];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制]
    double timeDouble=[timeStr doubleValue]/1000;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    NSString *confromTimespStr= [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}
/**工具类🔧－－把字符串\/格式转化为 HH:mm格式*/
+(NSString *)getNSDateWithHMString:(NSString *)HMtimeStr{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"HH:mm:ss"];
    NSDate* inputDate = [inputFormatter dateFromString:HMtimeStr];
    
    NSDateFormatter *outPutFormatter = [[NSDateFormatter alloc] init];
    [outPutFormatter setLocale:[NSLocale currentLocale]];
    [outPutFormatter setDateFormat:@"HH时mm分"];
    NSString *outStr = [outPutFormatter stringFromDate:inputDate];
    return outStr;
}

/**工具类🔧－－把字符串\/格式转化为 HH:mm格式*/
+(NSString *)getNSDateWithHMString2:(NSString *)HMtimeStr{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:HMtimeStr];
    
    NSDateFormatter *outPutFormatter = [[NSDateFormatter alloc] init];
    [outPutFormatter setLocale:[NSLocale currentLocale]];
    [outPutFormatter setDateFormat:@"HH时mm分"];
    NSString *outStr = [outPutFormatter stringFromDate:inputDate];
    return outStr;
}

/**工具类🔧－－把字符串\/格式转化为 yyyy年MM月dd日格式*/
+(NSString *)getNSDateWithYMDString:(NSString *)HMtimeStr
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* inputDate = [inputFormatter dateFromString:HMtimeStr];
    
    NSDateFormatter *outPutFormatter = [[NSDateFormatter alloc] init];
    [outPutFormatter setLocale:[NSLocale currentLocale]];
    [outPutFormatter setDateFormat:@"yyyy年MM月dd日 "];
    NSString *outStr = [outPutFormatter stringFromDate:inputDate];
    return outStr;
}

/**工具类🔧－－把字符串\/格式转化为 yyyy年MM月dd日 HH时mm分格式*/
+(NSString *)getNSDateWithYMDHMString:(NSString *)HMtimeStr{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* inputDate = [inputFormatter dateFromString:HMtimeStr];
    
    NSDateFormatter *outPutFormatter = [[NSDateFormatter alloc] init];
    [outPutFormatter setLocale:[NSLocale currentLocale]];
    [outPutFormatter setDateFormat:@"yyyy年MM月dd日 HH时mm分"];
    NSString *outStr = [outPutFormatter stringFromDate:inputDate];
    return outStr;

}

/**工具类🔧－－把字符串 yyyy-MM-dd转化为 yyyy年MM月dd日格式*/
+ (NSString *)getChineseDate:(NSString *)dateStr{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* inputDate = [inputFormatter dateFromString:dateStr];
    
    NSDateFormatter *outPutFormatter = [[NSDateFormatter alloc] init];
    [outPutFormatter setLocale:[NSLocale currentLocale]];
    [outPutFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSString *outStr = [outPutFormatter stringFromDate:inputDate];
    return outStr;
    
}

/**工具类🔧－－无障碍 把开始时间结束时间改为 上午几点几分到下午几点几分*/
+ (NSString *)getVoiceoverTimeWithStartTime:(NSString *)startTime andEndTime:(NSString *)endTime {
    
    NSString *sTime;
    NSString *s = [startTime substringToIndex:5];
    //分号:分割字符串
    NSArray *m = [s componentsSeparatedByString:@":"];
    
    NSString *firstWord = [m objectAtIndex:0];
    NSString *first = [firstWord substringToIndex:1];//字符串开始
    if (first.intValue == 0) {
        firstWord = [firstWord substringFromIndex:1];
    }
    
    NSString *secondWord = [m objectAtIndex:1];
    NSString *second = [secondWord substringToIndex:1];
    NSString *secondd = [secondWord substringFromIndex:1];
    if (second.intValue == 0 && secondd.intValue == 0) {
        sTime = [NSString stringWithFormat:@"%@点整",firstWord];
    }else if(second == 0) {
        sTime = [NSString stringWithFormat:@"%@点%@分",firstWord,secondd];
    }else{
        sTime = [NSString stringWithFormat:@"%@点%@分",firstWord,secondWord];
    }
    
    if (firstWord.intValue<12) {
        sTime = [NSString stringWithFormat:@"上午%@",sTime];
    }else{
        sTime = [NSString stringWithFormat:@"下午%@",sTime];
    }
    
    
    NSString *eTime;
    NSString *e = [endTime substringToIndex:5];
    //分号:分割字符串
    NSArray *n = [e componentsSeparatedByString:@":"];
    
    NSString *efirstWord = [n objectAtIndex:0];
    NSString *efirst = [efirstWord substringToIndex:1];//字符串开始
    if (efirst.intValue == 0) {
        efirstWord = [efirstWord substringFromIndex:1];
    }
    
    NSString *esecondWord = [n objectAtIndex:1];
    NSString *esecond = [esecondWord substringToIndex:1];
    NSString *esecondd = [esecondWord substringFromIndex:1];
    if (esecond.intValue == 0 && esecondd.intValue == 0) {
        eTime = [NSString stringWithFormat:@"%@点整",efirstWord];
    }else if(esecond == 0) {
        eTime = [NSString stringWithFormat:@"%@点%@分",efirstWord,esecondd];
    }else{
        eTime = [NSString stringWithFormat:@"%@点%@分",efirstWord,esecondWord];
    }
    
    if (efirstWord.intValue<12) {
        eTime = [NSString stringWithFormat:@"上午%@",eTime];
    }else{
        eTime = [NSString stringWithFormat:@"下午%@",eTime];
    }
    
    NSString *str = [NSString stringWithFormat:@"%@到%@",sTime,eTime];
    return str;
}

/**工具类🔧－－无障碍 把HH:mm改为 几点几分*/
+ (NSString *)getVoiceOverTimeWithTime:(NSString *)time {
    
    NSString *sTime;
    NSString *s = [time substringToIndex:5];
    //分号:分割字符串
    NSArray *m = [s componentsSeparatedByString:@":"];
    
    NSString *firstWord = [m objectAtIndex:0];
    NSString *first = [firstWord substringToIndex:1];//字符串开始
    if (first.intValue == 0) {
        firstWord = [firstWord substringFromIndex:1];
    }
    
    NSString *secondWord = [m objectAtIndex:1];
    NSString *second = [secondWord substringToIndex:1];
    NSString *secondd = [secondWord substringFromIndex:1];
    if (second.intValue == 0 && secondd.intValue == 0) {
        sTime = [NSString stringWithFormat:@"%@点整",firstWord];
    }else if(second == 0) {
        sTime = [NSString stringWithFormat:@"%@点%@分",firstWord,secondd];
    }else{
        sTime = [NSString stringWithFormat:@"%@点%@分",firstWord,secondWord];
    }
    
    return sTime;
    
}

/**工具类🔧－－无障碍 把yyyy-MM-dd改为 yyyy年MM月dd日*/
+ (NSString *)getVoiceOverTimeWithDateStr:(NSString *)dateStr {
    
    NSString *sTime;
    NSString *s = [dateStr substringToIndex:10];
    //分号:分割字符串
    NSArray *m = [s componentsSeparatedByString:@"-"];
    
    NSString *yearWord = [m objectAtIndex:0];
    NSString *monthWord = [m objectAtIndex:1];
    NSString *dayWord = [m objectAtIndex:2];
    
    sTime = [NSString stringWithFormat:@"%@年%@月%@日",yearWord,monthWord,dayWord];
    
    return sTime;
    
}

//+ (NSString *)getBossShopId {
//    
//    //获取路径
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    
//    //拼接文件名
//    NSString *filePath = [path stringByAppendingPathComponent:@"user.plist"];
//    
//    //读取数据
//    UserModel *userModel = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
//    
//    return userModel.shopid;
//    
//}

//宽高缩放
+ (CGFloat)autoScaleW:(CGFloat)w {
    return w * (kdeviceWidth / 375.0f);
}
+ (CGFloat)autoScaleH:(CGFloat)h {
    return h * (kdeviceHeight / 667.0f);
}
//外部计算高度
+ (CGFloat)calculateHeightWithFont:(CGFloat)fontSize andPresetWidth:(CGFloat)width andText:(NSString *)str {
    
    UIFont *tfont = [UIFont systemFontOfSize:fontSize];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    ////////   ios 7
    CGSize size = CGSizeMake(width, MAXFLOAT);
    CGSize sizeText = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return sizeText.height;
    
}

//外部计算宽度
+ (CGFloat)calculateWidthWithFont:(CGFloat)fontSize andPresetHeight:(CGFloat)height andText:(NSString *)str {
    
    UIFont *tfont = [UIFont systemFontOfSize:fontSize];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:tfont,NSFontAttributeName,nil];
    ////////   ios 7
    CGSize size = CGSizeMake(MAXFLOAT, height);
    CGSize sizeText = [str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return sizeText.width;
    
}
#pragma mark -
#pragma mark -- 富文本--可设置图片大小
//图片在前
+ (NSAttributedString *)stringWithImage:(UIImage *)image andTitle:(NSString *)contentStr WithWidth:(CGFloat)width {
    
    // 创建一个富文本
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    [attriStr addAttribute:NSFontAttributeName
     
                     value:[UIFont systemFontOfSize:14.0]
     
                     range:NSMakeRange(1, contentStr.length-1)];
    
    [attriStr addAttribute:NSForegroundColorAttributeName
     
                     value:DYJ_UIColorFrom16RGB(0x333333)
     
                     range:NSMakeRange(1, contentStr.length-1)];
    /**
     添加图片到指定的位置
     */
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = image;
    // 设置图片大小
    attchImage.bounds = CGRectMake(10, -7, width, width);
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:0];
    
    
    return attriStr;
    
}
//图片在后
+ (NSAttributedString *)stringWithTitle:(NSString *)contentStr andImage:(UIImage *)image WithWidth:(CGFloat)width {
    
    // 创建一个富文本
    NSMutableAttributedString * attriStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    
    /**
     添加图片到指定的位置
     */
    NSTextAttachment *attchImage = [[NSTextAttachment alloc] init];
    // 表情图片
    attchImage.image = image;
    // 设置图片大小
    attchImage.bounds = CGRectMake(1, -3, width, width);
    NSAttributedString *stringImage = [NSAttributedString attributedStringWithAttachment:attchImage];
    [attriStr insertAttributedString:stringImage atIndex:contentStr.length];
    
    return attriStr;
}
//获取城市列表
+ (NSMutableArray *)getCityData {
    
    //沙盒路径地址
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"CityData.plist"];
    NSMutableArray *CityData = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    
    
    return CityData;
}
//清除城市列表
+ (void)cleanCityData {
    
    //沙盒路径地址
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"CityData.plist"];
    NSMutableArray *CityData = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    
    [CityData removeAllObjects];
    [CityData writeToFile:filePath atomically:YES];
}

#pragma mark -
#pragma mark -- 行间距和字间距
//改变行间距
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
    
}
//改变字间距
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}
//改变行间距和字间距
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(wordSpace)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpace];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
    
}
//行间距 富文本赋值
+ (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
}

// 字典转json字符串方法
+ (NSString *)convertToJsonData:(NSDictionary *)dict

{
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}

//隐藏tableview多余分割线
+(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    
    view.backgroundColor = [UIColor clearColor];
    
    [tableView setTableFooterView:view];
}

//验证邮箱
+ (BOOL) IsEmailAdress:(NSString *)Email
{
    NSString *emailCheck = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",emailCheck];
    return [emailTest evaluateWithObject:Email];
}

//验证(5--24位数字字符)
+ (BOOL) checkUserName:(NSString *)userName
{
    NSString *pattern=@"^[0-9a-zA-Z]{5,24}";
    NSPredicate *pred=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch=[pred evaluateWithObject:userName];
    return isMatch;
}
//工具类🔧－－判断输入的字符串是否全为数字
+ (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

//日期格式转字符串
+ (NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}


//获取字符串日期的毫秒数
+ (long long)getZiFuChuan:(NSString*)time
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date1=[dateFormatter dateFromString:time];
    
    return [date1 timeIntervalSince1970]*1000;
    
}

//设置图片的模糊效果
+ (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}

//价格约束
+ (BOOL)twoDecimalConstraintTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        
        if (textField.text.length == 1 && [textField.text isEqualToString:@"0"] && ![string isEqualToString:@"."]){
            //除了小数，首位不能为0
            textField.text = string;
            
            return NO;
        }
        
        NSCharacterSet *cs;
        // 小数点在字符串中的位置 第一个数字从0位置开始
        
        NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
        
        // 判断字符串中是否有小数点，并且小数点不在第一位
        
        // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
        
        // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
        
        if (dotLocation == NSNotFound && range.location != 0) {
            
            // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
            
            /* [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
             */
            cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
            if (range.location >= 9) {
                NSLog(@"单笔金额不能超过亿位");
                if ([string isEqualToString:@"."] && range.location == 9) {
                    return YES;
                }
                return NO;
            }
        }else {
            
            cs = [[NSCharacterSet characterSetWithCharactersInString:kNum] invertedSet];
            
        }
        // 按cs分离出数组,数组按@""分离出字符串
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        BOOL basicTest = [string isEqualToString:filtered];
        
        if (!basicTest) {
            
            NSLog(@"只能输入数字和小数点");
            
            return NO;
            
        }
        
        if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
            
            NSLog(@"小数点后最多两位");
            
            return NO;
        }
        if (textField.text.length > 11) {
            
            return NO;
            
        }
    }
    
    return YES;
    
}

//折扣约束
+ (BOOL)oneDecimalConstraintTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        
        if (textField.text.length == 1 && [textField.text isEqualToString:@"0"] && ![string isEqualToString:@"."]){
            //除了小数，首位不能为0
            textField.text = string;
            
            return NO;
        }
        
        NSCharacterSet *cs;
        // 小数点在字符串中的位置 第一个数字从0位置开始
        
        NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
        
        // 判断字符串中是否有小数点，并且小数点不在第一位
        
        // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
        
        // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
        
        if (dotLocation == NSNotFound && range.location != 0) {
            
            // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
            
            /* [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
             */
            cs = [[NSCharacterSet characterSetWithCharactersInString:kAlphaNum] invertedSet];
            if (range.location >= 1) {
                NSLog(@"整数不可超过两位");
                if ([string isEqualToString:@"."] && range.location == 1) {
                    return YES;
                }
                return NO;
            }
        }else {
            
            cs = [[NSCharacterSet characterSetWithCharactersInString:kNum] invertedSet];
            
        }
        // 按cs分离出数组,数组按@""分离出字符串
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        BOOL basicTest = [string isEqualToString:filtered];
        
        if (!basicTest) {
            
            NSLog(@"只能输入数字和小数点");
            
            return NO;
            
        }
        
        if (dotLocation != NSNotFound && range.location > dotLocation + 1) {
            
            NSLog(@"小数点后最多一位");
            
            return NO;
        }
        if (textField.text.length > 2) {
            
            return NO;
            
        }
    }
    
    return YES;
    
}

//限制输入整数
+ (BOOL)wholeNumberConstraintTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        
        if (textField.text.length == 1 && [textField.text isEqualToString:@"0"] && ![string isEqualToString:@"."]){
            //除了小数，首位不能为0
            textField.text = string;
            
            return NO;
        }
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kNum] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
        
    }
    
    return YES;
    
}

//限制输入最多两位整数
+ (BOOL)twoWholeNumberConstraintTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        
        if (textField.text.length == 1 && [textField.text isEqualToString:@"0"] && ![string isEqualToString:@"."]){
            //除了小数，首位不能为0
            textField.text = string;
            
            return NO;
        }
        
        if (textField.text.length == 2) {
            return NO;
        }
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:kNum] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        return [string isEqualToString:filtered];
        
    }
    
    return YES;
    
}

@end
