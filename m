Return-Path: <linux-kernel+bounces-384333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C0B9B2930
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD3CB1F22155
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B979E1EF951;
	Mon, 28 Oct 2024 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TaLELn9Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZPNg+VL4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6F1D90B9
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100939; cv=none; b=CYeD3xJeN8/DXBjLCexTnF/0nEVVfA3ZGIalaOYuTk+JDekkQBpH2nZbChjri8XARbTyI7Prh1GCzodA7O2xWgXlne7iiMyR4Rbu5KnLq3pQmzN1YDfDrJnOvyFLH7v2OrUIlDTk6QA/1rPPE+LG5Qs1uHvHtMflgIIqiUr3HRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100939; c=relaxed/simple;
	bh=3PYaFV7Oys5DkACuILmY2qDle/vQ2K7t6BDA9FRSnXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jGtocnFugNA8iic9nqpnRORrrrscRLIeXOiHvmwOlstskG7Vz1AnQ7wzedFqXNrYjIgqDsuVGwT22zXJ1/ka7Vvu4XQDneopY0sP111rh4nr9CDxqiTN+6P8Lm4iEzFfoNOhSopGn/SOvQ6+qqU5TTuCvEmBeQrmb7mfCloEPOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TaLELn9Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZPNg+VL4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnhs7Q2K97xaJ0+aOCp8WgzteNZ8vBXPvoSOZogCkNI=;
	b=TaLELn9QTSDqXy0665N+aBbrs3u4Tk7e3c9mJ5+lOdiEIWa2EFAmHLy9TiO4j+ZfdUqadC
	CX8Zb5DVZAuZWNoQBu6dDuPMX2UisFBxKr1HA6pv5Veet9s3Jn+gaUlubTu/Zs1niW4vAN
	fT3Q6ouUhQ6I/KDuGiwe9+mHOtkvJstC25seQh3Yn0uGbEx/h7OF7By72YpLOQGPAwWjLB
	t+wwlHxrc1MdKOmId4+k+XObyaDOD3uWA//15Pqwhr6O7D30fOoP9XqFAtcKVln0HiicKy
	OE5ETcoWrrstDmgZzWXcWkUbtip5Hf1PrGgALLIpkiX3rRuO/0gJ0BkhRZGL7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wnhs7Q2K97xaJ0+aOCp8WgzteNZ8vBXPvoSOZogCkNI=;
	b=ZPNg+VL4qTSDxqHAdXffEjzy+DosUOMxp2489cRoPjI0lEWhxaeFCwBTFGQ0+tdKdt+fJY
	wQUhRmWOsiK4sODA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 09/44] serial: imx: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:45 +0100
Message-Id: <6d72f1abc0f151345934fa7963326dfd74b66ee8.1729865485.git.namcao@linutronix.de>
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

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/imx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 67d4a72eda77..753325b6d125 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2475,10 +2475,10 @@ static int imx_uart_probe(struct platform_device *p=
dev)
 		imx_uart_writel(sport, ucr3, UCR3);
 	}
=20
-	hrtimer_init(&sport->trigger_start_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	hrtimer_init(&sport->trigger_stop_tx, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	sport->trigger_start_tx.function =3D imx_trigger_start_tx;
-	sport->trigger_stop_tx.function =3D imx_trigger_stop_tx;
+	hrtimer_setup(&sport->trigger_start_tx, imx_trigger_start_tx, CLOCK_MONOT=
ONIC,
+		      HRTIMER_MODE_REL);
+	hrtimer_setup(&sport->trigger_stop_tx, imx_trigger_stop_tx, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_REL);
=20
 	/*
 	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later
--=20
2.39.5


