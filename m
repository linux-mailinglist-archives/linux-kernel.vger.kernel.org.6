Return-Path: <linux-kernel+bounces-384317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E704B9B2921
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB415282603
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1716E1DFE06;
	Mon, 28 Oct 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O/CZaGLC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4CQnBKyO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C21DD554
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100896; cv=none; b=OmUpxlc/Yvxpd0H5gdYbbvZToZC+sg3ekbeHmVsgDDAyLcXNcinwbnHMmixjMGC24S+h8FCctImf8CAsaBsoQCQN/LlLzM9gBtD3F2koCRbQitNylmyXNMQe6z14BKq07ZYsXOYMloKuovArBQvdJxGQ5F62Oc6V9vIdaGquWO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100896; c=relaxed/simple;
	bh=q85l8Rn54jUqp09xOP9w1ZewUSf4Q6vKvgjhh7tfDi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j9r6dSfc2yr+52d04JlJ74DdhcVnSG9RsY1P2k0YED6Fn/qLCkV8da3Il1F08B8vQUFKTKt5gtL1Knb5JKvL+Sik88q/9WfvlSx0tRwuN5Q0cbrnAHXzRe3KTTSFMeoZrffPcvbxpEFmzFmyouDXzHDqRZCqAzw6FNm3ldGNedE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O/CZaGLC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4CQnBKyO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyzJyFR/q82cIdy9DlEUJKpApgLq4Sn0n6FEbCe/fz0=;
	b=O/CZaGLCYsdv/6x//9IkN3MDOvHsHZ5JmWsDeKt/wcf0w3bzinY35edPkW0wYdok7S8apW
	0O0M2eEbx+lafLwyHj0jS61a5kwDyNtKq7tV5gKPZNAoswCy9NEtvdM5l+JgdpyzcgwGD5
	jE7mWoYr70nbQBCUPkbTB9PNL9Aoelfpq4Hdc8cMYX5MeaifhqzbIBabUP7+9BD5x70QXU
	OFjg5E47U10ny5t6HEN0Rf7RGzYWdK7XEl9+vRbyeSOhHZ24XvbB8ITwx3iN+Ml+xhuAjF
	LXpuQ0CPRCKXK+NVWot5oaPv3myfDpmAcpjagr0pwJaCpF6wgYplEkCJv4Xj0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyzJyFR/q82cIdy9DlEUJKpApgLq4Sn0n6FEbCe/fz0=;
	b=4CQnBKyOIkW/P5tkSUh6OLMxChh4drX2hePBe/e4D8l5Xd4xEneCihIHtvX2s2i8Y/7sHu
	wPOqCdCE/h/iDaDQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Oliver Neukum <oliver@neukum.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 19/24] net/cdc_ncm: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:32 +0100
Message-Id: <f2a07b8c0a24dc4526658ab5bb91fda0f4f0bcd2.1729865232.git.namcao@linutronix.de>
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
Cc: Oliver Neukum <oliver@neukum.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/usb/cdc_ncm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index d5c47a2a62dc..34e82f1e37d9 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -833,8 +833,7 @@ int cdc_ncm_bind_common(struct usbnet *dev, struct usb_=
interface *intf, u8 data_
=20
 	ctx->dev =3D dev;
=20
-	hrtimer_init(&ctx->tx_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	ctx->tx_timer.function =3D &cdc_ncm_tx_timer_cb;
+	hrtimer_setup(&ctx->tx_timer, &cdc_ncm_tx_timer_cb, CLOCK_MONOTONIC, HRTI=
MER_MODE_REL);
 	tasklet_setup(&ctx->bh, cdc_ncm_txpath_bh);
 	atomic_set(&ctx->stop, 0);
 	spin_lock_init(&ctx->mtx);
--=20
2.39.5


