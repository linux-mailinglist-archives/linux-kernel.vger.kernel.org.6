Return-Path: <linux-kernel+bounces-384328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A72119B292D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520D71F22044
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8C91D9339;
	Mon, 28 Oct 2024 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HiseFaS3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v5xINcpF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5D6191F91
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100937; cv=none; b=HbHM8W5epLXkrKmIydM2MFVfOAQXbJQCG25jVvTUoSiyI6tgXgQjioRiimEkXTmY2ofsGTwloIBYsXIwCPY93fXKlZrCT+RP6e+NuzfkQbJH9LFV0RSAPxv6JTGWA5sE3llsF9kSxAkKmqHAROG5IHEjgCbjkH8MqbYPYuZUNao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100937; c=relaxed/simple;
	bh=8s7L7Isjf0Nni/eQWdz4bolhPH6n6k+huVPS9Ks+Udk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yl/pDGg1DdJAaYYy/uJ2VLek9L8zqrlYVLyNvJZq+HAmqDbrsTQKd9xycIyRnP83IefTjx6ehbfJdwg4Hz7nsWFApLJjdoASnBzWedcWUXT/E9GrPH3UsRYsRbrfUtMmsYiAewd9fXIQqWICiAWXyzamU1LoaQkg0wU3rmomGc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HiseFaS3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v5xINcpF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iyVcUFP8Pc3i+Zxw4z9mRyRMZ1P4oTGU6J20Xh+9GY=;
	b=HiseFaS3Sw55YFJV3yfHqPxe2dY9i8IrBIbZh02LiZVNg8XkVmA3K+TZFnH3vDipE7qget
	s2VGNaZUvZ9YpwZjS6to3xBt1t4F9ue0+mkvSEpOkWUnWs3vNk62sMepQ5RtcsPelQknf5
	xB0O0Lk7kBXn8sL5nZGJ0A7yb3bzF+EUooffGdWyqaTdlaHCRTPv9JrLsZFiziJglfle8j
	GmERB9hVOqVYd9b3YuSY1W80fbZYIAQgce28h0QH15/NWiX/cGdTW9f2WHFMWUDspayCBO
	HIsl2X4ckhbE3ew9eF67vPPkRnejKM3Eei8TWb3owNh+lUw+hsOLfhr9yQo3zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100933;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5iyVcUFP8Pc3i+Zxw4z9mRyRMZ1P4oTGU6J20Xh+9GY=;
	b=v5xINcpF2i4S5gvwsDX2GX7b0zb550g1lrlJAL7p//twUK3Sl47lu+Ap5MHDThHiMrV2J9
	B8rx1M2ktrqGwCBg==
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
Subject: [PATCH 04/44] usb: gadget: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:40 +0100
Message-Id: <1f79c2d68dc641329cbbe358a2cba79d2335d8aa.1729865485.git.namcao@linutronix.de>
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
 drivers/usb/gadget/function/f_ncm.c | 3 +--
 drivers/usb/gadget/udc/dummy_hcd.c  | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/funct=
ion/f_ncm.c
index 8e761249d672..dcdb6246e542 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1558,8 +1558,7 @@ static int ncm_bind(struct usb_configuration *c, stru=
ct usb_function *f)
 	ncm->port.open =3D ncm_open;
 	ncm->port.close =3D ncm_close;
=20
-	hrtimer_init(&ncm->task_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	ncm->task_timer.function =3D ncm_tx_timeout;
+	hrtimer_setup(&ncm->task_timer, ncm_tx_timeout, CLOCK_MONOTONIC, HRTIMER_=
MODE_REL_SOFT);
=20
 	DBG(cdev, "CDC Network: IN/%s OUT/%s NOTIFY/%s\n",
 			ncm->port.in_ep->name, ncm->port.out_ep->name,
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/du=
mmy_hcd.c
index ff7bee78bcc4..bae07e87f37f 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2469,8 +2469,7 @@ static DEVICE_ATTR_RO(urbs);
=20
 static int dummy_start_ss(struct dummy_hcd *dum_hcd)
 {
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	dum_hcd->timer.function =3D dummy_timer;
+	hrtimer_setup(&dum_hcd->timer, dummy_timer, CLOCK_MONOTONIC, HRTIMER_MODE=
_REL_SOFT);
 	dum_hcd->rh_state =3D DUMMY_RH_RUNNING;
 	dum_hcd->stream_en_ep =3D 0;
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
@@ -2499,8 +2498,7 @@ static int dummy_start(struct usb_hcd *hcd)
 		return dummy_start_ss(dum_hcd);
=20
 	spin_lock_init(&dum_hcd->dum->lock);
-	hrtimer_init(&dum_hcd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_SOFT);
-	dum_hcd->timer.function =3D dummy_timer;
+	hrtimer_setup(&dum_hcd->timer, dummy_timer, CLOCK_MONOTONIC, HRTIMER_MODE=
_REL_SOFT);
 	dum_hcd->rh_state =3D DUMMY_RH_RUNNING;
=20
 	INIT_LIST_HEAD(&dum_hcd->urbp_list);
--=20
2.39.5


