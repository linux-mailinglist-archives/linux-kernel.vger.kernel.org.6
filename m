Return-Path: <linux-kernel+bounces-384327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5189B292C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55862826E2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B821D8A14;
	Mon, 28 Oct 2024 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IqUXv5Eb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lamGsNvW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A81B373B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100936; cv=none; b=dPYDRIqFNNTJQMNdp/gOyBaug7cEwE2kXB9eqH9d+RMhRvGzZiTRcLF7Beo0hrlYliwMGYyHSc9gON+4yYBgUTI5/M8R7D8U3ExVNVL3sWAZsqUGRmAkJPUEClZfc6Nx+Lsmz5l3uEFvb0vgk2AhLpCcXbhYTvEaX3Qp/xB0dR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100936; c=relaxed/simple;
	bh=EcIiVlXPxxmQNU0CXiQ79sLsnNyDCoucXBgFJQ3CdyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+VR/5HpZtkw0evHDxtJWlcAIOSR+mHg/X4wXTyEcXs2R+1NjIUJUQiDDYVL/jLNXrMS7WEXY17vcge7t1fq39OGV969CrZKdB4P71K9n0gXsQJqjI3T//GqAiGFTK3SjdRDCTiBVqlTb/h0m19xOWa4waQUQh9dZgHP0SJKDAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IqUXv5Eb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lamGsNvW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsQmLX6ZSibcBD7WZZrpoU2ZdQz66xx3VcZH5kz/i1M=;
	b=IqUXv5Ebknx4XbJN2MwH3VS6sdpJ4YCk0fgzvk3H5zqiWQpqJjqu0IoL4uMLD/zEEmD8O0
	4MowYD7qNI5uVvojCwKomreSo2PBS8e7rZBf79TH4P6a/KRvxncog/ATuDfUSOCyF6zSh0
	nsCumojJImENRnrniGOOmGTmmDS5t8mkM8oTgO4ei/Qb57G2fgtOXDSWnzhZq1fL21NHuz
	hs00zbnTM4UWZjtaog1WnnCUvSqkh/EnZk4iQJuO3VNBxTsC+XAxwRdNyWVesrQGrAwNQf
	wAGqQq71TyaGizvdsYaobzEzKXS97FQUz5gHEr01ftiQK1qTShum1iy0qmSa3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VsQmLX6ZSibcBD7WZZrpoU2ZdQz66xx3VcZH5kz/i1M=;
	b=lamGsNvWfH/46gy+dI72D8CUD73EQunOmhHqAhsxGZO77prZvTg01LRuCVCwDoCF+Fl4mZ
	dm4H+SU7oosMoMCw==
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
Subject: [PATCH 03/44] usb: fotg210-hcd: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:39 +0100
Message-Id: <35d03799c19982aa2f8adb0af3d2fc67c60ae61a.1729865485.git.namcao@linutronix.de>
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
 drivers/usb/fotg210/fotg210-hcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-hcd.c b/drivers/usb/fotg210/fotg21=
0-hcd.c
index 8c5aaf860635..36d4d5ab7a89 100644
--- a/drivers/usb/fotg210/fotg210-hcd.c
+++ b/drivers/usb/fotg210/fotg210-hcd.c
@@ -4901,8 +4901,7 @@ static int hcd_fotg210_init(struct usb_hcd *hcd)
 	 */
 	fotg210->need_io_watchdog =3D 1;
=20
-	hrtimer_init(&fotg210->hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	fotg210->hrtimer.function =3D fotg210_hrtimer_func;
+	hrtimer_setup(&fotg210->hrtimer, fotg210_hrtimer_func, CLOCK_MONOTONIC, H=
RTIMER_MODE_ABS);
 	fotg210->next_hrtimer_event =3D FOTG210_HRTIMER_NO_EVENT;
=20
 	hcc_params =3D fotg210_readl(fotg210, &fotg210->caps->hcc_params);
--=20
2.39.5


