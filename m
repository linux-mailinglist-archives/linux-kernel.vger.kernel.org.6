Return-Path: <linux-kernel+bounces-385159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFBF9B334C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37762282F50
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 14:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B731DD87D;
	Mon, 28 Oct 2024 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI7aAs6d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEBC1DE2C9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730125318; cv=none; b=TduClJEiW+sOtiBmwzW4mSsbZTB2o/d7hr2d48A2CRDumOKKrUX9uyb/1iyF2tJap278OzOtxItLtITDfAJT0SP3LL5kVmDDbEhGvkwJ7AouS7iMgP/wzlMzPOY88M3UtPGKPPD5qxlA/0B2yYtIbqJYJRrzfKQO31/WtISvEdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730125318; c=relaxed/simple;
	bh=hlb7GxVlE8k+4DrKaLRqKOCfrPot/tAVRCYBWPXQtw8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JK/9D1bwjOls1oE6e7cZDs4tvIYF1NPAVJnNQp5qd52WWA947hZLZzaFkWNtZob+lm9h+12ZsfwwOTuZZJCS1wBJNzEu4JzG6JofCsTw+o9/Yy38703jU4ZZqe75Qx3PXb7j5GgZ/CBuZ1G3MmWOV6mv4x9P6MSX3fexF4nrvcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI7aAs6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF90C4CECD;
	Mon, 28 Oct 2024 14:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730125318;
	bh=hlb7GxVlE8k+4DrKaLRqKOCfrPot/tAVRCYBWPXQtw8=;
	h=Date:From:To:Cc:Subject:From;
	b=DI7aAs6d4puAeYbfWjKRXQv8IwG+FTQCSKwWG4R2TtO+JBafb9Gp8GY0B7Y0EPNP2
	 XoYAVKb/HJIALXrkj6R+gMidGGma0pf3pWRfT/Skaf8BS+/sICsQk1KkuGvmd0TGKY
	 k8HPcgPtepQz+EN7FCaa/zhj0iihpWQqw4NR1f8JNnPlhonpzr/09GCjjAY+4GR7fz
	 ExUwOJ1PnDW8Nc4wTX23fN1ZDU18HpqE6QV/3+iSv5YscA3hRKYD770JzOxmjPMI1v
	 VwRuix+mXuJouJwkTDaMNzYiy+Ayba01wdCWJ3NLpoXHAa1Kn6bRo1c1bizANRcyQJ
	 00+k5zuEuOePA==
Date: Mon, 28 Oct 2024 11:19:41 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] tools headers arm64: Sync arm64's cputype.h with the
 kernel sources
Message-ID: <Zx-dffKdGsgkhG96@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tldr; FYI, I'm carrying this on the perf tools tree.

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

See further details at:

 https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README
Reply-To: 

To get the changes in:

  924725707d80bc25 ("arm64: cputype: Add Neoverse-N3 definitions")

That makes this perf source code to be rebuilt:

  CC      /tmp/build/perf-tools/util/arm-spe.o

The changes in the above patch add MIDR_NEOVERSE_N3, that probably need
changes in arm-spe.c, so probably we need to add it to that array?  Or
maybe we need to leave this for later when this is all tested on those
machines?

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
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/arm64/include/asm/cputype.h b/tools/arch/arm64/include/asm/cputype.h
index 5a7dfeb8e8eb55da..488f8e75134959f5 100644
--- a/tools/arch/arm64/include/asm/cputype.h
+++ b/tools/arch/arm64/include/asm/cputype.h
@@ -94,6 +94,7 @@
 #define ARM_CPU_PART_NEOVERSE_V3	0xD84
 #define ARM_CPU_PART_CORTEX_X925	0xD85
 #define ARM_CPU_PART_CORTEX_A725	0xD87
+#define ARM_CPU_PART_NEOVERSE_N3	0xD8E
 
 #define APM_CPU_PART_XGENE		0x000
 #define APM_CPU_VAR_POTENZA		0x00
@@ -176,6 +177,7 @@
 #define MIDR_NEOVERSE_V3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V3)
 #define MIDR_CORTEX_X925 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_X925)
 #define MIDR_CORTEX_A725 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A725)
+#define MIDR_NEOVERSE_N3 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N3)
 #define MIDR_THUNDERX	MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX)
 #define MIDR_THUNDERX_81XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_81XX)
 #define MIDR_THUNDERX_83XX MIDR_CPU_MODEL(ARM_CPU_IMP_CAVIUM, CAVIUM_CPU_PART_THUNDERX_83XX)
-- 
2.47.0


