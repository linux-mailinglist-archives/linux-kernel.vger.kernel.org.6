Return-Path: <linux-kernel+bounces-384324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 794EE9B2929
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308D41F22180
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DCF1D86E6;
	Mon, 28 Oct 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jc6bhKyx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ItcJkDlW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC896192B9D
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100935; cv=none; b=fSOmHbD+NLcduQFeNh4varRHoO3oxQ2q40t7aCclzH1WCTgUkNLPid9z3uGPMVtRCljxOYb/TuY5FjBh13lRDMXo3Mte6yj0G8na1O1pzUwe89wwUmRmcSF/+Duofx9Er6h7UdR6MmeExTRFWzofQKTm7i4gypPxlIGvLEHR7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100935; c=relaxed/simple;
	bh=7qykuoXRggVkPigHGCQrlryYIh72TFBX8g9YgRJtnQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K3Gl/uSIDrIHJxfIKynlpPqmoBSi8Jh4k6JZ0EAXi0Lnb5BOMvbDsulFP7zFJ7R6b6IS+8SUN+CynGYAn9Me1I2PljZ3F3g6uZz0rDBBOyUNm4xbwp2ODuhC3qDsWoXbS9NEM527QEV4kn9C/onuHAaQ+MAek+QgmrFbwZSNWUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jc6bhKyx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ItcJkDlW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ke5qweWt85bUkQA0Wor2RxSG+uxUvQzb1eYc8MKAi+M=;
	b=Jc6bhKyxsMMLohtN7tEtLr1Yu1svsxbHaOWYuxxwYCSls/f1RMCrYTjPVmoNZ1XbGs0z+u
	hYHmSbyEyunpIvjDQpQVxdtU8yI1tbSC9o09sLn57QEyqxfBfNFhYnYDM/MQyBpPYGiY3c
	c6Qb6F/7mfWw/5iEKZSGA9fyrO1pRupRmk0Q47Q2/VOjiyxWnLBYi6lMdLAdFfUAG7EzeM
	QK/GJUs26qMTCqvVgtqnONLXMmiXKZOvWiu5OEwNRmtELUOFbCOG0G5bw+1IsBJuvvz2wp
	n62Chf1rDAD4TtIyq0ddU+gAQtLSTXot7IwJzN1voFiF3DyDeY6bdKrXM0Bxkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ke5qweWt85bUkQA0Wor2RxSG+uxUvQzb1eYc8MKAi+M=;
	b=ItcJkDlWwP4ghoj/RtLiUH1zMSwiUqvsrp+qRujcslTmTRYymp/J13fDXwHNqnefve/dKZ
	kNzTv+Z+etEQmVBA==
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
Subject: [PATCH 01/44] USB: chipidea: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:37 +0100
Message-Id: <4cf9c2d0d93f5bc6ac6c377f92739793adca1f6e.1729865485.git.namcao@linutronix.de>
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
 drivers/usb/chipidea/otg_fsm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/otg_fsm.c b/drivers/usb/chipidea/otg_fsm.c
index c17516c29b63..a093544482d5 100644
--- a/drivers/usb/chipidea/otg_fsm.c
+++ b/drivers/usb/chipidea/otg_fsm.c
@@ -424,8 +424,7 @@ static enum hrtimer_restart ci_otg_hrtimer_func(struct =
hrtimer *t)
 /* Initialize timers */
 static int ci_otg_init_timers(struct ci_hdrc *ci)
 {
-	hrtimer_init(&ci->otg_fsm_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
-	ci->otg_fsm_hrtimer.function =3D ci_otg_hrtimer_func;
+	hrtimer_setup(&ci->otg_fsm_hrtimer, ci_otg_hrtimer_func, CLOCK_MONOTONIC,=
 HRTIMER_MODE_ABS);
=20
 	return 0;
 }
--=20
2.39.5


