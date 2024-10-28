Return-Path: <linux-kernel+bounces-384325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCCF9B292A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36731C2165D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3501D86ED;
	Mon, 28 Oct 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tZNIir/Z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EU0u3k5Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A671D7E43
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100935; cv=none; b=esKRU5Wvms7dyPIqV/EQHS7E0j4por/kkubeAwadCrHVweIyRxUEhCa5RPmCaYdtUTce0x3Ic9Nk+tHeq8pebKPm0B6R6ucAu61YH36GYWn4KF+p/U2LsSIIJ+LOLYoFMwDWO/eLUGf2Ts2LBA0+imzVhfwKzu9Weq//lV1Fseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100935; c=relaxed/simple;
	bh=/1mNpvW/TLJL1FvZBhareeX8SSNZHPRaTR5QSYG2ITc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iINO6XoE2OAWtMnKXbcj9JTR0k8C+Iug2GFpbrTsdBVmHeTuElXgNxLWfa9AqaLk8OJnTxj9eJ02fZSfVVO68aWAf/qzeDLvWRwtQyQTklWgi5YgiU9ZRahrUhKV2NPLN16weVhLpH8DRrHAKBAP3cQ0WsOeTprJSoxX8z/GlP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tZNIir/Z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EU0u3k5Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lbh3IVRyBqUV2FCpCmbEWh0nPes2Vx796VP9y2euSzU=;
	b=tZNIir/ZjgKJIcMUAApovbYmkhJLUIWRVt32nRm/YLIkJ+xK5ZSwIGhuRPNmbD+9xbptVo
	KGFWT8B8I4hWczqslIM7bG2g8yM06V9jmiXPc4EhmI8+jlT3ZQ+1CnmYYnGWZ+1Ms5T5L9
	OPp7fiyQhHXbFfANky5S5vUac/WsDdJg+wdgKwmTYDs0H/sX1+ROux6KBxEZ2cd1Ppq3Eu
	ADmDtf3qaQdJqSDRlVFQelXwLxahyB3fUzOZH0v5sSf1eDSOhgeWE19orGcgpqJIbqfRcH
	JkRhLQ8Lir3VNsmWvL1wvPJs5p3gfZfmuHhz38NtD539w+7/mNV8qoURJF6TxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lbh3IVRyBqUV2FCpCmbEWh0nPes2Vx796VP9y2euSzU=;
	b=EU0u3k5Yw9tKDbf61thRsQM1PslLsAnLvoWw3Ts1zB5XUq37uXGSWz28wcNpzKdnJRPTOm
	TK/Gkl4Ig5IHECAw==
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
Subject: [PATCH 02/44] usb: dwc2: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:38 +0100
Message-Id: <bcd709c15797dbf3469657b5cfb71261489c40e0.1729865485.git.namcao@linutronix.de>
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
 drivers/usb/dwc2/hcd_queue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index 238c6fd50e75..2a542a99ec44 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -1459,8 +1459,7 @@ static void dwc2_qh_init(struct dwc2_hsotg *hsotg, st=
ruct dwc2_qh *qh,
 	/* Initialize QH */
 	qh->hsotg =3D hsotg;
 	timer_setup(&qh->unreserve_timer, dwc2_unreserve_timer_fn, 0);
-	hrtimer_init(&qh->wait_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	qh->wait_timer.function =3D &dwc2_wait_timer_fn;
+	hrtimer_setup(&qh->wait_timer, &dwc2_wait_timer_fn, CLOCK_MONOTONIC, HRTI=
MER_MODE_REL);
 	qh->ep_type =3D ep_type;
 	qh->ep_is_in =3D ep_is_in;
=20
--=20
2.39.5


