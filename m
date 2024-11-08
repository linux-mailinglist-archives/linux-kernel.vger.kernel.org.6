Return-Path: <linux-kernel+bounces-401744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C2F9C1E9E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B397D283207
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE781EF952;
	Fri,  8 Nov 2024 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="o61aKxCd"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF891F5FA
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731074045; cv=none; b=eXI+6UrxZG8c0eG3A+wNrxf3KdQCAIhd+cTURq616yMX2HJ2KWxRIZcUm9kIUnVGitKoYtub3WIilQF9o97UOWgJm1rC6mYK+2XV0ONANycifqJ+mWg1EjuZNTLwBoXrRsRlIM6kvT/THIfhdjkNd4jKiW7pA1VJV5heZoAdaA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731074045; c=relaxed/simple;
	bh=NEWEEjqEKwbs3WC9Q+01tVU6WO2dpumDyXNj0Ie1Jik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F57XE2IJd9poRXwAfdLFIgQ37k0a54RS819eKPgdWTdbA55DygwJclW8Kr6FZy2uVpWrs70uBDAXVHxQ54NpHh+MOSpV3HUao00LBLgZPkuR1Owed8/OPMJm2zjYxOFEidvVAjwhh2mqJEyZGBOQFq5EqIDWr7olqGTcJzeobGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=o61aKxCd; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1731074042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2nN4JqEDzQF8CCUgP/ziSYmPd1Oo8YRgapLVQ+6WIcU=;
	b=o61aKxCdcZBd2XTmhnBPl8aecZCjt/wzStVNMVp/TwEhp49T8em57HVwDE216g+2p498NR
	cjiRwrOWiUxW8F5n0ju2oFnbFykdcrWmmCA9xAhO2i0Y3byW5NmliccfnEgzF3XSewx+ie
	uhwX45ih8uZHZbOJkWaeCLeTkfJxAxHcoQJ8sd6/nSEOhdkrERTDbXeu0E2pGJaeBUJL6z
	QXIIRKarHHyoHNpRGq+lOG8otxJw+xMaAq6wauxLydTRxceNzwhJ34W5vS0SIxLJoSQavV
	u0um4SRYHG86KeUR9Xv1E7QOlWqWXbTRhHOJlLpqHLYD2rOIJqYk/rWwgbBE+g==
To: linux-rockchip@lists.infradead.org,
	dri-devel@lists.freedesktop.org
Cc: heiko@sntech.de,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/rockchip: dsi: Perform trivial code cleanups
Date: Fri,  8 Nov 2024 14:53:57 +0100
Message-Id: <35555b58a7284450fb16281514e4e6a3eb9c7b82.1731073565.git.dsimic@manjaro.org>
In-Reply-To: <cover.1731073565.git.dsimic@manjaro.org>
References: <cover.1731073565.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Perform a few trivial code cleanups, to make one logged message a bit more
consistent with the other logged messages by capitalizing its first word, and
to avoid line wrapping by using the 100-column width better.

No intended functional changes are introduced by these code cleanups.

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 58a44af0e9ad..f451e70efbdd 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -1379,7 +1379,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 	}
 
 	if (!dsi->cdata) {
-		DRM_DEV_ERROR(dev, "no dsi-config for %s node\n", np->name);
+		DRM_DEV_ERROR(dev, "No dsi-config for %s node\n", np->name);
 		return -EINVAL;
 	}
 
@@ -1408,19 +1408,16 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 			dsi->pllref_clk = NULL;
 		} else {
 			ret = PTR_ERR(dsi->pllref_clk);
-			DRM_DEV_ERROR(dev,
-				      "Unable to get pll reference clock: %d\n",
-				      ret);
+			DRM_DEV_ERROR(dev, "Unable to get pll reference clock: %d\n", ret);
 			return ret;
 		}
 	}
 
 	if (dsi->cdata->flags & DW_MIPI_NEEDS_PHY_CFG_CLK) {
 		dsi->phy_cfg_clk = devm_clk_get(dev, "phy_cfg");
 		if (IS_ERR(dsi->phy_cfg_clk)) {
 			ret = PTR_ERR(dsi->phy_cfg_clk);
-			DRM_DEV_ERROR(dev,
-				      "Unable to get phy_cfg_clk: %d\n", ret);
+			DRM_DEV_ERROR(dev, "Unable to get phy_cfg_clk: %d\n", ret);
 			return ret;
 		}
 	}
@@ -1465,8 +1462,7 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 	if (IS_ERR(dsi->dmd)) {
 		ret = PTR_ERR(dsi->dmd);
 		if (ret != -EPROBE_DEFER)
-			DRM_DEV_ERROR(dev,
-				      "Failed to probe dw_mipi_dsi: %d\n", ret);
+			DRM_DEV_ERROR(dev, "Failed to probe dw_mipi_dsi: %d\n", ret);
 		return ret;
 	}
 

