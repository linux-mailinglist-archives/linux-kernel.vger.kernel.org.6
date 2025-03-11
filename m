Return-Path: <linux-kernel+bounces-556518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DE6A5CB08
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8C6189DEAF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DD726136E;
	Tue, 11 Mar 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pNNkRzGo"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D8260A41;
	Tue, 11 Mar 2025 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741711251; cv=none; b=V9vOfmdlUPAEXYiN0Zw60V9R30wBGNe3F0Y5OuUtFTNgsf/C2/7ugJGpp4q/YLu7qPxhzSlP3Czit2frWdttozBNgMjRCnFbdmHH3/TIK+n//SwdxMlAhwTV8pSmjSj5ffXpP8tWJhcprOsMX79mCpLz/h0JfR+yrNo2gcCXTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741711251; c=relaxed/simple;
	bh=DK7Z2yAARfFjabstQ/O2Gk5kpA6ZcrhH1LG7iGgqdkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J22D3DUTVjfkEEvBUzYP8o2XLrIANnHfUNyJJqbSUKmz14bDwdNlszH/FoR9y2G5i2ugYccgf6TPxgwO9fA8011fLQ+EKi5xNmo8TPZuNoM587XVjk15AyZDlfOhY+fZT4QSl0kQkpY8UrnvREX1q5LSkoXE2jqJdPaIAq951M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pNNkRzGo; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E695820457;
	Tue, 11 Mar 2025 16:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1741711241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vsxnqo6HjsJm0M7jyTeDr5TGZHZn8pllCm1cLgKcq08=;
	b=pNNkRzGoSHT7uu6aKBVfDDogYy52WcDlzL+z6J1vUw4AkLPL32vOqei6UMOB/XPyMRs0ZT
	rI3nTQfQ9dElg8BQIwbZk0qjeilAPeS92zWGoKgkwiobaipHO3k60NVdpUaUdHzaCi3WIL
	eJ6mHd73pdOdhlJtzt++q95mN1eJZwnHcRAYlpZMxVA4W4WAmUQYh8o8Gf7xY3U7Q+cO/m
	Gt2FlWW44EpuqOHwdEP3esyGkelyZ+MvAbAdTUL68AG76MLcWViNjSxXUae7DlBVwr8IYx
	CmVUazmLIeY0HLVQHeEYInEBUIZ4Ys9H+8HrtiCFIh4LOScJZBSez9A83UbBgw==
From: Antonin Godard <antonin.godard@bootlin.com>
Date: Tue, 11 Mar 2025 17:40:06 +0100
Subject: [PATCH 2/2] drm/panel: simple: Add POWERTIP PH128800T004-ZZA01
 panel entry
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-add-powertip-ph128800t004-v1-2-7f95e6984cea@bootlin.com>
References: <20250311-add-powertip-ph128800t004-v1-0-7f95e6984cea@bootlin.com>
In-Reply-To: <20250311-add-powertip-ph128800t004-v1-0-7f95e6984cea@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Antonin Godard <antonin.godard@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2004;
 i=antonin.godard@bootlin.com; h=from:subject:message-id;
 bh=DK7Z2yAARfFjabstQ/O2Gk5kpA6ZcrhH1LG7iGgqdkg=;
 b=owEBbQKS/ZANAwAIAdGAQUApo6g2AcsmYgBn0Gd8T8IJ2YfGapBfDSz8ZnX8ZKPn8hqGBfQdn
 sM97aEKijaJAjMEAAEIAB0WIQSGSHJRiN1AG7mg0//RgEFAKaOoNgUCZ9BnfAAKCRDRgEFAKaOo
 NjcHD/9Od77BWYqTNgey25Bzviy90iic4gmbyQDoBgfJRzh//POE7WRdv7jbjHEH+oKxfL6Obu2
 lMeA7Aq2Q9cQ3icQaphXHFJCQnHTwD2tmrsJsdsSDGouNk7R5A5L2UUCb8zFdxHfRy0EmMumZEh
 mTqa1cX/9byd8UumC/3Z39Ia2sP3gRbC5dKOPi73i13gh4bitGSbgbjKlt8EJOt92JMPo2uBpiX
 WwgFy7a1mXB9rLIKYFf0v9bboHx5a6q6ozvrf1D0Xhf5oZaOQ8wFhgvc8jjJYxQOwBq0Ii214II
 UYv+sNS8DsaRpsfZ2MQt3jqLYnk5VDVJhdYzAE51lBkZQc8GLS716+4Nu/wQ1Mxp/K8oFJWxqz0
 4pZpngtwaBIlqUhQWc4Mnk6HOqopwU8OJ6DZfUWInn2zJ5oPlGeuHV7p/pg6FGGiO3bOrvL34r4
 I6X2S5SGUc33I+mcJoh0rsxZL7UeOMmh4W22Y7NCtXcfMvc21PORoXRBJRhaGfdALkg20ZCQJym
 oyr/PQX6P5o4JQgiPzpgXIqtq+6DTy3J3jl7bPRMlrNI8kJMNzCeb6rHEbvwQ93lSFtPEYaOODn
 19sS1vO1Et06hzhqoEm0zGfaX9fWPgYNMy4D0iSPlYbA7UnxsG+tt5srO46oqxABakXYF+VbAZb
 sTyCnAHCTaTdpIQ==
X-Developer-Key: i=antonin.godard@bootlin.com; a=openpgp;
 fpr=8648725188DD401BB9A0D3FFD180414029A3A836
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvjeegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptehnthhonhhinhcuifhouggrrhguuceorghnthhonhhinhdrghhouggrrhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehieeguefhfeegheffgfeuieetheeileefheejkeetgfekueehueeluddvlefghfenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeejtgehtgemiegruggvmeejleegkeemgedtheelpdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpegrnhhtohhnihhnrdhgohgurghrugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughrihdquggvvhgvlheslhhishhtshdrfhhrvggvuggvshhkthhophdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrn
 hgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhihgvrhhrhidrrhgvughinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: antonin.godard@bootlin.com

Add support for the POWERTIP PH128800T004-ZZA01 10.1" (1280x800)
LCD-TFT panel. Its panel description is very much like the POWERTIP
PH128800T006-ZHC01 configured below this one, only its timings are
different.

Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9b2f128fd3094bfb6731fc348b91cc101f495a86..80dda575b48a99feb81b9a75dc69ef18075ffdcd 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3738,6 +3738,32 @@ static const struct panel_desc pda_91_00156_a0  = {
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
 };
 
+static const struct drm_display_mode powertip_ph128800t004_zza01_mode = {
+	.clock = 71150,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 48,
+	.hsync_end = 1280 + 48 + 32,
+	.htotal = 1280 + 48 + 32 + 80,
+	.vdisplay = 800,
+	.vsync_start = 800 + 9,
+	.vsync_end = 800 + 9 + 8,
+	.vtotal = 800 + 9 + 8 + 6,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+};
+
+static const struct panel_desc powertip_ph128800t004_zza01 = {
+	.modes = &powertip_ph128800t004_zza01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 216,
+		.height = 135,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode powertip_ph128800t006_zhc01_mode = {
 	.clock = 66500,
 	.hdisplay = 1280,
@@ -5089,6 +5115,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "pda,91-00156-a0",
 		.data = &pda_91_00156_a0,
+	}, {
+		.compatible = "powertip,ph128800t004-zza01",
+		.data = &powertip_ph128800t004_zza01,
 	}, {
 		.compatible = "powertip,ph128800t006-zhc01",
 		.data = &powertip_ph128800t006_zhc01,

-- 
2.47.0


