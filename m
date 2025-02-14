Return-Path: <linux-kernel+bounces-515528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51ADCA365E8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3991189553E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 18:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF91B193074;
	Fri, 14 Feb 2025 18:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0HKoZQC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAAD134AB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 18:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739558988; cv=none; b=JLu1/ASm2jERXf8qBGHlI1C5qmZ+3kC8ntXwfaGxn1rz95mBcvGC8jFCAwrjSZNIvKIu3ioTnTTs37QjiTOEsRf7ZVvmNJA83U5KNKpOWTkXwCKvCESJFGBuC+gd5lStReKd+3VCLV/FZzns4KiAnSWC/T1NJgkEYiu2Guoiec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739558988; c=relaxed/simple;
	bh=RO7lWffb5udWAoeJjtojwuIq2kWE79q14hclcnwcyiA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Tfr98XM+0HFtGjQv0nrilhzXn85BCDWE/pb5WOvJTGmiul2uQKs2tF/cPwoCmtZ4DoM37TdwMLZHlqDc4SnMu4sSRTqee+S7z1k9GoG0/njkZGrMBCKNE9x1C4y/aUm+o7jDme4Gva5OEWVIbDT+52wJzdgAn3KgBJaIwxm0jSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0HKoZQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92B64C4CED1;
	Fri, 14 Feb 2025 18:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739558987;
	bh=RO7lWffb5udWAoeJjtojwuIq2kWE79q14hclcnwcyiA=;
	h=Date:From:To:Cc:Subject:From;
	b=P0HKoZQCIpcUwntz0DsgS97mAyMuD4FjttLah1Rw3UTtidrRgbwa/D/5geV+j3nhx
	 Owbqa8yO0TiNGm12QkKoMsUVtHYU2prgUn88tVZer23Rj+uuDHxr2ni7PPmAIFGU1l
	 17r+sPieOAKQ3OGgM+fTPmFm31Z7PiVDjvVQMzEJUf/4SIgrH7Xof2intcA/P0X0z0
	 OQPSBRRP0iuKFraiATHpaa/bfcGpEVBW0NNibqjV55RyAc6rAUvxjNxAs2RKYlbFFH
	 7CwDMK/lBCTbfqLLZxVUTG2Z7eHZxlcf/e0R3Mu3ZPMO+S+NOc5haMz2pO2JDvd7Rh
	 8Ua+UoMWWsTUA==
Date: Fri, 14 Feb 2025 08:49:46 -1000
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.15] tools/sched_ext: Sync with scx repo
Message-ID: <Z6-QSpiAYi-OISua@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From f2c880fc8133e4607f9e0e22d08e5e2098c3604a Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 14 Feb 2025 08:46:20 -1000

Synchronize with https://github.com/sched-ext/scx at d384453984a0 ("kernel:
Sync at ad3b301aa05a ("sched_ext: Provides a sysfs 'events' to expose core
event counters")").

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Applied to sched_ext/for-6.15.

Thanks.

 tools/sched_ext/include/scx/common.bpf.h | 29 +++++++++++++++++++++---
 tools/sched_ext/scx_central.bpf.c        |  2 --
 tools/sched_ext/scx_central.c            | 15 +++++++++---
 3 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index f1caf9fc8f8c..77bbe0199a32 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -7,6 +7,13 @@
 #ifndef __SCX_COMMON_BPF_H
 #define __SCX_COMMON_BPF_H
 
+/*
+ * The generated kfunc prototypes in vmlinux.h are missing address space
+ * attributes which cause build failures. For now, suppress the generated
+ * prototypes. See https://github.com/sched-ext/scx/issues/1111.
+ */
+#define BPF_NO_KFUNC_PROTOTYPES
+
 #ifdef LSP
 #define __bpf__
 #include "../vmlinux.h"
@@ -78,10 +85,7 @@ s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
 struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;
 u64 scx_bpf_now(void) __ksym __weak;
-
 void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __weak;
-#define scx_read_event(e, name)							\
-	(bpf_core_field_exists((e)->name) ? (e)->name : 0)
 
 /*
  * Use the following as @it__iter when calling scx_bpf_dsq_move[_vtime]() from
@@ -89,6 +93,9 @@ void scx_bpf_events(struct scx_event_stats *events, size_t events__sz) __ksym __
  */
 #define BPF_FOR_EACH_ITER	(&___it)
 
+#define scx_read_event(e, name)							\
+	(bpf_core_field_exists((e)->name) ? (e)->name : 0)
+
 static inline __attribute__((format(printf, 1, 2)))
 void ___scx_bpf_bstr_format_checker(const char *fmt, ...) {}
 
@@ -581,6 +588,22 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 	__u.__val;					\
 })
 
+#define READ_ONCE_ARENA(type, x)				\
+({								\
+	union { type __val; char __c[1]; } __u =		\
+		{ .__c = { 0 } };				\
+	__read_once_size((void *)&(x), __u.__c, sizeof(x));	\
+	__u.__val;						\
+})
+
+#define WRITE_ONCE_ARENA(type, x, val)				\
+({								\
+	union { type __val; char __c[1]; } __u =		\
+		{ .__val = (val) }; 				\
+	__write_once_size((void *)&(x), __u.__c, sizeof(x));	\
+	__u.__val;						\
+})
+
 /*
  * log2_u32 - Compute the base 2 logarithm of a 32-bit exponential value.
  * @v: The value for which we're computing the base 2 logarithm.
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 5c165af1fa27..50bc1737c167 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -256,7 +256,6 @@ static int central_timerfn(void *map, int *key, struct bpf_timer *timer)
 	u64 now = scx_bpf_now();
 	u64 nr_to_kick = nr_queued;
 	s32 i, curr_cpu;
-	struct scx_event_stats events;
 
 	curr_cpu = bpf_get_smp_processor_id();
 	if (timer_pinned && (curr_cpu != central_cpu)) {
@@ -292,7 +291,6 @@ static int central_timerfn(void *map, int *key, struct bpf_timer *timer)
 
 	bpf_timer_start(timer, TIMER_INTERVAL_NS, BPF_F_TIMER_CPU_PIN);
 	__sync_fetch_and_add(&nr_timers, 1);
-
 	return 0;
 }
 
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index 1e9f74525d8f..6ba6e610eeaa 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include <signal.h>
+#include <assert.h>
 #include <libgen.h>
 #include <bpf/bpf.h>
 #include <scx/common.h>
@@ -60,14 +61,22 @@ int main(int argc, char **argv)
 	skel->rodata->nr_cpu_ids = libbpf_num_possible_cpus();
 	skel->rodata->slice_ns = __COMPAT_ENUM_OR_ZERO("scx_public_consts", "SCX_SLICE_DFL");
 
+	assert(skel->rodata->nr_cpu_ids <= INT32_MAX);
+
 	while ((opt = getopt(argc, argv, "s:c:pvh")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
 			break;
-		case 'c':
-			skel->rodata->central_cpu = strtoul(optarg, NULL, 0);
+		case 'c': {
+			u32 central_cpu = strtoul(optarg, NULL, 0);
+			if (central_cpu >= skel->rodata->nr_cpu_ids) {
+				fprintf(stderr, "invalid central CPU id value, %u given (%u max)\n", central_cpu, skel->rodata->nr_cpu_ids);
+				return -1;
+			}
+			skel->rodata->central_cpu = (s32)central_cpu;
 			break;
+		}
 		case 'v':
 			verbose = true;
 			break;
@@ -96,7 +105,7 @@ int main(int argc, char **argv)
 	 */
 	cpuset = CPU_ALLOC(skel->rodata->nr_cpu_ids);
 	SCX_BUG_ON(!cpuset, "Failed to allocate cpuset");
-	CPU_ZERO(cpuset);
+	CPU_ZERO_S(CPU_ALLOC_SIZE(skel->rodata->nr_cpu_ids), cpuset);
 	CPU_SET(skel->rodata->central_cpu, cpuset);
 	SCX_BUG_ON(sched_setaffinity(0, sizeof(*cpuset), cpuset),
 		   "Failed to affinitize to central CPU %d (max %d)",
-- 
2.48.1



