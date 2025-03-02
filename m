Return-Path: <linux-kernel+bounces-540740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19429A4B470
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 20:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF8DB3B14D6
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 19:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A061EDA2E;
	Sun,  2 Mar 2025 19:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xmgvyz3L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6T7NRgbA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5511EC01B
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 19:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740944209; cv=none; b=XAKo3qU9rTmQuVNV+G+lEqrxvyWVylqTnp9jrHvj1DHaGZXIewhEhKEqiOEVeVlslpYK8NNCM5sFyhMoGdX9EA1jlC1zAMC/XiCHNL0VdJ2qyoIhjptJBOIkJV+aWXy20b52gJ4aKO8D2hjga4SA0lBg/XDrmPaksdfVidh9H1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740944209; c=relaxed/simple;
	bh=oQlvzcCQFZGNU6jYrXc8Ejg3LVjNXwVuwT4rrg25Vc4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ZU4FkW7D/Jjx1oNRAEZ75Q43UC1yiQLg3JMakFXboWaP4fqDNE0SI9UTzPrDGHuF+MmlR04q+ge2Yj2nOWrsWICP7rlSU8LptvGyFjoOILEtA1jlepV9wgGB5czT83cO10wkVfCFYVzYn51o3hlLTuweP7bcMJwPTwWGciGaY4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xmgvyz3L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6T7NRgbA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250302193627.037768273@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740944206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=01lH/N7MkBCPfiP/7juACA911yRh9opjqKqKmt1gXEs=;
	b=xmgvyz3Lz2oqfV8XvLpQNPUczcFaLIp6LNooyT+yc49fKde1CuqDYvNyKNy6GkVxrlsnwK
	TNlAEQYDN8mRRgpcMqoiBMAcwiAqWjwbWeNwEbn3jPZXRl/6Aqpi6GHLpZk5BdnTF0xicd
	5TvfHnufM0sBeGrzn7cfiglujka6yhvVwhY46Zyg9a9ZF8osTQ5dJ2U88JNTS2ZwX9oT89
	fDQZgDJw2McX5k3rex28TK2g8oElz2fDWb/Q1iUraHTmqa8fVZuiC99ZuAoufl9BH8kicp
	Fo0+Ay+uvCavmKv0g1wQJgvMS7mM1t9YY37xyVVDO9BUPaKMvd2IJJmC9UIqHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740944206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=01lH/N7MkBCPfiP/7juACA911yRh9opjqKqKmt1gXEs=;
	b=6T7NRgbApbr1ytTNyf7p6cTe+v5gPj75on1ynxjzknusjrHW8vR9AYWskNwZGwiYkftch6
	oaBCHdiStkUtKoAQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch V2 02/17] posix-timers: Add cond_resched() to
 posix_timer_add() search loop
References: <20250302185753.311903554@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun,  2 Mar 2025 20:36:46 +0100 (CET)

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


