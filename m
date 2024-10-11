Return-Path: <linux-kernel+bounces-361653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD2399AAF4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C43528121A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39D41C7B99;
	Fri, 11 Oct 2024 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNQ3ldBY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B58038DF9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728671006; cv=none; b=XSYS6es0PNik2Xmc3cVfMwtpSXQm2YQ96adKnNefHFKfZSQnsjkSzup8VRgnfjR2lAVcqf2WU1GNtGzyaR1TPBWpSUZD2H6yxFsrIUHqqiQIQDRPv3qXm62uyiaL5ty69k+o0owd5H0oB8Qeo8ksLwF57BaeLVtmkudr1MQ6TT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728671006; c=relaxed/simple;
	bh=HEyO0nTu8MsOdlDhNl/oqYFjtVsOxx73m7/BPbJXaJk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WUOvTBs1TkqyNC6v+vummd11sxNfq79sr3vpHSGzjGpv6v3KBs+H+Vut3x/i5JpN9dF7BiVHKJ+v1nbYSLm5Ix9kw5e9hI3rUQI4ImV4cQhdakOVhOaSsFbUU0+fO2+1UqF2a4xMSLyf2/bapSoosrJYAbv79WIoIAWCFXWM98o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNQ3ldBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02813C4CEC7;
	Fri, 11 Oct 2024 18:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728671005;
	bh=HEyO0nTu8MsOdlDhNl/oqYFjtVsOxx73m7/BPbJXaJk=;
	h=Date:From:To:Cc:Subject:From;
	b=MNQ3ldBYznqHGswC7/tZbinvjKoj0e5Iok7cx6e5fuZQKDOtD351lQ9ZIDU+XxU6d
	 fM//0Sfdg5UST/jik+d3FsUU5V+xmX+brlyVDLWkdc6nmfkogffBzUcusg2c3J4YXI
	 TtlwHFRuetk3CngfCkippUN8bv+PctAmguFMt7DBj/fwKjIA4GzFzxH7SpSomxgDf0
	 Pfo+lmuxRGmlrwcyDXCZapDe4SKEEAjVZSSX90m54hGQxFie/BGKZJOjQNeM+SjBLv
	 Fz7/FNobCazNG6b/9pYByc8mD/VNiakgtr4/jHDNQSn0MD8yGp0fL39f/rPJX9iFuU
	 q0hVQn2tCiUwg==
Date: Fri, 11 Oct 2024 15:23:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/const.h with the
 kernel headers
Message-ID: <ZwltGNJwujKu1Fgn@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; Just FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
        [0] = "NORMAL",
        [1] = "RANDOM",
        [2] = "SEQUENTIAL",
        [3] = "WILLNEED",
        [4] = "DONTNEED",
        [5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

To pick up the changes in:

  947697c6f0f75f98 ("uapi: Define GENMASK_U128")

That causes no changes in tooling, just addresses this perf build
warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/const.h include/uapi/linux/const.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/const.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/include/uapi/linux/const.h b/tools/include/uapi/linux/const.h
index a429381e7ca507fe..e16be0d37746e14b 100644
--- a/tools/include/uapi/linux/const.h
+++ b/tools/include/uapi/linux/const.h
@@ -28,6 +28,23 @@
 #define _BITUL(x)	(_UL(1) << (x))
 #define _BITULL(x)	(_ULL(1) << (x))
 
+#if !defined(__ASSEMBLY__)
+/*
+ * Missing asm support
+ *
+ * __BIT128() would not work in the asm code, as it shifts an
+ * 'unsigned __init128' data type as direct representation of
+ * 128 bit constants is not supported in the gcc compiler, as
+ * they get silently truncated.
+ *
+ * TODO: Please revisit this implementation when gcc compiler
+ * starts representing 128 bit constants directly like long
+ * and unsigned long etc. Subsequently drop the comment for
+ * GENMASK_U128() which would then start supporting asm code.
+ */
+#define _BIT128(x)	((unsigned __int128)(1) << (x))
+#endif
+
 #define __ALIGN_KERNEL(x, a)		__ALIGN_KERNEL_MASK(x, (__typeof__(x))(a) - 1)
 #define __ALIGN_KERNEL_MASK(x, mask)	(((x) + (mask)) & ~(mask))
 
-- 
2.47.0


