Return-Path: <linux-kernel+bounces-384313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE009B291C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCFC3B21A49
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329DE1DF749;
	Mon, 28 Oct 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CxkisvMn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6T4Xk1Cd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9303E1D47B0
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100894; cv=none; b=ChzmDNfhhBf3ZLgzYbamtlEez4a6nwd/saIduYN/YA7YpLGsh33hQIEvqyI2OcLcWg4iRqNlfMWPydFnCb3P7oO+y0rSl0NegKgFUN69oXrnYK/6KXrCOr2DZhLahbKn6XLffJAUhLahH+5Qtx+PoZJLU8bftxLPxRskCWXCVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100894; c=relaxed/simple;
	bh=KwVkpb+23KwsjUwiagKn2SiNjubs/wEBZsrHiNYqphk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B/n1L/LLm7hYndeUotj953T6Bg55HDBlQJcR2prWG2x8d8xTBF7UX8XCXiMio8BCUoBbTrDGtFmeE9Luxwc0NaXVd7lg5FIk34kywP5wTNYWSuzOR5erVOF0+pCFjkNu5JoG/QWtDj9PpIlCOGd36ypDIZiZXF67X+gzEkZoKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CxkisvMn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6T4Xk1Cd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgSbgSUhO2aod2vaYHhL6ohERNVR0p9+JHiiJkBL9Yo=;
	b=CxkisvMnjh99YJ+yJUtuSQzf0fquHjshaczKKF9sKvBSNYWWqVYNkYMRuA1YWc/6dNmZ1s
	B+/v1Cg2d91H7iPbUgQz0kplq4OxdEFz6qNZGVTJ7bpAN04zRmelKgm4mK0XEYgCJLHFDP
	Kvcrai4lFqQvnp3Kgfwd/1VgeLrIksN1igY2LdqzZ9kokBxF4xNcmyE6NHaTPQg3spKp71
	1CzQZ+Imwg28p19vTlFxr3MP0aE7njMFPb2fsA5K5Gv1SrHyOGpAZJwpkwdcu6rUUEe9N5
	joT90wGiXoxQ9Ha5fe/MtbLhErk/Yxk4d18pPhXVJnTJc9iKrFsPUJruFa7u8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GgSbgSUhO2aod2vaYHhL6ohERNVR0p9+JHiiJkBL9Yo=;
	b=6T4Xk1CdPKSv/3MMmsl8bZEuTo2P5S0m+V7cr4Fyy7JG/7mkZrfTfOjqUAGT5Owx5PEDNo
	2srXQxh/Ws/AkPDg==
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
Subject: [PATCH 11/24] net: ethernet: hisilicon: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:24 +0100
Message-Id: <00397b6bec2694d2249e4d39236e1b42e83ab33e.1729865232.git.namcao@linutronix.de>
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
 drivers/net/ethernet/hisilicon/hip04_eth.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ether=
net/hisilicon/hip04_eth.c
index beb815e5289b..bea8b79e69b2 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -934,8 +934,6 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	priv->chan =3D arg.args[1] * RX_DESC_NUM;
 	priv->group =3D arg.args[2];
=20
-	hrtimer_init(&priv->tx_coalesce_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-
 	/* BQL will try to keep the TX queue as short as possible, but it can't
 	 * be faster than tx_coalesce_usecs, so we need a fast timeout here,
 	 * but also long enough to gather up enough frames to ensure we don't
@@ -944,7 +942,7 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	 */
 	priv->tx_coalesce_frames =3D TX_DESC_NUM * 3 / 4;
 	priv->tx_coalesce_usecs =3D 200;
-	priv->tx_coalesce_timer.function =3D tx_done;
+	hrtimer_setup(&priv->tx_coalesce_timer, tx_done, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL);
=20
 	priv->map =3D syscon_node_to_regmap(arg.np);
 	of_node_put(arg.np);
--=20
2.39.5


