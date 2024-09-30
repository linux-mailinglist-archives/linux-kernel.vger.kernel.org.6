Return-Path: <linux-kernel+bounces-344392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B17E298A8FF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FAE1F212FA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F7A18FDD8;
	Mon, 30 Sep 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0wNyO8g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC663D5
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711275; cv=none; b=nMQQ5bt83eZs/brvXGBHjegqcdvIKBs0WKbKlM6JnKqVI3ipoBi1WMFzWwn9ye1R5oxQAXAiiEQEUI5qoIH022Vm/Tg9AX2VgT+WOcT1xJo0QY6H+opzW6t7cXuSn5u+8Fc/jbQVbbg8wSewaBef4LDZEUCD7ID+ziF8HjTPbRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711275; c=relaxed/simple;
	bh=L6DBlEG4Hvvi/4d5XLAmrgOW+5Jwg2Mq/MiLrSHyzJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aVftPgmQuHJiqpw61ptsnTDnzBJkObHzMZSbuEiZIpAIBRhtTFpNPvkL/prCNAJfiK4ssIeZeUEt0cgKKi1pVkLyZz7exDiJprrqZ4B3LkfL2s8+5nnVs0PsxHsnkstIsxzWgHc9HWf+zUlYf4RqcwDOciGAUii8rP1BYkSiNLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0wNyO8g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A6FC4CEC7;
	Mon, 30 Sep 2024 15:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727711275;
	bh=L6DBlEG4Hvvi/4d5XLAmrgOW+5Jwg2Mq/MiLrSHyzJ0=;
	h=Date:From:To:Cc:Subject:From;
	b=m0wNyO8gTD7KWlxwhiLS07bMT6/cSPBGFIC2e+P9rLHiLXZl6MmcKHzT36KmWVHpR
	 HLakEVCJhI6yi98rqx9Dmzx8F3WbL4LUoFJ3fbM+Bkp3hFET4/gCmY1iYr0ONSLiZt
	 GokTq5yweOyenEY66jxXAekGeX1zlb22rdBKZnfwiKwj43AC185vQ5FAhkWCAbn4ce
	 g0BBm20I51c6FWOU1VZdPfrG6OWLnvyumSVtK5Idbp4/B7vNOw5yUSEzxpKP6iEyHY
	 GOMTkd4Pa4xSz9DC6IIocTpHMN+RCrUYhi1OSOCjNuIIP8W6ZHplxU+ryiLqIv03Eb
	 +BaKdWnf99LPg==
Date: Mon, 30 Sep 2024 12:47:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/1 fyi] tools include UAPI: Sync linux/fcntl.h copy with the
 kernel sources
Message-ID: <ZvrIKL3cREoRHIQd@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Picking the changes from:

  4356d575ef0f39a3 ("fhandle: expose u64 mount id to name_to_handle_at(2)")
  b4fef22c2fb97fa2 ("uapi: explain how per-syscall AT_* flags should be allocated")
  820a185896b77814 ("fcntl: add F_CREATED_QUERY")

It just moves AT_REMOVEDIR around, and adds a bunch more AT_ for
renameat2() and name_to_handle_at(). We need to improve this situation,
as not all AT_ defines are applicable to all fs flags...

This adds support for those new AT_ defines, addressing this build
warning:

  diff -u tools/perf/trace/beauty/include/uapi/sound/asound.h include/uapi/sound/asound.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/fs_at_flags.sh        |  5 ++
 .../trace/beauty/include/uapi/linux/fcntl.h   | 84 +++++++++++++------
 2 files changed, 65 insertions(+), 24 deletions(-)

diff --git a/tools/perf/trace/beauty/fs_at_flags.sh b/tools/perf/trace/beauty/fs_at_flags.sh
index 456f59addf741062..e3f13f96a27c227c 100755
--- a/tools/perf/trace/beauty/fs_at_flags.sh
+++ b/tools/perf/trace/beauty/fs_at_flags.sh
@@ -13,9 +13,14 @@ printf "static const char *fs_at_flags[] = {\n"
 regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+AT_([^_]+[[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
 # AT_EACCESS is only meaningful to faccessat, so we will special case it there...
 # AT_STATX_SYNC_TYPE is not a bit, its a mask of AT_STATX_SYNC_AS_STAT, AT_STATX_FORCE_SYNC and AT_STATX_DONT_SYNC
+# AT_HANDLE_FID and AT_HANDLE_MNT_ID_UNIQUE are reusing values and are valid only for name_to_handle_at()
+# AT_RENAME_NOREPLACE reuses 0x1 and is valid only for renameat2()
 grep -E $regex ${linux_fcntl} | \
 	grep -v AT_EACCESS | \
 	grep -v AT_STATX_SYNC_TYPE | \
+	grep -v AT_HANDLE_FID | \
+	grep -v AT_HANDLE_MNT_ID_UNIQUE | \
+	grep -v AT_RENAME_NOREPLACE | \
 	sed -r "s/$regex/\2 \1/g"	| \
 	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n"
 printf "};\n"
diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index c0bcc185fa48f852..87e2dec79fea4ef2 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -16,6 +16,9 @@
 
 #define F_DUPFD_QUERY	(F_LINUX_SPECIFIC_BASE + 3)
 
+/* Was the file just created? */
+#define F_CREATED_QUERY	(F_LINUX_SPECIFIC_BASE + 4)
+
 /*
  * Cancel a blocking posix lock; internal use only until we expose an
  * asynchronous lock api to userspace:
@@ -87,37 +90,70 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+#define AT_FDCWD		-100    /* Special value for dirfd used to
+					   indicate openat should use the
+					   current working directory. */
+
+
+/* Generic flags for the *at(2) family of syscalls. */
+
+/* Reserved for per-syscall flags	0xff. */
+#define AT_SYMLINK_NOFOLLOW		0x100   /* Do not follow symbolic
+						   links. */
+/* Reserved for per-syscall flags	0x200 */
+#define AT_SYMLINK_FOLLOW		0x400   /* Follow symbolic links. */
+#define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
+						   traversal. */
+#define AT_EMPTY_PATH			0x1000	/* Allow empty relative
+						   pathname to operate on dirfd
+						   directly. */
+/*
+ * These flags are currently statx(2)-specific, but they could be made generic
+ * in the future and so they should not be used for other per-syscall flags.
+ */
+#define AT_STATX_SYNC_TYPE		0x6000	/* Type of synchronisation required from statx() */
+#define AT_STATX_SYNC_AS_STAT		0x0000	/* - Do whatever stat() does */
+#define AT_STATX_FORCE_SYNC		0x2000	/* - Force the attributes to be sync'd with the server */
+#define AT_STATX_DONT_SYNC		0x4000	/* - Don't sync attributes with the server */
+
+#define AT_RECURSIVE			0x8000	/* Apply to the entire subtree */
+
 /*
- * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS is
- * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
- * unlinkat.  The two functions do completely different things and therefore,
- * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
- * faccessat would be undefined behavior and thus treating it equivalent to
- * AT_EACCESS is valid undefined behavior.
+ * Per-syscall flags for the *at(2) family of syscalls.
+ *
+ * These are flags that are so syscall-specific that a user passing these flags
+ * to the wrong syscall is so "clearly wrong" that we can safely call such
+ * usage "undefined behaviour".
+ *
+ * For example, the constants AT_REMOVEDIR and AT_EACCESS have the same value.
+ * AT_EACCESS is meaningful only to faccessat, while AT_REMOVEDIR is meaningful
+ * only to unlinkat. The two functions do completely different things and
+ * therefore, the flags can be allowed to overlap. For example, passing
+ * AT_REMOVEDIR to faccessat would be undefined behavior and thus treating it
+ * equivalent to AT_EACCESS is valid undefined behavior.
+ *
+ * Note for implementers: When picking a new per-syscall AT_* flag, try to
+ * reuse already existing flags first. This leaves us with as many unused bits
+ * as possible, so we can use them for generic bits in the future if necessary.
  */
-#define AT_FDCWD		-100    /* Special value used to indicate
-                                           openat should use the current
-                                           working directory. */
-#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
+
+/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
+#define AT_RENAME_NOREPLACE	0x0001
+#define AT_RENAME_EXCHANGE	0x0002
+#define AT_RENAME_WHITEOUT	0x0004
+
+/* Flag for faccessat(2). */
 #define AT_EACCESS		0x200	/* Test access permitted for
                                            effective IDs, not real IDs.  */
+/* Flag for unlinkat(2). */
 #define AT_REMOVEDIR		0x200   /* Remove directory instead of
                                            unlinking file.  */
-#define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
-#define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
-#define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
-
-#define AT_STATX_SYNC_TYPE	0x6000	/* Type of synchronisation required from statx() */
-#define AT_STATX_SYNC_AS_STAT	0x0000	/* - Do whatever stat() does */
-#define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
-#define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
-
-#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
+/* Flags for name_to_handle_at(2). */
+#define AT_HANDLE_FID		0x200	/* File handle is needed to compare
+					   object identity and may not be
+					   usable with open_by_handle_at(2). */
+#define AT_HANDLE_MNT_ID_UNIQUE	0x001	/* Return the u64 unique mount ID. */
 
-/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
-#define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
-					compare object identity and may not
-					be usable to open_by_handle_at(2) */
 #if defined(__KERNEL__)
 #define AT_GETATTR_NOSEC	0x80000000
 #endif
-- 
2.46.0


