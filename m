Return-Path: <linux-kernel+bounces-384318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFF79B2922
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 08:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421EA1C21176
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554ED1DFE21;
	Mon, 28 Oct 2024 07:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G2hRmndz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oZnQfhDS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036C21D7999
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730100896; cv=none; b=W7IYqhj+yD4VsfoEyRY1ArjT1vRPy4s+eV8A/2U9B1VOw5omLYizC/EUpZO4ygpOIfNaEn2SnMxbJ5eulGCDzHMWWuLkggSOZ6kAXrwMwqO+NNKNSQKkwhxJYYA0s8j3PadBdCb6kLcEzl78lFWGi6Qst3jTSipULE1TUJ+U8i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730100896; c=relaxed/simple;
	bh=eP4YwOV+ik9NVBmN7eiWnS9JIDlXfnnKX5pn2uw33Mo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XryGqXvE7ylkg5vYTI/K5PyekfTcTkSXopQMYF5aJPVdtmcnxCDLzNVIG25CmhjiDxxW70fCx9jOUnYeccf74Wq3nu7CRYywfvsR6xMc5eepJnMbYiLvRS3qCxUjBmaLUVwoGDqi90Fku076h7fEQEuuvC7reOTAKilRKj6g0yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G2hRmndz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oZnQfhDS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730100892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OS9JAYKlBmv1/1WNFHjpDSeNZZjMoTsDV1AeduiJ7Rs=;
	b=G2hRmndzIh3C5UAxGGNjuvoakgHfiuXb9YoPduqBS4CytNv6UV35L2Tt7rgeBD9uUY5LXf
	XEA65jfW0fghvpsCT2xcYRQZt0Q9NLA+SkWkYI9nNTndmmBz2MSgzEJaymOOJUBTgb9BGb
	8b86R4rAZk6i1a+Ol1NWj8+WMhwg/Evub+nJExtY8K+wimSo4x/t7G8QQ0kZksBMVzTGvg
	sRw4yGZ+7WgoC1mXZiGUAT9tgO/jUKtOyGRMMBYDtu4qfm/zOGpkYp8chD/pX4XYKo/eQw
	qSiEMlzPAobSuLJ9XQhLUTZFpmoh0KpigV+aU4rFxbwaeNyOXnyNBx21K6Uu8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730100892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OS9JAYKlBmv1/1WNFHjpDSeNZZjMoTsDV1AeduiJ7Rs=;
	b=oZnQfhDSoXbjeYOb7Qmkghj8BgtmsAojxdlLuGhBtBOX8RwWFIcM8uU/Az9jCYuET1KuUk
	L8SoSbHKYkM56JBQ==
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
Subject: [PATCH 20/24] wifi: Switch to use hrtimer_setup()
Date: Mon, 28 Oct 2024 08:34:33 +0100
Message-Id: <e2109e1f6be350eb37da0330a06fecb2f1a15c4f.1729865232.git.namcao@linutronix.de>
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
Cc: Kalle Valo <kvalo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 4 ++--
 drivers/net/wireless/virtual/mac80211_hwsim.c         | 6 ++----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/driver=
s/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 0e1ede9314d8..4840d0b500b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -264,8 +264,8 @@ void mt76x02u_init_beacon_config(struct mt76x02_dev *de=
v)
 	};
 	dev->beacon_ops =3D &beacon_ops;
=20
-	hrtimer_init(&dev->pre_tbtt_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
-	dev->pre_tbtt_timer.function =3D mt76x02u_pre_tbtt_interrupt;
+	hrtimer_setup(&dev->pre_tbtt_timer, mt76x02u_pre_tbtt_interrupt, CLOCK_MO=
NOTONIC,
+		      HRTIMER_MODE_REL);
 	INIT_WORK(&dev->pre_tbtt_work, mt76x02u_pre_tbtt_work);
=20
 	mt76x02_init_beacon_config(dev);
diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wi=
reless/virtual/mac80211_hwsim.c
index f0e528abb1b4..3695f79fec95 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5509,10 +5509,8 @@ static int mac80211_hwsim_new_radio(struct genl_info=
 *info,
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
=20
 	for (i =3D 0; i < ARRAY_SIZE(data->link_data); i++) {
-		hrtimer_init(&data->link_data[i].beacon_timer, CLOCK_MONOTONIC,
-			     HRTIMER_MODE_ABS_SOFT);
-		data->link_data[i].beacon_timer.function =3D
-			mac80211_hwsim_beacon;
+		hrtimer_setup(&data->link_data[i].beacon_timer, mac80211_hwsim_beacon,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_ABS_SOFT);
 		data->link_data[i].link_id =3D i;
 	}
=20
--=20
2.39.5


