Return-Path: <linux-kernel+bounces-224325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F40239120CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 11:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A96B51F22F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 09:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6483516EBF6;
	Fri, 21 Jun 2024 09:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wKgtLhzP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5Uzt/xsp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD2716E887
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 09:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718962677; cv=none; b=rnfVHD4iu+XJU+O/JxD5hnSsew1vUiTsb4vCpLvdXjrrEVuIb8Sx/8+a7jPqMWczPbsFBL0UPSV0jc46XgCq+c+twmrSSvjdVtlUxOpKNpdNII5YyNZPgMm1//0w99SvUZ5dsuCH6qQif/3Kjg6qbtwVy8h4k/Niac3zTvHg6V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718962677; c=relaxed/simple;
	bh=/GHidRAy3Vri5PVWO70pWsVO1oukzsSFzBKorCXDvts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EQZmXLehoJZvG0Zi70FJOjcojsSfb/a5SOU7N/zCw0XwrMhByRR+tLh+gQrcoMI872B2Qebfqza3igRl1/zF4lKhXEng3VM/VMRJ8BGfAekWnAGllSxF8svWLFHcQ31M4yBcua51xyCEWaEZqncYpDzOFPVrN7GW+ojYi4sD9go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wKgtLhzP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5Uzt/xsp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718962674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+StE62xb2HG77ARJrlDkRwiDs6UDMTFPfx8HvR0X4XU=;
	b=wKgtLhzPZLrfk0EB9bF2pJ9y1DQnSEpS67QUIuPFl2pruogj37qfFSj9RQgsgQxT5/7Vqy
	Xu8uoOaJOK3KwVtNnFEF2PEkevIFyMNs5I/z9yBm1CX+ye1cNt/gR1W/Wbc9HVTy/1XEE9
	epPBd7ne5eoS6RjKydZaHQcJaLh9tM+pYtCyLYidcIErQsduRjaov2F4TCYJC/Mp/T9EIy
	omvUboPaYXD7uTIGjHYabywQS4TNHj72adCRGtEl59MjwuEWWYkqgBvVltxI22JzSnF77m
	KQJuhyiv0Uwz1OAcFhd7XMpquDXFUZpQS164h7iEVS64HslepLAvvT0Kt0iVkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718962674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+StE62xb2HG77ARJrlDkRwiDs6UDMTFPfx8HvR0X4XU=;
	b=5Uzt/xspo/8RusQBBGIUxSD7BOIKspYrdKnThzuTU5Xmk44beody6haC5VV19tHzGDQJMr
	4vg7ou1Z0OfVdUBA==
Date: Fri, 21 Jun 2024 11:37:07 +0200
Subject: [PATCH 2/3] timer_migration: Spare write when nothing changed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-tmigr-fixes-v1-2-8c8a2d8e8d77@linutronix.de>
References: <20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de>
In-Reply-To: <20240621-tmigr-fixes-v1-0-8c8a2d8e8d77@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

The wakeup value is written unconditionally in tmigr_cpu_new_timer(). When
there was no new next timer expiry that needs to be propagated, then the
value that was read before is written. This is not required.

Move write to the place where wakeup value could have changed.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index d91efe1dc3bf..f55be5411ad9 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1237,14 +1237,13 @@ u64 tmigr_cpu_new_timer(u64 nextexp)
 		if (nextexp != tmc->cpuevt.nextevt.expires ||
 		    tmc->cpuevt.ignore) {
 			ret = tmigr_new_timer(tmc, nextexp);
+			/*
+			 * Make sure the reevaluation of timers in idle path
+			 * will not miss an event.
+			 */
+			WRITE_ONCE(tmc->wakeup, ret);
 		}
 	}
-	/*
-	 * Make sure the reevaluation of timers in idle path will not miss an
-	 * event.
-	 */
-	WRITE_ONCE(tmc->wakeup, ret);
-
 	trace_tmigr_cpu_new_timer_idle(tmc, nextexp);
 	raw_spin_unlock(&tmc->lock);
 	return ret;

-- 
2.39.2


