Return-Path: <linux-kernel+bounces-224324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 056059120CB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6B81C220DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86F16EBFC;
	Fri, 21 Jun 2024 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZsZpB8Ef";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/q3KKE9D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1B16E885
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962677; cv=none; b=Oviyti85olzr67AJdxjQe+T3z2xWTVYEeg1tXYiqM0I2n245wMyu7/RGrzdJkIMzGWrFE+3bHkMn+OUFDbRyUeAss8gQ777T4FWa7NlzHwn+1DR3VkhK80rAZiqgIvKITwmWlDwklJvzq4o/TxOhZ4kLvqnOJClDeWKrOJprazc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962677; c=relaxed/simple;
	bh=NdpY6Y968D6lDTyF25zr8X8Xnv4Bt0kqMFWlhamaolY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=slbxPZVvsLevKghNzhDHaiQFqh7zuf2cLiCWmE/YxUka0yRzvaZZOaAyLRgWwlkDm+dgGPpnacbLJAKQkWCMAQmgNn6QAxarVT930EfNsIjx7bYyy2Q46GytY4IHMaBTVm0H7o46cB+e0W+/8/s058X9EYcbBH4rMUi38OrXf2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZsZpB8Ef; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/q3KKE9D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718962674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XYA2gxPP8gXiPiESdv8zBi94vK/dZ95nSLvONfoEUs=;
	b=ZsZpB8Ef4Gr9ct0FwTlyA+RNwV8lOlbg3ajGxP7QWpblZWCkHQ4IeRMaU5X6efxPgF40ir
	oBQ7OHXgf88GGEze4n4fkzt6IpGkk8gbLsfd4zGRiGc1/1jtfP9vC+0vXGOvAGgrwJh7fX
	HQ5s89akSkm6LDjDnNS5o9qVjJCgT19Q8jOF6zFphET4TjfPrmwA79IyCKtL77FpCiIWVX
	shXOfhx98gt7oViWFefyMREtuvJdLF4TT1Qn4CyTNLCmi2ucWfoeb7Sza602YbSEIpscnA
	QpzC8bu/Hz4Ljg3NEWpToweeSLvjbh1EwiMSM97wwnudE/RE3KUe4aMCP/RILg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718962674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1XYA2gxPP8gXiPiESdv8zBi94vK/dZ95nSLvONfoEUs=;
	b=/q3KKE9Du5MBdf0gzdaT+VRlS+u0gX+fInMP2NyZoqPQrpSxuB/GRjPu0gL8ssk71Zrz4x
	9ilHcD0yysLjllCA==
Date: Fri, 21 Jun 2024 11:37:06 +0200
Subject: [PATCH 1/3] timer_migration: Do not rely always on group->parent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-tmigr-fixes-v1-1-8c8a2d8e8d77@linutronix.de>
References: <20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de>
In-Reply-To: <20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@alien8.de>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Narasimhan V <Narasimhan.V@amd.com>

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
Cc: Narasimhan V <Narasimhan.V@amd.com>
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


