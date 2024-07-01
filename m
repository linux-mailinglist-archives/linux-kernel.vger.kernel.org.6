Return-Path: <linux-kernel+bounces-236004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C74F91DC3D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F215D1F21A83
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8E01494C1;
	Mon,  1 Jul 2024 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JhQeYHSp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CJnMT9hc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E5F13C9A4
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829145; cv=none; b=bnxjUS78w+KcAdi+1oPYdqB6NL0Nj4odCIhDlSOLpscArkab1J7eeCv2AYCJCc0Lsct0vtaC/5usb7aoILNfJg44ucLZwIfnY0sjvOiR/Ue5x0cz/HXdbr6CNpnDE8FR2rcRZP+rMfUsMhnUyjIqH0Gvzd7JQ9cMnOy4ES2Y+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829145; c=relaxed/simple;
	bh=AfaZt+iIB+Mu6UbReX4cOUZDpnT5VxlA7zY/U0lFktQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u7iGjuH1BNZHcDrBI8mbXZctFAdCkY7iyo9quPty0cyd1gT5KvLLgGZTRi+x5s5aNTsuawBRF7DrVjSvDJtfRi3eD81fYZQnMRctQwCEaaStFFewQseSMj9y42vaj79IaKYaOwyzUtevHwmlSMO8YdzrNJR9+VnqXMR6S0iwie0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JhQeYHSp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CJnMT9hc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719829137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oON15loQKefft5FbGHUbwgp/Rc/h5lGwlddmep9FW6I=;
	b=JhQeYHSp6pdFOEtt9VtWNr3OO15+JYzIxLWiXexsgWUGZ/4NRzLm4hFuCzTtiy3lLXl3db
	eH5f7zXIi1+aoO1yy9WK3fCI2qQeMJuHGZhCy9pwSe7ms0IPezh37LOzf+Ipf6aGrq4fj9
	3s9194nBAJs+7SKddWxek2t0z+z2K5bU1NkxGHz9DlJy9huTGTJc1MymAeF4BNqJGL0bgz
	58bycqIqX5YQqlSt+EnuxOOMRM7gP6MqIsybZhtLbm10qIfnvBfTNTHeSgIO34sjPItdkl
	aX1HfzwoEOr1yzGBV2ZzkvlphI7fed5fIs3iTEWqGEjXOUXTGOGTy061jX1ung==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719829137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oON15loQKefft5FbGHUbwgp/Rc/h5lGwlddmep9FW6I=;
	b=CJnMT9hcjRfXeM9lCPmV8kHPLsVNfFIv8wJrQuAIUcdW9XLsCG9TBigG1fiuzKejzbGw/C
	kPAs6PUc2wgPTBBg==
Date: Mon, 01 Jul 2024 12:18:41 +0200
Subject: [PATCH v3 5/8] timers/migration: Read childmask and parent pointer
 in a single place
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-tmigr-fixes-v3-5-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
In-Reply-To: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
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
index b4391abfb4a9..a681cf89910e 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -535,6 +535,7 @@ static void __walk_groups(up_f up, struct tmigr_walk *data,
 
 		child = group;
 		group = group->parent;
+		data->childmask = group->childmask;
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


