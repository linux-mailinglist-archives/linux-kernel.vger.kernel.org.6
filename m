Return-Path: <linux-kernel+bounces-384245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28729B28BF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADBE1C2132E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680CC1922F9;
	Mon, 28 Oct 2024 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MamlcB/q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0oBArcpf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E75191F85
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100632; cv=none; b=AnVIHuQ3AD9NmyTOQVHrlFvkH8w75mmE85twOypSa/4z+v62i2GztyjLXtivRcYDMqXRXK/4yRqTwvRJrFzuHVN1uARFhu0yHvalGV3eNVu9hY3VxxFnvfsNZ/l2U2DEZPq1anfLR9gs1kYPAXr5lJQA1u4yGSr3Ls5e23V3RsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100632; c=relaxed/simple;
	bh=rPQoYBuvRBPxXxqFYU4bdWqAsBewz/w4trzATbcPrjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sM3YafgLk5b/6P5SDEmPq09X8nekAUkpwZDgN2otv4t2kOXkQPVdFlmetak8Jt2czxCWveS0GTK/TmIYnb5e80e9aOlZamZzFL4poaVTkVlu5LkC8BUrUzDb/L+uNO6+QIYAVGGmql7xMvmaV/Fn0CN6ccAd5qkDnie3STsSMzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MamlcB/q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0oBArcpf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHu/npypZeEz0R4NmSfWBAjA0w4EAi3CAQjNRRB7z94=;
	b=MamlcB/qDAXFjbOauft1QrKu+2nkd37sQA5djwbcMLqFjgsHvm/QH7u154lgcmp3yv3z2c
	LaDgMYUR/o7kxvBYCrLV0WvkD59k7RtBUJ0TkI3Mew448U6XhTNezIwMDJiaIQXI74LzG2
	FC0gDM95FlEq0SI9SVKFqDj0mo1aJI9tcye9sykWreF7al8FRjQxL3QMmsDxoX8rGyA2QR
	iIhCV3UZcV5Owf/oPxMhA2EjkXN7rU+gyBKFRVEKhKwEGejuRGpL3fMixudnEoLfRhppOr
	unfuTKMINDn5X/uAiRghbqTgg1oc1eU6fqIePl/gqMZxptKzBWzYMrNHLl6hzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHu/npypZeEz0R4NmSfWBAjA0w4EAi3CAQjNRRB7z94=;
	b=0oBArcpfshtV+9LVfFhxbneYZdve1GjkPYUbe/PbTWgRRNzGRv9iMa5WDbtuYUGj1ZM9/C
	4SO4+CenRYQvl6Cw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 05/21] can: bcm: Don't initialized an unused hrtimer
Date: Mon, 28 Oct 2024 08:29:24 +0100
Message-Id: <4e7dc11aa9ffb116678574889cda35b3cd5b7385.1729864615.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864615.git.namcao@linutronix.de>
References: <cover.1729864615.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The hrtimer "thrtimer" is not used for TX. But this timer is initialized
regardless.

Remove the hrtimer_init() for the unused hrtimer and change bcm_remove_op()
to make sure hrtimer_cancel() is not called with the uninitialized hrtimer.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Jakub Kicinski <kuba@kernel.org>
---
 net/can/bcm.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/net/can/bcm.c b/net/can/bcm.c
index 217049fa496e..792528f7bce2 100644
--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -780,10 +780,11 @@ static void bcm_free_op_rcu(struct rcu_head *rcu_head)
 	kfree(op);
 }
=20
-static void bcm_remove_op(struct bcm_op *op)
+static void bcm_remove_op(struct bcm_op *op, bool is_tx)
 {
 	hrtimer_cancel(&op->timer);
-	hrtimer_cancel(&op->thrtimer);
+	if (!is_tx)
+		hrtimer_cancel(&op->thrtimer);
=20
 	call_rcu(&op->rcu, bcm_free_op_rcu);
 }
@@ -844,7 +845,7 @@ static int bcm_delete_rx_op(struct list_head *ops, stru=
ct bcm_msg_head *mh,
 						  bcm_rx_handler, op);
=20
 			list_del(&op->list);
-			bcm_remove_op(op);
+			bcm_remove_op(op, false);
 			return 1; /* done */
 		}
 	}
@@ -864,7 +865,7 @@ static int bcm_delete_tx_op(struct list_head *ops, stru=
ct bcm_msg_head *mh,
 		if ((op->can_id =3D=3D mh->can_id) && (op->ifindex =3D=3D ifindex) &&
 		    (op->flags & CAN_FD_FRAME) =3D=3D (mh->flags & CAN_FD_FRAME)) {
 			list_del(&op->list);
-			bcm_remove_op(op);
+			bcm_remove_op(op, true);
 			return 1; /* done */
 		}
 	}
@@ -1015,10 +1016,6 @@ static int bcm_tx_setup(struct bcm_msg_head *msg_hea=
d, struct msghdr *msg,
 			     HRTIMER_MODE_REL_SOFT);
 		op->timer.function =3D bcm_tx_timeout_handler;
=20
-		/* currently unused in tx_ops */
-		hrtimer_init(&op->thrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL_SOFT);
-
 		/* add this bcm_op to the list of the tx_ops */
 		list_add(&op->list, &bo->tx_ops);
=20
@@ -1277,7 +1274,7 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_head=
, struct msghdr *msg,
 		if (err) {
 			/* this bcm rx op is broken -> remove it */
 			list_del(&op->list);
-			bcm_remove_op(op);
+			bcm_remove_op(op, false);
 			return err;
 		}
 	}
@@ -1581,7 +1578,7 @@ static int bcm_release(struct socket *sock)
 #endif /* CONFIG_PROC_FS */
=20
 	list_for_each_entry_safe(op, next, &bo->tx_ops, list)
-		bcm_remove_op(op);
+		bcm_remove_op(op, true);
=20
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list) {
 		/*
@@ -1613,7 +1610,7 @@ static int bcm_release(struct socket *sock)
 	synchronize_rcu();
=20
 	list_for_each_entry_safe(op, next, &bo->rx_ops, list)
-		bcm_remove_op(op);
+		bcm_remove_op(op, false);
=20
 	/* remove device reference */
 	if (bo->bound) {
--=20
2.39.5


