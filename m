Return-Path: <linux-kernel+bounces-384293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 429859B28F2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1C61F2153D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F001DE2B7;
	Mon, 28 Oct 2024 07:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VOeYa4eD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ke7cMsdc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4296A1DC06B
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100750; cv=none; b=LWhavOPsqe88FkrcrHFE6G+uvXRU6SYnyXIAr1Vm36z9zBIh+rzsAg1dYyc3fxoXfPoGHsR01Xzlh1cZaeslaNMS0cpi23LASd8SK7Bd+NT/7fOzc/kpDsFNc9/3XrVEbTIdTKlE99PkI3LYUTvzr81GfaC2jqlXZEASJuf/5pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100750; c=relaxed/simple;
	bh=KoGLP37VkEAx/sVraIGehUOfzr3ni3j2DVH+RYsW3sM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=er/jxVBZR6hLMHzJTxpaYus+6RqdI5jY3xiQVgR2LzFJXZ/2IuXszhdxYGJ0mC+j8BGrjkBxjZGuG44vrWkbEUlyJNpgGlPXBYD0m/lHxW9UrlcUlbF240IkPcLlIx0b7++Dz0EfAqGbIvhplcy1pcu2tClk0gUdWdSihxUWXfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VOeYa4eD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ke7cMsdc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDAYiTMT42emkjEGqfni6QzESyG5h52ZcdrArqG2woA=;
	b=VOeYa4eDEflRJrojN7JtxaNi0r/Ppgv8p3BkDUG8fcA/wzEbBNODfVgBONJR+yoSsLnMe4
	3Oko6BtaVr104W3tisdLXzNM4H5xIXE02Wqw4EesUIFLrSl++Fuw1LVOBffkyrG3gXML7C
	2kvbIxd8DGqUBe7klPxBhPrcSMZKngHcDBv+eYACAhUi92+cWe2VIYKA4Wqy+SG0q0EMsp
	op7T1IotordCAaNQmQtG1HL0ORRq/VqUei7g5By6k/ILIqlEQMriRsX9hQ+wFhMx9F1mGQ
	rO8dYO6oDXEHD9WlvV98QgIAcanQzhOnY2ymgj206y8N0w84oUGBUE8VuSOeQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lDAYiTMT42emkjEGqfni6QzESyG5h52ZcdrArqG2woA=;
	b=ke7cMsdck7dx6xO7ImdiESo5ugFk76xDHpFkhqIBV0LbKhNj7SoNu9+Y6Kri69M9Kp+taB
	+zECrW0FkMMW2EDw==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 28/31] PM: runtime: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:32:01 +0100
Message-Id: <d4c90402b2e9a5b60b0c836e4aeb9329436f80ba.1729864823.git.namcao@linutronix.de>
In-Reply-To: <cover.1729864823.git.namcao@linutronix.de>
References: <cover.1729864823.git.namcao@linutronix.de>
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 2ee45841486b..425c43b2d478 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1764,8 +1764,8 @@ void pm_runtime_init(struct device *dev)
 	INIT_WORK(&dev->power.work, pm_runtime_work);
=20
 	dev->power.timer_expires =3D 0;
-	hrtimer_init(&dev->power.suspend_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS=
);
-	dev->power.suspend_timer.function =3D pm_suspend_timer_fn;
+	hrtimer_setup(&dev->power.suspend_timer, pm_suspend_timer_fn, CLOCK_MONOT=
ONIC,
+		      HRTIMER_MODE_ABS);
=20
 	init_waitqueue_head(&dev->power.wait_queue);
 }
--=20
2.39.5


