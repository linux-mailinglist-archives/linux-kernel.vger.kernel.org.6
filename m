Return-Path: <linux-kernel+bounces-258192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A909384D8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9FCF1C20E6E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF9D1662E8;
	Sun, 21 Jul 2024 13:43:57 +0000 (UTC)
Received: from mailscanner06.zoner.fi (mailscanner06.zoner.fi [5.44.246.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FAA1649BF
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569436; cv=none; b=CUepGhkrESxxQAT2huJPfVgUsBweQzRQXWya4SlXT5kDBMik2EixE/WsEAHFsMHY6hl69IDNte5ASSAP+MEaK8OcVuxen0J00UtUqkfF5eRhuRWXNxu/rcfdhynh4VqWCXkrV3D46Y13Sb7ggxw99ui0TlqHQgpObNJrbfIsTqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569436; c=relaxed/simple;
	bh=XEFH0zaNHvuwzXhUhzYoSJbrC3MfilClBp8ulIngqpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VPNzdLfIvUtD/ysVqdZz/0l5fxe96D2p5NJjMid22/DE3YD19bfkgEJTCvUb1343d9MMV0aNoD4G4tIF6IEc2sQ1sXv0egbs13gNmzMRLskTFEr00RWwShaPhsdP41p4cUTsAw1PQ0FNijxjBQgjHISRxy1qLoO4oO21UWo/ylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner06.zoner.fi (Postfix) with ESMTPS id 3B8F72119D;
	Sun, 21 Jul 2024 16:37:04 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkG-00000001SjJ-3MOl;
	Sun, 21 Jul 2024 16:37:04 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/16] xz: Fix comments and coding style
Date: Sun, 21 Jul 2024 16:36:19 +0300
Message-ID: <20240721133633.47721-5-lasse.collin@tukaani.org>
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

- Fix comments that were no longer in sync with the code below them.
- Fix language errors.
- Fix coding style.

Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 lib/decompress_unxz.c | 20 ++++++++++----------
 lib/xz/Kconfig        |  3 ++-
 scripts/Makefile.lib  | 13 ++++++++-----
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/lib/decompress_unxz.c b/lib/decompress_unxz.c
index 34bb7efc0412..46aa3be13fc5 100644
--- a/lib/decompress_unxz.c
+++ b/lib/decompress_unxz.c
@@ -102,7 +102,7 @@
 #ifdef STATIC
 #	define XZ_PREBOOT
 #else
-#include <linux/decompress/unxz.h>
+#	include <linux/decompress/unxz.h>
 #endif
 #ifdef __KERNEL__
 #	include <linux/decompress/mm.h>
@@ -219,7 +219,7 @@ void *memmove(void *dest, const void *src, size_t size)
 #endif
 
 /*
- * Since we need memmove anyway, would use it as memcpy too.
+ * Since we need memmove anyway, we could use it as memcpy too.
  * Commented out for now to avoid breaking things.
  */
 /*
@@ -389,17 +389,17 @@ STATIC int INIT unxz(unsigned char *in, long in_size,
 }
 
 /*
- * This macro is used by architecture-specific files to decompress
+ * This function is used by architecture-specific files to decompress
  * the kernel image.
  */
 #ifdef XZ_PREBOOT
-STATIC int INIT __decompress(unsigned char *buf, long len,
-			   long (*fill)(void*, unsigned long),
-			   long (*flush)(void*, unsigned long),
-			   unsigned char *out_buf, long olen,
-			   long *pos,
-			   void (*error)(char *x))
+STATIC int INIT __decompress(unsigned char *in, long in_size,
+			     long (*fill)(void *dest, unsigned long size),
+			     long (*flush)(void *src, unsigned long size),
+			     unsigned char *out, long out_size,
+			     long *in_used,
+			     void (*error)(char *x))
 {
-	return unxz(buf, len, fill, flush, out_buf, pos, error);
+	return unxz(in, in_size, fill, flush, out, in_used, error);
 }
 #endif
diff --git a/lib/xz/Kconfig b/lib/xz/Kconfig
index aef086a6bf2f..6b80453d8f54 100644
--- a/lib/xz/Kconfig
+++ b/lib/xz/Kconfig
@@ -5,7 +5,8 @@ config XZ_DEC
 	help
 	  LZMA2 compression algorithm and BCJ filters are supported using
 	  the .xz file format as the container. For integrity checking,
-	  CRC32 is supported. See Documentation/staging/xz.rst for more information.
+	  CRC32 is supported. See Documentation/staging/xz.rst for more
+	  information.
 
 if XZ_DEC
 
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 29da0dc9776d..fb7655f1a0e5 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -533,14 +533,17 @@ quiet_cmd_fit = FIT     $@
 
 # XZ
 # ---------------------------------------------------------------------------
-# Use xzkern to compress the kernel image and xzmisc to compress other things.
+# Use xzkern or xzkern_with_size to compress the kernel image and xzmisc to
+# compress other things.
 #
 # xzkern uses a big LZMA2 dictionary since it doesn't increase memory usage
 # of the kernel decompressor. A BCJ filter is used if it is available for
-# the target architecture. xzkern also appends uncompressed size of the data
-# using size_append. The .xz format has the size information available at
-# the end of the file too, but it's in more complex format and it's good to
-# avoid changing the part of the boot code that reads the uncompressed size.
+# the target architecture.
+#
+# xzkern_with_size also appends uncompressed size of the data using
+# size_append. The .xz format has the size information available at the end
+# of the file too, but it's in more complex format and it's good to avoid
+# changing the part of the boot code that reads the uncompressed size.
 # Note that the bytes added by size_append will make the xz tool think that
 # the file is corrupt. This is expected.
 #
-- 
2.45.2


