Return-Path: <linux-kernel+bounces-236001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CCC91DC3A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EDB1F2168E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3223D13C685;
	Mon,  1 Jul 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sjV1lRCJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h0QEqtk1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FE12C491
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829143; cv=none; b=R0L9NwdfVZEaxpqCOv7tG3yyhvkJ3KqddYjBsS+3r0jAfHESpVGfLuz3BJQtGXjiEiKT2ulqQzeDNGQ57PY808lO3GjoXWtwXwoS4rpWm6muBgxcbVSp4rHzscVgKuMMREv025yGcStDFqjGx3zL2m/cRMpcTAnY1RX+Ml8qpdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829143; c=relaxed/simple;
	bh=5ikh8IH4woSIgTgstlLlThJYOjyMKptYoGYDMRliWG0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dA8udmjin0GVGy3QWXUz5Lq7xfPAcDs8qUrhD1qNu4w71YluceyFw3RymfyqTlDC8fKFgdx+tfENkuprevJIRMZkD0jUy5M3jipbd/sCNC9UvEGz/b1zzEUCRBZVJ5nxxkQzACFM1nbNxsV99mB/L/gfN85SrStYcEUqb3oaq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sjV1lRCJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h0QEqtk1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719829137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyBCuRiWGrZQ9/Lh9FP2UfloCMkS+RDbkIpMrfk9kbM=;
	b=sjV1lRCJGFwnMEMYB/ub0cV4ddS1PhkEtBwppkz2j6wYd49+Kx8vB6WMQvXCzQWjOVm7Gq
	XAhlY3JOcfROPd9TbaVun3QoSrOvEJMnpWqm+MCRVS4fC+OEF43lC8RlvYK6WWi9l1xJuG
	k7pAGe/mPkHjqM1XkU3IS/dWe3jE2eekHX4tOVQg071pr+eQp7pKTMZQMKZWGCCqnOAfbX
	nP/1AZ100dWC9CZrzewdZeeoEE+Mw4nwQc5agTRV0GQAnz67+XXGtnLGgIoVRsdTnyY/pX
	wmq641hTHoWZwglQuPhtYsj3bBneM1w/X/GmupyPbDkedPDe+QEtCx0/CtSt0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719829137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PyBCuRiWGrZQ9/Lh9FP2UfloCMkS+RDbkIpMrfk9kbM=;
	b=h0QEqtk1J57vth3R48m5OdqUWldakxItRCBuOuphA71liVOZgAaTTOKC+HMavdfJO0AD9u
	9ynQMeTrPfWkFKCg==
Date: Mon, 01 Jul 2024 12:18:40 +0200
Subject: [PATCH v3 4/8] timers/migration: Use a single struct for hierarchy
 walk data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-tmigr-fixes-v3-4-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
In-Reply-To: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

Two different structs are defined for propagating data from one to another
level when walking the hierarchy. Several struct members exist in both
structs which makes generalization harder.

Merge those two structs into a single one and use it directly in
walk_groups() and the corresponding function pointers instead of
introducing pointer casting all over the place.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c | 126 ++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 71 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 0ae7f2084d27..b4391abfb4a9 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -475,69 +475,31 @@ static bool tmigr_check_lonely(struct tmigr_group *group)
 	return bitmap_weight(&active, BIT_CNT) <= 1;
 }
 
-typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, void *);
-
-static void __walk_groups(up_f up, void *data,
-			  struct tmigr_cpu *tmc)
-{
-	struct tmigr_group *child = NULL, *group = tmc->tmgroup;
-
-	do {
-		WARN_ON_ONCE(group->level >= tmigr_hierarchy_levels);
-
-		if (up(group, child, data))
-			break;
-
-		child = group;
-		group = group->parent;
-	} while (group);
-}
-
-static void walk_groups(up_f up, void *data, struct tmigr_cpu *tmc)
-{
-	lockdep_assert_held(&tmc->lock);
-
-	__walk_groups(up, data, tmc);
-}
-
 /**
  * struct tmigr_walk - data required for walking the hierarchy
  * @nextexp:		Next CPU event expiry information which is handed into
  *			the timer migration code by the timer code
  *			(get_next_timer_interrupt())
- * @firstexp:		Contains the first event expiry information when last
- *			active CPU of hierarchy is on the way to idle to make
- *			sure CPU will be back in time. It is updated in top
- *			level group only. Be aware, there could occur a new top
- *			level of the hierarchy between the 'top level call' in
- *			tmigr_update_events() and the check for the parent group
- *			in walk_groups(). Then @firstexp might contain a value
- *			!= KTIME_MAX even if it was not the final top
- *			level. This is not a problem, as the worst outcome is a
- *			CPU which might wake up a little early.
+ * @firstexp:		Contains the first event expiry information when
+ *			hierarchy is completely idle.  When CPU itself was the
+ *			last going idle, information makes sure, that CPU will
+ *			be back in time. When using this value in the remote
+ *			expiry case, firstexp is stored in the per CPU tmigr_cpu
+ *			struct of CPU which expires remote timers. It is updated
+ *			in top level group only. Be aware, there could occur a
+ *			new top level of the hierarchy between the 'top level
+ *			call' in tmigr_update_events() and the check for the
+ *			parent group in walk_groups(). Then @firstexp might
+ *			contain a value != KTIME_MAX even if it was not the
+ *			final top level. This is not a problem, as the worst
+ *			outcome is a CPU which might wake up a little early.
  * @evt:		Pointer to tmigr_event which needs to be queued (of idle
  *			child group)
  * @childmask:		childmask of child group
  * @remote:		Is set, when the new timer path is executed in
  *			tmigr_handle_remote_cpu()
- */
-struct tmigr_walk {
-	u64			nextexp;
-	u64			firstexp;
-	struct tmigr_event	*evt;
-	u8			childmask;
-	bool			remote;
-};
-
-/**
- * struct tmigr_remote_data - data required for remote expiry hierarchy walk
  * @basej:		timer base in jiffies
  * @now:		timer base monotonic
- * @firstexp:		returns expiry of the first timer in the idle timer
- *			migration hierarchy to make sure the timer is handled in
- *			time; it is stored in the per CPU tmigr_cpu struct of
- *			CPU which expires remote timers
- * @childmask:		childmask of child group
  * @check:		is set if there is the need to handle remote timers;
  *			required in tmigr_requires_handle_remote() only
  * @tmc_active:		this flag indicates, whether the CPU which triggers
@@ -546,15 +508,43 @@ struct tmigr_walk {
  *			idle, only the first event of the top level has to be
  *			considered.
  */
-struct tmigr_remote_data {
-	unsigned long	basej;
-	u64		now;
-	u64		firstexp;
-	u8		childmask;
-	bool		check;
-	bool		tmc_active;
+struct tmigr_walk {
+	u64			nextexp;
+	u64			firstexp;
+	struct tmigr_event	*evt;
+	u8			childmask;
+	bool			remote;
+	unsigned long		basej;
+	u64			now;
+	bool			check;
+	bool			tmc_active;
 };
 
+typedef bool (*up_f)(struct tmigr_group *, struct tmigr_group *, struct tmigr_walk *);
+
+static void __walk_groups(up_f up, struct tmigr_walk *data,
+			  struct tmigr_cpu *tmc)
+{
+	struct tmigr_group *child = NULL, *group = tmc->tmgroup;
+
+	do {
+		WARN_ON_ONCE(group->level >= tmigr_hierarchy_levels);
+
+		if (up(group, child, data))
+			break;
+
+		child = group;
+		group = group->parent;
+	} while (group);
+}
+
+static void walk_groups(up_f up, struct tmigr_walk *data, struct tmigr_cpu *tmc)
+{
+	lockdep_assert_held(&tmc->lock);
+
+	__walk_groups(up, data, tmc);
+}
+
 /*
  * Returns the next event of the timerqueue @group->events
  *
@@ -625,10 +615,9 @@ static u64 tmigr_next_groupevt_expires(struct tmigr_group *group)
 
 static bool tmigr_active_up(struct tmigr_group *group,
 			    struct tmigr_group *child,
-			    void *ptr)
+			    struct tmigr_walk *data)
 {
 	union tmigr_state curstate, newstate;
-	struct tmigr_walk *data = ptr;
 	bool walk_done;
 	u8 childmask;
 
@@ -867,10 +856,8 @@ bool tmigr_update_events(struct tmigr_group *group, struct tmigr_group *child,
 
 static bool tmigr_new_timer_up(struct tmigr_group *group,
 			       struct tmigr_group *child,
-			       void *ptr)
+			       struct tmigr_walk *data)
 {
-	struct tmigr_walk *data = ptr;
-
 	return tmigr_update_events(group, child, data);
 }
 
@@ -1002,9 +989,8 @@ static void tmigr_handle_remote_cpu(unsigned int cpu, u64 now,
 
 static bool tmigr_handle_remote_up(struct tmigr_group *group,
 				   struct tmigr_group *child,
-				   void *ptr)
+				   struct tmigr_walk *data)
 {
-	struct tmigr_remote_data *data = ptr;
 	struct tmigr_event *evt;
 	unsigned long jif;
 	u8 childmask;
@@ -1062,7 +1048,7 @@ static bool tmigr_handle_remote_up(struct tmigr_group *group,
 void tmigr_handle_remote(void)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
-	struct tmigr_remote_data data;
+	struct tmigr_walk data;
 
 	if (tmigr_is_not_available(tmc))
 		return;
@@ -1104,9 +1090,8 @@ void tmigr_handle_remote(void)
 
 static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
 					    struct tmigr_group *child,
-					    void *ptr)
+					    struct tmigr_walk *data)
 {
-	struct tmigr_remote_data *data = ptr;
 	u8 childmask;
 
 	childmask = data->childmask;
@@ -1164,7 +1149,7 @@ static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
 bool tmigr_requires_handle_remote(void)
 {
 	struct tmigr_cpu *tmc = this_cpu_ptr(&tmigr_cpu);
-	struct tmigr_remote_data data;
+	struct tmigr_walk data;
 	unsigned long jif;
 	bool ret = false;
 
@@ -1252,10 +1237,9 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 
 static bool tmigr_inactive_up(struct tmigr_group *group,
 			      struct tmigr_group *child,
-			      void *ptr)
+			      struct tmigr_walk *data)
 {
 	union tmigr_state curstate, newstate, childstate;
-	struct tmigr_walk *data = ptr;
 	bool walk_done;
 	u8 childmask;
 

-- 
2.39.2


