Return-Path: <linux-kernel+bounces-384294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 316409B28F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12271F204E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096F51DE3AA;
	Mon, 28 Oct 2024 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lQfu1DYS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBeYXwQS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB718191F62
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100751; cv=none; b=mOK+7ThyM/pOzqzPRARfDN/mlmSUjWehCzPK7X/XZ49Nv2+bHGNCByPAzy7qD3Eugt8HKidRE0RVDox8Lx+BLtp7cU7hIAjqqnrhKl9XiK2Q+VxkNwrlx2ziIFRmG3RcLSxAt4zZVSES0aIYx8xy8GWotuXRwv3PqNCD2tEYw4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100751; c=relaxed/simple;
	bh=kQ6BKIhl3w/6/TLxxrPq+qOApBwa/1iiAmh+swXeI4o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XbTzcV95x8AfMr+kmIBvvkgjm+taPgr02pbAhJgGKXlEYYHw8uIc+8n27Eozs4K7fIU/yx5qoNNtdrI8DjoebBGFvG+VeXr6sUufrHr2V1QupAVxRgohsxRcL4gyU81qBtYMKuLOZwxojGaiJgKJV1kb9dqrhHx2QoPvnfV+bVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lQfu1DYS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aBeYXwQS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bP5cyQTok5lidmuCqIWmyhURfoTz6x70yCEPg03oU4M=;
	b=lQfu1DYS2CWIpWMjV7uqYcAvKiv4K2TkO8zm9QYKqNxKnnEZkdVo+SsZ0KMb89pNhwl9De
	vDsbGMZMiOPFX0a26FV/UbHEan22TR2aWGlMLKvx/RDENmhgQS3MlCICuLjamN1lDmD9vc
	RMbhlJZPkl3NegQEOrfFLXqglQkWYuK9vh72aSCDuzgxXkBcg0Z4gVN/kCVTsasiQZBdCO
	Y2aqXOZ2Q/HdzqZmclkdWsHR0ITS4RZTP74cHrDQWq6efD0w02b0/1t/HxVU832u0hXgw8
	wmSPWU3OpIt0QDkOn8jXBlHoNOdalGgRszwirt1tiSdfdtpeAqDjgZ6Q63Xolg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bP5cyQTok5lidmuCqIWmyhURfoTz6x70yCEPg03oU4M=;
	b=aBeYXwQSX5RRCua3/0Tecbox2G06ieXX1w9dkw1Oiujwqs2Tjx5CR9R+yUTSqhN43mv5hj
	F8lUs4asnn9HPsAw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 31/31] hwrng: timeriomem: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:32:04 +0100
Message-Id: <38019ad544cb1c2d0f2a678573611a4e05992040.1729864823.git.namcao@linutronix.de>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/char/hw_random/timeriomem-rng.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/timeriomem-rng.c b/drivers/char/hw_rand=
om/timeriomem-rng.c
index 65b8260339f5..27b0e2026d53 100644
--- a/drivers/char/hw_random/timeriomem-rng.c
+++ b/drivers/char/hw_random/timeriomem-rng.c
@@ -152,8 +152,7 @@ static int timeriomem_rng_probe(struct platform_device =
*pdev)
=20
 	priv->period =3D ns_to_ktime(period * NSEC_PER_USEC);
 	init_completion(&priv->completion);
-	hrtimer_init(&priv->timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	priv->timer.function =3D timeriomem_rng_trigger;
+	hrtimer_setup(&priv->timer, timeriomem_rng_trigger, CLOCK_MONOTONIC, HRTI=
MER_MODE_ABS);
=20
 	priv->rng_ops.name =3D dev_name(&pdev->dev);
 	priv->rng_ops.read =3D timeriomem_rng_read;
--=20
2.39.5


