---
# Jachin
date: 2016-03-08 11:42:21
---
#Andriod 学习过程中的小问题
##1.formatFileSize方法找不到
直接用Formatter不行 必须加上	
	andriod.text.format
	android.text.format.Formatter中的formatFileSize
方法，该方法	String formatFileSize (Context context, long number) ，第二个参数是long型，一般为File对象的最后修改时间或创建时间的方法，最终返回类似 12KB、5Bytes的值，20MB的字符串。


##2.	
	 InputStream is = getClassLoader().getResourceAsStream(""); 返回值为null

Eclipse开发Android时使用

 	InputStream is = getClassLoader().getResourceAsStream("filename");

没有问题，只要文件位于src文件夹下的位置正确。今天在studio里还是这样写，始终取不到值，一直为null。google了百遍才发现这种替代写法。

	InputStream is = getResources().getAssets().open("filename");
但是需要在main下创建assets文件夹，将需要访问的文件放在该文件夹下。

##3.测试类注意
所有测试方法必须以test开头，否则没有测试选项。
##4.发送sd卡就绪广播失败 android4.4
﻿用以下代码
//发送sd卡就绪广播

	if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            Intent mediaScanIntent = new Intent(
                    Intent.ACTION_MEDIA_SCANNER_SCAN_FILE);
            Uri contentUri = Uri.fromFile(file); //out is your file you saved/deleted/moved/copied
            mediaScanIntent.setData(contentUri);
            this.sendBroadcast(mediaScanIntent);
        } else {
            sendBroadcast(new Intent(
                    Intent.ACTION_MEDIA_MOUNTED,
                    Uri.parse("file://"
                            + Environment.getExternalStorageDirectory())));
        }

##5 hendle 方法有错误
可能导包有问题 

	import android.os.Handler;