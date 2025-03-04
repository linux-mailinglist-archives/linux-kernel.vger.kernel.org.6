Return-Path: <linux-kernel+bounces-543070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2653DA4D125
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 02:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B458D171793
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 01:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43F218A6D3;
	Tue,  4 Mar 2025 01:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NLY3E68D"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71982147C9B
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741052670; cv=none; b=UBNQ8Z3N8uHh/ZQufQdIu73KGexaBso6uRTr5MHLRMFNMY0glM2DYNrm6KcwjeVnP+PDwmX8gaP4CCNULBw8lXJbO91DXEPgVV6ikoSWDjykMLJywUeUM6pAbZ1AgqDcIUSeFl3c4/wVRgBJvcd8jdA/vmI0R7wqLvThGIjx+kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741052670; c=relaxed/simple;
	bh=XP3rwzkTa1mXnGdnUHFUWqLPHJxazgMc4cL1Dqwrxk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V+J0nb+ku46yXQ+MZY4s98wsQGFVwyyc19EI79zZ8xwuXpIuwqiR7pZzgDfnZ6HmYLbnYcGGfkhx/OEbrbeZnjFpK5yLGvVpuV1Q1A4kzQyJQMS9RHETSPXL6PtNlcn8ju2H1WerNURHFgrxyhuW725Hh3Y9B/ahlMvRRTklf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NLY3E68D; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741052660;
	bh=XP3rwzkTa1mXnGdnUHFUWqLPHJxazgMc4cL1Dqwrxk8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NLY3E68DYDkzVvAkCnu5VDpYvpn0xoEudpCXALBbfaiQT5f/rtb9Zmv3NXOqbxhGc
	 qdFzoXkH76VoYcLBaFtPqDQYM/MnetZFz817LDvf2hwzaqHjXTxHms9vw/OqGH+6Ic
	 T3qMqUrZ5Czeea6MobKuohAB+gvJXJQbklJEwacwomyXO+OhPpgXazTOT6ZIi5pZuz
	 0ePEsUgElXEisUlqex5CtEqpiHJ97rUcrXXy1FqJSrdLrTNkfis/WIlwqewRaC77Z6
	 m5T0p0JaKYpbtOrXr9mmCVMfr8MgyQaDCgVKlUFM5NrmFrOXXJ3PRXwKKMR4C3L5vf
	 fW7VxK7rVOkXA==
Received: from localhost (unknown [188.27.58.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id B13CF17E0FD1;
	Tue,  4 Mar 2025 02:44:20 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 04 Mar 2025 03:44:03 +0200
Subject: [PATCH v4 04/12] phy: rockchip: samsung-hdptx: Drop unused struct
 lcpll_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-phy-sam-hdptx-bpc-v4-4-8657847c13f7@collabora.com>
References: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
In-Reply-To: <20250304-phy-sam-hdptx-bpc-v4-0-8657847c13f7@collabora.com>
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


