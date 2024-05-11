Return-Path: <linux-kernel+bounces-176563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE7A8C31B0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBD71F217EE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 13:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF55336A;
	Sat, 11 May 2024 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qK9cMOWO"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2906FC6
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715434985; cv=none; b=aF28aPIqpa5pHn76TGedAP+zUs+dbf3Ns7KKzo69lpsgImlIa1VmX9tMcQtHtta5BREaFy3NEBRymvc5G949e8F0gBbehB/BtvOcWdbEJhn/RO1GhUXnBcmR+0ySVKFTZQ3C7P1Hd14scdS50iWhPxt+xbbQJWlC7zX23JoK+og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715434985; c=relaxed/simple;
	bh=5e3+lzc93eLN1U5/WEyH120IBkdktfJJJGOghG1BnGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CsRb5LZZCiEvCdu8Q183P4rO39KUeFefrRHcWkV5wApAuSPqVIx9QB9AO3xcCnl9PWR1AAlYDCA4+IO8OzxRJx06QqqMec/fXe3gqo7CR4HIhL5jo2q05N6hAKWbCD8nvDOX4A5J3bAB0EeK7CT1HUDv3TImIYmQ6BGId6/KiW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qK9cMOWO; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715434980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RgtGAFbku9bwQJoqLJ8e+foNfnAXhgDDb46wiVqco90=;
	b=qK9cMOWOcTh9nApidPyn0t0k6Xl41N2Ja8jfAEZasuVfIsEmAVGkSnmymzIZ++FmEt7Nji
	IDu1WggGereH5bWvjMNlw1Vbo987sVju+TBtz6bQ27IGhMWfWl642X5l/eg/5C4v1s0OgC
	893B6O06NZr/CbCnnI1GS90etmlS1QA=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/bridge: nxp-ptn3460: Remove a small useless code snippet
Date: Sat, 11 May 2024 21:42:50 +0800
Message-ID: <20240511134251.313513-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In ptn3460_bridge_attach(), the check on the existence of bridge->encoder
has already been done in the implementation of drm_bridge_attach(). The
driver won't go further if bridge->encoder is NULL and the driver will quit
even if drm_bridge_attach() fails for some reasons. Thereforei, there is
no need to check another time at the later, remove the redundant checking
codes "if (!bridge->encoder) { ... }".

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/nxp-ptn3460.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index ed93fd4c3265..e77aab965fcf 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -229,11 +229,6 @@ static int ptn3460_bridge_attach(struct drm_bridge *bridge,
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
 		return 0;
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	ptn_bridge->connector.polled = DRM_CONNECTOR_POLL_HPD;
 	ret = drm_connector_init(bridge->dev, &ptn_bridge->connector,
 			&ptn3460_connector_funcs, DRM_MODE_CONNECTOR_LVDS);
-- 
2.43.0


