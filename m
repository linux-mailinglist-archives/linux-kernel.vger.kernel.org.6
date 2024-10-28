Return-Path: <linux-kernel+bounces-384315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0439B291E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D877F1F21889
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E781DFDAD;
	Mon, 28 Oct 2024 07:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AOdFjRQ2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zoQNfhFd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BA1DA100
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100895; cv=none; b=pJVkJFJ2d0gzmhgKilCCuqVb22omjo5lJPasuHilsPRiW/2BtWBu2Z2Q09uAwP/xLcjyZqB3yAXuFHQGzMzyE0E0DiqE/B98hd8p+5yJaDhTfZLxZK9woG7Ki3KxiOoYbRBUakpVEd14mS+K9POyN6fRXGfPqSlxQRvPFTJy83c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100895; c=relaxed/simple;
	bh=k/+b4xdBHMNKHASg6Y/MWnH1t51sY5i1B8fzAQunBmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IIgu2lCj6IAyIZTaB/AL98qbXAMTpD+RASwYBbIzMsDgH/BjocJkcCPReTvAXPPP80bVqk2LWh6KQk9GxQ920ae3KkLJvEa56tgC464IKQ7TawuPV1fk2ZbzU5wfOcQ14LzZu4qB/35IrYCTekroy2YatIsNNtbVKfAlCt3+SrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AOdFjRQ2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zoQNfhFd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEebMZUUnqm+N8fGkKxXOzNj0uVNdxtaDjuByeScOX4=;
	b=AOdFjRQ28euIuq0TlSX9keU44VNLscPykpJK96gV+ZLsj+RjPVjWcfUMK3yhBgjqMS4eVP
	t2hORDH1ufRU1CocAQLWUgeD+LDuNgBzXRuvyUBXHsWCccFz9XK10+3h+GyQGalljRBTzG
	V07DXRkbmv5gODbcX9n0rIRWyJ/zHfxWXazSg/l1PsRvkIcKjePsWxuC75K60porq0H5ZF
	dS0lhAXzaina0dG6ujIgnwgxwRa6Gng/n+uEp4nnaHT6AOBrSZ6+J3H9SiqcqwSeq1z3iz
	ESlbQdK9E3yDJVaqbgPVV7hbBEGL+D3DCGPnAJwCsrjLVbeNmX00Y7jtSx8quQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LEebMZUUnqm+N8fGkKxXOzNj0uVNdxtaDjuByeScOX4=;
	b=zoQNfhFdJw9EoV72XsztryK6VBW46DS/D5MV9Mi2JpKTH2EVEAE+70Rl6GMmOa046xyX06
	L6TJASV4J/P0ZDCA==
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
Subject: [PATCH 17/24] net: fec: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:30 +0100
Message-Id: <37f6a100ed534ed45cc818ea106f3d8e15afbed6.1729865232.git.namcao@linutronix.de>
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
 drivers/net/ethernet/freescale/fec_ptp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_ptp.c b/drivers/net/etherne=
t/freescale/fec_ptp.c
index 4cffda363a14..b357967d56b6 100644
--- a/drivers/net/ethernet/freescale/fec_ptp.c
+++ b/drivers/net/ethernet/freescale/fec_ptp.c
@@ -738,8 +738,8 @@ void fec_ptp_init(struct platform_device *pdev, int irq=
_idx)
=20
 	INIT_DELAYED_WORK(&fep->time_keep, fec_time_keep);
=20
-	hrtimer_init(&fep->perout_timer, CLOCK_REALTIME, HRTIMER_MODE_REL);
-	fep->perout_timer.function =3D fec_ptp_pps_perout_handler;
+	hrtimer_setup(&fep->perout_timer, fec_ptp_pps_perout_handler, CLOCK_REALT=
IME,
+		      HRTIMER_MODE_REL);
=20
 	irq =3D platform_get_irq_byname_optional(pdev, "pps");
 	if (irq < 0)
--=20
2.39.5


