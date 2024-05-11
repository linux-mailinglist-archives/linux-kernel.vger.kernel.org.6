Return-Path: <linux-kernel+bounces-176558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC398C31A0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360B9281BB0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 13:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9824D51C54;
	Sat, 11 May 2024 13:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oTadM/iX"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED15024E
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 13:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715433881; cv=none; b=NtiUVfds6X3hGsLC7nAJPVCPg32Gw3afkmd9OnH3roFkXHpoLpifRHfiDnPJnYn452nVZgd9Th+9KIKn0yduib3IIS+X0tIDwLQNU51ypv9GiTP0ov2Md2SZrWkqZgaDfu+pYqN9+cOtDca2U5Oo9vnIeJGOZ1n201CLwVj5zdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715433881; c=relaxed/simple;
	bh=fYQ+E4OSc4wxVYuh2mIdAJlqCAIdlE+Q+PVPR7UX4gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uWjEufigyK1I6ERSmO5iNiwlKnK6OHG+yIo6lweX6rqzmxeQY0XQJVVzzt5Ba9omsy2Id8dNdkU1oifz7lRknwaXx5M6iSyGtP8iv2b2Xoc5ypy+iaGrv4+662DYmEuVrS/tTVFN/TapbLhypzubJz/GI3jfqbiQ3nIXKVa5sfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oTadM/iX; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715433876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G4aWH9heM5QxNrIphohY5XxHxE4Iln3Lp/nTshXAL3g=;
	b=oTadM/iXv2RMQypdOnk4bRZ/QzgmhcMv2hkt6sVbOm0/z9X9RxFe5ab89CH4ZW3hB3xtDf
	w6s1E861sO0dGRllNsduL5q+nNgOh5nGMT+5UJrLHYFIRsTMNmfY27wXzZ/1dw+HTrz8Gf
	BIdGiYZMkxxDeutp+jhc0ptInXiRDeU=
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
Subject: [PATCH] drm/bridge: tfp410: Remove a small useless code snippet
Date: Sat, 11 May 2024 21:24:23 +0800
Message-ID: <20240511132423.311884-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In the tfp410_attach(), the check on the existence of bridge->encoder has
already been done in the implementation of drm_bridge_attach() function.
The driver won't go further if bridge->encoder is NULL and the driver will
quit even if drm_bridge_attach() fails for some reasons.

Therefore there is no need to check another time at the later, remove the
redundant checking codes "if (!bridge->encoder) { ... }".

Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/ti-tfp410.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index c7bef5c23927..b1b1e4d5a24a 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -133,11 +133,6 @@ static int tfp410_attach(struct drm_bridge *bridge,
 	if (flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)
 		return 0;
 
-	if (!bridge->encoder) {
-		dev_err(dvi->dev, "Missing encoder\n");
-		return -ENODEV;
-	}
-
 	if (dvi->next_bridge->ops & DRM_BRIDGE_OP_DETECT)
 		dvi->connector.polled = DRM_CONNECTOR_POLL_HPD;
 	else
-- 
2.43.0


