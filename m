Return-Path: <linux-kernel+bounces-384286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938D9B28ED
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FE9A1F2226C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996E21DDC0B;
	Mon, 28 Oct 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s7DoRECV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hhECnvon"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880721DACBB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100749; cv=none; b=ON8s/Uwq4EvNKD2guXNheSLCFIUdYvqSyn/uqmi6oRMavh7XhfPdZ4jrPVmnvneG8jP9NG3fqrkKl7u5FfFRC1sxC3jWeng1R5ilMidmdnD0YusIHfGG9AqFfrn7PypDnAqBkNiL8tmRZCkCP1gyPlOMHwn6wicK99vRViqPZM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100749; c=relaxed/simple;
	bh=DgvwSAkDCHNl9T+jExGv9opoZtlAjlaik41GARiZMmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBHASsB98RIky5CeCM/W1MGDhW3qgdAHd8ru72qr5ssUeb2Dezbuc8yMSPFtqTknELxUz5EU1RNqCoVyzFfDfG/hBQizdb4lo5iZNHie7GlXiq+ZE8cCYkyQQLEXYwEe/zcopCUAW24rjGX6ip6IQI9j5JAOk7w1zahiqvQNcz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s7DoRECV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hhECnvon; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V47MlVMzGanDaCs+1QO3kznYikX5lsFVO9X/vkH7Msk=;
	b=s7DoRECVY8MlaAa5x23iW3Eyu0suKb73jj2QdsBaQBANnnCJXHE9vxH+wwjGsR33hjfkTs
	CE7zpWS/Eavl75bQspeGRWkHwCMEo97Kg1H59dEpi5/vd2HCJ1QS72RVEgjcFXxdrYEYFP
	5dttmuPpGT+UWK6MPi06mKVLOxwp2eQr1AoJpw26psfUa+ZF4ipqnxoi9U1InQJzcs27EQ
	5mBm1bsgMZqc138RZiz4OqLzfgPSRHK2JS2N9wfhtMieL48NwqF4nH33D7K+piNV+q1ZOn
	hd3jNFPMArPQYo2c5TKQdTczyJxDjSC7zZ8WTa1RahC+TnSrGOCQFAZW4WfsTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V47MlVMzGanDaCs+1QO3kznYikX5lsFVO9X/vkH7Msk=;
	b=hhECnvonTSx0bG7qRo7xYtMr7tok82jXY1cP1wjCJKb4nqN1BGqTmqrsEFGSJmLl7Hs5gX
	HhoQiW1gl3SoriAQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 24/31] tracing/osnoise: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:57 +0100
Message-Id: <491c6ad7c82f8fc446d0727757e6b4267ac64417.1729864823.git.namcao@linutronix.de>
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
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 1439064f65d6..e50f7a1aae6d 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1896,8 +1896,7 @@ static int timerlat_main(void *data)
 	tlat->count =3D 0;
 	tlat->tracing_thread =3D false;
=20
-	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	tlat->timer.function =3D timerlat_irq;
+	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_A=
BS_PINNED_HARD);
 	tlat->kthread =3D current;
 	osn_var->pid =3D current->pid;
 	/*
@@ -2461,8 +2460,7 @@ static int timerlat_fd_open(struct inode *inode, stru=
ct file *file)
 	tlat =3D this_cpu_tmr_var();
 	tlat->count =3D 0;
=20
-	hrtimer_init(&tlat->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	tlat->timer.function =3D timerlat_irq;
+	hrtimer_setup(&tlat->timer, timerlat_irq, CLOCK_MONOTONIC, HRTIMER_MODE_A=
BS_PINNED_HARD);
=20
 	migrate_enable();
 	return 0;
--=20
2.39.5


