//
//  UFMFile.m
//  UFMParseImpl
//
//  Created by XueFeng Chen on 2022/11/8.
//

#import "UFMFile.h"

#import "UIImage+UFMCompress.h"

NSString *const _Nonnull UFMFileTypeTextPlain = @"txt";
NSString *const _Nonnull UFMFileTypeTextHTML = @"html";
NSString *const _Nonnull UFMFileTypeTextMarkDown = @"md";
NSString *const _Nonnull UFMFileTypeImagePNG = @"png";
NSString *const _Nonnull UFMFileTypeImageJPEG = @"jpeg";
NSString *const _Nonnull UFMFileTypeImageGIF = @"gif";
NSString *const _Nonnull UFMFileTypeVideoMPEG = @"mpeg";
NSString *const _Nonnull UFMFileTypeApplicationPDF = @"pdf";

@implementation UFMFile

- (instancetype)initWithMetaData:(id)metaData error:(NSError **)error {
    if (self = [super initWithMetaData:metaData error:error]) {
        NSAssert([metaData isKindOfClass:[PFFileObject class]], @"metaData type is incorrect");
        
        PFFileObject *fileObject = (PFFileObject *)metaData;
        
        self.url = fileObject.url;
        self.name = fileObject.name;
        self.dirty = fileObject.isDirty;

        // init
        self.fileType = @"";
        
        // 先判断后缀，决定文件类型
        NSArray *array = [self.name componentsSeparatedByString:@"."];
        if (array.count == 2) {
            NSString *fileName = array[0];
            NSString *fileType = array[1];
            
            self.fileType = fileType;
            
            if ([fileType isEqualToString:UFMFileTypeImagePNG] ||
                [fileType isEqualToString:UFMFileTypeImageJPEG] ||
                [fileType isEqualToString:UFMFileTypeImageGIF]) {
                // 图片文件则判断是否有预存的宽和高，否则默认200/200
                NSArray *sizeArray = [fileName componentsSeparatedByString:@"_"];
                if (sizeArray.count == 3) {
                    self.imageWidth = [sizeArray[1] floatValue];
                    self.imageHeight = [sizeArray[2] floatValue];
                } else {
                    self.imageWidth = 200.0f;
                    self.imageHeight = 200.0f;
                }
            }
        }
    }
    
    return self;
}

- (instancetype)initWithFileData:(NSData *)fileData fileType:(NSString *)fileType error:(NSError **)error {
    if (self = [super init]) {
        self.fileType = fileType;
        NSData *data = fileData;
        
        if ([fileType isEqualToString:UFMFileTypeImagePNG] ||
            [fileType isEqualToString:UFMFileTypeImageJPEG] ||
            [fileType isEqualToString:UFMFileTypeImageGIF]) {
            UIImage *image = [UIImage imageWithData:fileData];
            data = [image ufm_compressToByte:200 * 1024];
            image = [UIImage imageWithData:data];
            self.imageWidth = image.size.width;
            self.imageHeight = image.size.height;
            self.name = [NSString stringWithFormat:@"file_%.2f_%.2f.%@", self.imageWidth, self.imageHeight, fileType];
        } else {
            self.name = [NSString stringWithFormat:@"file.%@", fileType];
        }
        
        PFFileObject *fileObject = [PFFileObject fileObjectWithName:self.name data:data contentType:@"" error:error];
        
        if (*error) {
            return nil;
        } else {
            self.metaData = fileObject;
            self.url = fileObject.url;
            self.dirty = fileObject.isDirty;
        }
    }
    
    return self;
}

@end
