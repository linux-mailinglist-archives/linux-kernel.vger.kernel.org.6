Return-Path: <linux-kernel+bounces-236000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B45391DC39
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7E01F21E68
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1674313C3D5;
	Mon,  1 Jul 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YM/PJcxH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTo8gdsr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2912C486
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829143; cv=none; b=lZiQPNXI01pFsT9+x5p+UvnrLevX6wA7x9gCWU8PcTiDXHoC6xRxhWiSM2ZYGsIigxAjJz8qio13bVKTNGDqsbCo80odF/rWbPUjPJDwSr8cp7Taa28GD6PGOzWD9U8jns/2kT6C3nNktVEjqDBK1CRocnPRvH1TmneqRZOFTc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829143; c=relaxed/simple;
	bh=z+6QJK2NRXZ1G8UVShVCdiJwma9rji51m5mPHCZ6/Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r8NK/EmsCs3PipqvM6va7liN6IYOuwKtQglPDPZJ/rhbActRQn2f++CqCINgPt/Of6lEguE55AoJ+1vY6lN2iOcQy5VWotWBUeXPblliEzYEoia48OvSNOuSLl2sSPyB5iduje+00hKcEO/S32kcPQWS5DwaiSTud1YykZJ+B7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YM/PJcxH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTo8gdsr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719829136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQjbgYi559EvGTCmhM3yem27rQqPiOzkClsVHFeLpfs=;
	b=YM/PJcxHwSehEOlQfkaTF4BnY07Zq32iP3ZcBIWPLKQiVcYEFsxkBRx2EijNDgdCsx+atb
	hXiJee9A0JmMl2Z8SwJXdxCf0HatONsdmnd0ijXZ/7+WaAw6DF/WHKEUxwo4goXmpoFlLd
	vIpwxiMxhNUdA4yyESWcoJUUNvb/Qlqh4X4SP9f1BpISOZhMaT+P18FJwTj4i2nwG52Ia8
	JRjIIqLCd6uwWc/Xw9D2M54vv1XE+4kQ74c4tA8tpapQPbl2zymRMaJSZXjlQvL/Oa2lTJ
	xZZbkkvXj5LXd7eav4Ffq9l8W3/fI435XLULsKv2sg1/nzSQ2mgve2AwrH3Yew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719829136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zQjbgYi559EvGTCmhM3yem27rQqPiOzkClsVHFeLpfs=;
	b=VTo8gdsrUvQUNvQNnvwyvXcLW7Vk8z1W8VUieFN6/kEP7BytOiRdSwdDiAw2NE7wkIupcN
	rY565oIGhtBEs9Bw==
Date: Mon, 01 Jul 2024 12:18:37 +0200
Subject: [PATCH v3 1/8] timers/migration: Do not rely always on
 group->parent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-tmigr-fixes-v3-1-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
In-Reply-To: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

When reading group->parent without holding the group lock it is racy
against CPUs coming online the first time and thereby creating another
level of the hierarchy. This is not a problem when this value is read once
to decide whether to abort a propagation or not. The worst outcome is an
unnecessary/early CPU wake up. But it is racy when reading it several times
during a single 'action' (like activation, deactivation, checking for
remote timer expiry,...) and relying on the consitency of this value
without holding the lock. This happens at the moment e.g. in
tmigr_inactive_up() which is also calling tmigr_udpate_events(). Code relys
on group->parent not to change during this 'action'.

Update parent struct member description to explain the above only
once. Remove parent pointer checks when they are not mandatory (like update
of data->childmask). Remove a warning, which would be nice but the trigger
of this warning is not reliable and add expand the data structure member
description instead. Expand a comment, why it is safe to rely on parent
pointer here (inside hierarchy update).

Fixes: 7ee988770326 ("timers: Implement the hierarchical pull model")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 33 +++++++++++++++------------------
 kernel/time/timer_migration.h | 12 +++++++++++-
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 84413114db5c..d91efe1dc3bf 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -507,7 +507,14 @@ static void walk_groups(up_f up, void *data, struct tmigr_cpu *tmc)
  *			(get_next_timer_interrupt())
  * @firstexp:		Contains the first event expiry information when last
  *			active CPU of hierarchy is on the way to idle to make
- *			sure CPU will be back in time.
+ *			sure CPU will be back in time. It is updated in top
+ *			level group only. Be aware, there could occur a new top
+ *			level of the hierarchy between the 'top level call' in
+ *			tmigr_update_events() and the check for the parent group
+ *			in walk_groups(). Then @firstexp might contain a value
+ *			!= KTIME_MAX even if it was not the final top
+ *			level. This is not a problem, as the worst outcome is a
+ *			CPU which might wake up a little early.
  * @evt:		Pointer to tmigr_event which needs to be queued (of idle
  *			child group)
  * @childmask:		childmask of child group
@@ -649,7 +656,7 @@ static bool tmigr_active_up(struct tmigr_group *group,
 
 	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state));
 
-	if ((walk_done == false) && group->parent)
+	if (walk_done == false)
 		data->childmask = group->childmask;
 
 	/*
@@ -1317,20 +1324,9 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	/* Event Handling */
 	tmigr_update_events(group, child, data);
 
-	if (group->parent && (walk_done == false))
+	if (walk_done == false)
 		data->childmask = group->childmask;
 
-	/*
-	 * data->firstexp was set by tmigr_update_events() and contains the
-	 * expiry of the first global event which needs to be handled. It
-	 * differs from KTIME_MAX if:
-	 * - group is the top level group and
-	 * - group is idle (which means CPU was the last active CPU in the
-	 *   hierarchy) and
-	 * - there is a pending event in the hierarchy
-	 */
-	WARN_ON_ONCE(data->firstexp != KTIME_MAX && group->parent);
-
 	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
 
 	return walk_done;
@@ -1552,10 +1548,11 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 		data.childmask = child->childmask;
 
 		/*
-		 * There is only one new level per time. When connecting the
-		 * child and the parent and set the child active when the parent
-		 * is inactive, the parent needs to be the uppermost
-		 * level. Otherwise there went something wrong!
+		 * There is only one new level per time (which is protected by
+		 * tmigr_mutex). When connecting the child and the parent and
+		 * set the child active when the parent is inactive, the parent
+		 * needs to be the uppermost level. Otherwise there went
+		 * something wrong!
 		 */
 		WARN_ON(!tmigr_active_up(parent, child, &data) && parent->parent);
 	}
diff --git a/kernel/time/timer_migration.h b/kernel/time/timer_migration.h
index 6c37d94a37d9..494f68cc13f4 100644
--- a/kernel/time/timer_migration.h
+++ b/kernel/time/timer_migration.h
@@ -22,7 +22,17 @@ struct tmigr_event {
  * struct tmigr_group - timer migration hierarchy group
  * @lock:		Lock protecting the event information and group hierarchy
  *			information during setup
- * @parent:		Pointer to the parent group
+ * @parent:		Pointer to the parent group. Pointer is updated when a
+ *			new hierarchy level is added because of a CPU coming
+ *			online the first time. Once it is set, the pointer will
+ *			not be removed or updated. When accessing parent pointer
+ *			lock less to decide whether to abort a propagation or
+ *			not, it is not a problem. The worst outcome is an
+ *			unnecessary/early CPU wake up. But do not access parent
+ *			pointer several times in the same 'action' (like
+ *			activation, deactivation, check for remote expiry,...)
+ *			without holding the lock as it is not ensured that value
+ *			will not change.
  * @groupevt:		Next event of the group which is only used when the
  *			group is !active. The group event is then queued into
  *			the parent timer queue.

-- 
2.39.2


