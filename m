Return-Path: <linux-kernel+bounces-384307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A488D9B2917
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7B3D1C203A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80ADC1DA109;
	Mon, 28 Oct 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LN1WJk9E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fV7WhHhH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08201D31BE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100892; cv=none; b=hEj6vo5bHwzpqQE3a18o6pYffNZcShJEit0phtjNbiGVgGcLsN517fTzzZTdQAm63uSgLKIReVyWjwJB5HiBOzI7aXrhvCZni4srun9smoK1fEoEcNIrFTyRq4V+KA6HBWFT+LnkQZ/fZCMfb0GwZIXgiqxrdClB/2YM4q1ThLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100892; c=relaxed/simple;
	bh=UIfp12f6ICg1/fF3nWdK6jYYWW5ZwrHHOvfZ/2sJy54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W04KdZXED9qDfDqGSqSnYqagKLpJ4WPR5vBkM0uODQKJfpy13FCnz4azGlgHkYg5I/hHk5ziY/53naCsenqZPV9uOlRhAu8ff8+UjdGafJBB6PdvgqaPObxKW3YV30KXRegOZtnaP/CnC3UK6eL1aDojcm3yTyiqtoqlwDKphsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LN1WJk9E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fV7WhHhH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBuM06sYWpJW/gUpuuXSFlaQhARIqOQtwS++UcbYnzM=;
	b=LN1WJk9E5+JPLxlztImE2RI4VQQ9BjYNW4S28UuUit4RQPbXnfuzsRkALyYzv17sVQ5wV/
	8nrXernaD3lgq78FsTj6DH+MR26g/qeDtiGBfWYmZzATtZ1OPi+cTAkPJxjM0EidWs1hIh
	UPTby1WtgZsvTA0u6Slb3JGLhk/5nNoiev3VeerbWVI3TVwuAl7hDep7Qdg7kue4Wkr13A
	0ZJ+MANQPqYspFa5w0c+YoOrvVJsaUyCvFmtdP3qpKtdv1cKuNGkvCjKSZ1mN1PKigITOr
	7CQfImt+bNCuCZ0amQUSjlnrpjI3xd89graenMEH1DKga80UtP15Hnes9NrE7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UBuM06sYWpJW/gUpuuXSFlaQhARIqOQtwS++UcbYnzM=;
	b=fV7WhHhHWPls7HOvJAAcWSN8u1/zguFoy9O4Dxqmyle70+LM1abyFzzTgG/ANdAj4DqZ/+
	VVD5GfbHQVbPfgDg==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 07/24] can: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:20 +0100
Message-Id: <e4ce3a3a28625d54ef93e47bfb02f7ffb741758a.1729865232.git.namcao@linutronix.de>
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
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 net/can/bcm.c             | 16 ++++++----------
 net/can/isotp.c           | 10 ++++------
 net/can/j1939/bus.c       |  4 ++--
 net/can/j1939/transport.c |  8 ++------
 4 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 792528f7bce2..2048cbbed138 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -1012,9 +1012,8 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_head=
, struct msghdr *msg,
 		op->ifindex =3D ifindex;
=20
 		/* initialize uninitialized (kzalloc) structure */
-		hrtimer_init(&op->timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
-		op->timer.function =3D bcm_tx_timeout_handler;
+		hrtimer_setup(&op->timer, bcm_tx_timeout_handler, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_SOFT);
=20
 		/* add this bcm_op to the list of the tx_ops */
 		list_add(&op->list, &bo->tx_ops);
@@ -1189,13 +1188,10 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
 		op->rx_ifindex =3D ifindex;
=20
 		/* initialize uninitialized (kzalloc) structure */
-		hrtimer_init(&op->timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
-		op->timer.function =3D bcm_rx_timeout_handler;
-
-		hrtimer_init(&op->thrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
-		op->thrtimer.function =3D bcm_rx_thr_handler;
+		hrtimer_setup(&op->timer, bcm_rx_timeout_handler, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_SOFT);
+		hrtimer_setup(&op->thrtimer, bcm_rx_thr_handler, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL_SOFT);
=20
 		/* add this bcm_op to the list of the rx_ops */
 		list_add(&op->list, &bo->rx_ops);
diff --git a/net/can/isotp.c b/net/can/isotp.c
index 16046931542a..442c343afe1f 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1634,12 +1634,10 @@ static int isotp_init(struct sock *sk)
 	so->rx.buflen =3D ARRAY_SIZE(so->rx.sbuf);
 	so->tx.buflen =3D ARRAY_SIZE(so->tx.sbuf);
=20
-	hrtimer_init(&so->rxtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	so->rxtimer.function =3D isotp_rx_timer_handler;
-	hrtimer_init(&so->txtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	so->txtimer.function =3D isotp_tx_timer_handler;
-	hrtimer_init(&so->txfrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	so->txfrtimer.function =3D isotp_txfr_timer_handler;
+	hrtimer_setup(&so->rxtimer, isotp_rx_timer_handler, CLOCK_MONOTONIC, HRTI=
MER_MODE_REL_SOFT);
+	hrtimer_setup(&so->txtimer, isotp_tx_timer_handler, CLOCK_MONOTONIC, HRTI=
MER_MODE_REL_SOFT);
+	hrtimer_setup(&so->txfrtimer, isotp_txfr_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_SOFT);
=20
 	init_waitqueue_head(&so->wait);
 	spin_lock_init(&so->rx_lock);
diff --git a/net/can/j1939/bus.c b/net/can/j1939/bus.c
index 486687901602..39844f14eed8 100644
--- a/net/can/j1939/bus.c
+++ b/net/can/j1939/bus.c
@@ -158,8 +158,8 @@ struct j1939_ecu *j1939_ecu_create_locked(struct j1939_=
priv *priv, name_t name)
 	ecu->addr =3D J1939_IDLE_ADDR;
 	ecu->name =3D name;
=20
-	hrtimer_init(&ecu->ac_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	ecu->ac_timer.function =3D j1939_ecu_timer_handler;
+	hrtimer_setup(&ecu->ac_timer, j1939_ecu_timer_handler, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL_SOFT);
 	INIT_LIST_HEAD(&ecu->list);
=20
 	j1939_priv_get(priv);
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 319f47df3330..7f97e7f97799 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1510,12 +1510,8 @@ static struct j1939_session *j1939_session_new(struc=
t j1939_priv *priv,
 	skcb =3D j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
=20
-	hrtimer_init(&session->txtimer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_SOFT);
-	session->txtimer.function =3D j1939_tp_txtimer;
-	hrtimer_init(&session->rxtimer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL_SOFT);
-	session->rxtimer.function =3D j1939_tp_rxtimer;
+	hrtimer_setup(&session->txtimer, j1939_tp_txtimer, CLOCK_MONOTONIC, HRTIM=
ER_MODE_REL_SOFT);
+	hrtimer_setup(&session->rxtimer, j1939_tp_rxtimer, CLOCK_MONOTONIC, HRTIM=
ER_MODE_REL_SOFT);
=20
 	netdev_dbg(priv->ndev, "%s: 0x%p: sa: %02x, da: %02x\n",
 		   __func__, session, skcb->addr.sa, skcb->addr.da);
--=20
2.39.5


