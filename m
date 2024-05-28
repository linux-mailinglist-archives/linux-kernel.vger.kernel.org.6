Return-Path: <linux-kernel+bounces-192857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18078D2322
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868AB1F22468
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133CB482CA;
	Tue, 28 May 2024 18:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYEP8qQ8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A22B47F60
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 18:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716920054; cv=none; b=Q5/ROG2Vm3TD3asS6okbNXx/BM5gCia8bXvA8C02Xaryg7e4yDNWcJOpUZlv4D50qNyuDY27KNzerOZ6zXOjhzzSwXw/9kFkbRaL2uEZ7tEGEJIdHowf8p2yOmgsv9L+luB3PujiGbkZEGWI7JqxWNc/m5zv0gHQab+H3gKqoIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716920054; c=relaxed/simple;
	bh=eW7J25ArsEyennZdbBf0fqRZKqfZSfVryDcvJEurD+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Fy1gV2UmPaW5vHwWmRjHVu/4Bkl9jTWxaVFKTzh7ntgxBlRJUVOWgnHxYVsA7W6mjNZxKsMocSs5u4nF4tfC+Rw27EARobDdhTimOVFAjgWTakTkh37oJukMTObeIsZFspfPC2N8cxnQkI0N7mr4UD7KsSLw8n8AMtFZao42znA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYEP8qQ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3DAC3277B;
	Tue, 28 May 2024 18:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716920053;
	bh=eW7J25ArsEyennZdbBf0fqRZKqfZSfVryDcvJEurD+g=;
	h=Date:From:To:Cc:Subject:From;
	b=SYEP8qQ8SqLJ/em3CQUMJXMkoo6EwxecpN4tuXsY7+4DO+l32IgpWmKVLjCk3oMG1
	 vYd0o3q4k4oqx1JQaLZCt0RtQqal4FFuuVUtxmA6su9B3Z62rBXiH/rawveGNkOpDT
	 A9aD9Auzx7x25o/8+VAGSGNCtyfhINqtXyOkNp7/AOT7XaX+RILBoBQ4EPSxITZQBY
	 VfDVh8YFGiP1sJW3LbwyqNtGyeWM7kLLFeVqJP6FRmrLEvv3uk1+AiP+TDiqRULW1p
	 TqGfcHz7ebxlzwXCIEdSa+pfJFd6a88c1zUZK6XhCa3MxkjM/KRaTVp/Hj6QkK0t8O
	 BUxZF9faSfanw==
Date: Tue, 28 May 2024 15:14:10 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@alien8.de>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Subject: [PATCH 1/1 fyi] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <ZlYe8jOzd1_DyA7X@x1>
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

To pick up the changes from these csets:

  53bc516ade85a764 ("x86/msr: Move ARCH_CAP_XAPIC_DISABLE bit definition to its rightful place")

That patch just move definitions around, so this just silences this perf
build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index e72c2b87295799af..e022e6eb766c6405 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -170,6 +170,10 @@
 						 * CPU is not affected by Branch
 						 * History Injection.
 						 */
+#define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
+						 * IA32_XAPIC_DISABLE_STATUS MSR
+						 * supported
+						 */
 #define ARCH_CAP_PBRSB_NO		BIT(24)	/*
 						 * Not susceptible to Post-Barrier
 						 * Return Stack Buffer Predictions.
@@ -192,11 +196,6 @@
 						 * File.
 						 */
 
-#define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
-						 * IA32_XAPIC_DISABLE_STATUS MSR
-						 * supported
-						 */
-
 #define MSR_IA32_FLUSH_CMD		0x0000010b
 #define L1D_FLUSH			BIT(0)	/*
 						 * Writeback and invalidate the
-- 
2.44.0


