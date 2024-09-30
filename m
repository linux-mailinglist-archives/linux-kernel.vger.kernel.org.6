Return-Path: <linux-kernel+bounces-344411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A3DE98A93E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F40D282F67
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB87191F8A;
	Mon, 30 Sep 2024 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOp5Ivph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE57333062
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727711826; cv=none; b=ZZKczFQgosfUBt1700r/Nz4mpj4yWO8AxSebk7pO3kSqAj+ktAKOrdvEuXHnJiB/gC3gweJ8CARw7aNi4gyHYeXagHQQ3xHErH96dOPNJbz5lpykt7iPnqoQSm1fRPD8h9h3r0I7cOa3JG4/CYP1QDSo9UHzOtuSqtdSlvzoSck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727711826; c=relaxed/simple;
	bh=OAUZo0XVCbIHxvTam7w6e0A+nu54AlPC/kAMVpGVhKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qcXARYQ8L1tjKLR9lOD48unKOVDOZscbVyJCkFmEeB8M7LseQCfJFhXeQPPnlYo4RPUfJ5o3ngIrXAjWdKDWqX14wBDqA8bJJ61TuF8g+8bTaG62di29t0Om5hZPTWZessmTTcTn8t2Xw+e5ts84N8E0HBYyJQQFAHRXg14+qGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOp5Ivph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF2FC4CEC7;
	Mon, 30 Sep 2024 15:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727711826;
	bh=OAUZo0XVCbIHxvTam7w6e0A+nu54AlPC/kAMVpGVhKA=;
	h=Date:From:To:Cc:Subject:From;
	b=YOp5IvphtEoXATBhvNoYYI8LF0g8YeshXNS2kBdOzm1DLTmvGl8A0ZujG9Wl8hF3t
	 HSjtMiOg9MDM9QE1FWZXMEFP3jBRt2JXbcvLQPexVonW/c4Rvp1Y1a2HjFxHcat+F5
	 Fr4/QOztpcxRuMCjRiQZ+oLxNP1bkGGy9pEwLF1c/2igEgqcxibXkKPFw/nVuiF4VS
	 5EH+Sh0aNtCV6+qqyutVoW/YP88YhoNAhSGv6Sv+7zNrOthUE3ae67vOmt48iLJ8rQ
	 jzZ77v9MRV5UYc6q4jynUwIeg8hb0jbeARb0mF409zTKzRASM4nLPw7CNQyViOQ9Ww
	 cAna0ok8ql8yw==
Date: Mon, 30 Sep 2024 12:57:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Sohil Mehta <sohil.mehta@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/1 fyi] perf trace beauty: Update the
 arch/x86/include/asm/irq_vectors.h copy with the kernel sources
Message-ID: <ZvrKT7oQc1AOv6Vk@x1>
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

  a1fab3e69d9d0e9b ("x86/irq: Fix comment on IRQ vector layout")

That just adds some comments, so no changes in perf tooling, just
silences this build warning:

  diff -u tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h arch/x86/include/asm/irq_vectors.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h b/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
index 13aea8fc3d45fcf4..47051871b436182f 100644
--- a/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
+++ b/tools/perf/trace/beauty/arch/x86/include/asm/irq_vectors.h
@@ -18,8 +18,8 @@
  *  Vectors   0 ...  31 : system traps and exceptions - hardcoded events
  *  Vectors  32 ... 127 : device interrupts
  *  Vector  128         : legacy int80 syscall interface
- *  Vectors 129 ... LOCAL_TIMER_VECTOR-1
- *  Vectors LOCAL_TIMER_VECTOR ... 255 : special interrupts
+ *  Vectors 129 ... FIRST_SYSTEM_VECTOR-1 : device interrupts
+ *  Vectors FIRST_SYSTEM_VECTOR ... 255   : special interrupts
  *
  * 64-bit x86 has per CPU IDT tables, 32-bit has one shared IDT table.
  *
-- 
2.46.0


