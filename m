Return-Path: <linux-kernel+bounces-258195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E4779384DF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8C5281A54
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3EA1684A6;
	Sun, 21 Jul 2024 13:44:05 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F38166302;
	Sun, 21 Jul 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569444; cv=none; b=htwEsqxYFbYnh4+02VZJKwM5DHUb6J469X/luVSHqAHLfT8LKy2GsUmVuC18XcXxPmdar6jEe8qQCDdV12hBgEzBtJVOnN5rlYDdckqmvH4S6baZdKVRhebczFRkVsbm4cQKCaL7ScD3Wz5vBlsz/odM+Z/mWnpaZYGvHO9xR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569444; c=relaxed/simple;
	bh=2lEL0ztI202vG1vl0esWYraQK8Wqx5ZFsEP/uhjXvjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pd5x7o0U2pvekc8HRdUjztYxKg8HfOxrU8LGdJfvWTO2bDXxitxooa4FUFxA0sVOEWBgwS42sftryJx7pLx+3U8VUzY3Yu67tbYIxGL+PxKaeb7yu1/1jkzljWqZ8WzPg3F6XjxROYiRDyLKAVlhnuB6Z+VJbpQUJyWr+0o/3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id 1CB6042DDF;
	Sun, 21 Jul 2024 16:37:04 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkG-00000001SjJ-2vIn;
	Sun, 21 Jul 2024 16:37:03 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-spdx@vger.kernel.org
Subject: [PATCH v2 03/16] xz: Switch from public domain to BSD Zero Clause License (0BSD)
Date: Sun, 21 Jul 2024 16:36:18 +0300
Message-ID: <20240721133633.47721-4-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721133633.47721-1-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the public domain notices and add SPDX license identifiers.

Change MODULE_LICENSE from "GPL" to "Dual BSD/GPL" because 0BSD should
count as a BSD license variant here.

The switch to 0BSD was done in the upstream XZ Embedded project because
public domain has (real or perceived) legal issues in some jurisdictions.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-spdx@vger.kernel.org
Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 include/linux/decompress/unxz.h |  5 ++---
 include/linux/xz.h              |  5 ++---
 lib/decompress_unxz.c           |  5 ++---
 lib/xz/xz_crc32.c               |  5 ++---
 lib/xz/xz_dec_bcj.c             |  5 ++---
 lib/xz/xz_dec_lzma2.c           |  5 ++---
 lib/xz/xz_dec_stream.c          |  5 ++---
 lib/xz/xz_dec_syms.c            | 12 +++---------
 lib/xz/xz_dec_test.c            | 12 +++---------
 lib/xz/xz_lzma2.h               |  5 ++---
 lib/xz/xz_private.h             |  5 ++---
 lib/xz/xz_stream.h              |  5 ++---
 scripts/xz_wrap.sh              |  5 +----
 13 files changed, 27 insertions(+), 52 deletions(-)

diff --git a/include/linux/decompress/unxz.h b/include/linux/decompress/unxz.h
index f764e2a7201e..3dd2658a9dab 100644
--- a/include/linux/decompress/unxz.h
+++ b/include/linux/decompress/unxz.h
@@ -1,10 +1,9 @@
+/* SPDX-License-Identifier: 0BSD */
+
 /*
  * Wrapper for decompressing XZ-compressed kernel, initramfs, and initrd
  *
  * Author: Lasse Collin <lasse.collin@tukaani.org>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 #ifndef DECOMPRESS_UNXZ_H
diff --git a/include/linux/xz.h b/include/linux/xz.h
index 7285ca5d56e9..5728d57aecc0 100644
--- a/include/linux/xz.h
+++ b/include/linux/xz.h
@@ -1,11 +1,10 @@
+/* SPDX-License-Identifier: 0BSD */
+
 /*
  * XZ decompressor
  *
  * Authors: Lasse Collin <lasse.collin@tukaani.org>
  *          Igor Pavlov <https://7-zip.org/>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 #ifndef XZ_H
diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index 842894158944..34bb7efc0412 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: 0BSD
+
 /*
  * Wrapper for decompressing XZ-compressed kernel, initramfs, and initrd
  *
  * Author: Lasse Collin <lasse.collin@tukaani.org>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 /*
diff --git a/lib/xz/xz_crc32.c b/lib/xz/xz_crc32.c
index 88a2c35e1b59..30b8a27110b1 100644
--- a/lib/xz/xz_crc32.c
+++ b/lib/xz/xz_crc32.c
@@ -1,11 +1,10 @@
+// SPDX-License-Identifier: 0BSD
+
 /*
  * CRC32 using the polynomial from IEEE-802.3
  *
  * Authors: Lasse Collin <lasse.collin@tukaani.org>
  *          Igor Pavlov <https://7-zip.org/>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 /*
diff --git a/lib/xz/xz_dec_bcj.c b/lib/xz/xz_dec_bcj.c
index ef449e97d1a1..ab9237ed6db8 100644
--- a/lib/xz/xz_dec_bcj.c
+++ b/lib/xz/xz_dec_bcj.c
@@ -1,11 +1,10 @@
+// SPDX-License-Identifier: 0BSD
+
 /*
  * Branch/Call/Jump (BCJ) filter decoders
  *
  * Authors: Lasse Collin <lasse.collin@tukaani.org>
  *          Igor Pavlov <https://7-zip.org/>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 #include "xz_private.h"
diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index 27ce34520e78..613939f5dd6c 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -1,11 +1,10 @@
+// SPDX-License-Identifier: 0BSD
+
 /*
  * LZMA2 decoder
  *
  * Authors: Lasse Collin <lasse.collin@tukaani.org>
  *          Igor Pavlov <https://7-zip.org/>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 #include "xz_private.h"
diff --git a/lib/xz/xz_dec_stream.c b/lib/xz/xz_dec_stream.c
index 683570b93a8c..0058406ccd17 100644
--- a/lib/xz/xz_dec_stream.c
+++ b/lib/xz/xz_dec_stream.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: 0BSD
+
 /*
  * .xz Stream decoder
  *
  * Author: Lasse Collin <lasse.collin@tukaani.org>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 #include "xz_private.h"
diff --git a/lib/xz/xz_dec_syms.c b/lib/xz/xz_dec_syms.c
index 61098c67a413..495d2cc2e6e8 100644
--- a/lib/xz/xz_dec_syms.c
+++ b/lib/xz/xz_dec_syms.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: 0BSD
+
 /*
  * XZ decoder module information
  *
  * Author: Lasse Collin <lasse.collin@tukaani.org>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 #include <linux/module.h>
@@ -25,9 +24,4 @@ EXPORT_SYMBOL(xz_dec_microlzma_end);
 MODULE_DESCRIPTION("XZ decompressor");
 MODULE_VERSION("1.1");
 MODULE_AUTHOR("Lasse Collin <lasse.collin@tukaani.org> and Igor Pavlov");
-
-/*
- * This code is in the public domain, but in Linux it's simplest to just
- * say it's GPL and consider the authors as the copyright holders.
- */
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/lib/xz/xz_dec_test.c b/lib/xz/xz_dec_test.c
index da28a19d6c98..53d3600f2ddb 100644
--- a/lib/xz/xz_dec_test.c
+++ b/lib/xz/xz_dec_test.c
@@ -1,10 +1,9 @@
+// SPDX-License-Identifier: 0BSD
+
 /*
  * XZ decoder tester
  *
  * Author: Lasse Collin <lasse.collin@tukaani.org>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 #include <linux/kernel.h>
@@ -212,9 +211,4 @@ module_exit(xz_dec_test_exit);
 MODULE_DESCRIPTION("XZ decompressor tester");
 MODULE_VERSION("1.0");
 MODULE_AUTHOR("Lasse Collin <lasse.collin@tukaani.org>");
-
-/*
- * This code is in the public domain, but in Linux it's simplest to just
- * say it's GPL and consider the authors as the copyright holders.
- */
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/lib/xz/xz_lzma2.h b/lib/xz/xz_lzma2.h
index 92d852d4f87a..d2632b7dfb9c 100644
--- a/lib/xz/xz_lzma2.h
+++ b/lib/xz/xz_lzma2.h
@@ -1,11 +1,10 @@
+/* SPDX-License-Identifier: 0BSD */
+
 /*
  * LZMA2 definitions
  *
  * Authors: Lasse Collin <lasse.collin@tukaani.org>
  *          Igor Pavlov <https://7-zip.org/>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 #ifndef XZ_LZMA2_H
diff --git a/lib/xz/xz_private.h b/lib/xz/xz_private.h
index bf1e94ec7873..2412a5d54801 100644
--- a/lib/xz/xz_private.h
+++ b/lib/xz/xz_private.h
@@ -1,10 +1,9 @@
+/* SPDX-License-Identifier: 0BSD */
+
 /*
  * Private includes and definitions
  *
  * Author: Lasse Collin <lasse.collin@tukaani.org>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 #ifndef XZ_PRIVATE_H
diff --git a/lib/xz/xz_stream.h b/lib/xz/xz_stream.h
index 430bb3a0d195..55f9f6f94b78 100644
--- a/lib/xz/xz_stream.h
+++ b/lib/xz/xz_stream.h
@@ -1,10 +1,9 @@
+/* SPDX-License-Identifier: 0BSD */
+
 /*
  * Definitions for handling the .xz file format
  *
  * Author: Lasse Collin <lasse.collin@tukaani.org>
- *
- * This file has been put into the public domain.
- * You can do whatever you want with this file.
  */
 
 #ifndef XZ_STREAM_H
diff --git a/scripts/xz_wrap.sh b/scripts/xz_wrap.sh
index d06baf626abe..bb760b721b2c 100755
--- a/scripts/xz_wrap.sh
+++ b/scripts/xz_wrap.sh
@@ -1,13 +1,10 @@
 #!/bin/sh
+# SPDX-License-Identifier: 0BSD
 #
 # This is a wrapper for xz to compress the kernel image using appropriate
 # compression options depending on the architecture.
 #
 # Author: Lasse Collin <lasse.collin@tukaani.org>
-#
-# This file has been put into the public domain.
-# You can do whatever you want with this file.
-#
 
 BCJ=
 LZMA2OPTS=
-- 
2.45.2


