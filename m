Return-Path: <linux-kernel+bounces-191052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8898D0601
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848362970A4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A073661FC7;
	Mon, 27 May 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhySuJg7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D585261FC3
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 15:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823191; cv=none; b=qHiWeH/GtdXMBfPaKrpLXTDhd7IJ5s6tlucPFZEkuRkJRE6CaslJ8OrQCMz+79cl9G0lAXjbHOE2lJQS3QnC+q6GcmA7TLD3H0HjdzhUlBmtrLtVcAhRnK5R6QkB4+OQG6xaL34DskI9rMoBuQIGUl1Z2GxMlDTQrlJItwxtXDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823191; c=relaxed/simple;
	bh=2gbAwopo2HWIN0N1R10t5TTB9HarOofSo6zOGB+sApM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=UD8slnuJpFdgLuRmZ1oA40LxRj1xGK2fLUgkOHQrbV6oSCPIXToRcszKCSjSVCu3PlRucLeQyLI5/fXUQ32NCaVjceDVmSEtuJJBuRfRmqQ12L7E+5EiCM9IthBACxUVlizm8uQyX4AN85UigCpm6CygAY8rwsCrNrucfE3k1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhySuJg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3353C2BBFC;
	Mon, 27 May 2024 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716823191;
	bh=2gbAwopo2HWIN0N1R10t5TTB9HarOofSo6zOGB+sApM=;
	h=Date:From:To:Cc:Subject:From;
	b=VhySuJg7GbfoSkGyENYDL/fLRHo8O1m6nDsBi8Q5RppPqREZwt/Nxl77Rd7AWqvC6
	 u5jbUU1Gyo1M9/Yy/+Vkowk9/nINMrPCt7aIZS9AOVlH1pC0e8LQ55PjsfuJP2Rwcr
	 1WWzEA0Lt+uhFpZ22pWiKbUbmLlkTX3byeDtl93oOLYEiYdaKyT2h7VZ5PLJ3bIgfG
	 JX2368IzDjik/t6IvRvoWXW7LXlrN414v/V5ZZfbTU2AB3LqAcppzwShQI3s3xPAvR
	 QHJfKQwtQiLAAo1oeI5zjDEWyIfXqjK/9tMYq/xZDREWrwtaqs4h2QA9pr2qShQuT1
	 FLRkOO2Mpk31w==
Date: Mon, 27 May 2024 12:19:48 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH 1/1 fyi] tools headers UAPI: Sync linux/prctl.h with the
 kernel sources
Message-ID: <ZlSklGWp--v_Ije7@x1>
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

To pick the changes in:

  628d701f2de5b9a1 ("powerpc/dexcr: Add DEXCR prctl interface")
  6b9391b581fddd85 ("riscv: Include riscv_set_icache_flush_ctx prctl")

That adds some PowerPC and a RISC-V specific prctl options:

  $ tools/perf/trace/beauty/prctl_option.sh > before
  $ cp include/uapi/linux/prctl.h tools/perf/trace/beauty/include/uapi/linux/prctl.h
  $ tools/perf/trace/beauty/prctl_option.sh > after
  $ diff -u before after
  --- before	2024-05-27 12:14:21.358032781 -0300
  +++ after	2024-05-27 12:14:32.364530185 -0300
  @@ -65,6 +65,9 @@
   	[68] = "GET_MEMORY_MERGE",
   	[69] = "RISCV_V_SET_CONTROL",
   	[70] = "RISCV_V_GET_CONTROL",
  +	[71] = "RISCV_SET_ICACHE_FLUSH_CTX",
  +	[72] = "PPC_GET_DEXCR",
  +	[73] = "PPC_SET_DEXCR",
   };
   static const char *prctl_set_mm_options[] = {
   	[1] = "START_CODE",
  $

That now will be used to decode the syscall option and also to compose
filters, for instance:

  [root@five ~]# perf trace -e syscalls:sys_enter_prctl --filter option==SET_NAME
       0.000 Isolated Servi/3474327 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23f13b7aee)
       0.032 DOM Worker/3474327 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23deb25670)
       7.920 :3474328/3474328 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24fbb10)
       7.935 StreamT~s #374/3474328 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24fb970)
       8.400 Isolated Servi/3474329 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24bab10)
       8.418 StreamT~s #374/3474329 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7f23e24ba970)
  ^C[root@five ~]#

This addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/include/uapi/linux/prctl.h include/uapi/linux/prctl.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Benjamin Gray <bgray@linux.ibm.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 .../trace/beauty/include/uapi/linux/prctl.h   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/trace/beauty/include/uapi/linux/prctl.h b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
index 370ed14b1ae0928c..35791791a879b288 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/prctl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
@@ -306,4 +306,26 @@ struct prctl_mm_map {
 # define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
 # define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
 
+#define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
+# define PR_RISCV_CTX_SW_FENCEI_ON	0
+# define PR_RISCV_CTX_SW_FENCEI_OFF	1
+# define PR_RISCV_SCOPE_PER_PROCESS	0
+# define PR_RISCV_SCOPE_PER_THREAD	1
+
+/* PowerPC Dynamic Execution Control Register (DEXCR) controls */
+#define PR_PPC_GET_DEXCR		72
+#define PR_PPC_SET_DEXCR		73
+/* DEXCR aspect to act on */
+# define PR_PPC_DEXCR_SBHE		0 /* Speculative branch hint enable */
+# define PR_PPC_DEXCR_IBRTPD		1 /* Indirect branch recurrent target prediction disable */
+# define PR_PPC_DEXCR_SRAPD		2 /* Subroutine return address prediction disable */
+# define PR_PPC_DEXCR_NPHIE		3 /* Non-privileged hash instruction enable */
+/* Action to apply / return */
+# define PR_PPC_DEXCR_CTRL_EDITABLE	 0x1 /* Aspect can be modified with PR_PPC_SET_DEXCR */
+# define PR_PPC_DEXCR_CTRL_SET		 0x2 /* Set the aspect for this process */
+# define PR_PPC_DEXCR_CTRL_CLEAR	 0x4 /* Clear the aspect for this process */
+# define PR_PPC_DEXCR_CTRL_SET_ONEXEC	 0x8 /* Set the aspect on exec */
+# define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
+# define PR_PPC_DEXCR_CTRL_MASK		0x1f
+
 #endif /* _LINUX_PRCTL_H */
-- 
2.45.1


