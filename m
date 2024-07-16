Return-Path: <linux-kernel+bounces-253279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FD3931EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1DAB281853
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 02:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61141B641;
	Tue, 16 Jul 2024 02:51:03 +0000 (UTC)
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61C0101CA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=58.251.27.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721098262; cv=none; b=mF0Hp6p7YR/ifAtBlAk7MNx1sy1iLl+vhNd/S73CdoDRjBrRDbHsEuiJ2Tj8B7XsjyTRvxXh1WC93xOlRoCrq50+JntTFy+tRUObenUAFSJvZntjAdJiFYqdPr6zpGJrdOoDhe2ll4lIyE7K/IcM1cYbPHjisONrWI34/lZFkwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721098262; c=relaxed/simple;
	bh=GNI38pCAIw/mgTfyEWaKect+FEbkxtnjrrpW/eCbt9E=;
	h=Date:Message-ID:Mime-Version:From:To:Subject:Content-Type; b=sgC2YX2oyvMz4SIU+KBD78eeECAZlCXZkdL2jkEd+O2wypwm+QQD5yNmjCFIZW/G3sq++0jDpD/033ZXftxylULj1tJLyeePzBFLSGaNiyEQ1Cq4KzH6AgblpaAassY0A9NHg7OSPbIK1EKSeTi+hErB4xP3zXc6lrfFSRlEIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=58.251.27.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4WNNfZ5qQnz1Ds2
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:43:18 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mxde.zte.com.cn (FangMail) with ESMTPS id 4WNNfR1p4xz4xBTs
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 10:43:11 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4WNNfD3pDqz8XrX6;
	Tue, 16 Jul 2024 10:43:00 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 46G2gh5T016096;
	Tue, 16 Jul 2024 10:42:43 +0800 (+08)
	(envelope-from xu.xin16@zte.com.cn)
Received: from mapi (xaxapp03[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 16 Jul 2024 10:42:44 +0800 (CST)
Date: Tue, 16 Jul 2024 10:42:44 +0800 (CST)
X-Zmail-TransId: 2afb6695de24ffffffffb34-7742d
X-Mailer: Zmail v1.0
Message-ID: <20240716104244764N2jD8gnBpnsLjCDnQGQ8c@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <xu.xin16@zte.com.cn>
To: <peterz@infradead.org>, <bsegall@google.com>, <dietmar.eggemann@arm.com>,
        <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <jiang.kun2@zte.com.cn>,
        <juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>,
        <liu.chun2@zte.com.cn>, <mgorman@suse.de>, <mingo@redhat.com>,
        <rostedt@goodmis.org>, <tu.qiang35@zte.com.cn>,
        <vincent.guittot@linaro.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <zhang.yunkai@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjMgUkVTRU5EXSBzY2hlZC9jb3JlOiBBZGQgV0FSTl9PTl9PTkNFKCkgdG8gY2hlY2sgb3ZlcmZsb3cgZm9yIG1pZ3JhdGVfZGlzYWJsZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 46G2gh5T016096
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6695DE45.001/4WNNfZ5qQnz1Ds2

From: Peilin He <he.peilin@zte.com.cn>

Background
==========
When repeated migrate_disable() calls are made with missing the
corresponding migrate_enable() calls, there is a risk of
'migration_disabled' going upper overflow because
'migration_disabled' is a type of unsigned short whose max value is
65535.

In PREEMPT_RT kernel, if 'migration_disabled' goes upper overflow, it may
make the migrate_disable() ineffective within local_lock_irqsave(). This
is because, during the scheduling procedure, the value of
'migration_disabled' will be checked, which can trigger CPU migration.
Consequently, the count of 'rcu_read_lock_nesting' may leak due to
local_lock_irqsave() and local_unlock_irqrestore() occurring on different
CPUs.

Usecase
========
For example, When I developed a driver, I encountered a warning like
"WARNING: CPU: 4 PID: 260 at kernel/rcu/tree_plugin.h:315
rcu_note_context_switch+0xa8/0x4e8" warning. It took me half a month
to locate this issue. Ultimately, I discovered that the lack of upper
overflow detection mechanism in migrate_disable() was the root cause,
leading to a significant amount of time spent on problem localization.

If the upper overflow detection mechanism was added to migrate_disable(),
the root cause could be very quickly and easily identified.

Effect
======
Using WARN_ON_ONCE() to check if 'migration_disabled' is upper overflow
can help developers identify the issue quickly.

Signed-off-by: Peilin He<he.peilin@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yunkai Zhang <zhang.yunkai@zte.com.cn>
Reviewed-by: Qiang Tu <tu.qiang35@zte.com.cn>
Reviewed-by: Kun Jiang <jiang.kun2@zte.com.cn>
Reviewed-by: Fan Yu <fan.yu9@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: Liu Chun <liu.chun2@zte.com.cn>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
v2->v3:
Some fixes according to:
https://lore.kernel.org/all/20240704134716.GU11386@noisy.programming.kicks-ass.net/
1.Convert p->migration_disabled to a signed type and check earlier.
2.Add overflow check for p->migration_disabled in migrate.enable().
3.Check for overflow on debug builds.

v1->v2:
Some fixes according to:
https://lore.kernel.org/all/20240702124334.762dbd5a@rorschach.local.home/
1.Merge if conditions into WARN().
2.Remove the newline character '\n'. Right, we don't need the redundant \n.

 kernel/sched/core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8cc4975d6b2b..1992f2848732 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2259,6 +2259,12 @@ void migrate_disable(void)
 	struct task_struct *p = current;

 	if (p->migration_disabled) {
+#ifdef CONFIG_DEBUG_PREEMPT
+		/*
+		 *Warn about overflow half-way through the range.
+		 */
+		WARN_ON_ONCE((s16)p->migration_disabled < 0);
+#endif
 		p->migration_disabled++;
 		return;
 	}
@@ -2277,14 +2283,20 @@ void migrate_enable(void)
 		.flags     = SCA_MIGRATE_ENABLE,
 	};

+#ifdef CONFIG_DEBUG_PREEMPT
+	/*
+	 * Check both overflow from migrate_disable() and superfluous
+	 * migrate_enable().
+	 */
+	if (WARN_ON_ONCE((s16)p->migration_disabled <= 0))
+		return;
+#endif
+
 	if (p->migration_disabled > 1) {
 		p->migration_disabled--;
 		return;
 	}

-	if (WARN_ON_ONCE(!p->migration_disabled))
-		return;
-
 	/*
 	 * Ensure stop_task runs either before or after this, and that
 	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
-- 
2.17.1

