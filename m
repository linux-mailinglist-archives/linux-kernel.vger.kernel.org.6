Return-Path: <linux-kernel+bounces-384295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36E59B28F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC471F210C7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AD81DE3B1;
	Mon, 28 Oct 2024 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3vXenMPq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kRqDJQ+P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387751AF0CF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100751; cv=none; b=O/yVdkC88eIaN4SzJVN1vbQ+jy5KJ+2ENE421IK9KHb+mC1HXdpRG4BD0DPQ9VJYvXFPYiYydkQEYOhp3pyQoVJCCIXm5dBb2tbJ2EXBPiwwQ0/osC+KJF1JAn+3E1YUGBQC7pk2zG+nz0nNbbc1yGsemhhQx8JOXuewQv+yQxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100751; c=relaxed/simple;
	bh=k0AhVer/COxuWP6iGY1J5RVKPazlMQyiNZuvVy7H9qU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LeXSrXc+Jsincp6QcHi9QznwGfbg1I1l/GKRpnBcyYXnMpRc9MU8xUny1Qb9YGQmQdDajvfsTiGaEZvE4OyEzXqczapF1mrNpC6O+lmEjpv1yQB/OvRhQux9gHozwFF+dxSar6MG7ceag13+2tLteloaSSPNLcYR0PEyphf4tIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3vXenMPq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kRqDJQ+P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=790s+cOMBj/y5/dRJ9WI50uaiiyWoEp3JuylETTc5rY=;
	b=3vXenMPqNctfs6kufbGGAdlgsIYMmQBjYPNzB761vjf1wuWP7NWD0/MUkbKY9eqywO80/y
	3cLw7+8wgD8C3xDD5bv+Vgzl0GFWX5ns55WQdte1aq0LAjy5VGNni4DAelfSLShdf3B1Kj
	BUSWEvO6YDGPYjDfKvqyvMW1gdb+5TnMuxE5doFFfesST1E4DIA3FHBszqcHASrcVJb1cw
	Mwqpqui44bszaZio9v117iKlm1OER3fGcMnZJpoiYn7Z68oEuNOYh7qJQXdl7cS5+nYQe3
	M0HcXga2MmgaCpY2xfY3SSoIuEwNEKtLMG3rG8VH3DM21S9Iz1czOOT3ltWm7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=790s+cOMBj/y5/dRJ9WI50uaiiyWoEp3JuylETTc5rY=;
	b=kRqDJQ+PUMhFGuDd5xRgTeqzvpY7oldpTijFtw9+gYiI5v9LgTLbBl0KgTF95vDwomogDH
	qvT8Xok/B9h/oxBw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 30/31] null_blk: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:32:03 +0100
Message-Id: <d9d3bbed4ff7dbc6b3310f6c5a76acdc93a87696.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a newly introduced hrtimer_setup() which will replace
hrtimer_init(). This new function is similar to the old one, except that it
also sanity-checks and initializes the timer's callback function.

Switch to use this new function.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/null_blk/main.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2f0431e42c49..b815b26b39d2 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1418,8 +1418,7 @@ static void nullb_setup_bwtimer(struct nullb *nullb)
 {
 	ktime_t timer_interval =3D ktime_set(0, TIMER_INTERVAL);
=20
-	hrtimer_init(&nullb->bw_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	nullb->bw_timer.function =3D nullb_bwtimer_fn;
+	hrtimer_setup(&nullb->bw_timer, nullb_bwtimer_fn, CLOCK_MONOTONIC, HRTIME=
R_MODE_REL);
 	atomic_long_set(&nullb->cur_bytes, mb_per_tick(nullb->dev->mbps));
 	hrtimer_start(&nullb->bw_timer, timer_interval, HRTIMER_MODE_REL);
 }
@@ -1596,8 +1595,8 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ct=
x *hctx,
 	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
=20
 	if (!is_poll && nq->dev->irqmode =3D=3D NULL_IRQ_TIMER) {
-		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		cmd->timer.function =3D null_cmd_timer_expired;
+		hrtimer_setup(&cmd->timer, null_cmd_timer_expired, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
 	cmd->error =3D BLK_STS_OK;
 	cmd->nq =3D nq;
--=20
2.39.5


