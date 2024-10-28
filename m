Return-Path: <linux-kernel+bounces-384320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BF79B2924
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06E3928266C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FD41E0488;
	Mon, 28 Oct 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xxg4on47";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cx7rcIzM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E921DF729
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100897; cv=none; b=NPQrbBKN0L5jTrm+UklF0TD9MzIp0JdfBUs8f7JbrkCcKoskaUxIN8RAVKNI7X8ci4IodXaPRZDaK0hzcLmx7q5kFBKqddYlgVp39+8Gg9508G8gLFr+GZXNdJqYVeDN9bDuPuxANdo3huzbggOeYddVjdijzTbx6prw5cQvusQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100897; c=relaxed/simple;
	bh=1a8MV3w+xC5HrzzJFCpxnU/jGz3Zj2tPw2Sc3a7IPIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TzdeSocaklbcLckkJA+j4cM7QDM52yrNtSSmBuNYCivP/fnsZNUn+VGMCVOR7KWfFtPJJ4GJgRbKV6HPBAQ8vhbrIwJ+X+ZGViLsQrBECWgnc3b/7wZXqbcg+Yjpn466B0wy/k4H2yjDsHB7ezJHH2iK1o35Qtf6qsfjWhiAvH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xxg4on47; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cx7rcIzM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxqQCk6RJhkTJsofe3LYEK4ElLPZkvK8TQzsS4QZDX4=;
	b=Xxg4on47coUGZKOwjRJgj7KfLOiOJCR61fm0g8KE5gjkzxPRxkCjpA14nQeM8uGP0TgG4B
	DjKfMyjTZW5GpU8+0cBAEWYkTID+2rSh989PWa5baaMy3O38TjwxrJXGOU3JLjAmZOkZ+r
	1K6IQq7ecBkVgaMRHG5rIZunbIBkxNXa7X5gSf6mgYN0Zuf9kwsfoh+W6njnz3OtKxP77L
	/i8WcQV0WCsOGi/hjSdh0cQN+T7kKti3aXKiZRIhpDgTpadrWqqoQ7SfKFY2gnsxceRzo4
	CajYfkMJNxkV1DL7xHFpHJBy1ERalO1bT9kQe1FyOdadHHflG0GwPmyAcYfAbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XxqQCk6RJhkTJsofe3LYEK4ElLPZkvK8TQzsS4QZDX4=;
	b=Cx7rcIzM4eUjgKvOkRXBACW2+eNh+gPCYHSQf3D1+lo4i0TfxGb8I83M9Z5Io+Wn/9XAPb
	vFTHcQVPLsLjgzAA==
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 21/24] wifi: rt2x00: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:34 +0100
Message-Id: <49f2bce487f56eb2a3ff572ea6d7de0a43560c0f.1729865232.git.namcao@linutronix.de>
In-Reply-To: <cover.1729865232.git.namcao@linutronix.de>
References: <cover.1729865232.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There is a new function hrtimer_setup() which will replace hrtimer_init()
and also set the timer callback function with additional sanity checks.

This driver calls hrtimer_init() in rt2x00dev.c, then set the hrtimer's
callback function in rt2800mmio.c and rt2800usb.c. Therefore, switching to
the new function is not a simple one-for-one replacement.

Because only usb/mmio variants of this driver use hrtimer, ideally all
hrtimer code should be moved in those specific parts. However, all usage of
hrtimer_cancel() should be moved as well, and that is not so obvious to do.

With the lack of hardware to verify any non-trivial changes, introduce a
dummy timer callback function and use hrtimer_setup() instead of
hrtimer_init().

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/w=
ireless/ralink/rt2x00/rt2x00dev.c
index 9e7d9dbe954c..187701a8f8c8 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -1362,6 +1362,11 @@ static unsigned int rt2x00dev_extra_tx_headroom(stru=
ct rt2x00_dev *rt2x00dev)
 	return rt2x00dev->tx[0].winfo_size;
 }
=20
+static enum hrtimer_restart rt2x00lib_dummy_timeout(struct hrtimer *timer)
+{
+	return HRTIMER_NORESTART;
+}
+
 /*
  * driver allocation handlers.
  */
@@ -1391,8 +1396,8 @@ int rt2x00lib_probe_dev(struct rt2x00_dev *rt2x00dev)
 	mutex_init(&rt2x00dev->conf_mutex);
 	INIT_LIST_HEAD(&rt2x00dev->bar_list);
 	spin_lock_init(&rt2x00dev->bar_list_lock);
-	hrtimer_init(&rt2x00dev->txstatus_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
+	hrtimer_setup(&rt2x00dev->txstatus_timer, rt2x00lib_dummy_timeout, CLOCK_=
MONOTONIC,
+		      HRTIMER_MODE_REL);
=20
 	set_bit(DEVICE_STATE_PRESENT, &rt2x00dev->flags);
=20
--=20
2.39.5


