Return-Path: <linux-kernel+bounces-384352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A43FD9B2945
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B131F22360
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B42520125C;
	Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QDvG0fS/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zN03OVNF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7601D9592
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100947; cv=none; b=jPUTm0rGwe6Y3oJ58+AeMs9m4Fx0Nolk8B8CCviBlZunf2bcxaseRI0IJXYp2zhg/yFIDqPVZztpgbDbMRaZBcdpFL0H+OW/PAVGSOMBWQM3KNpKeLwfdB+4N+EyhJz7ItZnR1JbpjpQJ3czCOb589EmSWS98BaCwFRQXEAZgBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100947; c=relaxed/simple;
	bh=uo0UBotNAOOrFI7BXUpj6mVFpoIhs6Iz9NQiYAbjsMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J1a4Ex8FNd9cfsqx1DV84w/FtWjLe1L/8vGQaicEGn66+F016Fc7v4JakhWyAy/SbpEQHy+evM3HJKhE/zmqVxJ/3iouTJhbh1NtEEG4MqmEwbqeEMxxWZb0bCHCflWGmgeN+bujjrRBxJ7KkbJ3LJ6Bs1xRkYik2/WwePAlmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QDvG0fS/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zN03OVNF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXo8Vnu1FJr88iLh2NTVp3EoV5Lz8sXeO0n/sEXre9E=;
	b=QDvG0fS/ywXuRSSpcdPrkBjk/CzZXC4F2VrV76z6Mqvd18HnXtfNVjzVYU73L3LTLTm+Eu
	Yo3gxw7YC35hvJziJR8gONiM38MV0k/Xe5oweIOGEFEQk//OG06lTBI+N7Q97w+A/Hwy+y
	Iuy1G9fN0opygRfZzJ1WuphNsWI1w/8GzosUTex9O81ZxfKAk2KN+3x4lWw0RMCclbrzyI
	U4su64cWvueY5WsXKpuLNr9Mh1asQQG8P7okP5TNNkLPJRBs6nI4Gc/UNJkyjO6w3gMCvr
	kw0yywtRWZhihN4EzWucs22X5/AbrGd96v16fr2/KuVMdkZq0EQSlEVpIHb+vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bXo8Vnu1FJr88iLh2NTVp3EoV5Lz8sXeO0n/sEXre9E=;
	b=zN03OVNFugHZ4hmlVnnrpsG3i2yBln2HcR+god28USo+Epo5f7VtwOK3S+X7DwpMFBJbRc
	LBhc6UYMQW4ZfqDw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 27/44] i2c: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:03 +0100
Message-Id: <89bade198d679a579a929add8aed1f5431aa03c5.1729865485.git.namcao@linutronix.de>
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
Cc: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/busses/i2c-imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 98539313cbc9..47f3ea4dc79d 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1417,8 +1417,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 		return -ENOMEM;
=20
 	spin_lock_init(&i2c_imx->slave_lock);
-	hrtimer_init(&i2c_imx->slave_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	i2c_imx->slave_timer.function =3D i2c_imx_slave_timeout;
+	hrtimer_setup(&i2c_imx->slave_timer, i2c_imx_slave_timeout, CLOCK_MONOTON=
IC,
+		      HRTIMER_MODE_ABS);
=20
 	match =3D device_get_match_data(&pdev->dev);
 	if (match)
--=20
2.39.5


