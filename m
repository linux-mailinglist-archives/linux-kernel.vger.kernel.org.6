Return-Path: <linux-kernel+bounces-258194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B200A9384DE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22020B212CF
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3235016849F;
	Sun, 21 Jul 2024 13:44:05 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AB01662FD;
	Sun, 21 Jul 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569444; cv=none; b=opUASRW35c6ocJ77CtzVZlF7XXZV4h41Hy2ock8DOH7d6RTQkMSU+cM0uMrTCloqUN7XB+8oVnRDQiCZju4RHY0/sErO59Ozmki3ZFPs0J3arFCpFTopv/vkwNsHj8Ehgm150FjzFmauIbtcDb6XTiIl7nUFLEo6NfnmpaqJGUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569444; c=relaxed/simple;
	bh=hd2/aP4JJajf13tV7LZL+ATAtMpbkgGP2R4Ggtzvn8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qW0l+gBZkU+LZjo/DNcWiPPfevlwDuBT5H/t1+qc82XBTd5iJuUh23XOen0b+Uv1x5vPJeWHXl7m+NPXR6gmq6VgRAnbLxxgQ4+YJHcxdwsQu7LNkg0qaybVDtO9/iVHhV9gu0RPDYrqRf6h13bOL2n+hYiAWpgZ/QyCmBud9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id 968BC42DD6;
	Sun, 21 Jul 2024 16:37:04 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkH-00000001SjJ-0oju;
	Sun, 21 Jul 2024 16:37:04 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org,
	Rui Li <me@lirui.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 07/16] xz: Documentation/staging/xz.rst: Revise thoroughly
Date: Sun, 21 Jul 2024 16:36:22 +0300
Message-ID: <20240721133633.47721-8-lasse.collin@tukaani.org>
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

Add SPDX license identifier.

Omit xz_dec_test info. That isn't relevant to developers of non-XZ code.

Revise the docs about xzkern and add xzkern_with_size. The latter was
added to scripts/Makefile.lib in the commit 7ce7e984ab2b ("kbuild: rename
cmd_{bzip2,lzma,lzo,lz4,xzkern,zstd22}").

Omit contact info as MAINTAINERS has it.

Omit other info that is outdated or not relevant in the kernel context.

Include the xz_dec kernel-doc from include/linux/xz.h.

Cc: Rui Li <me@lirui.org>
Cc: linux-doc@vger.kernel.org
Reviewed-by: Sam James <sam@gentoo.org>
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 Documentation/staging/xz.rst | 160 +++++++++++++++--------------------
 1 file changed, 67 insertions(+), 93 deletions(-)

diff --git a/Documentation/staging/xz.rst b/Documentation/staging/xz.rst
index b2f5ff12a161..e1054e9a8e65 100644
--- a/Documentation/staging/xz.rst
+++ b/Documentation/staging/xz.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: 0BSD
+
 ============================
 XZ data compression in Linux
 ============================
@@ -6,62 +8,55 @@ Introduction
 ============
 
 XZ is a general purpose data compression format with high compression
-ratio and relatively fast decompression. The primary compression
-algorithm (filter) is LZMA2. Additional filters can be used to improve
-compression ratio even further. E.g. Branch/Call/Jump (BCJ) filters
-improve compression ratio of executable data.
-
-The XZ decompressor in Linux is called XZ Embedded. It supports
-the LZMA2 filter and optionally also BCJ filters. CRC32 is supported
-for integrity checking. The home page of XZ Embedded is at
-<https://tukaani.org/xz/embedded.html>, where you can find the
-latest version and also information about using the code outside
-the Linux kernel.
-
-For userspace, XZ Utils provide a zlib-like compression library
-and a gzip-like command line tool. XZ Utils can be downloaded from
-<https://tukaani.org/xz/>.
+ratio. The XZ decompressor in Linux is called XZ Embedded. It supports
+the LZMA2 filter and optionally also Branch/Call/Jump (BCJ) filters
+for executable code. CRC32 is supported for integrity checking.
+
+See the `XZ Embedded`_ home page for the latest version which includes
+a few optional extra features that aren't required in the Linux kernel
+and information about using the code outside the Linux kernel.
+
+For userspace, `XZ Utils`_ provide a zlib-like compression library
+and a gzip-like command line tool.
+
+.. _XZ Embedded: https://tukaani.org/xz/embedded.html
+.. _XZ Utils: https://tukaani.org/xz/
 
 XZ related components in the kernel
 ===================================
 
 The xz_dec module provides XZ decompressor with single-call (buffer
-to buffer) and multi-call (stateful) APIs. The usage of the xz_dec
-module is documented in include/linux/xz.h.
-
-The xz_dec_test module is for testing xz_dec. xz_dec_test is not
-useful unless you are hacking the XZ decompressor. xz_dec_test
-allocates a char device major dynamically to which one can write
-.xz files from userspace. The decompressed output is thrown away.
-Keep an eye on dmesg to see diagnostics printed by xz_dec_test.
-See the xz_dec_test source code for the details.
+to buffer) and multi-call (stateful) APIs in include/linux/xz.h.
 
 For decompressing the kernel image, initramfs, and initrd, there
 is a wrapper function in lib/decompress_unxz.c. Its API is the
 same as in other decompress_*.c files, which is defined in
 include/linux/decompress/generic.h.
 
-scripts/xz_wrap.sh is a wrapper for the xz command line tool found
-from XZ Utils. The wrapper sets compression options to values suitable
-for compressing the kernel image.
+For kernel makefiles, three commands are provided for use with
+``$(call if_changed)``. They require the xz tool from XZ Utils.
+
+- ``$(call if_changed,xzkern)`` is for compressing the kernel image.
+  It runs the script scripts/xz_wrap.sh which uses arch-optimized
+  options and a big LZMA2 dictionary.
 
-For kernel makefiles, two commands are provided for use with
-$(call if_needed). The kernel image should be compressed with
-$(call if_needed,xzkern) which will use a BCJ filter and a big LZMA2
-dictionary. It will also append a four-byte trailer containing the
-uncompressed size of the file, which is needed by the boot code.
-Other things should be compressed with $(call if_needed,xzmisc)
-which will use no BCJ filter and 1 MiB LZMA2 dictionary.
+- ``$(call if_changed,xzkern_with_size)`` is like ``xzkern`` above but
+  this also appends a four-byte trailer containing the uncompressed size
+  of the file. The trailer is needed by the boot code on some archs.
+
+- Other things can be compressed with ``$(call if_needed,xzmisc)``
+  which will use no BCJ filter and 1 MiB LZMA2 dictionary.
 
 Notes on compression options
 ============================
 
-Since the XZ Embedded supports only streams with no integrity check or
-CRC32, make sure that you don't use some other integrity check type
-when encoding files that are supposed to be decoded by the kernel. With
-liblzma, you need to use either LZMA_CHECK_NONE or LZMA_CHECK_CRC32
-when encoding. With the xz command line tool, use --check=none or
---check=crc32.
+Since the XZ Embedded supports only streams with CRC32 or no integrity
+check, make sure that you don't use some other integrity check type
+when encoding files that are supposed to be decoded by the kernel.
+With liblzma from XZ Utils, you need to use either ``LZMA_CHECK_CRC32``
+or ``LZMA_CHECK_NONE`` when encoding. With the ``xz`` command line tool,
+use ``--check=crc32`` or ``--check=none`` to override the default
+``--check=crc64``.
 
 Using CRC32 is strongly recommended unless there is some other layer
 which will verify the integrity of the uncompressed data anyway.
@@ -71,57 +66,36 @@ by the decoder; you can only change the integrity check type (or
 disable it) for the actual uncompressed data.
 
 In userspace, LZMA2 is typically used with dictionary sizes of several
-megabytes. The decoder needs to have the dictionary in RAM, thus big
-dictionaries cannot be used for files that are intended to be decoded
-by the kernel. 1 MiB is probably the maximum reasonable dictionary
-size for in-kernel use (maybe more is OK for initramfs). The presets
-in XZ Utils may not be optimal when creating files for the kernel,
-so don't hesitate to use custom settings. Example::
-
-	xz --check=crc32 --lzma2=dict=512KiB inputfile
-
-An exception to above dictionary size limitation is when the decoder
-is used in single-call mode. Decompressing the kernel itself is an
-example of this situation. In single-call mode, the memory usage
-doesn't depend on the dictionary size, and it is perfectly fine to
-use a big dictionary: for maximum compression, the dictionary should
-be at least as big as the uncompressed data itself.
-
-Future plans
-============
+megabytes. The decoder needs to have the dictionary in RAM:
+
+- In multi-call mode the dictionary is allocated as part of the
+  decoder state. The reasonable maximum dictionary size for in-kernel
+  use will depend on the target hardware: a few megabytes is fine for
+  desktop systems while 64 KiB to 1 MiB might be more appropriate on
+  some embedded systems.
+
+- In single-call mode the output buffer is used as the dictionary
+  buffer. That is, the size of the dictionary doesn't affect the
+  decompressor memory usage at all. Only the base data structures
+  are allocated which take a little less than 30 KiB of memory.
+  For the best compression, the dictionary should be at least
+  as big as the uncompressed data. A notable example of single-call
+  mode is decompressing the kernel itself (except on PowerPC).
+
+The compression presets in XZ Utils may not be optimal when creating
+files for the kernel, so don't hesitate to use custom settings to,
+for example, set the dictionary size. Also, xz may produce a smaller
+file in single-threaded mode so setting that explicitly is recommended.
+Example::
+
+    xz --threads=1 --check=crc32 --lzma2=dict=512KiB inputfile
+
+xz_dec API
+==========
+
+This is available with ``#include <linux/xz.h>``.
+
+``XZ_EXTERN`` is a macro used in the preboot code. Ignore it when
+reading this documentation.
 
-Creating a limited XZ encoder may be considered if people think it is
-useful. LZMA2 is slower to compress than e.g. Deflate or LZO even at
-the fastest settings, so it isn't clear if LZMA2 encoder is wanted
-into the kernel.
-
-Support for limited random-access reading is planned for the
-decompression code. I don't know if it could have any use in the
-kernel, but I know that it would be useful in some embedded projects
-outside the Linux kernel.
-
-Conformance to the .xz file format specification
-================================================
-
-There are a couple of corner cases where things have been simplified
-at expense of detecting errors as early as possible. These should not
-matter in practice all, since they don't cause security issues. But
-it is good to know this if testing the code e.g. with the test files
-from XZ Utils.
-
-Reporting bugs
-==============
-
-Before reporting a bug, please check that it's not fixed already
-at upstream. See <https://tukaani.org/xz/embedded.html> to get the
-latest code.
-
-Report bugs to <lasse.collin@tukaani.org> or visit #tukaani on
-Freenode and talk to Larhzu. I don't actively read LKML or other
-kernel-related mailing lists, so if there's something I should know,
-you should email to me personally or use IRC.
-
-Don't bother Igor Pavlov with questions about the XZ implementation
-in the kernel or about XZ Utils. While these two implementations
-include essential code that is directly based on Igor Pavlov's code,
-these implementations aren't maintained nor supported by him.
+.. kernel-doc:: include/linux/xz.h
-- 
2.45.2


