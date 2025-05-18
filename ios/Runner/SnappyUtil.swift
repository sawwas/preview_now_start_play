////
////  SnappyUtil.swift
////  Runner
////
////  Created by Zhe deng on 2025/5/15.
////
//
//import Foundation
//import Snappy
//
//// 创建一个Swift Package Manager配置： swift package init --type library
//func snappyUtilCompressed() {
//   
//    // 压缩 Data
//    let originalData = "Hello, Snappy!".data(using: .utf8)!
//    do {
//        if #available(iOS 14, *) {
//            let compressedData = try originalData.compressedUsingSnappy()
//        } else {
//            // Fallback on earlier versions
//        }
//        print("原始大小: \\(originalData.count) 字节")
//        print("压缩后大小: \\(compressedData.count) 字节")
//    } catch {
//        print("压缩错误: \\(error)")
//    }
//
//    // 压缩字符串
//    let text = "Hello, Snappy!"
//    do {
//        if #available(iOS 14, *) {
//            if let compressedData = try text.compressedUsingSnappy() {
//                print("字符串压缩成功")
//            }
//        } else {
//            // Fallback on earlier versions
//        }
//    } catch {
//        print("压缩错误: \\(error)")
//    }
//}
//
//func snappyUtilUnCompressed() {
//   
//    do {
//        let originalData = "Hello, Snappy!".data(using: .utf8)!
//        if #available(iOS 14, *) {
//            let decompressedData = try originalData.uncompressedUsingSnappy()
//            if let decompressedString = String(data: decompressedData, encoding: .utf8) {
//                print("解压缩后的文本: \\(decompressedString)")
//            }
//        }
//    } catch {
//        print("解压缩错误: \\(error)")
//    }
//}
//
//func snappyUtilAsyncCompressed() {
//   
//    // 异步压缩
//    if #available(iOS 13.0, *) {
//        Task {
//            do {
//                let text = "Hello, Snappy!"
//                if #available(iOS 14, *) {
//                    if let compressedData = try await text.compressedUsingSnappy() {
//                        print("异步压缩成功")
//                        
//                        // 异步解压缩
//                        let decompressedData = try await compressedData.uncompressedUsingSnappy()
//                        print("异步解压缩成功")
//                    }
//                } else {
//                    // Fallback on earlier versions
//                }
//            } catch {
//                print("异步操作错误: \\(error)")
//            }
//        }
//    } else {
//        // Fallback on earlier versions
//    }
//}
