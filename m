Return-Path: <linux-kernel+bounces-208025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DA7901F7C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354281F25D92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797C778C6D;
	Mon, 10 Jun 2024 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frg5E44G";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hpEi6uSC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7752DA953
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015763; cv=none; b=E4ChjDrRJW3dIcKjYo3S9sjWzaSRbGaif7vC1iBoCansvWbKCZkX3pOHYFDQnXgDK9etjPCDYgpdlT2UOr4NZdYXEZcIL+0kA1rN20tLzuZnlIHz5wWUOGtkOJ6MqfjVJI2vBg95FcEttYG373Ahr2UZajyjGswE8ZxnkI9kbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015763; c=relaxed/simple;
	bh=B0WAN0JEU1tgIdyEfvxFn7qkPgY6v9AYf8X0SQKnT4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BYeO2lvifgLIFW+wptEUKf6tZ58oWdCYnk3sayYIyf2BZhcF561Mgo3Z+gVgEHpjtPgtIFeZ3zunqp7QitVA1stEEvErrab3EhZTOgqdIDXkKB6IRbLJzklFABds4Ee5Us+MBtcIeceGkA7GKJnNis291XpkpWAAjz1jv14CVXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frg5E44G; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hpEi6uSC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718015760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=elz8sflg56mJQdzHKEWHhDJCRAHOKDUf7YGtiy+qSew=;
	b=frg5E44G3kFCn6jb8N+ZhrH1npf+JKsr9hkun5hHwS59PyQmr5530SEq/LBBznSRlm58Q0
	IZ1ihUfGRmXU5qBudVk2YxM0K8dWJajTBwfkHjInq0CmJ4uE78tjDY5jXE2PhCYW3CvZp1
	d0w6mcUGNW/HxkpR4vy3d7TGaUXeITKVnYDOfB19MiH5OS/CI2xFiCnRxesh/o9xJSKZRK
	EaiUHiiyN0pwwmJpmKdr/rWeMlPIttCCjzuLqTp0flGphhD4zHqX1GqRRjMVhEhWKkxkix
	Zz4MZITDv6BM/sDqRXBDzf4PHcJolIkGwHyvTUvNyvIm29t814gZEDMgWPJjxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718015760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=elz8sflg56mJQdzHKEWHhDJCRAHOKDUf7YGtiy+qSew=;
	b=hpEi6uSCvEmBIT/NMeBqBn1M+LvaCTZR5cEI4C4mhRUuOPvlt7EcCznxUGbdGJRQKi4Jtx
	OHUMtccpCySf5vDg==
To: linux-kernel@vger.kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH] timers/tick_sched: combine WARN_ON_ONCE and print_once
Date: Mon, 10 Jun 2024 12:35:52 +0200
Message-Id: <20240610103552.25252-1-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the WARN_ON_ONCE() triggers, the printk of the additional information
related to the warning will not happen in print level "warn". When reading
the dmesg with a restriction to level "warn", the information published by
the printk_once() will not show up there.

Transform WARN_ON_ONCE() and printk_once() into a WARN_ONCE().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/tick-sched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 71a792cd8936..afeae34e2a09 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1026,10 +1026,10 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
 		if (expires == KTIME_MAX || ts->next_tick == hrtimer_get_expires(&ts->sched_timer))
 			return;
 
-		WARN_ON_ONCE(1);
-		printk_once("basemono: %llu ts->next_tick: %llu dev->next_event: %llu timer->active: %d timer->expires: %llu\n",
-			    basemono, ts->next_tick, dev->next_event,
-			    hrtimer_active(&ts->sched_timer), hrtimer_get_expires(&ts->sched_timer));
+		WARN_ONCE(1, "basemono: %llu ts->next_tick: %llu dev->next_event: %llu "
+			  "timer->active: %d timer->expires: %llu\n", basemono, ts->next_tick,
+			  dev->next_event, hrtimer_active(&ts->sched_timer),
+			  hrtimer_get_expires(&ts->sched_timer));
 	}
 
 	/*
-- 
2.39.2


