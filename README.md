KWImageArchive
==============

KWImageArchive loads image files stored in a ZIP file.

```obj-c
#import "KWImageArchive.h"
```

```obj-c
KWImageArchive *archive = [[KWImageArchive alloc] init];

NSError *err = nil;
[archive loadArchiveWithPath:@"iconic.zip" error:&err];

UIImage *image = [archive imageForName:@"aperture_32x32.png"];
```

## DEMO APPLICATION

The demo application includes
[Iconic](http://somerandomdude.com/work/open-iconic/)
open source icon set licensed under CC BY-SA.

<img src="https://raw.github.com/kawanet/KWImageArchive/master/public/capture1.png" width="320">

## INSTALLATION

```rb:Podfile
pod 'KWImageArchive', :git => 'https://github.com/kawanet/KWImageArchive.git'
```

## DEPENDENCY

https://github.com/pixelglow/zipzap

## AUTHOR

Yusuke Kawasaki http://www.kawa.net/

## COPYRIGHT 
The following copyright notice applies to all the files provided in this distribution, including binary files, unless explicitly noted otherwise.

    Copyright 2013 Yusuke Kawasaki
