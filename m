Return-Path: <linux-kernel+bounces-345061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC7098B18A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296821C218EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C579B664;
	Tue,  1 Oct 2024 00:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nAEnwC08"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775EE79CF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 00:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727743423; cv=none; b=jtiZJy0p8N5d7Mv0g6sGtg/m2LYsY4bGiXYnnvKUDkKO5aSe+EfngTA35HR+25tcu+BgjzF3mzTIshr521xWCal6X3U25ONjY+Hb+TNR7N+WSnWGK4uCAcRSWkJ8wF/7DMH9zWc54U1GF0gOImKCo2Fa4fGftBh6nf8KjMQTNDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727743423; c=relaxed/simple;
	bh=P5bzN8Fyi+yrdR6oa6emyFTB918asqqrUurgbmkOUIs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZhW6kc4mVYHbKCnQ2jqPUb0Hd0hbnWE6qGljP6uTfc6sTmt3HY9Tx2BoJCBMgSLN6ATpMNGSfre59UN6oxZ+5ybZgby+Ab2Ya/BPQhJUUY1FxYdjVNwvH1ks/S1FSpt+LdWthA0K0zfw6of0mUqZepzrNj3ZPDlLguIsyA7dkOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nAEnwC08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F08FC4CEC7;
	Tue,  1 Oct 2024 00:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727743423;
	bh=P5bzN8Fyi+yrdR6oa6emyFTB918asqqrUurgbmkOUIs=;
	h=Date:From:To:Cc:Subject:From;
	b=nAEnwC08jnInKVjFgpzGCt6yQCJXSubmdZ4C1zMeE3/BfjfOnKLCfCA51P73Oad32
	 Th1Gow09Krprl3fCQNLM78Mz3M64LyCZg0nk/ARzMmVAuaH/ivv2WFKAJdMArpy1Uv
	 0U7Yz3I3uZvyz4Kom8D0hNuEaSy4j5GQiTMPyGuafa6BINc2AywJTNMIq/yl7U7Miw
	 E3kNYZc+VbF2Z8gXoQ9vEosZaGNOdORRDpqPOfCQZu4OqwfkiqEpw5mLcumh1cGGYl
	 xfmhIe/mHc2Vhu80SzsteW06gelRaaAnxiQbfFASt5dUxlVzSsX2mGxkIt75RqDs33
	 3wF/BOOV/xmQg==
Date: Mon, 30 Sep 2024 21:43:39 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>, Will Deacon <will@kernel.org>
Subject: [PATCH 1/1 fyi] tools headers arm64: Sync arm64's cputype.h with the
 kernel sources
Message-ID: <ZvtFu7J-Awy2zuEJ@x1>
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

To get the changes in:

  db0d8a84348b876d ("arm64: errata: Enable the AC03_CPU_38 workaround for ampere1a")

That makes this perf source code to be rebuilt:

  CC      /tmp/build/perf-tools/util/arm-spe.o

The changes in the above patch add MIDR_AMPERE1A, used in arm-spe.c, so
probably we need to add it to that array?  Or maybe we need to leave
this for later when this is all tested on those machines?

  static const struct midr_range neoverse_spe[] = {
          MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
          MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
          MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V1),
          {},
  };

Mark Rutland recommended about arm-spe.c in a previous update to this
file:

"I would not touch this for now -- someone would have to go audit the
TRMs to check that those other cores have the same encoding, and I think
it'd be better to do that as a follow-up."

That addresses this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/arm64/include/asm/cputype.h arch/arm64/include/asm/cputype.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: D Scott Phillips <scott@os.amperecomputing.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 5fd7caea44193624..5a7dfeb8e8eb55da 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -143,6 +143,7 @@
 #define APPLE_CPU_PART_M2_AVALANCHE_MAX	0x039
 
 #define AMPERE_CPU_PART_AMPERE1		0xAC3
+#define AMPERE_CPU_PART_AMPERE1A	0xAC4
 
 #define MICROSOFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
 
@@ -212,6 +213,7 @@
 #define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
 #define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
 #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
+#define MIDR_AMPERE1A MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1A)
 #define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MICROSOFT_CPU_PART_AZURE_COBALT_100)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
-- 
2.46.0


