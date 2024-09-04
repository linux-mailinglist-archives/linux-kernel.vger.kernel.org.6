Return-Path: <linux-kernel+bounces-315083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3084596BDD5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F71B2114C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC86A1DC06F;
	Wed,  4 Sep 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XWIELyuD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Rj9SvQ/M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ECD1DB942
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455136; cv=none; b=M27M0qzILqaibzdhppUjclA121fv9K8C8KkWV5S+OQW7l6esMfx5s8miYhPNodly2VlG2x4T4ykyxAYYwXHfOGKJIifTTal9hrt6tRDQD3BEyNqzsM2B+7PfarG0stB+63TpGlT9dCM+fCwzXGU70t5MiyDTrbnq7e/uSOdGeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455136; c=relaxed/simple;
	bh=PVBamWA90dG0GtoUae7n0pSnC/+Ad2phybotoldzGv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DtRBsJ1809hrC/Q3pQk+ITASaFj74ccP5s61GabBFX6UaHmfJ54mWFQLRKtwVI/Zsf3sXrUlRuH0cKWLnfNEdwkZQYWrUUcPYukaxt7FWnyown/z+shL+Tei0yTmSoL+PLtRz5+7LEtYBupXXm86fxb06EYX1KmhvOiobO/hW4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XWIELyuD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Rj9SvQ/M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725455132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7qec2sb6ncYP6uk7h36V0HagfHlRIyzZPjUXHyLPpI=;
	b=XWIELyuDfqQSBl3TS8800c8GiXKQGIPEuKQiqJuUvX8MLVdlHJ4QhNbUHuIh3YfE57NMgV
	vP9SP+mHX1DcH8uQlez1zDeFFFAY+sElJnycX0XXOTwVGkrWLve5eZTJBgZ+JLCgSmb9A/
	kYSNs5EwyRNqupxCndRsuo3dOwC8JdINs9Lb3uStLREDMFmyK2h7p8ArK62Zb658l4pDwP
	XRJWX3s7mc+3UsKf4AnCywXitS4FWmtU2pZuIEwk2ZEhYjAIjY82/wghQiFsymDIOCxxW+
	MYx2BMKfpfHDvM1PMMquQqXbjufZ8oJxuKDs61PENkQgWDlI6Unxn8pVmX17ZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725455132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s7qec2sb6ncYP6uk7h36V0HagfHlRIyzZPjUXHyLPpI=;
	b=Rj9SvQ/MTXhF2KAa5hw0PTpph8S2J85cxCIVDjdznhkVqmsxsrG2Zozj2/xvfA6quERew2
	GOMksECSdxD9T1Dw==
Date: Wed, 04 Sep 2024 15:04:51 +0200
Subject: [PATCH 01/15] timers: Rename next_expiry_recalc() to be unique
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-devel-anna-maria-b4-timers-flseep-v1-1-e98760256370@linutronix.de>
References: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
In-Reply-To: <20240904-devel-anna-maria-b4-timers-flseep-v1-0-e98760256370@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>

next_expiry_recalc is the name of a function as well as the name of a
struct member of struct timer_base. This might lead to confusion.

Rename next_expiry_recalc() to timer_recalc_next_expiry(). No functional
change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 311ea459b976..5e021a2d8d61 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1900,7 +1900,7 @@ static int next_pending_bucket(struct timer_base *base, unsigned offset,
  *
  * Store next expiry time in base->next_expiry.
  */
-static void next_expiry_recalc(struct timer_base *base)
+static void timer_recalc_next_expiry(struct timer_base *base)
 {
 	unsigned long clk, next, adj;
 	unsigned lvl, offset = 0;
@@ -2009,7 +2009,7 @@ static unsigned long next_timer_interrupt(struct timer_base *base,
 					  unsigned long basej)
 {
 	if (base->next_expiry_recalc)
-		next_expiry_recalc(base);
+		timer_recalc_next_expiry(base);
 
 	/*
 	 * Move next_expiry for the empty base into the future to prevent an
@@ -2413,7 +2413,7 @@ static inline void __run_timers(struct timer_base *base)
 		 * jiffies to avoid endless requeuing to current jiffies.
 		 */
 		base->clk++;
-		next_expiry_recalc(base);
+		timer_recalc_next_expiry(base);
 
 		while (levels--)
 			expire_timers(base, heads + levels);

-- 
2.39.2


