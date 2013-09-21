KWImageArchive
==============

## SYNOPSYS

```obj-c
#import "KWImageArchive.h"
```

```obj-c
NSError *err = nil;
KWImageArchive *archive = [KWImageArchive archiveWithPath:@"iconic.zip" error:&err];
UIImage *image = [archive imageForName:@"aperture_32x32.png"];
```

## DEMO APP

<img src="https://raw.github.com/kawanet/KWImageArchive/master/public/capture1.png" width="320">

## AUTHOR 

Yusuke Kawasaki http://www.kawa.net/

## COPYRIGHT 
The following copyright notice applies to all the files provided in this distribution, including binary files, unless explicitly noted otherwise.

    Copyright 2013 Yusuke Kawasaki

