Return-Path: <linux-kernel+bounces-384322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1002B9B2926
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9C21F21F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38A91E0B93;
	Mon, 28 Oct 2024 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YJ6pQjkk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Inn5sSdh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952141DF963
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100897; cv=none; b=TK8BQTggajGawOyldHv7mdIx5H8eR8TEK4h1eQNSvfq9vKwQV/cQ54GcC9xSZlcx3b3vvenHgyrN0MqEM4uBgKB9EleiISdQSEtBmhK6bhB/spBEh8CtWIa0Ayi3CHPP3jZkyBr83qWn4C8DBxxZ9Fxu1ZFGQxJihVP0e9YKet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100897; c=relaxed/simple;
	bh=HR7i5HgsvpMEKoCk8cMkJUzpoOTjIdVJsVilamWu4q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ggpOzldJfUnv8TjaCp29rL8JNLusbsQIfFWuwq/GO7jl5gNumCpXFq05DqNruWatoEBWueoCGojXSOCbb/wgiS2Qc2klkSp85ytws4cmQAWNtw61EiOxZbLyq/JnazkHKiZiJpot6YTKv1C3GM93EfGnE9z5c9qUF1ZSnA8ocA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YJ6pQjkk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Inn5sSdh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0YY4YX/eXNm+SsADhJXuP6fTNpj76qLiAdcRLa92EU=;
	b=YJ6pQjkkuFiOxSYYRaG9f98svzwTptkpr/BnIAHPXPfM5Y07DJTfahR8/vT4yoQYvize18
	hZXIFXcCubQuVuTK830Bkdbtbhd6b+Vi6V46G4aoILKcDFj+qVMwJ7NDksIwiScqRJMZro
	D5X3kXhlv+FrHI/nmsTBQIYE5aNo+s/72pR5HIlVDSZjX647SwjchI37jhAc0hPPDVpcBL
	9ensWyblNOlapEVEdLMvmnM4lxcg0YmEYTJRuybEp2vYqbQCgPkbRhXEbotJ0hVUgKh+45
	yZFuWElffaop6Gu+tgBqHXdEw3TWtct7Irw8Cr0uj2SPvssaJV9ik6kaExpi3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y0YY4YX/eXNm+SsADhJXuP6fTNpj76qLiAdcRLa92EU=;
	b=Inn5sSdhIHRBFCZpv3ELJg0AGHM8Fj656N7sHm/u8xXAZw+ho4YBlGQi7SC6+fATezOQyb
	vFKWpgF1uSVIksAA==
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
Subject: [PATCH 23/24] octeontx2-pf: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:36 +0100
Message-Id: <3bf0e5d21365ac965e65374857ff67c465134301.1729865232.git.namcao@linutronix.de>
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
 drivers/net/ethernet/marvell/octeontx2/af/ptp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c b/drivers/net/=
ethernet/marvell/octeontx2/af/ptp.c
index bcc96eed2481..66749b3649c1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/ptp.c
@@ -545,8 +545,7 @@ static int ptp_probe(struct pci_dev *pdev,
 	spin_lock_init(&ptp->ptp_lock);
 	if (cn10k_ptp_errata(ptp)) {
 		ptp->read_ptp_tstmp =3D &read_ptp_tstmp_sec_nsec;
-		hrtimer_init(&ptp->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-		ptp->hrtimer.function =3D ptp_reset_thresh;
+		hrtimer_setup(&ptp->hrtimer, ptp_reset_thresh, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL);
 	} else {
 		ptp->read_ptp_tstmp =3D &read_ptp_tstmp_nsec;
 	}
--=20
2.39.5


