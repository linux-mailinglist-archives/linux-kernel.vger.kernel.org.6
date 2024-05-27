Return-Path: <linux-kernel+bounces-191263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B8A8D08E7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 18:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9562880A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 16:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544AE7347E;
	Mon, 27 May 2024 16:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJp3rtJp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D52F2629C
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 16:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716828132; cv=none; b=fzcFenbLBWbJl3T0bJA3GCSGmfz2E7ZWb8s7YydyxXPn1XfBeZKcFec9pY7E9lc81QC9pmpIsDuF4roPKSQO3zM/g4sQ+L9FYtVwj2QYcinq5F6644++3qODesOXrsJoX0AjKIlfqqy6OkkTx7xj6ikDMpkrt08ylZGkGxsfUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716828132; c=relaxed/simple;
	bh=ZWuGoTD2JPYaPTkmGgmk9SxvtTBGRBdsRXzhPCF9O+4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hl3j0rs9S42I15pfxrtvsyzAfnXFb5IhdSPTse9UkEV/+tznlVnM4IZtU7mj8gESbvaFi1seYFvfa/6w6yhl5Xs+e5vI3uY9MxvJE7A1VbPZ+5srBRavKVJhO9jluR4k/n+6StgW/YRKRCV3+2hSdw4U+QvaIshjOlDy5LvXjOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJp3rtJp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8B6C2BBFC;
	Mon, 27 May 2024 16:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716828132;
	bh=ZWuGoTD2JPYaPTkmGgmk9SxvtTBGRBdsRXzhPCF9O+4=;
	h=Date:From:To:Cc:Subject:From;
	b=vJp3rtJp6vkJogCer/ztnT/qJVrxXTE/58xYj4sNoMug/XRbACAOpeKgIZjDmAmKR
	 lZnMrfgDXE8wCUU0OIQNwWcQuHS8Vg+Ue41pH+LomGfm0wbkt2kD/B8aqB8IyiDAS1
	 RHGBoXnNXhtltm2OWYCSmdhgJQJnwfffjJak3A0vTpJX354C/8sadSztMx9vf/Edj5
	 53h9R/JOENnvGEPNVXXKT5HH3tA6GZ+wOmFv52ikXdKMLu8VEGcC7XLvnwRWhCbMdk
	 ohSuySqG+WLkrilUtYu7Ff3nUjuRClfP0HW/pXWKIYhSkB++5S/emMQKtyECk5+UqU
	 72OviDvtTGWkQ==
Date: Mon, 27 May 2024 13:42:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/1 fyi] perf trace beauty: Update the
 arch/x86/include/asm/irq_vectors.h copy with the kernel sources to pick
 POSTED_MSI_NOTIFICATION
Message-ID: <ZlS34M0x30EFVhbg@x1>
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

To pick up the change in:

  f5a3562ec9dd29e6 ("x86/irq: Reserve a per CPU IDT vector for posted MSIs")

That picks up this new vector:

  $ cp arch/x86/include/asm/irq_vectors.h tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
  $ tools/perf/trace/beauty/tracepoints/x86_irq_vectors.sh > after
  $ diff -u before after
  --- before	2024-05-27 12:50:47.708863932 -0300
  +++ after	2024-05-27 12:51:15.335113123 -0300
  @@ -1,6 +1,7 @@
   static const char *x86_irq_vectors[] = {
   	[0x02] = "NMI",
   	[0x80] = "IA32_SYSCALL",
  +	[0xeb] = "POSTED_MSI_NOTIFICATION",
   	[0xec] = "LOCAL_TIMER",
   	[0xed] = "HYPERV_STIMER0",
   	[0xee] = "HYPERV_REENLIGHTENMENT",
  $

Now those will be known when pretty printing the irq_vectors:*
tracepoints.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../perf/trace/beauty/arch/x86/include/asm/irq_vectors.h  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h b/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
index d18bfb238f660fcc..13aea8fc3d45fcf4 100644
--- a/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
+++ b/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
@@ -97,10 +97,16 @@
 
 #define LOCAL_TIMER_VECTOR		0xec
 
+/*
+ * Posted interrupt notification vector for all device MSIs delivered to
+ * the host kernel.
+ */
+#define POSTED_MSI_NOTIFICATION_VECTOR	0xeb
+
 #define NR_VECTORS			 256
 
 #ifdef CONFIG_X86_LOCAL_APIC
-#define FIRST_SYSTEM_VECTOR		LOCAL_TIMER_VECTOR
+#define FIRST_SYSTEM_VECTOR		POSTED_MSI_NOTIFICATION_VECTOR
 #else
 #define FIRST_SYSTEM_VECTOR		NR_VECTORS
 #endif
-- 
2.45.1


