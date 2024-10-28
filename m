Return-Path: <linux-kernel+bounces-384319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3618A9B2923
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EC0282492
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997931DFE3A;
	Mon, 28 Oct 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3delRPNF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ylZY3DFX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8CF1D9A41
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100896; cv=none; b=WjAPP/uGe8/g8i1yWPHegr4FzOL8KXaOE1xrZsOVtIWfwu0bMd0kcNTWAltexLeraaza8O/edEuHfKOm1aneO5ZoCZTXfHf5TSmCRsLhe5OEcyAtn8zZf/qeimrDKmw1feV5ZGr1cqvQ9p5BfWXQUx/eQ8oBRAa1fulyW5Wtw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100896; c=relaxed/simple;
	bh=albjBGOrXlcjYPXZSQHgCZ9IdrYuovJW+KtvpXDggnI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uJ9DCRoMZnLQDj+w9a1aARi9ugHPgmF+lv6ZkWlkhsLJx1YD4YHQizbsGMGftsJe72f29qYhPeVsKV+tM5XpXprTfTExrA7K8xPUJFP7sq9QaKbg0RVI+hSsol+bbPzgCQvhUf0ib0wOFrBffAjyR5PHtns2Tbec5E3TPHUmXAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3delRPNF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ylZY3DFX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lv2h/77aH+9nFUo7h9NGs+/N5o8hl722p+7yXY/Iaaw=;
	b=3delRPNFYYre966VjU1bq+3/ilH+rfPC7bwjQJsni8WtlOdG1d+2KZYgl515nqAOYsYjRi
	66qhoUkaVec42XSj1a0HbGgQI75/HjEUIWdpIWe8+Y44IdAOwjPhxBO64ezruZM5BhqqO1
	zP22MHwPwrwXdvZuRYcnNZu4GzrX4UbkWC4RUPi1sFFMkLJDmsk+2QFnGYIC4eF0B1+hzx
	6yPlldgRqmSeJUNbNFygixU9+2T6VOiMAqK/QEiLl5tfF+1J4hkKT8fHBncG5SuSdQXUHl
	w1+Sz18Cy/ZtkFxb+wX2oAk5I4M+s9FnAp3RvWUrQ0tKSYhHPDn6sZ7P4CqDSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lv2h/77aH+9nFUo7h9NGs+/N5o8hl722p+7yXY/Iaaw=;
	b=ylZY3DFX5gIB95UcSLARB+ui68h0h+/rb1uTvTwXWHHofSNff1LnKve/67IBC9eSRCbxCO
	9Dd6rLWkJ96Jg3Cw==
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
Subject: [PATCH 16/24] net: stmmac: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:29 +0100
Message-Id: <45aca4db7aa93cc60224ed630ef937418870702b.1729865232.git.namcao@linutronix.de>
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
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/ne=
t/ethernet/stmicro/stmmac/stmmac_main.c
index e2140482270a..61ed82561168 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3148,8 +3148,7 @@ static void stmmac_init_coalesce(struct stmmac_priv *=
priv)
 		priv->tx_coal_frames[chan] =3D STMMAC_TX_FRAMES;
 		priv->tx_coal_timer[chan] =3D STMMAC_COAL_TX_TIMER;
=20
-		hrtimer_init(&tx_q->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		tx_q->txtimer.function =3D stmmac_tx_timer;
+		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
 	}
=20
 	for (chan =3D 0; chan < rx_channel_count; chan++)
@@ -6967,8 +6966,7 @@ int stmmac_xdp_open(struct net_device *dev)
 		stmmac_set_tx_tail_ptr(priv, priv->ioaddr,
 				       tx_q->tx_tail_addr, chan);
=20
-		hrtimer_init(&tx_q->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		tx_q->txtimer.function =3D stmmac_tx_timer;
+		hrtimer_setup(&tx_q->txtimer, stmmac_tx_timer, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
 	}
=20
 	/* Enable the MAC Rx/Tx */
--=20
2.39.5


