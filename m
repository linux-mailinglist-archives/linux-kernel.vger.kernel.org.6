Return-Path: <linux-kernel+bounces-384354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE009B2947
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879461F223B8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30CB2022C8;
	Mon, 28 Oct 2024 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2BlLuMWs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pOXFDH9m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C331FF5EE
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100947; cv=none; b=L46QI4kEOgBJk1Y01bOvaIWc9KgJ7tvFgbmUpH1idnuw7iCjs1gfH+Tq7eEKq4wJHJ3eWDWCabIkGAoK0Ga43CJhVXkhVgyIjKuoQ0Qqq6mJcZvMwa19IbRlA8ME5vAez5jIc4wBPPyz0bMwhCC0Dz41FUS2WQcsfF1VO3J/7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100947; c=relaxed/simple;
	bh=NK+oDY6MZkIBi20Thz8oDGFhAMJ0KNb+mrKMcXJWunI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V3WLnXa62cW44bNAQic1urNu54qaHx9cxZ8y9nRUDtkb0OzWtIbDVXmXRr32fEw6WgsvgZYKNZGGdnG1ex7Ke07wLc7q3YQvbBxIo93tCnMX7+/RY0X1Tx3igiO+v1T3WVxbepSAAjo5tJS8TSX45krQQ4/YOlPbhACpNLbzT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2BlLuMWs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pOXFDH9m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12+NsosUTlLwSgzZpkxNdegUdpKN5EkTxqaOkWrT2+E=;
	b=2BlLuMWsXNf0vNQlh85Y2zTSjprmcMfYvUm4pMu03hj2yHGTOip80Gi3OXAokcE45R/Zka
	bRESMFQPCzw1OSbHF0yhLX4esIt2bU8wjsZ1Q078UtBvWMIn9fIKj/eyhOZz5iK8VRznmK
	rw63fqtgmLz1TID+y2ae9nq2zul1Np1SwpX+E/MXJD/su7nQt/zEne09mWg3mwErjbzcbz
	6z/hib+Q6IVGfVOXBK6PI9sxynmweeHFuycgupJZJwKheAJmxADIYHfYNARxzDG8JdMCq5
	U+Ks9npfPyo7/sIJMY0DIoefTyT47ZqtfJ+YoMW+Rz+EKeyioWBClwaJp0fV4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=12+NsosUTlLwSgzZpkxNdegUdpKN5EkTxqaOkWrT2+E=;
	b=pOXFDH9mgiRZHL8sGz1AaiS2YnOxqGAEyMxusodarJjhonuP7IV4UTxEkCs5vOWWqtwHjp
	9ONIOUgFokwF5CAQ==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 28/44] stm class: heartbeat: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:35:04 +0100
Message-Id: <377d15868b1a4da1d524ab7989b78f2fa13a754c.1729865485.git.namcao@linutronix.de>
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
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 drivers/hwtracing/stm/heartbeat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/stm/heartbeat.c b/drivers/hwtracing/stm/hear=
tbeat.c
index e9496fe97baa..495eb1dc8ac5 100644
--- a/drivers/hwtracing/stm/heartbeat.c
+++ b/drivers/hwtracing/stm/heartbeat.c
@@ -81,10 +81,8 @@ static int stm_heartbeat_init(void)
 		stm_heartbeat[i].data.type	=3D STM_USER;
 		stm_heartbeat[i].data.link	=3D stm_heartbeat_link;
 		stm_heartbeat[i].data.unlink	=3D stm_heartbeat_unlink;
-		hrtimer_init(&stm_heartbeat[i].hrtimer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_ABS);
-		stm_heartbeat[i].hrtimer.function =3D
-			stm_heartbeat_hrtimer_handler;
+		hrtimer_setup(&stm_heartbeat[i].hrtimer, stm_heartbeat_hrtimer_handler,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS);
=20
 		ret =3D stm_source_register_device(NULL, &stm_heartbeat[i].data);
 		if (ret)
--=20
2.39.5


