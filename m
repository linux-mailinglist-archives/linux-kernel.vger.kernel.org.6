Return-Path: <linux-kernel+bounces-253873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A4A93281E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197632846A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 14:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0847F19B591;
	Tue, 16 Jul 2024 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QfApOE8s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PWMLuTdw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78D919B3CC
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139604; cv=none; b=dvfXqK8u1MSog7oITt9OVmDGfXAI1+40JkYDpFtjvAz4yOyB9dX7z0COMlWsq8XWNie2V6y9D9BM7CKrZzPI4KBHcXR1lPYYisKOIGLjH2fL0NVZbzqFwTYAoyKmG3U3wltSxJ9WRIhQkA6MwImaEDZvZJTb1BLHyCvsIRbUrpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139604; c=relaxed/simple;
	bh=EZWQp7FsRv0KdfRe4qK34+G1LZqaxgWdO3h3XEKXP5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3//sPRt8xc6fVEsrh/3C4qa/+/FZY3XbrXz5jZX9oJxKPOefgliAs5c5BLOmj0RIJCfXz7CWmrKubUPBt74UNDN0EmcOwOTT8Q5JovkWFN3DS8W0p39j7+V3d9UBnIfzxn+4+LUEWDhm9Q0otUB8U9PdYU9vEYRrHddrAudzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QfApOE8s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PWMLuTdw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721139598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBjD7OWHewRPkSx34IGE//hknqpZ0DI2fekqxjXeSK0=;
	b=QfApOE8sm8BzdJN17JVT0JK7lpDAWhxZC5DCSZs/gc3X4e8QHf4Bz47mA2Sx9CunTaYeEt
	XtKoDF02/MB0UzVn3/LU9PTLdJL36bfIPqsH7KHJvraUGVS9pZzVWShK/H31bjnexkpovd
	j1Ab6CA0MHlXi3/dzlLBKKPZzbZ7ZcLO6aWcApf1ks8Wawz/kIt5jlQ1sz4uKae60RKWyB
	xlnyvc2mP6O3lE1lfaVs3f4N5m4Is+cOcco5hRX9ox6FURyhJAwKZHI06GOMG/FIu6B20L
	0u3FlNWvPH4e4xFvMkLO1PUiEbf23ybnRS6YsJrDLTw5kz9e9cnzc1VyIMs+Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721139598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WBjD7OWHewRPkSx34IGE//hknqpZ0DI2fekqxjXeSK0=;
	b=PWMLuTdw51VhO/1wZk8rJtKD71nkSPI87JdEWUsYJdGSfWfLhX1UscAWwHH+3bNmxkX20n
	8SvYbS91V+9J79Bw==
Date: Tue, 16 Jul 2024 16:19:21 +0200
Subject: [PATCH v4 3/8] timers/migration: Improve tracing
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-tmigr-fixes-v4-3-757baa7803fe@linutronix.de>
References: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
In-Reply-To: <20240716-tmigr-fixes-v4-0-757baa7803fe@linutronix.de>
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

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index ed279212e8c0..ed9dfa061d2e 100644
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


