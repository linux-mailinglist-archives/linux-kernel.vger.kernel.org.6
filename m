Return-Path: <linux-kernel+bounces-566166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4EBA67418
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DFD0189C622
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAB420E701;
	Tue, 18 Mar 2025 12:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="D00NnSNl"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DC20E329
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301434; cv=none; b=IhGI/Ywq4iz/0uzXiMqBGidzTkaceVfRi2wzqHZbE5Wg/qP5APvsSdpxm19b2V0eqhDgPrJePupj3SanZTwtwa3V+K+nRk23tbLelrXFDImcen4i6CAQZ8x+4nj1CCPTBylPbUz2Rs3mdzvXsl5yj/y+TEt+IjRHQl+ll+MXtDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301434; c=relaxed/simple;
	bh=CbGJo3fnaG0dnRvI8ahS/cX5JHOWrCA6Qvj9/K2MTY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dU9zKJKKR2515H5Xbv6JxkkcLIphnplOctlG7pV9ZIzXJel2bt0Tv0UPaQLwvhol/qJ0Y5xpRfwlL75AFwSkncd7tg4U93eGL52sd1FhN8vZKgWgfZBH/AMaCzkHpSdjAN4njG2947BaRilKRSLhdhwH6cSYTseO95/rdma40Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=D00NnSNl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742301431;
	bh=CbGJo3fnaG0dnRvI8ahS/cX5JHOWrCA6Qvj9/K2MTY8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D00NnSNlUIZ1TW/XHgDI7suSO3lILHI5JbBf1Bb09Nvs6/O5SpqX19no2TZ9BdqaT
	 dv2Y7l+VkMfei6PXdLI3FxSnABlWeM4dlM7NKq1I/4l8mEx75p2K1zRSx6Ym0kGgrb
	 oumvZs8xNe8iX3wq6ypyfM91leO1DZvyBO8XnYCb+HCLBS6sVXZyMdUgWJcZfZjSTl
	 VqHC8J4UYlr6kGIqI4XsZf4t+r7gAUiNrdx9BFxUkPGx4sTQSwLpbOTYZjXAsrvSXR
	 2TPiFF5Ynkyw+ItYTxwgy0mLYbHXlswP8ou2u5Izt9aVm/xzPgvO4WUnoB28czipDf
	 uuWQbx9PI9xoQ==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 374E117E1578;
	Tue, 18 Mar 2025 13:37:11 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 18 Mar 2025 14:35:46 +0200
Subject: [PATCH v6 12/14] phy: rockchip: samsung-hdptx: Rename ambiguous
 rk_hdptx_phy->rate
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-phy-sam-hdptx-bpc-v6-12-8cb1678e7663@collabora.com>
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

The main purpose of the ->rate member of struct rk_hdptx_phy is to
implement rk_hdptx_phy_clk_recalc_rate() by providing the actual rate
programmed in hardware.  Hence the current naming is too generic and
rather ambiguous.

Improve clarity by renaming ->rate to ->hw_rate.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 2feb46f6d4e5bd2f43140e465cc25d2b0c363df4..a19a89233d808e2b38f6e7e58a1dc38ddd7cadd3 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -401,7 +401,7 @@ struct rk_hdptx_phy {
 
 	/* clk provider */
 	struct clk_hw hw;
-	unsigned long rate;
+	unsigned long hw_rate;
 	bool restrict_rate_change;
 
 	atomic_t usage_count;
@@ -1030,7 +1030,7 @@ static int rk_hdptx_ropll_tmds_cmn_config(struct rk_hdptx_phy *hdptx,
 
 	ret = rk_hdptx_post_enable_pll(hdptx);
 	if (!ret)
-		hdptx->rate = rate;
+		hdptx->hw_rate = rate;
 
 	return ret;
 }
@@ -1830,7 +1830,7 @@ static int rk_hdptx_phy_clk_prepare(struct clk_hw *hw)
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
-	return rk_hdptx_phy_consumer_get(hdptx, hdptx->rate);
+	return rk_hdptx_phy_consumer_get(hdptx, hdptx->hw_rate);
 }
 
 static void rk_hdptx_phy_clk_unprepare(struct clk_hw *hw)
@@ -1845,7 +1845,7 @@ static unsigned long rk_hdptx_phy_clk_recalc_rate(struct clk_hw *hw,
 {
 	struct rk_hdptx_phy *hdptx = to_rk_hdptx_phy(hw);
 
-	return hdptx->rate;
+	return hdptx->hw_rate;
 }
 
 static long rk_hdptx_phy_clk_round_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.48.1


