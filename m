Return-Path: <linux-kernel+bounces-330987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F02E997A6E0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 19:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6FD282373
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 17:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462D15A865;
	Mon, 16 Sep 2024 17:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="T1stqdsL"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B581311A7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726508474; cv=none; b=Mji87Szxj2hnkQggl5udBrn8/fkOX1FLHbqXeaUliz2nGVRVNGmuzhEvcbVbss1+sLISUj+xO5zEOx9pdODoPyPxXsccA6JDXeV0PSemye+uSSuwntDzqnueLbv5xLLiM0LRRanpfqkclUwisl89MM32QJQpbQWu0bLHSlQRfmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726508474; c=relaxed/simple;
	bh=XERhGkQVfIN2ihHwOsXSas1EWUnzUJcrtPWyNIriFYo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=i4ZGd2sNYtyS8Po64B/irabCrpg9taLfxqgtZYSr70cAARk81GWxIIMVQD8X8wucilsv1unL0xTQDIP9ZFIs5GCxgmHNPDvuQ2yI1crbL5KaCe1SMMXplqzLnOEmXuK2ZQQuGg93MPBq3jKGS6vEzC4sa24jZ9QFouC7FhopHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=T1stqdsL; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726508430; x=1727113230; i=markus.elfring@web.de;
	bh=5SGK/TY72KmFyRsQhuci5dBJyuneuqu3SiP14BigZGA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T1stqdsLhzgqpMFh8jzX1i59SUygs7pEZMwqXt1Bqmd9UJAdlN8+G1sIycLycLZq
	 YRCCeidMtW9ZI4zfo6styDHOcREI0fjgoDnImRy1yBPBMtO5aHVUnPfnVbW3ZMxfk
	 g1/hWEZDaD7dUVxtHcAx8m+idjU74Yz7zyhq+beFX6E1PF8OdrAdWsU1/nguKcWVJ
	 H+0mZYfVSbLfvtK4XtSqWWgwB9IsTxlt8m4ZTUSZnj7vxH+mcNbb6qtAdVbMAYfJh
	 m+JZt7wLnJNg/qbZ9FglBVgqXP7ExtDFkBiwc0gjFvSDvrZLc2p1XI1gcsp1wAaK2
	 suqgXuAK9r9PD2ARLw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYtwy-1sUAV41JHE-00LYSq; Mon, 16
 Sep 2024 19:40:30 +0200
Message-ID: <096fc4ee-8ffe-4eb6-88f8-28dc944b079f@web.de>
Date: Mon, 16 Sep 2024 19:40:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linuxppc-dev@lists.ozlabs.org, Anjali K <anjalik@linux.ibm.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Kan Liang <kan.liang@linux.intel.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] powerpc/perf: Use guard(irqsave)() in eight functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4itjh4f1YOCmJfNLXxyV6dv0Z7b50VyILMhOp4u68y7IQBDcsMR
 pwUORGisP/0PIfUll6L4iv4icDhWaZDvI3DsHAbGSQ3eOTUzzqcT7sLeOdC7NJZoA4LMOP4
 EHXnc4H1P7QZJ2xhdrRf/owE1B8btyWB4vAqC2CeACOnBKj9KrotFLl+ptZhUtRfxyui9KE
 XKmFASJ6MZKhUD/dGnEog==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CFJGuE5Kdvk=;EEJAVilNWVUwlEBuWtKQdnKAN+n
 SNhQCmJI1IVQGcfTBrBlkXdbwrPiCJzYqrwAxttoV+czr3XtzeJMRcc3CfHPFZU0/0Zgyg3WD
 0TA1ao2fG80Vpa5SKw81k9gNRWoX0E4nlYmtIlAS699mFY5FOK/ndImgUFJOm4UKQHv63AvMs
 O+PRbls36ZTelq11VwwxZRXYI6/WYi73RFZd4peQvjDJFAUAyGP5AC31lSAJAamT0/qlo7dQ/
 z1OID7KbYLO3jaGODZqimBa/J1nhia8SVk5uZcYXL3faMEiJy9aZRaDaURuR/a/0McaTJv622
 oLHb0D6u5xBaO3psQr92dPoqLjljv3yRyvUb3kIuWaN7VPozcWTaNXX4mcCIykxNpTxtR8Wyw
 uEEIycJfQyrADv7QsgoJ6RW1zaANPzgheFXbPNYp8/p20wh6bKG2QaCeeHIxlmbelQbTDJKLZ
 D6o7sZWn7luXZwMIScF2qqSKt55kKDeNn/U4YDU/Ohfy6H4INs1n54QqazgXgdoS/BuihMrvu
 UWt15MwA4BctSGC/T1OYGq45/2jwkObdfLjKaIXvZDGsrqOdju2JFc+XdNrIXfdMsOtKKWZ9O
 NoZ3Z+nvUI5K/7SMKxYPbIHrn0BEG3pdemRr6NGriImBePp9T7yPmIraHPrCt3Ar8FzIQ0GIH
 j76irRi0dDE8YsBl4MCdQMrsk88UQaze6bgn0lWQYap/DpFFfhFq1cU0izovwmpd4Y5f+0EQn
 XQnjYxxiovXO2ZmroVsoLuYjRAnZ7lj3r016YRtCNBILk7Dvf27zRTZrSGSixIREjVN3F7dV4
 ROnLtQI2LGbp+Afu7YI5Jobg==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 16 Sep 2024 19:25:00 +0200

Scope-based resource management became supported for some
programming interfaces by contributions of Peter Zijlstra on 2023-05-26.
See also the commit 54da6a0924311c7cf5015533991e44fb8eb12773 ("locking:
Introduce __cleanup() based infrastructure").

* Thus replace local_irq_save() and local_irq_restore() calls by calls
  of the macro =E2=80=9Cguard(irqsave)=E2=80=9D.

* Omit the local variables =E2=80=9Cflags=E2=80=9D and =E2=80=9Cirq_flags=
=E2=80=9D.

* Replace selected usage of the label =E2=80=9Cout=E2=80=9D by a few retur=
n statements.


This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 arch/powerpc/perf/core-book3s.c | 102 +++++++++++++-------------------
 1 file changed, 42 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book=
3s.c
index 42867469752d..6416c629a2b1 100644
=2D-- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -895,7 +895,7 @@ static int any_pmc_overflown(struct cpu_hw_events *cpu=
hw)
 /* Called from sysrq_handle_showregs() */
 void perf_event_print_debug(void)
 {
-	unsigned long sdar, sier, flags;
+	unsigned long sdar, sier;
 	u32 pmcs[MAX_HWEVENTS];
 	int i;

@@ -907,7 +907,7 @@ void perf_event_print_debug(void)
 	if (!ppmu->n_counter)
 		return;

-	local_irq_save(flags);
+	guard(irqsave)();

 	pr_info("CPU: %d PMU registers, ppmu =3D %s n_counters =3D %d",
 		 smp_processor_id(), ppmu->name, ppmu->n_counter);
@@ -949,8 +949,6 @@ void perf_event_print_debug(void)
 #endif
 	pr_info("SIAR:  %016lx SDAR:  %016lx SIER:  %016lx\n",
 		mfspr(SPRN_SIAR), sdar, sier);
-
-	local_irq_restore(flags);
 }

 /*
@@ -1298,11 +1296,12 @@ static void write_mmcr0(struct cpu_hw_events *cpuh=
w, unsigned long mmcr0)
 static void power_pmu_disable(struct pmu *pmu)
 {
 	struct cpu_hw_events *cpuhw;
-	unsigned long flags, mmcr0, val, mmcra;
+	unsigned long mmcr0, val, mmcra;

 	if (!ppmu)
 		return;
-	local_irq_save(flags);
+
+	guard(irqsave)();
 	cpuhw =3D this_cpu_ptr(&cpu_hw_events);

 	if (!cpuhw->disabled) {
@@ -1398,8 +1397,6 @@ static void power_pmu_disable(struct pmu *pmu)
 		}
 #endif
 	}
-
-	local_irq_restore(flags);
 }

 /*
@@ -1411,7 +1408,6 @@ static void power_pmu_enable(struct pmu *pmu)
 {
 	struct perf_event *event;
 	struct cpu_hw_events *cpuhw;
-	unsigned long flags;
 	long i;
 	unsigned long val, mmcr0;
 	s64 left;
@@ -1422,15 +1418,16 @@ static void power_pmu_enable(struct pmu *pmu)

 	if (!ppmu)
 		return;
-	local_irq_save(flags);
+
+	guard(irqsave)();

 	cpuhw =3D this_cpu_ptr(&cpu_hw_events);
 	if (!cpuhw->disabled)
-		goto out;
+		return;

 	if (cpuhw->n_events =3D=3D 0) {
 		ppc_set_pmu_inuse(0);
-		goto out;
+		return;
 	}

 	cpuhw->disabled =3D 0;
@@ -1474,7 +1471,7 @@ static void power_pmu_enable(struct pmu *pmu)
 			       &cpuhw->mmcr, cpuhw->event, ppmu->flags)) {
 		/* shouldn't ever get here */
 		printk(KERN_ERR "oops compute_mmcr failed\n");
-		goto out;
+		return;
 	}

 	if (!(ppmu->flags & PPMU_ARCH_207S)) {
@@ -1577,10 +1574,6 @@ static void power_pmu_enable(struct pmu *pmu)
 		mb();
 		mtspr(SPRN_MMCRA, cpuhw->mmcr.mmcra);
 	}
-
- out:
-
-	local_irq_restore(flags);
 }

 static int collect_events(struct perf_event *group, int max_count,
@@ -1619,11 +1612,10 @@ static int collect_events(struct perf_event *group=
, int max_count,
 static int power_pmu_add(struct perf_event *event, int ef_flags)
 {
 	struct cpu_hw_events *cpuhw;
-	unsigned long flags;
 	int n0;
 	int ret =3D -EAGAIN;

-	local_irq_save(flags);
+	guard(irqsave)();
 	perf_pmu_disable(event->pmu);

 	/*
@@ -1685,7 +1677,6 @@ static int power_pmu_add(struct perf_event *event, i=
nt ef_flags)
 	}

 	perf_pmu_enable(event->pmu);
-	local_irq_restore(flags);
 	return ret;
 }

@@ -1696,9 +1687,8 @@ static void power_pmu_del(struct perf_event *event, =
int ef_flags)
 {
 	struct cpu_hw_events *cpuhw;
 	long i;
-	unsigned long flags;

-	local_irq_save(flags);
+	guard(irqsave)();
 	perf_pmu_disable(event->pmu);

 	power_pmu_read(event);
@@ -1740,7 +1730,6 @@ static void power_pmu_del(struct perf_event *event, =
int ef_flags)
 		power_pmu_bhrb_disable(event);

 	perf_pmu_enable(event->pmu);
-	local_irq_restore(flags);
 }

 /*
@@ -1750,7 +1739,6 @@ static void power_pmu_del(struct perf_event *event, =
int ef_flags)

 static void power_pmu_start(struct perf_event *event, int ef_flags)
 {
-	unsigned long flags;
 	s64 left;
 	unsigned long val;

@@ -1763,7 +1751,7 @@ static void power_pmu_start(struct perf_event *event=
, int ef_flags)
 	if (ef_flags & PERF_EF_RELOAD)
 		WARN_ON_ONCE(!(event->hw.state & PERF_HES_UPTODATE));

-	local_irq_save(flags);
+	guard(irqsave)();
 	perf_pmu_disable(event->pmu);

 	event->hw.state =3D 0;
@@ -1777,20 +1765,17 @@ static void power_pmu_start(struct perf_event *eve=
nt, int ef_flags)

 	perf_event_update_userpage(event);
 	perf_pmu_enable(event->pmu);
-	local_irq_restore(flags);
 }

 static void power_pmu_stop(struct perf_event *event, int ef_flags)
 {
-	unsigned long flags;
-
 	if (!event->hw.idx || !event->hw.sample_period)
 		return;

 	if (event->hw.state & PERF_HES_STOPPED)
 		return;

-	local_irq_save(flags);
+	guard(irqsave)();
 	perf_pmu_disable(event->pmu);

 	power_pmu_read(event);
@@ -1799,7 +1784,6 @@ static void power_pmu_stop(struct perf_event *event,=
 int ef_flags)

 	perf_event_update_userpage(event);
 	perf_pmu_enable(event->pmu);
-	local_irq_restore(flags);
 }

 /*
@@ -1996,7 +1980,7 @@ static bool is_event_blacklisted(u64 ev)
 static int power_pmu_event_init(struct perf_event *event)
 {
 	u64 ev;
-	unsigned long flags, irq_flags;
+	unsigned long flags;
 	struct perf_event *ctrs[MAX_HWEVENTS];
 	u64 events[MAX_HWEVENTS];
 	unsigned int cflags[MAX_HWEVENTS];
@@ -2115,43 +2099,41 @@ static int power_pmu_event_init(struct perf_event =
*event)
 	if (check_excludes(ctrs, cflags, n, 1))
 		return -EINVAL;

-	local_irq_save(irq_flags);
-	cpuhw =3D this_cpu_ptr(&cpu_hw_events);
+	{
+		guard(irqsave)();
+		cpuhw =3D this_cpu_ptr(&cpu_hw_events);

-	err =3D power_check_constraints(cpuhw, events, cflags, n + 1, ctrs);
+		err =3D power_check_constraints(cpuhw, events, cflags, n + 1, ctrs);

-	if (has_branch_stack(event)) {
-		u64 bhrb_filter =3D -1;
+		if (has_branch_stack(event)) {
+			u64 bhrb_filter =3D -1;

-		/*
-		 * Currently no PMU supports having multiple branch filters
-		 * at the same time. Branch filters are set via MMCRA IFM[32:33]
-		 * bits for Power8 and above. Return EOPNOTSUPP when multiple
-		 * branch filters are requested in the event attr.
-		 *
-		 * When opening event via perf_event_open(), branch_sample_type
-		 * gets adjusted in perf_copy_attr(). Kernel will automatically
-		 * adjust the branch_sample_type based on the event modifier
-		 * settings to include PERF_SAMPLE_BRANCH_PLM_ALL. Hence drop
-		 * the check for PERF_SAMPLE_BRANCH_PLM_ALL.
-		 */
-		if (hweight64(event->attr.branch_sample_type & ~PERF_SAMPLE_BRANCH_PLM_=
ALL) > 1) {
-			local_irq_restore(irq_flags);
-			return -EOPNOTSUPP;
-		}
+			/*
+			 * Currently no PMU supports having multiple branch filters
+			 * at the same time. Branch filters are set via MMCRA IFM[32:33]
+			 * bits for Power8 and above. Return EOPNOTSUPP when multiple
+			 * branch filters are requested in the event attr.
+			 *
+			 * When opening event via perf_event_open(), branch_sample_type
+			 * gets adjusted in perf_copy_attr(). Kernel will automatically
+			 * adjust the branch_sample_type based on the event modifier
+			 * settings to include PERF_SAMPLE_BRANCH_PLM_ALL. Hence drop
+			 * the check for PERF_SAMPLE_BRANCH_PLM_ALL.
+			 */
+			if (hweight64(event->attr.branch_sample_type & ~PERF_SAMPLE_BRANCH_PLM=
_ALL)
+			    > 1)
+				return -EOPNOTSUPP;

-		if (ppmu->bhrb_filter_map)
-			bhrb_filter =3D ppmu->bhrb_filter_map(
-					event->attr.branch_sample_type);
+			if (ppmu->bhrb_filter_map)
+				bhrb_filter =3D ppmu->bhrb_filter_map(event->attr.branch_sample_type)=
;

-		if (bhrb_filter =3D=3D -1) {
-			local_irq_restore(irq_flags);
-			return -EOPNOTSUPP;
+			if (bhrb_filter =3D=3D -1)
+				return -EOPNOTSUPP;
+
+			cpuhw->bhrb_filter =3D bhrb_filter;
 		}
-		cpuhw->bhrb_filter =3D bhrb_filter;
 	}

-	local_irq_restore(irq_flags);
 	if (err)
 		return -EINVAL;

=2D-
2.46.0


