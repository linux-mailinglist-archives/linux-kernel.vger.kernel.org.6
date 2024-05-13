Return-Path: <linux-kernel+bounces-177449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962488C3ECF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 12:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07701B2373F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5349A14A0AF;
	Mon, 13 May 2024 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="zYbqSc/z"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7516A14BF8D
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595822; cv=none; b=qRKpQnIXCzf7zMoASr99y08L1WXK78+mQ4cV3M/vyjXznf9QoCG7EdoEX1Jh01Z1SxqLC0Pa2V8DrTFit8cP6lB3y4K0p5LrWDl1O/mB/yUarGuczdNVv83jstiPbBfI7BG7UyXC5JFoekMelApM2WLePdN1C5w1WujwvRyM+Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595822; c=relaxed/simple;
	bh=zNoO3TGNt53DpymRhJbqpaAM8wYTkYGLujh9zuHKWUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ErOkPEW7cIYqSRONI2sP+ZJoPb9R68XK+b49LoPv1Gsn0Svt0QuGOqZo94OCuwBn7BJSwQWIWy9l7WAUYDUpuZjeMTdvzg1+qzle/XS5xOnxxrxRvvojhTwnpnqXy4AgjLKwnPODuCscofdr5zJHTGY9IdtEVEk3j29t/7idW20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=zYbqSc/z; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1715595816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YMCk3QCTKq/g7VpLGuVrxPpSogwMZaPOszYZbr21za4=;
	b=zYbqSc/ziPZ4Tx+GqOoE8Ua17xY80ctiOGcKEGjf6NH4aDNfWFehrM8uU8w2NWLwxLfHxj
	ECNQVSGQFlaSGn9/a/AhesKJvgF/gnEh3hi8dnuTDBOS37wPNDCHaVpE7blSPmyDSLmPeq
	beyCcQERG72467unRPGy45q8pe7TBvZTCms3flWWdqOXvF7yUmh9THrybFuPMx3+/KikMR
	1il93oO14y5F7i8VMuPagO39iJtKRH+yimh6yeIycIEEPh4I3TOd4EILIrPEEkkOHMKD6k
	ZtHlDgyomeuQEKSGWy9qcerF6NokXEOALNi8Z2HpxCTz5vF3+FhbI9GHYLdBmA==
From: Diederik de Haas <didi.debian@cknow.org>
To: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Joe Perches <joe@perches.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH] docs: dev-tools: checkpatch: Add targets for checkpatch tags
Date: Mon, 13 May 2024 12:22:21 +0200
Message-ID: <20240513102237.112376-1-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Make the tags directly linkable by defining targets for them.

Closes: https://lore.kernel.org/r/8090211.0vHzs8tI1a@bagend/
Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
---
 Documentation/dev-tools/checkpatch.rst | 216 +++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/Documentation/dev-tools/checkpatch.rst b/Documentation/dev-tools/checkpatch.rst
index 127968995847..6499e29c3a19 100644
--- a/Documentation/dev-tools/checkpatch.rst
+++ b/Documentation/dev-tools/checkpatch.rst
@@ -242,6 +242,8 @@ This section contains a description of all the message types in checkpatch.
 Allocation style
 ----------------
 
+  .. _alloc-array-args:
+
   **ALLOC_ARRAY_ARGS**
     The first argument for kcalloc or kmalloc_array should be the
     number of elements.  sizeof() as the first argument is generally
@@ -249,6 +251,8 @@ Allocation style
 
     See: https://www.kernel.org/doc/html/latest/core-api/memory-allocation.html
 
+  .. _alloc-sizeof-struct:
+
   **ALLOC_SIZEOF_STRUCT**
     The allocation style is bad.  In general for family of
     allocation functions using sizeof() to get memory size,
@@ -262,6 +266,8 @@ Allocation style
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#allocating-memory
 
+  .. _alloc-with-multiply:
+
   **ALLOC_WITH_MULTIPLY**
     Prefer kmalloc_array/kcalloc over kmalloc/kzalloc with a
     sizeof multiply.
@@ -272,16 +278,22 @@ Allocation style
 API usage
 ---------
 
+  .. _arch-defines:
+
   **ARCH_DEFINES**
     Architecture specific defines should be avoided wherever
     possible.
 
+  .. _arch-include-linux:
+
   **ARCH_INCLUDE_LINUX**
     Whenever asm/file.h is included and linux/file.h exists, a
     conversion can be made when linux/file.h includes asm/file.h.
     However this is not always the case (See signal.h).
     This message type is emitted only for includes from arch/.
 
+  .. _avoid-bug:
+
   **AVOID_BUG**
     BUG() or BUG_ON() should be avoided totally.
     Use WARN() and WARN_ON() instead, and handle the "impossible"
@@ -289,6 +301,8 @@ API usage
 
     See: https://www.kernel.org/doc/html/latest/process/deprecated.html#bug-and-bug-on
 
+  .. _consider-kstrto:
+
   **CONSIDER_KSTRTO**
     The simple_strtol(), simple_strtoll(), simple_strtoul(), and
     simple_strtoull() functions explicitly ignore overflows, which
@@ -298,6 +312,8 @@ API usage
 
     See: https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
 
+  .. _constant-conversion:
+
   **CONSTANT_CONVERSION**
     Use of __constant_<foo> form is discouraged for the following functions::
 
@@ -334,6 +350,8 @@ API usage
 
     See: https://lore.kernel.org/lkml/1400106425.12666.6.camel@joe-AO725/
 
+  .. _deprecated-api:
+
   **DEPRECATED_API**
     Usage of a deprecated RCU API is detected.  It is recommended to replace
     old flavourful RCU APIs by their new vanilla-RCU counterparts.
@@ -342,6 +360,8 @@ API usage
 
     See: https://www.kernel.org/doc/html/latest/RCU/whatisRCU.html#full-list-of-rcu-apis
 
+  .. _deprecated-variable:
+
   **DEPRECATED_VARIABLE**
     EXTRA_{A,C,CPP,LD}FLAGS are deprecated and should be replaced by the new
     flags added via commit f77bf01425b1 ("kbuild: introduce ccflags-y,
@@ -360,6 +380,8 @@ API usage
       2. https://lore.kernel.org/lkml/1313384834-24433-12-git-send-email-lacombar@gmail.com/
       3. https://www.kernel.org/doc/html/latest/kbuild/makefiles.html#compilation-flags
 
+  .. _device-attr-functions:
+
   **DEVICE_ATTR_FUNCTIONS**
     The function names used in DEVICE_ATTR is unusual.
     Typically, the store and show functions are used with <attr>_store and
@@ -374,6 +396,8 @@ API usage
 
     See: https://www.kernel.org/doc/html/latest/driver-api/driver-model/device.html#attributes
 
+  .. _device-attr-ro:
+
   **DEVICE_ATTR_RO**
     The DEVICE_ATTR_RO(name) helper macro can be used instead of
     DEVICE_ATTR(name, 0444, name_show, NULL);
@@ -383,6 +407,8 @@ API usage
 
     See: https://www.kernel.org/doc/html/latest/driver-api/driver-model/device.html#attributes
 
+  .. _device-attr-rw:
+
   **DEVICE_ATTR_RW**
     The DEVICE_ATTR_RW(name) helper macro can be used instead of
     DEVICE_ATTR(name, 0644, name_show, name_store);
@@ -392,6 +418,8 @@ API usage
 
     See: https://www.kernel.org/doc/html/latest/driver-api/driver-model/device.html#attributes
 
+  .. _device-attr-wo:
+
   **DEVICE_ATTR_WO**
     The DEVICE_AATR_WO(name) helper macro can be used instead of
     DEVICE_ATTR(name, 0200, NULL, name_store);
@@ -401,6 +429,8 @@ API usage
 
     See: https://www.kernel.org/doc/html/latest/driver-api/driver-model/device.html#attributes
 
+  .. _duplicated-sysctl-const:
+
   **DUPLICATED_SYSCTL_CONST**
     Commit d91bff3011cf ("proc/sysctl: add shared variables for range
     check") added some shared const variables to be used instead of a local
@@ -419,6 +449,8 @@ API usage
       1. https://lore.kernel.org/lkml/20190430180111.10688-1-mcroce@redhat.com/
       2. https://lore.kernel.org/lkml/20190531131422.14970-1-mcroce@redhat.com/
 
+  .. _enosys:
+
   **ENOSYS**
     ENOSYS means that a nonexistent system call was called.
     Earlier, it was wrongly used for things like invalid operations on
@@ -426,15 +458,21 @@ API usage
 
     See: https://lore.kernel.org/lkml/5eb299021dec23c1a48fa7d9f2c8b794e967766d.1408730669.git.luto@amacapital.net/
 
+  .. _enotsupp:
+
   **ENOTSUPP**
     ENOTSUPP is not a standard error code and should be avoided in new patches.
     EOPNOTSUPP should be used instead.
 
     See: https://lore.kernel.org/netdev/20200510182252.GA411829@lunn.ch/
 
+  .. _export-symbol:
+
   **EXPORT_SYMBOL**
     EXPORT_SYMBOL should immediately follow the symbol to be exported.
 
+  .. _in-atomic:
+
   **IN_ATOMIC**
     in_atomic() is not for driver use so any such use is reported as an ERROR.
     Also in_atomic() is often used to determine if sleeping is permitted,
@@ -445,6 +483,8 @@ API usage
 
     See: https://lore.kernel.org/lkml/20080320201723.b87b3732.akpm@linux-foundation.org/
 
+  .. _lockdep:
+
   **LOCKDEP**
     The lockdep_no_validate class was added as a temporary measure to
     prevent warnings on conversion of device->sem to device->mutex.
@@ -452,20 +492,28 @@ API usage
 
     See: https://lore.kernel.org/lkml/1268959062.9440.467.camel@laptop/
 
+  .. _malformed-include:
+
   **MALFORMED_INCLUDE**
     The #include statement has a malformed path.  This has happened
     because the author has included a double slash "//" in the pathname
     accidentally.
 
+  .. _use-lockdep:
+
   **USE_LOCKDEP**
     lockdep_assert_held() annotations should be preferred over
     assertions based on spin_is_locked()
 
     See: https://www.kernel.org/doc/html/latest/locking/lockdep-design.html#annotations
 
+  .. _uapi-include:
+
   **UAPI_INCLUDE**
     No #include statements in include/uapi should use a uapi/ path.
 
+  .. _usleep-range:
+
   **USLEEP_RANGE**
     usleep_range() should be preferred over udelay(). The proper way of
     using usleep_range() is mentioned in the kernel docs.
@@ -476,6 +524,8 @@ API usage
 Comments
 --------
 
+  .. _block-comment-style:
+
   **BLOCK_COMMENT_STYLE**
     The comment style is incorrect.  The preferred style for multi-
     line comments is::
@@ -500,12 +550,16 @@ Comments
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#commenting
 
+  .. _data-race:
+
   **DATA_RACE**
     Applications of data_race() should have a comment so as to document the
     reasoning behind why it was deemed safe.
 
     See: https://lore.kernel.org/lkml/20200401101714.44781-1-elver@google.com/
 
+  .. _fsf-mailing-address:
+
   **FSF_MAILING_ADDRESS**
     Kernel maintainers reject new instances of the GPL boilerplate paragraph
     directing people to write to the FSF for a copy of the GPL, since the
@@ -519,12 +573,16 @@ Comments
 Commit message
 --------------
 
+  .. _bad-sign-off:
+
   **BAD_SIGN_OFF**
     The signed-off-by line does not fall in line with the standards
     specified by the community.
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1
 
+  .. _bad-stable-address-style:
+
   **BAD_STABLE_ADDRESS_STYLE**
     The email format for stable is incorrect.
     Some valid options for stable address are::
@@ -536,17 +594,23 @@ Commit message
 
       stable@vger.kernel.org # version info
 
+  .. _commit-comment-symbol:
+
   **COMMIT_COMMENT_SYMBOL**
     Commit log lines starting with a '#' are ignored by git as
     comments.  To solve this problem addition of a single space
     infront of the log line is enough.
 
+  .. _commit-message:
+
   **COMMIT_MESSAGE**
     The patch is missing a commit description.  A brief
     description of the changes made by the patch should be added.
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 
+  .. _email-subject:
+
   **EMAIL_SUBJECT**
     Naming the tool that found the issue is not very useful in the
     subject line.  A good subject line summarizes the change that
@@ -554,6 +618,8 @@ Commit message
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 
+  .. _from-sign-off-mismatch:
+
   **FROM_SIGN_OFF_MISMATCH**
     The author's email does not match with that in the Signed-off-by:
     line(s). This can be sometimes caused due to an improperly configured
@@ -566,6 +632,8 @@ Commit message
       - The email subaddresses do not match.
       - The email comments do not match.
 
+  .. _missing-sign-off:
+
   **MISSING_SIGN_OFF**
     The patch is missing a Signed-off-by line.  A signed-off-by
     line should be added according to Developer's certificate of
@@ -573,6 +641,8 @@ Commit message
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
 
+  .. _no-author-sign-off:
+
   **NO_AUTHOR_SIGN_OFF**
     The author of the patch has not signed off the patch.  It is
     required that a simple sign off line should be present at the
@@ -582,6 +652,8 @@ Commit message
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin
 
+  .. _diff-in-commit-msg:
+
   **DIFF_IN_COMMIT_MSG**
     Avoid having diff content in commit message.
     This causes problems when one tries to apply a file containing both
@@ -590,6 +662,8 @@ Commit message
 
     See: https://lore.kernel.org/lkml/20150611134006.9df79a893e3636019ad2759e@linux-foundation.org/
 
+  .. _gerrit-change-id:
+
   **GERRIT_CHANGE_ID**
     To be picked up by gerrit, the footer of the commit message might
     have a Change-Id like::
@@ -599,6 +673,8 @@ Commit message
 
     The Change-Id line must be removed before submitting.
 
+  .. _git-commit-id:
+
   **GIT_COMMIT_ID**
     The proper way to reference a commit id is:
     commit <12+ chars of sha1> ("<title line>")
@@ -612,6 +688,8 @@ Commit message
 
     See: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes
 
+  .. _bad-fixes-tag:
+
   **BAD_FIXES_TAG**
     The Fixes: tag is malformed or does not follow the community conventions.
     This can occur if the tag have been split into multiple lines (e.g., when
@@ -623,6 +701,8 @@ Commit message
 Comparison style
 ----------------
 
+  .. _assign-in-if:
+
   **ASSIGN_IN_IF**
     Do not use assignments in if condition.
     Example::
@@ -634,16 +714,22 @@ Comparison style
       foo = bar(...);
       if (foo < BAZ) {
 
+  .. _bool-comparison:
+
   **BOOL_COMPARISON**
     Comparisons of A to true and false are better written
     as A and !A.
 
     See: https://lore.kernel.org/lkml/1365563834.27174.12.camel@joe-AO722/
 
+  .. _comparison-to-null:
+
   **COMPARISON_TO_NULL**
     Comparisons to NULL in the form (foo == NULL) or (foo != NULL)
     are better written as (!foo) and (foo).
 
+  .. _constant-comparison:
+
   **CONSTANT_COMPARISON**
     Comparisons with a constant or upper case identifier on the left
     side of the test should be avoided.
@@ -652,6 +738,8 @@ Comparison style
 Indentation and Line Breaks
 ---------------------------
 
+  .. _code-indent:
+
   **CODE_INDENT**
     Code indent should use tabs instead of spaces.
     Outside of comments, documentation and Kconfig,
@@ -659,6 +747,8 @@ Indentation and Line Breaks
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#indentation
 
+  .. _deep-indentation:
+
   **DEEP_INDENTATION**
     Indentation with 6 or more tabs usually indicate overly indented
     code.
@@ -668,6 +758,8 @@ Indentation and Line Breaks
 
     See: https://lore.kernel.org/lkml/1328311239.21255.24.camel@joe2Laptop/
 
+  .. _switch-case-indent-level:
+
   **SWITCH_CASE_INDENT_LEVEL**
     switch should be at the same indent as case.
     Example::
@@ -691,6 +783,8 @@ Indentation and Line Breaks
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#indentation
 
+  .. _long-line:
+
   **LONG_LINE**
     The line has exceeded the specified maximum length.
     To use a different maximum line length, the --max-line-length=n option
@@ -703,6 +797,8 @@ Indentation and Line Breaks
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
 
+  .. _long-line-string:
+
   **LONG_LINE_STRING**
     A string starts before but extends beyond the maximum line length.
     To use a different maximum line length, the --max-line-length=n option
@@ -710,6 +806,8 @@ Indentation and Line Breaks
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
 
+  .. _long-line-comment:
+
   **LONG_LINE_COMMENT**
     A comment starts before but extends beyond the maximum line length.
     To use a different maximum line length, the --max-line-length=n option
@@ -717,12 +815,16 @@ Indentation and Line Breaks
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking-long-lines-and-strings
 
+  .. _split-string:
+
   **SPLIT_STRING**
     Quoted strings that appear as messages in userspace and can be
     grepped, should not be split across multiple lines.
 
     See: https://lore.kernel.org/lkml/20120203052727.GA15035@leaf/
 
+  .. _multiline-dereference:
+
   **MULTILINE_DEREFERENCE**
     A single dereferencing identifier spanned on multiple lines like::
 
@@ -750,6 +852,8 @@ Indentation and Line Breaks
     violation because it is much easier to read a dereferencing identifier
     on a single line.
 
+  .. _trailing-statements:
+
   **TRAILING_STATEMENTS**
     Trailing statements (for example after any conditional) should be
     on the next line.
@@ -766,6 +870,8 @@ Indentation and Line Breaks
 Macros, Attributes and Symbols
 ------------------------------
 
+  .. _array-size:
+
   **ARRAY_SIZE**
     The ARRAY_SIZE(foo) macro should be preferred over
     sizeof(foo)/sizeof(foo[0]) for finding number of elements in an
@@ -775,10 +881,14 @@ Macros, Attributes and Symbols
 
       #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
 
+  .. _avoid-externs:
+
   **AVOID_EXTERNS**
     Function prototypes don't need to be declared extern in .h
     files.  It's assumed by the compiler and is unnecessary.
 
+  .. _avoid-l-prefix:
+
   **AVOID_L_PREFIX**
     Local symbol names that are prefixed with `.L` should be avoided,
     as this has special meaning for the assembler; a symbol entry will
@@ -791,12 +901,16 @@ Macros, Attributes and Symbols
     the beginning or end of code regions via
     `SYM_CODE_START_LOCAL`/`SYM_CODE_END`
 
+  .. _bit-macro:
+
   **BIT_MACRO**
     Defines like: 1 << <digit> could be BIT(digit).
     The BIT() macro is defined via include/linux/bits.h::
 
       #define BIT(nr)         (1UL << (nr))
 
+  .. _const-read-mostly:
+
   **CONST_READ_MOSTLY**
     When a variable is tagged with the __read_mostly annotation, it is a
     signal to the compiler that accesses to the variable will be mostly
@@ -805,6 +919,8 @@ Macros, Attributes and Symbols
     const __read_mostly does not make any sense as const data is already
     read-only.  The __read_mostly annotation thus should be removed.
 
+  .. _date-time:
+
   **DATE_TIME**
     It is generally desirable that building the same source code with
     the same set of tools is reproducible, i.e. the output is always
@@ -816,6 +932,8 @@ Macros, Attributes and Symbols
 
     See: https://www.kernel.org/doc/html/latest/kbuild/reproducible-builds.html#timestamps
 
+  .. _define-arch-has:
+
   **DEFINE_ARCH_HAS**
     The ARCH_HAS_xyz and ARCH_HAVE_xyz patterns are wrong.
 
@@ -827,9 +945,13 @@ Macros, Attributes and Symbols
 
     See: https://lore.kernel.org/lkml/CA+55aFycQ9XJvEOsiM3txHL5bjUc8CeKWJNR_H+MiicaddB42Q@mail.gmail.com/
 
+  .. _do-while-macro-with-trailing-semicolon:
+
   **DO_WHILE_MACRO_WITH_TRAILING_SEMICOLON**
     do {} while(0) macros should not have a trailing semicolon.
 
+  .. _init-attribute:
+
   **INIT_ATTRIBUTE**
     Const init definitions should use __initconst instead of
     __initdata.
@@ -837,6 +959,8 @@ Macros, Attributes and Symbols
     Similarly init definitions without const require a separate
     use of const.
 
+  .. _inline-location:
+
   **INLINE_LOCATION**
     The inline keyword should sit between storage class and type.
 
@@ -854,6 +978,8 @@ Macros, Attributes and Symbols
               ...
       }
 
+  .. _misplaced-init:
+
   **MISPLACED_INIT**
     It is possible to use section markers on variables in a way
     which gcc doesn't understand (or at least not the way the
@@ -868,6 +994,8 @@ Macros, Attributes and Symbols
 
     See: https://lore.kernel.org/lkml/1377655732.3619.19.camel@joe-AO722/
 
+  .. _multistatement-macro-use-do-while:
+
   **MULTISTATEMENT_MACRO_USE_DO_WHILE**
     Macros with multiple statements should be enclosed in a
     do - while block.  Same should also be the case for macros
@@ -881,10 +1009,14 @@ Macros, Attributes and Symbols
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl
 
+  .. _prefer-fallthrough:
+
   **PREFER_FALLTHROUGH**
     Use the `fallthrough;` pseudo keyword instead of
     `/* fallthrough */` like comments.
 
+  .. _trailing-semicolon:
+
   **TRAILING_SEMICOLON**
     Macro definition should not end with a semicolon. The macro
     invocation style should be consistent with function calls.
@@ -906,6 +1038,8 @@ Macros, Attributes and Symbols
 
     See: https://lore.kernel.org/lkml/1399671106.2912.21.camel@joe-AO725/
 
+  .. _single-statement-do-while-macro:
+
   **SINGLE_STATEMENT_DO_WHILE_MACRO**
     For the multi-statement macros, it is necessary to use the do-while
     loop to avoid unpredictable code paths. The do-while loop helps to
@@ -917,6 +1051,8 @@ Macros, Attributes and Symbols
     the do-while loop is redundant. So remove the do-while loop for single
     statement macros.
 
+  .. _weak-declaration:
+
   **WEAK_DECLARATION**
     Using weak declarations like __attribute__((weak)) or __weak
     can have unintended link defects.  Avoid using them.
@@ -925,15 +1061,21 @@ Macros, Attributes and Symbols
 Functions and Variables
 -----------------------
 
+  .. _camelcase:
+
   **CAMELCASE**
     Avoid CamelCase Identifiers.
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#naming
 
+  .. _const-const:
+
   **CONST_CONST**
     Using `const <type> const *` is generally meant to be
     written `const <type> * const`.
 
+  .. _const-struct:
+
   **CONST_STRUCT**
     Using const is generally a good idea.  Checkpatch reads
     a list of frequently used structs that are always or
@@ -944,6 +1086,8 @@ Functions and Variables
 
     See: https://lore.kernel.org/lkml/alpine.DEB.2.10.1608281509480.3321@hadrien/
 
+  .. _embedded-function-name:
+
   **EMBEDDED_FUNCTION_NAME**
     Embedded function names are less appropriate to use as
     refactoring can cause function renaming.  Prefer the use of
@@ -952,6 +1096,8 @@ Functions and Variables
     Note that this does not work with -f (--file) checkpatch option
     as it depends on patch context providing the function name.
 
+  .. _function-arguments:
+
   **FUNCTION_ARGUMENTS**
     This warning is emitted due to any of the following reasons:
 
@@ -972,6 +1118,8 @@ Functions and Variables
 
          All arguments should have identifier names.
 
+  .. _function-without-args:
+
   **FUNCTION_WITHOUT_ARGS**
     Function declarations without arguments like::
 
@@ -981,22 +1129,30 @@ Functions and Variables
 
       int foo(void)
 
+  .. _global-initialisers:
+
   **GLOBAL_INITIALISERS**
     Global variables should not be initialized explicitly to
     0 (or NULL, false, etc.).  Your compiler (or rather your
     loader, which is responsible for zeroing out the relevant
     sections) automatically does it for you.
 
+  .. _initialised-static:
+
   **INITIALISED_STATIC**
     Static variables should not be initialized explicitly to zero.
     Your compiler (or rather your loader) automatically does
     it for you.
 
+  .. _multiple-assignments:
+
   **MULTIPLE_ASSIGNMENTS**
     Multiple assignments on a single line makes the code unnecessarily
     complicated. So on a single line assign value to a single variable
     only, this makes the code more readable and helps avoid typos.
 
+  .. _return-parentheses:
+
   **RETURN_PARENTHESES**
     return is not a function and as such doesn't need parentheses::
 
@@ -1010,6 +1166,8 @@ Functions and Variables
 Permissions
 -----------
 
+  .. _device-attr-perms:
+
   **DEVICE_ATTR_PERMS**
     The permissions used in DEVICE_ATTR are unusual.
     Typically only three permissions are used - 0644 (RW), 0444 (RO)
@@ -1017,10 +1175,14 @@ Permissions
 
     See: https://www.kernel.org/doc/html/latest/filesystems/sysfs.html#attributes
 
+  .. _execute-permissions:
+
   **EXECUTE_PERMISSIONS**
     There is no reason for source files to be executable.  The executable
     bit can be removed safely.
 
+  .. _exported-world-writable:
+
   **EXPORTED_WORLD_WRITABLE**
     Exporting world writable sysfs/debugfs files is usually a bad thing.
     When done arbitrarily they can introduce serious security bugs.
@@ -1030,10 +1192,14 @@ Permissions
 
     See: https://lore.kernel.org/linux-arm-kernel/cover.1296818921.git.segoon@openwall.com/
 
+  .. _non-octal-permissions:
+
   **NON_OCTAL_PERMISSIONS**
     Permission bits should use 4 digit octal permissions (like 0700 or 0444).
     Avoid using any other base like decimal.
 
+  .. _symbolic-perms:
+
   **SYMBOLIC_PERMS**
     Permission bits in the octal form are more readable and easier to
     understand than their symbolic counterparts because many command-line
@@ -1049,10 +1215,14 @@ Permissions
 Spacing and Brackets
 --------------------
 
+  .. _assignment-continuations:
+
   **ASSIGNMENT_CONTINUATIONS**
     Assignment operators should not be written at the start of a
     line but should follow the operand at the previous line.
 
+  .. _braces:
+
   **BRACES**
     The placement of braces is stylistically incorrect.
     The preferred way is to put the opening brace last on the line,
@@ -1073,6 +1243,8 @@ Spacing and Brackets
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces
 
+  .. _bracket-space:
+
   **BRACKET_SPACE**
     Whitespace before opening bracket '[' is prohibited.
     There are some exceptions:
@@ -1089,6 +1261,8 @@ Spacing and Brackets
 
         = { [0...10] = 5 }
 
+  .. _concatenated-string:
+
   **CONCATENATED_STRING**
     Concatenated elements should have a space in between.
     Example::
@@ -1099,17 +1273,23 @@ Spacing and Brackets
 
       printk(KERN_INFO "bar");
 
+  .. _else-after-brace:
+
   **ELSE_AFTER_BRACE**
     `else {` should follow the closing block `}` on the same line.
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces
 
+  .. _line-spacing:
+
   **LINE_SPACING**
     Vertical space is wasted given the limited number of lines an
     editor window can display when multiple blank lines are used.
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#spaces
 
+  .. _open-brace:
+
   **OPEN_BRACE**
     The opening brace should be following the function definitions on the
     next line.  For any non-functional block it should be on the same line
@@ -1117,6 +1297,8 @@ Spacing and Brackets
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#placing-braces-and-spaces
 
+  .. _pointer-location:
+
   **POINTER_LOCATION**
     When using pointer data or a function that returns a pointer type,
     the preferred use of * is adjacent to the data name or function name
@@ -1129,11 +1311,15 @@ Spacing and Brackets
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#spaces
 
+  .. _spacing:
+
   **SPACING**
     Whitespace style used in the kernel sources is described in kernel docs.
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#spaces
 
+  .. _trailing-whitespace:
+
   **TRAILING_WHITESPACE**
     Trailing whitespace should always be removed.
     Some editors highlight the trailing whitespace and cause visual
@@ -1141,6 +1327,8 @@ Spacing and Brackets
 
     See: https://www.kernel.org/doc/html/latest/process/coding-style.html#spaces
 
+  .. _unnecessary-parentheses:
+
   **UNNECESSARY_PARENTHESES**
     Parentheses are not required in the following cases:
 
@@ -1172,6 +1360,8 @@ Spacing and Brackets
           &foo->bar
           *foo->bar
 
+  .. _while-after-brace:
+
   **WHILE_AFTER_BRACE**
     while should follow the closing bracket on the same line::
 
@@ -1185,19 +1375,27 @@ Spacing and Brackets
 Others
 ------
 
+  .. _config-description:
+
   **CONFIG_DESCRIPTION**
     Kconfig symbols should have a help text which fully describes
     it.
 
+  .. _corrupted-patch:
+
   **CORRUPTED_PATCH**
     The patch seems to be corrupted or lines are wrapped.
     Please regenerate the patch file before sending it to the maintainer.
 
+  .. _cvs-keyword:
+
   **CVS_KEYWORD**
     Since linux moved to git, the CVS markers are no longer used.
     So, CVS style keywords ($Id$, $Revision$, $Log$) should not be
     added.
 
+  .. _default-no-break:
+
   **DEFAULT_NO_BREAK**
     switch default case is sometimes written as "default:;".  This can
     cause new cases added below default to be defective.
@@ -1205,16 +1403,22 @@ Others
     A "break;" should be added after empty default statement to avoid
     unwanted fallthrough.
 
+  .. _dos-line-endings:
+
   **DOS_LINE_ENDINGS**
     For DOS-formatted patches, there are extra ^M symbols at the end of
     the line.  These should be removed.
 
+  .. _dt-schema-binding-patch:
+
   **DT_SCHEMA_BINDING_PATCH**
     DT bindings moved to a json-schema based format instead of
     freeform text.
 
     See: https://www.kernel.org/doc/html/latest/devicetree/bindings/writing-schema.html
 
+  .. _dt-split-binding-patch:
+
   **DT_SPLIT_BINDING_PATCH**
     Devicetree bindings should be their own patch.  This is because
     bindings are logically independent from a driver implementation,
@@ -1224,20 +1428,28 @@ Others
 
     See: https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters
 
+  .. _embedded-filename:
+
   **EMBEDDED_FILENAME**
     Embedding the complete filename path inside the file isn't particularly
     useful as often the path is moved around and becomes incorrect.
 
+  .. _file-path-changes:
+
   **FILE_PATH_CHANGES**
     Whenever files are added, moved, or deleted, the MAINTAINERS file
     patterns can be out of sync or outdated.
 
     So MAINTAINERS might need updating in these cases.
 
+  .. _memset:
+
   **MEMSET**
     The memset use appears to be incorrect.  This may be caused due to
     badly ordered parameters.  Please recheck the usage.
 
+  .. _not-unified-diff:
+
   **NOT_UNIFIED_DIFF**
     The patch file does not appear to be in unified-diff format.  Please
     regenerate the patch file before sending it to the maintainer.
@@ -1245,6 +1457,8 @@ Others
   **PRINTF_0XDECIMAL**
     Prefixing 0x with decimal output is defective and should be corrected.
 
+  .. _spdx-license-tag:
+
   **SPDX_LICENSE_TAG**
     The source file is missing or has an improper SPDX identifier tag.
     The Linux kernel requires the precise SPDX identifier in all source files,
@@ -1252,5 +1466,7 @@ Others
 
     See: https://www.kernel.org/doc/html/latest/process/license-rules.html
 
+  .. _typo-spelling:
+
   **TYPO_SPELLING**
     Some words may have been misspelled.  Consider reviewing them.
-- 
2.43.0


