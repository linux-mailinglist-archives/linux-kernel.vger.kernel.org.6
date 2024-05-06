Return-Path: <linux-kernel+bounces-169907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250898BCF31
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60AC2822B0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3469884D0A;
	Mon,  6 May 2024 13:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR9oKcUP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8CF79B9D
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002557; cv=none; b=HQsetPDlAmnI1d1gu1vL8GlJsBuQxqjefScDOuDf0pxrF/laqvVRQ7R3tXcehSVsUmgrEGLYdpKzwjI7M7e2qdkAelptsKoHk8Rq6qurwHCepQ7cUdlwbpfsMPMKH8evKsRrg4kImXX1SVFk+a7pz1xTpNa+HXZGAheX1kUayTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002557; c=relaxed/simple;
	bh=0kDtbAaVTUzCfU0u7ieyZBAWWC/9d6iWWtENhJGOYbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U6NOKHTYwEaMjGIlphv2Y3D3j1DS7V8CdF/69n4XSiBtZQWibb1ogfPqQChzG+oa4yuZrzWdO/kbEVBfwWPswFOZ1o24wa4/AxqzeDyYfZk+f5+CvvgahFq5yKy5MAbUU3pjYijMTM+vFV6cLHpBYmKsNwuiIs6BtSGv31mX2SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR9oKcUP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B47FC4DDE1;
	Mon,  6 May 2024 13:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002557;
	bh=0kDtbAaVTUzCfU0u7ieyZBAWWC/9d6iWWtENhJGOYbs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lR9oKcUPpndQp18qBV2mivcjy5kCKkBF2vXx/0ArM+BTUOKgA1xP3vAJGn+Flb0eT
	 ykzkprANmvCZsVEeLfqtVIhJWrmhZMrEH++iJMmN9TEzWSR4IbXrpJfYycMRFQHrRm
	 P0iURHTBT2I627ep7jAhQsCgQ4qXcpNqb1FhnDHOduu5LVnf/CG1h+UEsmH72UMjDl
	 wm+mTtr80qXdKbW2c4xhJoglyiYi5fnBirDDMqCgXJseEKdDyCYeHv4QvIusbD847m
	 MPQuOzC5k93U5fsv0gDViI1ej/aRkesOWMzvxK4CA/lXlbXxxTsshhNpJcDOk3enw7
	 ukHmYtM8RpLQQ==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:40 +0200
Subject: [PATCH 11/20] drm/bridge: tc358775: reformat weird indentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-11-545dcf00b8dd@kernel.org>
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
In-Reply-To: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Vinay Simha BN <simhavcs@gmail.com>, 
 Tony Lindgren <tony@atomide.com>
Cc: Daniel Semkowicz <dse@thaumatec.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.4

Reformat the indentation of the mipi_dsi_device_info initialization.
While at it, move it to the top of the function.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index be2175571b99..e6d1f0c686ac 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -557,14 +557,15 @@ static const struct drm_bridge_funcs tc_bridge_funcs = {
 
 static int tc_attach_host(struct tc_data *tc)
 {
+	const struct mipi_dsi_device_info info = {
+		.type = "tc358775",
+		.channel = 0,
+		.node = NULL,
+	};
 	struct device *dev = tc->dev;
 	struct mipi_dsi_host *host;
 	struct mipi_dsi_device *dsi;
 	int ret;
-	const struct mipi_dsi_device_info info = { .type = "tc358775",
-							.channel = 0,
-							.node = NULL,
-						};
 
 	host = of_find_mipi_dsi_host_by_node(tc->host_node);
 	if (!host)

-- 
2.39.2


