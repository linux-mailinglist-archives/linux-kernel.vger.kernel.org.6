Return-Path: <linux-kernel+bounces-566157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFD2A673FF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BA9B19A44E9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281CD20D4E7;
	Tue, 18 Mar 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TD3isOYV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E167220CCD8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301425; cv=none; b=KoFSx2MlDKB7ybXLn3BzdKNrffFARfr5TNVMTnsz2UFMncWnZK4tss7Q1XWJeTaCZZ6ga20DA0ssAxYoNLufDutgkR2fS0wKMcIk5VrboejHP+ehgaOtIgAgg39uZiUER9xXMCCygVkvKUYQSRKUx/86851wivyZhm7kbWEJLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301425; c=relaxed/simple;
	bh=aLFjfuHhMM8ugvw6TfnrjxNMybfxMUpblGyCoPEtCr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bfwmw2d3xvc1nQZFjldM5777PVFGdiX9zs1cQ+GxmlG8R81TWn1AbI0jJJS+o9+rvnh6DGVl9opprzEbQap7nTz5PO5ikTcYxGGG5mWEcfb5JYT7NxLPeP6fGxtUcllmE7vGfjcD8vnbpyg/mFyfAL5ymlMprMnmccFn8zvQwF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TD3isOYV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742301422;
	bh=aLFjfuHhMM8ugvw6TfnrjxNMybfxMUpblGyCoPEtCr8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TD3isOYVazfpHN0o9ZJjl1Lz5KSZ/obCjRohBBKaLSor5oXo2dWNT2G1wmMJy5NNG
	 6af6v6hLeOXnBPyVaAcoZapYhjB+qTLo0I878ygu+GWWUeITFs9MCvh+4xfGbYlT5P
	 lD4owS9Y6MYLe5F101HJtJKSDsppk/95BTnxR4nQjYhc+w74WI8+/FUMQ1EWso17MP
	 h6OzdS/5p3oeeFr5B/ZUgHCCMluGgczvgC4vdwQAwL9cDEDzZIU+6TbxDSf1Nh86+m
	 ceX79o1DHySiItrDjsIJvROM3fnI+W/5EN6eafRXAQMm3rL2/iZviaJmi9IRKqHdza
	 Am01c/R3DTBZw==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 07DC917E100A;
	Tue, 18 Mar 2025 13:37:02 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 18 Mar 2025 14:35:39 +0200
Subject: [PATCH v6 05/14] phy: rockchip: samsung-hdptx: Drop unused struct
 lcpll_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-phy-sam-hdptx-bpc-v6-5-8cb1678e7663@collabora.com>
References: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
In-Reply-To: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2

This is just a leftover from downstream support for HDMI 2.1.
Remove the unused struct for now.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 31 -----------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index d0989dc5a0173af4de4521e690c3f7b6cc343402..70621687b5eb3581a81af20b23d0be53263003bb 100644
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


