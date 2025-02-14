Return-Path: <linux-kernel+bounces-514981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB6DA35E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169D4189788C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47562661B7;
	Fri, 14 Feb 2025 12:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BbTyiLUj"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF44265CA3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537887; cv=none; b=sgNYKV4MkyJocrSOUfhih8d/W8EXk3F2MtpYHGEVDZH8hswGhPAxkpDFjaSasMuQtll3XQMRzGI09ldHtywwymA5BuWYT+EB3n8eX2EOvlIJtFrLnCjQy15w48s/BY/fdZmRjstgUSysRlxGYXPOdgDHfH5AIQfPFE/HvLyx8ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537887; c=relaxed/simple;
	bh=C6p+y1LeiwCUtm5K+R1smGuMr2P0VRt1Lu7WvhpHm+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jujMRZy9s684hsIiD0c7he9/rX99TOYLms9suzma+BxRgmI0aQfFi1xKYyEJoIR/CKGbEj9EkNrF3gxnMjpge0oAj3F37m9wo/FsRMKay3UUk2XDHMgtEmNVEA1jjLZc8L1ITXa+w7Amzc1lh7F/8n2sU8SQkU4gD7A0f+PKPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BbTyiLUj; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EDC1E4429A;
	Fri, 14 Feb 2025 12:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739537878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IanyTrBjepRErJlkuSDGkmybOW22CjOKomKYv0f60o=;
	b=BbTyiLUjgh0wcwVZAGmPTmiqj4H279U01KSTNv+VADvmmelxEDjNfM18+zE+d3sIUvLIXp
	Dhe52YFVAvgF+TDaGp00J7tbK/x3VwDwCy3AvuiaAmFeeyZk5OECr69Y1e7tmkeeyvcsCt
	QkfwG5x8W7HVeQm08y7YvjV6Xhw3SSqDkIK7NEScFDsvlZb7f8InmLvdarvfvt8eqXh18J
	B2QrcrQkgjcqdLdX7nJqHOLMgEif+tML6jbo00MKbVJ+HlP2FFMfoB2BAoKNqHe0q2mZBK
	5EO4I38hyQPsjsOqDfLUcfvZQlIbggHum9+eCD37RNhHcVhrst37Adt5OISL0w==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 14 Feb 2025 13:57:41 +0100
Subject: [PATCH v7 2/5] drm: of: drm_of_find_panel_or_bridge: move
 misplaced comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-drm-assorted-cleanups-v7-2-88ca5827d7af@bootlin.com>
References: <20250214-drm-assorted-cleanups-v7-0-88ca5827d7af@bootlin.com>
In-Reply-To: <20250214-drm-assorted-cleanups-v7-0-88ca5827d7af@bootlin.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepieeiuedvffetgfeuudelheeutefggfejieettdetteekueeuueeukeevvedvueevnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegludelvddrudeikedrudejkedruddukegnpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudejpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurhhiqdguvghvvghlsehlihhsthhsrdhfrhgvv
 gguvghskhhtohhprdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

This comment is misleading as it refers to one of the inner if() branches
only, not the whole outer if(). Move it to the branch it refers to.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v7: none

This patch was added in v6.
---
 drivers/gpu/drm/drm_of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index 5530919e0ba05f7ce1806730b292319f36e905ed..d0183dea770308e77f05da364ffe087d53f3be36 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -268,9 +268,9 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 			*panel = NULL;
 	}
 
-	/* No panel found yet, check for a bridge next. */
 	if (bridge) {
 		if (ret) {
+			/* No panel found yet, check for a bridge next. */
 			*bridge = of_drm_find_bridge(remote);
 			if (*bridge)
 				ret = 0;

-- 
2.48.1


