Return-Path: <linux-kernel+bounces-384316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3DF9B291F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B8A31F210A6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B461D7E3D;
	Mon, 28 Oct 2024 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d6Clmt90";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WKiJKrfq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CAB1DA634
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100896; cv=none; b=sN6tBQV6fLKCU10A29jIZgONNYpMGJCa/6iJV7+SvUKXe28XjO944KCarsLq9sYKN6eDTTztpE1FIceLRuOqsmfafpQg5pcAPjK20Aaww6I6CjlvrZ/Sw+XIxSdVQKKmTUaV0EdhTgGPDpK3ferLGr+dskwbKrMC51IYQ5omivM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100896; c=relaxed/simple;
	bh=IIbEppl4dS+chwmBL45RLcZjLxLuKIjbYMvPgSIRg+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C0qgRzKQJMS+xbFj0Utaq8FRlKbsfAn725IZz5VdKRKj/4gYb3Un7IhSwtiV7zzCUKUlRe5qFiqfPhWtl361f1go/ta+0G/BatbYH7dXCqZ3iIJB/GhsRrCeOywk/qHRf6wk+WnOd2QOGsxvkQyQtp4hx40uPppZiLpRp1SXqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d6Clmt90; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WKiJKrfq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJdI/mozZHXhIuU2am3kttDkMcd+QLHW2Wp2sHPuTUc=;
	b=d6Clmt90z4tM0ANE9itUdXnm1TKSEoiFc/5LwsB1i0dBsTb1hnTCuK3GdnRTQDO5s/DBd4
	SkbX6F52AYVOzdC3CyH+fwKvcSXpy1Fl3z1YaI+SvA7LxyiNjiFTjmYmLESs8Quv1MLTv/
	Z0wue0GsWc1afyS0lyF3M/XZgz8BaT1gewDrKesRFlFMSdjsPufDyt9qD933jj8xAkUM8I
	v6DmOP9BPYUGj/Mo2fBd7/ulwkxFPoFy1CTS4p7eIDs3QWD+jT1tGz4r+9CgYgTH8vQVNJ
	wLv2KlDWVSW0Ks0NOGQkCLYqbe1dgFvT1ti+GOXqhekNxjNgz1XeCkgN5YkzjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJdI/mozZHXhIuU2am3kttDkMcd+QLHW2Wp2sHPuTUc=;
	b=WKiJKrfqIRrEvd3kHACthQ4R1va8cfjJgpe3wZifAat/SnrDNO35tZFW5R4lvJnb6tO1Kg
	xEKi6yrblff+c2DA==
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
Subject: [PATCH 18/24] net: wwan: iosm: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:31 +0100
Message-Id: <5b39405467f80bb8e4c83108df12cd2f4a0193e6.1729865232.git.namcao@linutronix.de>
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
 drivers/net/wwan/iosm/iosm_ipc_imem.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_imem.c b/drivers/net/wwan/iosm/=
iosm_ipc_imem.c
index 829515a601b3..530a3ea47a1a 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_imem.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_imem.c
@@ -1381,24 +1381,20 @@ struct iosm_imem *ipc_imem_init(struct iosm_pcie *p=
cie, unsigned int device_id,
 	/* The phase is set to power off. */
 	ipc_imem->phase =3D IPC_P_OFF;
=20
-	hrtimer_init(&ipc_imem->startup_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->startup_timer.function =3D ipc_imem_startup_timer_cb;
+	hrtimer_setup(&ipc_imem->startup_timer, ipc_imem_startup_timer_cb, CLOCK_=
MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&ipc_imem->tdupdate_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->tdupdate_timer.function =3D ipc_imem_td_update_timer_cb;
+	hrtimer_setup(&ipc_imem->tdupdate_timer, ipc_imem_td_update_timer_cb, CLO=
CK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&ipc_imem->fast_update_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->fast_update_timer.function =3D ipc_imem_fast_update_timer_cb;
+	hrtimer_setup(&ipc_imem->fast_update_timer, ipc_imem_fast_update_timer_cb=
, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&ipc_imem->td_alloc_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	ipc_imem->td_alloc_timer.function =3D ipc_imem_td_alloc_timer_cb;
+	hrtimer_setup(&ipc_imem->td_alloc_timer, ipc_imem_td_alloc_timer_cb, CLOC=
K_MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
-	hrtimer_init(&ipc_imem->adb_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ipc_imem->adb_timer.function =3D ipc_imem_adb_timer_cb;
+	hrtimer_setup(&ipc_imem->adb_timer, ipc_imem_adb_timer_cb, CLOCK_MONOTONI=
C,
+		      HRTIMER_MODE_REL);
=20
 	if (ipc_imem_config(ipc_imem)) {
 		dev_err(ipc_imem->dev, "failed to initialize the imem");
--=20
2.39.5


