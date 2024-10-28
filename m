Return-Path: <linux-kernel+bounces-384368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F029B2954
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58409282A73
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C96204F7D;
	Mon, 28 Oct 2024 07:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZOoBsKHO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UL8Uq496"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C17D202646
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100953; cv=none; b=V68YRgVMVfJigYtM76fxEUgrLZOre+NW7wpCST6qFcq3wDT7WqPZkm6hqU4bew6MC4ml+wB34C2xjZaJamrqB1q1kRxCueJMFTiQgtUDxxrDlhaX3beb+oThOhA4E34L+OmMmkvySGhQZtyNR4esk9cfC/x/j4l6R/H9gXNowXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100953; c=relaxed/simple;
	bh=s86+jwvVGQkywluQ+jtGbWhLIvyPeVuJVFuJfE9PoQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N/5ja67NFOLgT/UwKImfDdfyEz6odl6knE9smpADECxrnmUdhfx8hZsZKrCVc0TZ3lfC1Mfhk8OD7jCBVlUm3arsqA0eQvs8PqGd6hyRgHV8NbpcBcwGq+DSBmTkhprtzO54vgoxqqSZMXLC2wbt/F0sm7v2AzbRt/48xJH95rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZOoBsKHO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UL8Uq496; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZgMzIqO4ieBnomo8nG9x2WYQXCUfDw+hlHKe86zbQQ=;
	b=ZOoBsKHO38xnH5rS/KG4zuinD+qWH5vOuDco9RhmUKkgIZymyC3gipbbnwiX94q7gbC7lv
	CvkVXVVGHgVqyivc8YIZEmt5qL3Taq+llUKF3ZMKu5/ME9DIFnM/gkyJD0YqrlWj+Jy82D
	/dkhOReQ+U9lVhNABc+GzMEgeQtN3euTlNlDDUmL/DDeiNEFXqDAgUCLTduFwrDK/P5Gz5
	02jUcIZirjRGk5DJqHSqotnG/0pJfnYxChih7XKA+1eWByE+O9/t9qauYHaXgoGFTYje52
	NauGdXbCliJH4rRgMYUy0hL+PiNbN+vZAZV8BDUlWFv00hL75eZ3r39y8YrPYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1ZgMzIqO4ieBnomo8nG9x2WYQXCUfDw+hlHKe86zbQQ=;
	b=UL8Uq496JL7txN8CK+FvY170EpMoa4AgTgdzx/pEB3HS+Or62ksp8BfZ096C180iamkqRV
	9BYK/tBhz0k9tjBQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH 41/44] RDMA: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:17 +0100
Message-Id: <e56dc176e3382916a8131ba37129decb3b781fe3.1729865485.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865485.git.namcao@linutronix.de>
References: <cover.1729865485.git.namcao@linutronix.de>
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

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Jason Gunthorpe <jgg@ziepe.ca>
---
 drivers/infiniband/hw/hfi1/init.c | 5 ++---
 drivers/infiniband/sw/rdmavt/qp.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/init.c b/drivers/infiniband/hw/hfi1=
/init.c
index cbac4a442d9e..d6fbd9c2b8b4 100644
--- a/drivers/infiniband/hw/hfi1/init.c
+++ b/drivers/infiniband/hw/hfi1/init.c
@@ -635,12 +635,11 @@ void hfi1_init_pportdata(struct pci_dev *pdev, struct=
 hfi1_pportdata *ppd,
 	spin_lock_init(&ppd->cca_timer_lock);
=20
 	for (i =3D 0; i < OPA_MAX_SLS; i++) {
-		hrtimer_init(&ppd->cca_timer[i].hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
 		ppd->cca_timer[i].ppd =3D ppd;
 		ppd->cca_timer[i].sl =3D i;
 		ppd->cca_timer[i].ccti =3D 0;
-		ppd->cca_timer[i].hrtimer.function =3D cca_timer_fn;
+		hrtimer_setup(&ppd->cca_timer[i].hrtimer, cca_timer_fn, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 	}
=20
 	ppd->cc_max_table_entries =3D IB_CC_TABLE_CAP_DEFAULT;
diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdma=
vt/qp.c
index e6203e26cc06..614009fb9632 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1107,9 +1107,8 @@ int rvt_create_qp(struct ib_qp *ibqp, struct ib_qp_in=
it_attr *init_attr,
 		}
 		/* initialize timers needed for rc qp */
 		timer_setup(&qp->s_timer, rvt_rc_timeout, 0);
-		hrtimer_init(&qp->s_rnr_timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_REL);
-		qp->s_rnr_timer.function =3D rvt_rc_rnr_retry;
+		hrtimer_setup(&qp->s_rnr_timer, rvt_rc_rnr_retry, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
=20
 		/*
 		 * Driver needs to set up it's private QP structure and do any
--=20
2.39.5


