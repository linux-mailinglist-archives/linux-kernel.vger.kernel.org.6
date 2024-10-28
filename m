Return-Path: <linux-kernel+bounces-384330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5443F9B292F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 867CA1C21730
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CB01EE024;
	Mon, 28 Oct 2024 07:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4F8nwo/C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8yctEO1C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB301D88DD
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100939; cv=none; b=qgfk/3U1w/l5UkjdKCFfB8+MJZNM8crEfs9GvlgiPwZgFkjsp4/QHnw+aQ9odhnAHBkDeAxKu7keo0hgpl9BvG2RJLKHZ+PHb8zl4YfxqHT7x2ynmt5GXvzIevaevbGxHgm8/rKb+9BFXiLZltkXjZMbAODTovCZ1GiM+TVB8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100939; c=relaxed/simple;
	bh=6tAcVwXV0yfM8sT/Li7mHpI+3tGTUqV6Roxtj3Y4kPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GkB3xmi0jX5OgDImnSOtepQdJxxhxoUMIP3Wa1jInS2Qf3gZdnCam4w6jbBdqrBGA6OKdeR43GZPGHpPiwPTV7HOuCJmN2OjO+JHFeIS1z6EDlbiYQXFVpjFWZP0BWAysaMrmvSkRzdeQEk9njO4OVkRrSibPge8bQpBc/tirX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4F8nwo/C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8yctEO1C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jZWyOgpHOB7XQ7LSkzhpzmsHUeSnxjnVm7YmCze7h4=;
	b=4F8nwo/CfWFNJg3e3aDHdiGxuHxXMw1DtZ8OoFmqJGgT0BQI6UNmhcByfxsylwNkIatXz/
	FQzCGPUbuF2qlDCKDd1Y5cg1yYp6B6iTPQ+kFI1gvouUpqrzEo8HVwoafGqV7JIdV7ubl0
	skbtwZF54UTrPnbwCsprB5U8ZZwur/Nh4YYOq1BChNtTNSt/zzWmtRqu16NbYT7Sgnndkk
	nDQgSqKT0/T+lUt2cirWaUiYeuwVJa0wDyctTRO4LpdXOBVmRywufrPGbasq8VQy2kzp6S
	jpSKHmbQ9oAxj+YABZcE2ynAKw1GUxditMzICMtRJP2VNxuV8gexD++pQNmP2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/jZWyOgpHOB7XQ7LSkzhpzmsHUeSnxjnVm7YmCze7h4=;
	b=8yctEO1Cou4CX3y6t9DbEPj7lbg/lZQqcRo7oCvM9Egw2r+vht1F268+HJHo5GuEciWHs9
	kgFAgygVvNhMAoCQ==
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
Subject: [PATCH 05/44] usb: ehci: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:41 +0100
Message-Id: <b5b58a460c817dcf60fe3e93e16bfa08e79204ff.1729865485.git.namcao@linutronix.de>
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
 drivers/usb/host/ehci-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-hcd.c b/drivers/usb/host/ehci-hcd.c
index 802bfafb1012..127699aa482a 100644
--- a/drivers/usb/host/ehci-hcd.c
+++ b/drivers/usb/host/ehci-hcd.c
@@ -466,8 +466,7 @@ static int ehci_init(struct usb_hcd *hcd)
 	 */
 	ehci->need_io_watchdog =3D 1;
=20
-	hrtimer_init(&ehci->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	ehci->hrtimer.function =3D ehci_hrtimer_func;
+	hrtimer_setup(&ehci->hrtimer, ehci_hrtimer_func, CLOCK_MONOTONIC, HRTIMER=
_MODE_ABS);
 	ehci->next_hrtimer_event =3D EHCI_HRTIMER_NO_EVENT;
=20
 	hcc_params =3D ehci_readl(ehci, &ehci->caps->hcc_params);
--=20
2.39.5


