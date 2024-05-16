Return-Path: <linux-kernel+bounces-180671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 037F18C719D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 08:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02721F21973
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 06:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D8325570;
	Thu, 16 May 2024 06:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="hadd6n4m";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="PnOMc5wk"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DF21D53F
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 06:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715840715; cv=none; b=nSEpW0hxxtNuzhznH32oeJEJbhWgD5x1IufuGAIFsJ7uhe/d3alebFabdtGUqA+RTJioAAwE1TqSk64FrRmbGrZq7pJGezNA5O+gfg7RyA0S7Dq/KR8uwZ9/KSXlDpeLxYO5N6tOoe9rRpAL7DQzpFSfO+bu0lsjijJVXx6K0x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715840715; c=relaxed/simple;
	bh=SaOiCHxwt8vnIKaxDdC1b9Uwm+iMZnNRlK+ZpCasYuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l4rd3PZ57oLcaQ4BJbZDVWPhCmjTpo5byHGkEMfVh1xKDI23pK+iDTNdoTF0VAvDUZ2X4rdjLI0WtdfUVkO7E5V3RW5D/Ad5O77jIxZ70XcaUMW7iMQgDtWsjWGAu152p+eOdpyp/j6FeMJLeML2yqCgJTkdIJcpqHcrvl2ZjUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=hadd6n4m; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=PnOMc5wk reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1715840713; x=1747376713;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eXSRJ9ePSQv2BRVPVAwRZ5tukZAjyNQB7JMiQsOB8x8=;
  b=hadd6n4mI3q4VUA58hrqvg/3U4aDPyx/2X2GnAOpbU1GFKi7MgB06qJH
   Rcql1LEKfbWXaomeDWYTRQzZ/Sa30fsfU7AQHGankte9TVWJ/y80RPqCr
   Jji71+XDR3RdhRnBo3KSm6pIb5jQFQtXVzCTbma60FD9+JLl8ndjEcA2X
   OkGYH12WroqWMba7e7lXNuADRFVO/5dVVwBLV2gTiu1gKyjForWTzjAAP
   QwRWXOsgKE2Zp10R3CVdVOaCbww/Vw6W68fmf1rFPEF1g2DYYztUOIE0T
   moEcJrhjPdf+3N5g+ZLHFRnRUlg69xknMsodulaidP4EWAT1uN3g8kgiU
   Q==;
X-CSE-ConnectionGUID: VszA4rqNR/qsNv/XzKy4KA==
X-CSE-MsgGUID: Fq9c5anXSamT1K8pUT7tlw==
X-IronPort-AV: E=Sophos;i="6.08,163,1712613600"; 
   d="scan'208";a="36926960"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 May 2024 08:25:06 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 87495172EAE;
	Thu, 16 May 2024 08:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1715840701; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=eXSRJ9ePSQv2BRVPVAwRZ5tukZAjyNQB7JMiQsOB8x8=;
	b=PnOMc5wkNdlyJ2j1ykBMFHHOVXO2rQs18mSmwhOwegV8w1boATeh1sgPe3E29mVKe1beUy
	gCkBer+x6OdCoR3iNvAhBfw3QmRZkcRwXZgcaaGgUNxHdYp3C5xAxQ5D0SYPvzrLmlOBs/
	5jqRtAp7hynm121UkmOPyf/IvXMcJ5WV938b7TJpMhTa4VSjBxfTvfx5zROnUeHjjWRAM4
	p8abwya3jMT7r0IYEh46/l4xHvwfD/5qsutqErr6GWE4b0oNA5yi3AVfK5/iKRy/zVqmGt
	YCTlvv1WnaDYASdil+CZtjduP39wQ7RmFn0M6WWkJjnyXsAhexBzKH3/CUktCQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/bridge: tc358767: Use dev_err_probe
Date: Thu, 16 May 2024 08:24:53 +0200
Message-Id: <20240516062455.106266-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516062455.106266-1-alexander.stein@ew.tq-group.com>
References: <20240516062455.106266-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The function calls preceding these returns can return -EPROBE_DEFER. So
use dev_err_probe to add some information to
/sys/kernel/debug/devices_deferred

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/gpu/drm/bridge/tc358767.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 99e8a8cf29f5b..de62a7e2eafec 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2215,7 +2215,8 @@ static int tc_probe_dpi_bridge_endpoint(struct tc_data *tc)
 	/* port@1 is the DPI input/output port */
 	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0, &panel, &bridge);
 	if (ret && ret != -ENODEV)
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "Could not find DPI panel or bridge\n");
 
 	if (panel) {
 		bridge = devm_drm_panel_bridge_add(dev, panel);
@@ -2243,7 +2244,8 @@ static int tc_probe_edp_bridge_endpoint(struct tc_data *tc)
 	/* port@2 is the output port */
 	ret = drm_of_find_panel_or_bridge(dev->of_node, 2, 0, &panel, NULL);
 	if (ret && ret != -ENODEV)
-		return ret;
+		return dev_err_probe(dev, ret,
+				     "Could not find DSI panel or bridge\n");
 
 	if (panel) {
 		struct drm_bridge *panel_bridge;
@@ -2455,7 +2457,7 @@ static int tc_probe(struct i2c_client *client)
 		ret = tc_mipi_dsi_host_attach(tc);
 		if (ret) {
 			drm_bridge_remove(&tc->bridge);
-			return ret;
+			return dev_err_probe(dev, ret, "Failed to attach DSI host\n");
 		}
 	}
 
-- 
2.34.1


