Return-Path: <linux-kernel+bounces-544607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FACBA4E30C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5279719C4247
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 15:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D790F27FE65;
	Tue,  4 Mar 2025 15:10:13 +0000 (UTC)
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83907239579
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101013; cv=fail; b=IsDte9b1jMbs9ISmbKgG410jP9rlWRhySL39lwM6VsClsrxByroiuI7TP/9yZQF1XifjfsmjSHpe4zQTQB9oT8ml0Xg7MLXyhDneS5VDrhiAnL2pSAdAdyXZqzLTdPnZLg0zOIRsWZAtuT60r31c977uvxQjdH3vzsaHDhR6EFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101013; c=relaxed/simple;
	bh=6N3Vl81OgIrXzphCKs7ypeaQEhZhz9yM6Nm+AWi8+Q0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ugCnfyrRgaZsxhdZ31EKM11StJktB94Av6jAUZqJkPJPZCcgnt0zjsuSwAou8c4T0hPLFVlRTVhwWT5L7WOss3DUnlmJjm7oiosPL5z6c9HjiCRz1k+CDACGidBzTTztvw4dz5EVfp948d++ZEBb+GV7y5sd1z52idhBbGhIKqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=222.66.158.135; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=fail smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 0242B40F1CED
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:10:09 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fFc5bvnzFyNF
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:08:20 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 98FAC42724; Tue,  4 Mar 2025 18:08:13 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541457-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 54B4941F5C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:58:22 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 2663C2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:58:22 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C7318969C8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D811FBC9E;
	Mon,  3 Mar 2025 10:53:49 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754FD1F8AE2
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 10:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999227; cv=none; b=Q6oKQ6SqtxmbSPnXAuU9CS26Of00ogxwWturH9VDXBlMeMI3dO/bqhP/1sbhlA6J5op4vAskqj3s1OVlc3mCM0s4aCI2dU2iwcr335d2XnTmAbJLd/d1JXNV/rjZlKJ+kDN7kQP9pHgShY6KeoGCJWPphnswVsAjtLZ3zCaxP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999227; c=relaxed/simple;
	bh=ajaYSo1Ace+j6quvrpngCRHOZEge52pf4Olu9YPWJIQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oa/x5V+ESZAFdFrj5kB2BSlqztSc0F8ecr3XYrhzt5qTUQWJUoNOkEDDQ99UriTFLlP9EYeHYAOw9ybmiB2qavQan738+Eg/V2fhdBUJs4/d6ny/b0OpKj5hrtREupPi+cfnREYQYo7dN/pEWAc3atqEMsL+SoWiCV3IqxBkDyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 523ArVvd092780;
	Mon, 3 Mar 2025 18:53:31 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Z5wXZ23DHz2K8nM6;
	Mon,  3 Mar 2025 18:48:46 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 3 Mar 2025 18:53:29 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>
Subject: [RFC PATCH V2 3/3] sched: Do not consider the delayed task when cpu is about to enter idle
Date: Mon, 3 Mar 2025 18:52:41 +0800
Message-ID: <20250303105241.17251-4-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250303105241.17251-1-xuewen.yan@unisoc.com>
References: <20250303105241.17251-1-xuewen.yan@unisoc.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 523ArVvd092780
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fFc5bvnzFyNF
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741705702.84335@V5wu58tUoMTje0G/d5AQKQ
X-ITU-MailScanner-SpamCheck: not spam

When there are one task with sched-delayed and one task
which is descheduling, Using nr-running to determine
CPU idle may be incorrect.
For example:
task-A is sched_delayed, task-B is descheduling:
1. before schedule():
   rq-nr-running=3D2, task-A->on_rq=3D1; task-B->on_rq=3D1;
2. after block_task(B):
   rq-nr-running=3D1, task-A->on_rq=3D1; task-B->on_rq=3D0;
3. after pick_next_task(), because the task-A would be dequeued:
   rq-nr-running=3D0, task-A->on_rq=3D0; task-B->on_rq=3D0;

In ttwu_queue_cond, it hope the nr-running to be 0 after
the step 2, however, now the nr-running is not 0.
So sub the nr-delayed-task when checking the rq-nr-running.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
 kernel/sched/core.c  | 2 +-
 kernel/sched/fair.c  | 5 -----
 kernel/sched/sched.h | 5 +++++
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67189907214d..6569f220c2fb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3963,7 +3963,7 @@ static inline bool ttwu_queue_cond(struct task_stru=
ct *p, int cpu)
 	 * p->on_cpu can be whatever, we've done the dequeue, so
 	 * the wakee has been accounted out of ->nr_running.
 	 */
-	if (!cpu_rq(cpu)->nr_running)
+	if (!(cpu_rq(cpu)->nr_running - cfs_h_nr_delayed(cpu_rq(cpu))))
 		return true;
=20
 	return false;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8797f6872155..29ee1ce17036 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7181,11 +7181,6 @@ static bool dequeue_task_fair(struct rq *rq, struc=
t task_struct *p, int flags)
 	return true;
 }
=20
-static inline unsigned int cfs_h_nr_delayed(struct rq *rq)
-{
-	return (rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable);
-}
-
 #ifdef CONFIG_SMP
=20
 /* Working cpumask for: sched_balance_rq(), sched_balance_newidle(). */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8512a9fb022..3996b0c5c332 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3609,6 +3609,11 @@ static inline bool is_per_cpu_kthread(struct task_=
struct *p)
 }
 #endif
=20
+static inline unsigned int cfs_h_nr_delayed(struct rq *rq)
+{
+	return (rq->cfs.h_nr_queued - rq->cfs.h_nr_runnable);
+}
+
 extern void swake_up_all_locked(struct swait_queue_head *q);
 extern void __prepare_to_swait(struct swait_queue_head *q, struct swait_=
queue *wait);
=20
--=20
2.25.1



