Return-Path: <linux-kernel+bounces-253877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EC9932829
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96DC28487F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7772019D89F;
	Tue, 16 Jul 2024 14:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BRN5Pwol";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mea1wI7E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989DB19B5AF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139607; cv=none; b=ovlkzTUjcHZ3FqT0tqNC2zNgJbgzC3zaibe0UJE210y6UYjne/1UgOhy/Kmu/w81L6l7amd21foxKzUnxfvO09XbhDtlHchshKcy2yCJSv0Yn9mZ1h600bo2NIg/c0YXtJahsX5bjL88wQjRp/scO2Zkp81QmCBXLMLCtRgSM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139607; c=relaxed/simple;
	bh=OpM2KuSJIW5rOw3rC8SFNnH6l7hunxKEVDqLGpHkC7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ATgqK+al0f/M+iWa8LO5Qluc0wvEveMZn4hZnNiFPbwrCjDJr0/3snqYY5UyuRHxin23gOqU8h9/XTpa1rEy4kNl9PW/Mwr1Vk7lv2pw/j/ScCsMyogQu0hOyyGNExvZ/b0ynRFatXQfC4UsluHZbCUyKmmAHubmmbbM0lDyfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BRN5Pwol; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mea1wI7E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721139599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJwImKVD06i2BD4sac+Dv+NDLFI+BDAzv/wiUneFEYc=;
	b=BRN5Pwol9gHP3WVHDZ/sQEhVaFYRmiOoz9yfOHARd2IzbJXg+s5ksd10HVrYqnTsZzwTZY
	5doIyQTEEAuY5NjZ7DIXcATwcrcJseC5honqnR6GpeENtrCJpUXF1/isF8layDzWG7Em+R
	/QDOgqCB9TYe0WdkHWVUVjI+/qE3zZB4fCP90f85RO65qcJRf/q8CdOD9mTkoK4FwyHpe/
	wiwL2bmbwEfOi/tIYQdsFQQi1VzotmlUIi8bt1epI3rj8AKaK/dvZSuFH0a8K54TS8+PiO
	oXF9lnsPiviwhvkEQVkY+jlG6yLpypX8LWNlnPZcrfBk6GVGFagI+lZ0PLCa8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721139599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eJwImKVD06i2BD4sac+Dv+NDLFI+BDAzv/wiUneFEYc=;
	b=Mea1wI7EGd90Qi+hPZZBaUfYmx6Pj9YRKMFDl5wS2KMZS4e55b88Cmy5PEbNPivqho753M
	0jZbrG5mWTyj8hBg==
Date: Tue, 16 Jul 2024 16:19:23 +0200
Subject: [PATCH v4 5/8] timers/migration: Read childmask and parent pointer
 in a single place
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-tmigr-fixes-v4-5-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
In-Reply-To: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reading the childmask and parent pointer is required when propagating
changes through the hierarchy. At the moment this reads are spread all over
the place which makes it harder to follow.

Move those reads to a single place to keep code clean.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 3458ee047027..af9c520bf3de 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -535,6 +535,7 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 
 		child = group;
 		group = group->parent;
+		data->childmask = child->childmask;
 	} while (group);
 }
 
@@ -647,9 +648,6 @@ static bool tmigr_active_up(struct tmigr_group *group,
 
 	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
 
-	if (walk_done == false)
-		data->childmask = group->childmask;
-
 	/*
 	 * The group is active (again). The group event might be still queued
 	 * into the parent group's timerqueue but can now be handled by the
@@ -1027,12 +1025,10 @@ static bool tmigr_handle_remote_up(struct tmigr_group *group,
 	}
 
 	/*
-	 * Update of childmask for the next level and keep track of the expiry
-	 * of the first event that needs to be handled (group->next_expiry was
-	 * updated by tmigr_next_expired_groupevt(), next was set by
-	 * tmigr_handle_remote_cpu()).
+	 * Keep track of the expiry of the first event that needs to be handled
+	 * (group->next_expiry was updated by tmigr_next_expired_groupevt(),
+	 * next was set by tmigr_handle_remote_cpu()).
 	 */
-	data->childmask = group->childmask;
 	data->firstexp = group->next_expiry;
 
 	raw_spin_unlock_irq(&group->lock);
@@ -1110,7 +1106,7 @@ static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
 	 * group before reading the next_expiry value.
 	 */
 	if (group->parent && !data->tmc_active)
-		goto out;
+		return false;
 
 	/*
 	 * The lock is required on 32bit architectures to read the variable
@@ -1135,9 +1131,6 @@ static bool tmigr_requires_handle_remote_up(struct tmigr_group *group,
 		raw_spin_unlock(&group->lock);
 	}
 
-out:
-	/* Update of childmask for the next level */
-	data->childmask = group->childmask;
 	return false;
 }
 
@@ -1309,9 +1302,6 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	/* Event Handling */
 	tmigr_update_events(group, child, data);
 
-	if (walk_done == false)
-		data->childmask = group->childmask;
-
 	return walk_done;
 }
 

-- 
2.39.2


