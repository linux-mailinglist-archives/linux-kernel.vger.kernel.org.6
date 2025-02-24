Return-Path: <linux-kernel+bounces-528672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025ECA41A89
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186D0188FB8C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAF924E4DD;
	Mon, 24 Feb 2025 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n7Vc0Tvu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vul37pfq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DA424A075
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392128; cv=none; b=VZJTwXVQAsFYMfoYFQnf9jRWjFJinALuf48uNzh6DnfJCQs8zq5Whi7VNy/Gwbrvv9lOY4V/QuHKYT0GR8XQil5Zqve+GkP+nDorVTFYyLMBl8V+UnHps2nE0r4Byg+5onySQ6tboP8kdLovhOjQzmQ/aUDhpt2UKAmtKA0U1J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392128; c=relaxed/simple;
	bh=oQlvzcCQFZGNU6jYrXc8Ejg3LVjNXwVuwT4rrg25Vc4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=F4yuzhiArl46aj9MFm4jlVCVdMHQR3q38ERLGV1J8wFIwyfoN3XDmZ6tHLvOL4vS/NWK8aY3rWFUnKp6evSOleImFN2kwj5myRH/T+CIYQ8/EBW8sbsYPyq6RPoF0zTntYHK5zaL/fDO2rcaEY/zGuVRqqjNgL2fdoZIzII6ptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n7Vc0Tvu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vul37pfq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250224101343.078382991@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740392125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=01lH/N7MkBCPfiP/7juACA911yRh9opjqKqKmt1gXEs=;
	b=n7Vc0TvuPivoUf80HcFzQyk5nsEFGqS9IK44m+qEf41VjU6kimR+V7lIRuzl3q4H1eGcYz
	x8PzR89TYE6PiEdWHAaBJHwgai9pDNDu2lX1QnlMM1LlMDM1dcA5LfA99+y1ImBE4cIBYk
	vO85ddwkYQJvrM7KTCgeDGki7x00uJ47Doc5M214+dWJFjv1sH3tkhzJBLPm0BiIcHSKOe
	kpBvjnUalDzjXNcUUsDg9oazQq3UDN7dUBs6nKS3zKzw9TXdkK4Dt1xUfCFmdd0W0eGf1d
	5NsVsG/OlmZj/pdXdpBEY2QJ7p/Gr4ydRl44QtRtriQ5f9QGnGIaklZbyitwfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740392125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=01lH/N7MkBCPfiP/7juACA911yRh9opjqKqKmt1gXEs=;
	b=vul37pfqSTKI+ljhHrHN355oM3Zq+CRZhLL9+RWlg4MYyEq/dYJhQsGX01cscRpnPxpsCX
	69TqKNz+/cYB11AQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 02/11] posix-timers: Add cond_resched() to posix_timer_add()
 search loop
References: <20250224095736.145530367@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 11:15:25 +0100 (CET)

From: Eric Dumazet <edumazet@google.com>

With a large number of POSIX timers the search for a valid ID might cause a
soft lockup on PREEMPT_NONE/VOLUNTARY kernels.

Add cond_resched() to the loop to prevent that.

[ tglx: Split out from Eric's series ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250214135911.2037402-2-edumazet@google.com
---
 kernel/time/posix-timers.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -144,6 +144,7 @@ static int posix_timer_add(struct k_itim
 			return id;
 		}
 		spin_unlock(&hash_lock);
+		cond_resched();
 	}
 	/* POSIX return code when no timer ID could be allocated */
 	return -EAGAIN;


