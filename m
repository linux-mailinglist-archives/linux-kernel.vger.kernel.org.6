Return-Path: <linux-kernel+bounces-235998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF4B91DC37
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D99F1F213E3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8958E12FF88;
	Mon,  1 Jul 2024 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="13OzOF0G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zts6jgZO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9B85934
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829142; cv=none; b=VXsD6z3GpuRMJCNxxaWITeHpAay+KKLc5cH0eq9GPFr8TSr7FAJsgekliD32e3NDtlGFstLJ38VGOVWw1bq07tdYfFTxOPC++sAoKA8/namw16YQxAlpjDJ99squB+9zd1jiWOWTxBaxOKbqHUIqw2NS89MX6w0Ml/LSVRBoJU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829142; c=relaxed/simple;
	bh=Zo7jte0xJA7gqL2z3VTBSa/ju6aCpBt01nulJ8aS9Lo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0wPWvqHhJ0f7WHDzYqRTPnFfIfJt8Yg+M/62ZsQ3atR4k+LSG5Ds/nWzgyHL7Q0iSOni6xKhDT0QDeDnWQCOIRF565SSAubMjmWqI9LOQ7YJhah8QKj5+JmKtNRhHTceY/BJXvR0z5fNDKTlIlwe7dsK3Fu/dseqIDHSDQNsH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=13OzOF0G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zts6jgZO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719829136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brPKlDhy+dXUY1lRR5BGqIYBAri98xW3VtWbYMv4jjE=;
	b=13OzOF0GVc+vXFXC8ElvTJaXxNuhpsUmKF1H3PXu9smdMmRVWMU8RuGOevP53MiE+AhWQ5
	wGvmEPiNgGbG1WkJl/Z+yELtdWOzzSgZ//rdKdZay273NOy2+IiP50+naIT7eTpIDDMG5z
	AabNntOooIWKk2IRTYkX/zRrptDm7p6QtO/EtjFU7GWlCrXz1boNk5hI+GGzl6Qq1dJv7A
	cRbPgXRMOMrtAMNTd00tIK0gavhaFS4GIuAs9fv2ymbP99Tfluci47AXCII7/QVJw52yZb
	yPudKzlBvXH+b7b7GsX8+1aEiSEzTUVddWUc8yrN+X8xzJ6MjKFzd7/ySNbG3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719829136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=brPKlDhy+dXUY1lRR5BGqIYBAri98xW3VtWbYMv4jjE=;
	b=zts6jgZOQo/Csqe+TFdgS4ghpwewtGyNxfbKoGVKjUZj8WtOCA1SVU99qShAEjN7BgWkql
	A0VVr+8kgGrx0eCg==
Date: Mon, 01 Jul 2024 12:18:39 +0200
Subject: [PATCH v3 3/8] timers/migration: Improve tracing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-tmigr-fixes-v3-3-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
In-Reply-To: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

Trace points of inactive and active propagation are located at the end of
the related functions. The interesting information of those trace points is
the updated group state. When trace points are not located directly at the
place where group state changed, order of trace points in traces could be
confusing.

Move inactive and active propagation trace points directly after update of
group state values.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 5c030b30ed0a..0ae7f2084d27 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -656,6 +656,8 @@ static bool tmigr_active_up(struct tmigr_group *group,
 
 	} while (!atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state));
 
+	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
+
 	if (walk_done == false)
 		data->childmask = group->childmask;
 
@@ -673,8 +675,6 @@ static bool tmigr_active_up(struct tmigr_group *group,
 	 */
 	group->groupevt.ignore = true;
 
-	trace_tmigr_group_set_cpu_active(group, newstate, childmask);
-
 	return walk_done;
 }
 
@@ -1306,9 +1306,10 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 
 		WARN_ON_ONCE((newstate.migrator != TMIGR_NONE) && !(newstate.active));
 
-		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state,
-				       newstate.state))
+		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state)) {
+			trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
 			break;
+		}
 
 		/*
 		 * The memory barrier is paired with the cmpxchg() in
@@ -1327,8 +1328,6 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	if (walk_done == false)
 		data->childmask = group->childmask;
 
-	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
-
 	return walk_done;
 }
 

-- 
2.39.2


