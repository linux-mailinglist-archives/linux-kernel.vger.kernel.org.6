Return-Path: <linux-kernel+bounces-224326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 583019120CC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D39287F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03916EC03;
	Fri, 21 Jun 2024 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Syf8++Sj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mWT3iKI5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8938816E88C
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962677; cv=none; b=Ss1JfLE9RhYo+XBLO4WUk/qsSxFce9ewHxagVT09LXYQ6XixfvnBCmIjjyiRlv9JM5dMmC9/bodTTqnqqh/qVl1uGeofki8STHcR96AVVjo5UpSyErw/wI/cyHAhWwkLT6O6Jf7dCeBrUlwW3SNkwcJGWmQV28sbhT91XRNDQOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962677; c=relaxed/simple;
	bh=PwYyFHQ4kiQ6SlbBfOlHQ9Tq9MamRHEQ978yb3m+p7I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N64NjlfwvHSRadqfXMIRv67VjE2CBk3tPTzalZa1bUBn+lyHpyqcH16REB2fxWYjfFs28avzVkHdizJZQfWiYvH764ZxQ3izTsPVI7UysXys0e4ddO80is/8GTa9VX/1GBiCxIZU9vazsbLEVefF+ezbR6bWjsdAMG4bmAJTJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Syf8++Sj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mWT3iKI5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718962674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFB1tC9CT9g0HRd6KCO32Pre0A+EA4ekFX5x5x/JyAo=;
	b=Syf8++SjACZ7evxx6WsyucNANQ8MUwLdzXzek3g9+CNCI3556Gn/ujUTjOpOtYH4ZZ9dUi
	m2ym/6o0XbNc+ZoesLFJxjLg8RPcQxvcj28XiAG1Su/5ovqyA68sBUMgEDnoems+FoNxSu
	+V688d87cZKVIJNzmh2XGMm3G2dsyFWo/XpPGj6W1qZgW5E1jDxZNHL/6vfWhGJ1XEb9qP
	wcT8IZS0Qt3OpZj3G8SbCeJeLiXVHGb6qb3dmJBVpL4rim59H/hD3IxM3PBsWMZFt0NsP/
	OdmgwrpBe7jR+c/5OU5X7xfcEicLIRgg9DpnpVrvY+HvCcEF37x1T0zf0U2vIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718962674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFB1tC9CT9g0HRd6KCO32Pre0A+EA4ekFX5x5x/JyAo=;
	b=mWT3iKI51YKpZRElKbsKOYH+pUNshVdw3s6gfFUU46nzjecIeG6cp40DJYa+OfwMGzKWyS
	HCdaew106TCT5DAQ==
Date: Fri, 21 Jun 2024 11:37:08 +0200
Subject: [PATCH 3/3] timer_migration: Improve tracing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-tmigr-fixes-v1-3-8c8a2d8e8d77@linutronix.de>
References: <20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de>
In-Reply-To: <20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de>
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
---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index f55be5411ad9..41ea48d08c65 100644
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
 
@@ -1305,9 +1305,10 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 
 		WARN_ON_ONCE((newstate.migrator != TMIGR_NONE) && !(newstate.active));
 
-		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state,
-				       newstate.state))
+		if (atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state)) {
+			trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
 			break;
+		}
 
 		/*
 		 * The memory barrier is paired with the cmpxchg() in
@@ -1326,8 +1327,6 @@ static bool tmigr_inactive_up(struct tmigr_group *group,
 	if (walk_done == false)
 		data->childmask = group->childmask;
 
-	trace_tmigr_group_set_cpu_inactive(group, newstate, childmask);
-
 	return walk_done;
 }
 

-- 
2.39.2


