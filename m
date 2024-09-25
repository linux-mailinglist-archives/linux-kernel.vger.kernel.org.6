Return-Path: <linux-kernel+bounces-339692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B01298692B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 00:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A867C1C23241
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B07B156F23;
	Wed, 25 Sep 2024 22:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVJzsw4I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E12148838
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727303301; cv=none; b=oxaLdvCSIPrB78Gw8ZwuwgbSrq11fhvDRFXtpbok8eT/CUq2BYOequSPjZuKya95yqQK7ldQ2h+XEu+RRdrQPRUNZoumxg7K00lxEkld5oPvg4p9Ry4gID0Gp7PU/sBZ0dhrWrClhtUJ/nbv7J1RWzGDRtAwB6M4aWGOQkEDvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727303301; c=relaxed/simple;
	bh=cE+zJj+RRxFJpslmJFHiN/+FOWMr/gRNrNJ//B6y6fs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KddGAOSHwAQstMQ56brdIGA3XvzYsJXb3G3ogkKx6uxtug1ONK4APuVHxUamzAgoIOBs/qV5TzsO2nhqHsHYISE62Nv9FT42Npbxtw7a3smr9SxYbMfFIygUNRjY8yCzXNeQb2bZRUeYaaVU4Oz6UtSk7FK4P3tl5OmIOqL9bM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVJzsw4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE16C4CEC3;
	Wed, 25 Sep 2024 22:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727303301;
	bh=cE+zJj+RRxFJpslmJFHiN/+FOWMr/gRNrNJ//B6y6fs=;
	h=Date:From:To:Cc:Subject:From;
	b=BVJzsw4I4DLCWTsHKXZtmWkfCRV0VWq8IQReGRMpribe88G64vMzEcuePhsgeb5In
	 kZVOXKEDbCPz2Pit2S5kKvd6eM57qMg27yP/4vYbuFmDVkPUK5GhXk7PlnrpC+AeRs
	 gZ2k6wcl7gdb0NhsZ9y5eYVrxDnkO1apwliUYncIre8U2iukZsCz/PGM4asxma4OhY
	 qV5l5xNu2u3NxHh12xPVbIXcgisrxc3h9nEItCYdtCp6gRj58w9ALPhvg0CIlVrfqy
	 thvn7e3XaLFbI1sT/UPzFBmvJe018xIs8IO+F7bIshYvgACXBRSpuUcpiyjKXBllPv
	 hdXufGb/Hns7Q==
Date: Wed, 25 Sep 2024 12:28:20 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org, kernle-team@meta.com, sched-ext@meta.com
Subject: [PATCH sched_ext/for-6.12-fixes] tools/sched_ext: Receive misc
 updates from SCX repo
Message-ID: <ZvSOhNJT1giUi4nh@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From a748db0c8c6a88da66c3ab3791bd1a229f4a7fee Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Wed, 25 Sep 2024 12:22:37 -1000

Receive misc tools/sched_ext updates from https://github.com/sched-ext/scx
to sync userspace bits.

- LSP macros to help language servers.

- bpf_cpumask_weight() declaration and cast_mask() helper.

- Cosmetic updates to scx_flatcg.bpf.c.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applied to sched_ext/for-6.12-fixes.

Thanks.

 tools/sched_ext/include/scx/common.bpf.h     | 15 +++++++++++++++
 tools/sched_ext/include/scx/user_exit_info.h |  4 ++++
 tools/sched_ext/scx_flatcg.bpf.c             |  5 ++---
 3 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index f538c75db183..225f61f9bfca 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -7,7 +7,13 @@
 #ifndef __SCX_COMMON_BPF_H
 #define __SCX_COMMON_BPF_H
 
+#ifdef LSP
+#define __bpf__
+#include "../vmlinux/vmlinux.h"
+#else
 #include "vmlinux.h"
+#endif
+
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 #include <asm-generic/errno.h>
@@ -309,6 +315,15 @@ void bpf_cpumask_copy(struct bpf_cpumask *dst, const struct cpumask *src) __ksym
 u32 bpf_cpumask_any_distribute(const struct cpumask *cpumask) __ksym;
 u32 bpf_cpumask_any_and_distribute(const struct cpumask *src1,
 				   const struct cpumask *src2) __ksym;
+u32 bpf_cpumask_weight(const struct cpumask *cpumask) __ksym;
+
+/*
+ * Access a cpumask in read-only mode (typically to check bits).
+ */
+const struct cpumask *cast_mask(struct bpf_cpumask *mask)
+{
+	return (const struct cpumask *)mask;
+}
 
 /* rcu */
 void bpf_rcu_read_lock(void) __ksym;
diff --git a/tools/sched_ext/include/scx/user_exit_info.h b/tools/sched_ext/include/scx/user_exit_info.h
index 891693ee604e..8ce2734402e1 100644
--- a/tools/sched_ext/include/scx/user_exit_info.h
+++ b/tools/sched_ext/include/scx/user_exit_info.h
@@ -25,7 +25,11 @@ struct user_exit_info {
 
 #ifdef __bpf__
 
+#ifdef LSP
+#include "../vmlinux/vmlinux.h"
+#else
 #include "vmlinux.h"
+#endif
 #include <bpf/bpf_core_read.h>
 
 #define UEI_DEFINE(__name)							\
diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
index 936415b98ae7..e272bc39bbbd 100644
--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -225,7 +225,7 @@ static void cgrp_refresh_hweight(struct cgroup *cgrp, struct fcg_cgrp_ctx *cgc)
 				break;
 
 			/*
-			 * We can be oppotunistic here and not grab the
+			 * We can be opportunistic here and not grab the
 			 * cgv_tree_lock and deal with the occasional races.
 			 * However, hweight updates are already cached and
 			 * relatively low-frequency. Let's just do the
@@ -258,8 +258,7 @@ static void cgrp_cap_budget(struct cgv_node *cgv_node, struct fcg_cgrp_ctx *cgc)
 	 * and thus can't be updated and repositioned. Instead, we collect the
 	 * vtime deltas separately and apply it asynchronously here.
 	 */
-	delta = cgc->cvtime_delta;
-	__sync_fetch_and_sub(&cgc->cvtime_delta, delta);
+	delta = __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
 	cvtime = cgv_node->cvtime + delta;
 
 	/*
-- 
2.46.0


