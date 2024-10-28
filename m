Return-Path: <linux-kernel+bounces-384285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653FA9B28EC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5E52815BB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7859F1DDA3C;
	Mon, 28 Oct 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c/2yptmz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jgH6gSDT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA74D1DA634
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100748; cv=none; b=l4bkBSIos+FoiwcEPF8Ir81smPSyNbu/4ZfKsGXTyGWysmtgqSBlZcFDb18eX9Tnstilm/jRmc/Vpi27/maL2MrQuQr+iDR574VRNe+RAvSHqaPX89YR0QRWr1IrCti0YbO6ydDZLqLt+Xjutno1yuPNRoS4hjud45CCgOPwN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100748; c=relaxed/simple;
	bh=4j1WP5ehxHj4mYlvpYltxxrO4sqQU0hAN2uFCoJmt2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FbgmX+iWRNAZbcYuIOMac5vpJxpI8x7P4QfEPlp7u2RRG0QnDAU3QwHGDyVgfVxX5HFjijWqmMrrL7RBlLlOHX++CZtLu7j+nyuHiqlq6z7Hf9pGIZYcQyjUBlTna6KFpc7mAQyZ4K8tgg5Tjj6bsFuCmg8HKchevXgR5YY3vGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c/2yptmz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jgH6gSDT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huKaPtaYzUgDhdKaFdYHwviz0Ur8cPBTKnQ57LRJxeg=;
	b=c/2yptmzy99p0qknVenIbAuV8FLy7mL9zD6IpJT/31tDj4Z40kRK8/I2sWgRYk4a9zCFe4
	TzrNYEkmeKgRJaToCZybw9Ovo6b6mQMAYM0m2nx6A4gnlZsfHiZau4MY6zF1EaaFrHk2Vd
	Umbu8jINh1C9XHQ4vFeNLiLUJJiLWoehl3VEpBNGqsRUXd1GZ1KkINr6lEnZL3/OetpUUe
	rwRE/wwbJ7fMKFHqr5SdtuVwVmz4MhmD83+4NGScGcAAGSvbN3G/0rSjdUXCGqn4/653Xl
	/6HPvNXmmaUziWWiiXZGWqMHOXZl1sDSR47hUCdJR3P0wgd5vlwH7893BRf1KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huKaPtaYzUgDhdKaFdYHwviz0Ur8cPBTKnQ57LRJxeg=;
	b=jgH6gSDTpxzju8Uh/8S0+lwqfbD2gu7+Rhsh9QbOVx9OyoC9pfRe7J57bW9VlJqhwViEQa
	c+S10DBayTI4MUDQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Richard Weinberger <richard@nod.at>
Subject: [PATCH 22/31] ubifs: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:31:55 +0100
Message-Id: <2443754dc58c8afba6c5df7a7cca3e3669332086.1729864823.git.namcao@linutronix.de>
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
Cc: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
index 01d8eb170382..a79f229df475 100644
--- a/fs/ubifs/io.c
+++ b/fs/ubifs/io.c
@@ -1179,8 +1179,7 @@ int ubifs_wbuf_init(struct ubifs_info *c, struct ubif=
s_wbuf *wbuf)
 	wbuf->c =3D c;
 	wbuf->next_ino =3D 0;
=20
-	hrtimer_init(&wbuf->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	wbuf->timer.function =3D wbuf_timer_callback_nolock;
+	hrtimer_setup(&wbuf->timer, wbuf_timer_callback_nolock, CLOCK_MONOTONIC, =
HRTIMER_MODE_REL);
 	return 0;
 }
=20
--=20
2.39.5


