Return-Path: <linux-kernel+bounces-384308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB5E9B2916
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1335A28252B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:45:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F36A1DA0E0;
	Mon, 28 Oct 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="glQqNMpz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTkbuGSq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B141D1305
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100892; cv=none; b=hHyNOqOQXmoAjz8xnqgdkEu/DPpXvF/5ACePzA0Urgp8gVuAqw/GgjDNTjMeqdrOKUqfZDuQwhSIaGjSVivBTgyUhZbumwBUgx3EcCpL+RGWzkq0xO+RsGqN9cm6/n4Tyrx4e04ngIvKpZiAJPZgTyfY/hQrZBqdLjWxmJE17eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100892; c=relaxed/simple;
	bh=UEEWNr6vkvJ2yuF3etO3unNqtvL1psmqI4ZgW5d28W0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KWBUuRNM9R8CD4vQ9tctqeY5pehCIEJE9bRnKpDgTnQL2FKobY1q0gfVnzdGSMTdPEhEvty4xDvgML22GwcacDGHNEymhMJTI8gfZdkD8s/4TR0ouMJ8OBnkxY3zeJOf+pIJ65gmaapRBU/eVeIN6Xn6esfynBhicy0Gx40zcKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=glQqNMpz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTkbuGSq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJBkHtyT4teuZbaM7TI9FQL2VUs8Qow+v09qjqOiNx0=;
	b=glQqNMpzMM4TkbAI0owjYdwGIM+xdOMzyUUuk+Q6ToDzCxGOt7Ly5IKBwVPJspfewdOUQQ
	UgjuMy72p/vIMAWPw5LPoF5KfYqwm9TTMmKQb0r4D2ztXtU/xObA/BVc0dFkN+MptRDh2m
	U1e9wCjlZsdt8abUhrdyycA1qzrI6FHFaw/dc/SEntdi6sqNfexBJLuvxRpV2oEVlW+9nl
	NnhlES9tRwNyTTV8UDpTeOAqlEJBLzNSNudH+eFHgHrnByCteyIFaOsNAq/KnB3dJ2+M4Y
	UDFOHTW7UiZUx+o9igbK/hbtrcBsnNWsQ4mzg7DLk7TjjteepNkVAPtrX6eh7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZJBkHtyT4teuZbaM7TI9FQL2VUs8Qow+v09qjqOiNx0=;
	b=aTkbuGSq2i1X3KEMYKVdZf8IEsFU+OGA+eTdvm/8zThVs5sg9Tk+p5jHMDJKlT/zD77RIS
	fEcQJwLS53mo3BAw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 08/24] net: ethernet: ti: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:21 +0100
Message-Id: <800557e9eb5451966ab6a850fc56c4a3f73a40d9.1729865232.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865232.git.namcao@linutronix.de>
References: <cover.1729865232.git.namcao@linutronix.de>
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
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c     | 9 ++++-----
 drivers/net/ethernet/ti/icssg/icssg_common.c | 5 ++---
 drivers/net/ethernet/ti/icssg/icssg_prueth.c | 5 ++---
 3 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/etherne=
t/ti/am65-cpsw-nuss.c
index cbe99017cbfa..ba5e32366fb8 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2236,8 +2236,8 @@ static int am65_cpsw_nuss_ndev_add_tx_napi(struct am6=
5_cpsw_common *common)
=20
 		netif_napi_add_tx(common->dma_ndev, &tx_chn->napi_tx,
 				  am65_cpsw_nuss_tx_poll);
-		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINN=
ED);
-		tx_chn->tx_hrtimer.function =3D &am65_cpsw_nuss_tx_timer_callback;
+		hrtimer_setup(&tx_chn->tx_hrtimer, &am65_cpsw_nuss_tx_timer_callback,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL_PINNED);
=20
 		ret =3D devm_request_irq(dev, tx_chn->irq,
 				       am65_cpsw_nuss_tx_irq,
@@ -2485,9 +2485,8 @@ static int am65_cpsw_nuss_init_rx_chns(struct am65_cp=
sw_common *common)
 			 dev_name(dev), i);
 		netif_napi_add(common->dma_ndev, &flow->napi_rx,
 			       am65_cpsw_nuss_rx_poll);
-		hrtimer_init(&flow->rx_hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
-		flow->rx_hrtimer.function =3D &am65_cpsw_nuss_rx_timer_callback;
+		hrtimer_setup(&flow->rx_hrtimer, &am65_cpsw_nuss_rx_timer_callback, CLOC=
K_MONOTONIC,
+			      HRTIMER_MODE_REL_PINNED);
=20
 		ret =3D devm_request_irq(dev, flow->irq,
 				       am65_cpsw_nuss_rx_irq,
diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/eth=
ernet/ti/icssg/icssg_common.c
index fdebeb2f84e0..16ca4b1fc01b 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_common.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
@@ -249,9 +249,8 @@ int prueth_ndev_add_tx_napi(struct prueth_emac *emac)
 		struct prueth_tx_chn *tx_chn =3D &emac->tx_chns[i];
=20
 		netif_napi_add_tx(emac->ndev, &tx_chn->napi_tx, emac_napi_tx_poll);
-		hrtimer_init(&tx_chn->tx_hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_PINNED);
-		tx_chn->tx_hrtimer.function =3D &emac_tx_timer_callback;
+		hrtimer_setup(&tx_chn->tx_hrtimer, &emac_tx_timer_callback, CLOCK_MONOTO=
NIC,
+			      HRTIMER_MODE_REL_PINNED);
 		ret =3D request_irq(tx_chn->irq, prueth_tx_irq,
 				  IRQF_TRIGGER_HIGH, tx_chn->name,
 				  tx_chn);
diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/eth=
ernet/ti/icssg/icssg_prueth.c
index 5fd9902ab181..fe5c32be1ab3 100644
--- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
+++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
@@ -951,9 +951,8 @@ static int prueth_netdev_init(struct prueth *prueth,
 	ndev->hw_features |=3D NETIF_PRUETH_HSR_OFFLOAD_FEATURES;
=20
 	netif_napi_add(ndev, &emac->napi_rx, icssg_napi_rx_poll);
-	hrtimer_init(&emac->rx_hrtimer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_PINNED);
-	emac->rx_hrtimer.function =3D &emac_rx_timer_callback;
+	hrtimer_setup(&emac->rx_hrtimer, &emac_rx_timer_callback, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_PINNED);
 	prueth->emac[mac] =3D emac;
=20
 	return 0;
--=20
2.39.5


