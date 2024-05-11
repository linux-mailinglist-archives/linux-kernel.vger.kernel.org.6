Return-Path: <linux-kernel+bounces-176537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C18B58C314F
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 14:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D292B20C26
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 12:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCCF4E1CF;
	Sat, 11 May 2024 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rnl2UFX/"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AAF7E9
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715431377; cv=none; b=XlML8rKPLrwQkSYWHGF5dSyuIIQtalKnyLooffbPnl5F5+nz/Yw5yIahidSYFF2sjdpFZY0upSJpVKziMXG4dFyowke50gU6FWwwMWxy6AEKVS8qv1cHBG52oBOAtFENk0eZU9XUwTyPiLpsHhL/tY/Bi5w0Fo1HWJtv//zBpD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715431377; c=relaxed/simple;
	bh=MeHi4bk5Ajd8/IQPQj4d8hEx3eNYc+Qz7JCRrKuCY1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myBvviUu80c8ZSGTII46tsJQKWIkP+qsY8PXaKqXiSK7gBgAW94IK8xDRKP0XB9nXm5hZe/fVWE53eI13QHZqbMLOT+WiHmugEi56GP1qFlicboekAId+Kf0BRvuXL76cYBdBRLznjsJPrZBpkGM8qhFNAZhKYyYv4zxNXoXO1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rnl2UFX/; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715431374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5Mlk8jFKvoypD9IZYpI3BVSdxetHEe1rriO0cIJzkmo=;
	b=Rnl2UFX/CCFkmjgSw8t9xem4X/DuUT4GTH4ZefCtr3W9ufq9lIMQAo9rMIqPcC7Z4lu/ke
	qkvjoTDCwgIO2jP4xHrEIajjK3jDOfLjDEWbOuTe7VyuJ0NeWV0MynxnFZFsbIL2g60lP9
	Q6VrTpvROk4YSvqllU8Vox+Q/1Y7ifU=
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
Subject: [PATCH] drm/bridge: Remove a small useless code snippet
Date: Sat, 11 May 2024 20:42:38 +0800
Message-ID: <20240511124238.297192-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Because the check on the non-existence (encoder == NULL) has already been
done in the implementation of drm_bridge_attach() function, and
drm_bridge_attach() is called earlier. The driver won't get to check point
even if drm_bridge_attach() fails for some reasons, as it will clear the
bridge->encoder to NULL and return a negective error code.

Therefore, there is no need to check another again. Remove the redundant
codes at the later.

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/simple-bridge.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/simple-bridge.c b/drivers/gpu/drm/bridge/simple-bridge.c
index 28376d0ecd09..3caa918ac2e0 100644
--- a/drivers/gpu/drm/bridge/simple-bridge.c
+++ b/drivers/gpu/drm/bridge/simple-bridge.c
@@ -116,11 +116,6 @@ static int simple_bridge_attach(struct drm_bridge *bridge,
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
 		return 0;
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Missing encoder\n");
-		return -ENODEV;
-	}
-
 	drm_connector_helper_add(&sbridge->connector,
 				 &simple_bridge_con_helper_funcs);
 	ret = drm_connector_init_with_ddc(bridge->dev, &sbridge->connector,
-- 
2.43.0


