Return-Path: <linux-kernel+bounces-527689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 341EAA40E32
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C49D1894AF1
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E781632DD;
	Sun, 23 Feb 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dSfwBE8g"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DCA205E0F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740308553; cv=none; b=aYNV1ZD70d9E1yDQwR4eU6khFs5Y/YeQVyT/hfzcfPgtvUifFfQIawquEb547xYpCtN13PQiH8+dLClrU7nth+Zyxs8WL4fY56IBEpbnbVJxDN51DeIB0QIGJsdvZzLVK+zq8PhfiBAc9TxGTR+rgcbBUpJhI3uwDRTDQMUbo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740308553; c=relaxed/simple;
	bh=XP3rwzkTa1mXnGdnUHFUWqLPHJxazgMc4cL1Dqwrxk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iuLUbsKpVlzAhS+tVbgROSUgQwRTCgynhFy8CvfU0XHeHETUHZxKbZIwz1NiQFOD7Zy6tQU1yAQsGnjZMdFkIoJsD07LBZzCTW5bvb8LzjNXeZ0SnNF+ntMOd+SfDHGvB6zwmwfZ7NUS9OdcBVDeJOvbhHtpNBQhUeOC+ApnpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dSfwBE8g; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740308549;
	bh=XP3rwzkTa1mXnGdnUHFUWqLPHJxazgMc4cL1Dqwrxk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dSfwBE8gRMyKyiTvnE+U9pT26OuqKF6ct5ERrWfIZIXSEHtZXLFWB8C+J4NYrApdI
	 5vEcMIrxGyVkIE6Pf1aGJ5svcLAqHwkndamru3xOQooolXdADaMmZIKc+jw6pd47n9
	 eXOh4qU4Uy5HfrNp5hwJJpy4YFLz2yhkUzLRaBvZBXgeQIpTEXK+YqKGGpn8JXY3t2
	 Vu3YUwScqES/tnD6MOggcFCmPtDw0ziV0+gjEmOTHkSBrK3JSqHTswmAsDCL5Jgz2W
	 JuVq7yVA4/5ik7Djn5+ZYkeJ5UcwjpdnzT+Jy2UVWiD2ktkhv5AHijHIEAXhFE2Xix
	 aiq3GLNCEJMlg==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id F3DDF17E0DD5;
	Sun, 23 Feb 2025 12:02:28 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sun, 23 Feb 2025 13:02:11 +0200
Subject: [PATCH v3 4/8] phy: rockchip: samsung-hdptx: Drop unused
 lcpll_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250223-phy-sam-hdptx-bpc-v3-4-66a5c8e68327@collabora.com>
References: <20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com>
In-Reply-To: <20250223-phy-sam-hdptx-bpc-v3-0-66a5c8e68327@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

This is just a leftover from downstream support for HDMI 2.1.
Remove the unused struct for now.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 31 -----------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index cf2c3a46604cb9d8c26fe5ec8346904e0b62848f..f9b5c96d6c789e435657e224032d35b5a6950945 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -329,37 +329,6 @@ enum dp_link_rate {
 	DP_BW_HBR2,
 };
 
-struct lcpll_config {
-	u32 bit_rate;
-	u8 lcvco_mode_en;
-	u8 pi_en;
-	u8 clk_en_100m;
-	u8 pms_mdiv;
-	u8 pms_mdiv_afc;
-	u8 pms_pdiv;
-	u8 pms_refdiv;
-	u8 pms_sdiv;
-	u8 pi_cdiv_rstn;
-	u8 pi_cdiv_sel;
-	u8 sdm_en;
-	u8 sdm_rstn;
-	u8 sdc_frac_en;
-	u8 sdc_rstn;
-	u8 sdm_deno;
-	u8 sdm_num_sign;
-	u8 sdm_num;
-	u8 sdc_n;
-	u8 sdc_n2;
-	u8 sdc_num;
-	u8 sdc_deno;
-	u8 sdc_ndiv_rstn;
-	u8 ssc_en;
-	u8 ssc_fm_dev;
-	u8 ssc_fm_freq;
-	u8 ssc_clk_div_sel;
-	u8 cd_tx_ser_rate_sel;
-};
-
 struct ropll_config {
 	u32 bit_rate;
 	u8 pms_mdiv;

-- 
2.48.1


