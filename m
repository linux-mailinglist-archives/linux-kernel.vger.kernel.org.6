Return-Path: <linux-kernel+bounces-569993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786E4A6AA89
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436F31728E8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D12226CF7;
	Thu, 20 Mar 2025 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CzsG3UQ3"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB522576E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486448; cv=none; b=CMrVDhdk/9OYFqwHj71QW13y0YTBZwHllvZh1QqPI7GmonKPZrOpCeJDE1rN7SZsir94cKepCEKS0XuWBj2ZDf2qA1x0Q4kU8cx17Mu4DwIN2rAnyyFtrfrEN0ffM74NoZRFW4/wqOljaRZ4oYGPJNe+UnD7J8949prXB+Arysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486448; c=relaxed/simple;
	bh=c1oUALt2KZgajaeiEy/9OAK/9/j14NZ5nS73HsxdZOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W7YconKKxkHQFxK7552DJ9bmM2fJvEvXOSYhPnMjiQDW1A70H+vssdPcPapAiRa+i2MEP64oissWNt91wxa0cuOmcNUMT8qU32d+A6wjrPbE1pCtO3IkYWF2WKGMqtyXhaxtc0sxSIFErqFsi3A9IqW40NPa1mnd726DmB+9ODU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=CzsG3UQ3; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C4DC211D9;
	Thu, 20 Mar 2025 16:58:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742486332;
	bh=c1oUALt2KZgajaeiEy/9OAK/9/j14NZ5nS73HsxdZOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CzsG3UQ3P+BFjeqjvNttXI1wQZV9UVcYua46Bv9y5moC+fnyiWZ2m+E0BM8LyWkNL
	 0nVmHfF3YZ9jLMVFVNv/2ah4mRPmajdqUA1ycz+yoXL6Sop+eMvPqZopiG/2aQfztF
	 mayEFlT4oW4VvMl3wWcO8Ls3xikcnGupsww8ools=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 20 Mar 2025 18:00:00 +0200
Subject: [PATCH 05/18] phy: cdns-dphy: Remove leftover code
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-cdns-dsi-impro-v1-5-725277c5f43b@ideasonboard.com>
References: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
In-Reply-To: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=c1oUALt2KZgajaeiEy/9OAK/9/j14NZ5nS73HsxdZOA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn3DuXfrbZgb5HrB7SFJHZvRCd5XaWzMnIWXgYf
 iBzaJo2AZaJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ9w7lwAKCRD6PaqMvJYe
 9QYnD/9SaANQrGkZJO7Zmwlo0W7xTjRHCWOhTeqcEynVVwMAO+RVr0kriNrx5BwgX6n+YAtJv6o
 RT70WTwbL4JWMjhRLvsPkyXU6qrURFb/B3NEzVPkQRBfn8CTY5ZQ+YOHlQj2pig5U7gOVhrvWHU
 frqxUuO7DcNFF9C4LeMH6jn49tAYjU3qpkOxuRFcUt3oAZRAIDbMUhM0VTIpFQiMF9RncNysBNC
 JAYul/Uk7YN83kA8ghEWZBJqYanUlpALW2slT7VH6T7gEMQhxhs44NjVO3SAccOS9nHdGgMQt2Q
 IHsksmPUGQvhTNJxZGMogeBLnJKJztkhRstSn0AYqcyGjOkVM2vkSVXfGyN1V8KJC/XKd6hrNuR
 EM8jujdmT9FW2eDPWRagHRQEQiPX+1wZhCJHKeHv2+l80JNiWBRwnNGJ8MNp10DNgI3B94fy+0Y
 Fd51034Ze7gBiej00SmxqhX6CMW37U/a+ORgFUGKW+bO3GjMTnP/hkYqsI6MRaNWxG3B/Yt+F/D
 FErSRtSNFvEbqOYIW/8Vfqvu7MxJGlUq50uYo24RnQ+l91eykgZ3eleigcx3M0e16Yl+BHDlQAT
 E6jkzLLd66EKOGbSOeu2vgqYBez8E+GbmuG2PN/YPzWje7F26fsIimCTLUE8CkudCzFeJLIJGa/
 jEuKCgGoINUTRtQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The code in cdns-dphy has probably been part of a DSI driver in the
past. Remove DSI defines and variables which are not used or do not
actually do anything. Also rename cdns_dsi_get_dphy_pll_cfg() to
cdns_get_dphy_pll_cfg(), i.e. drop the "dsi", as it's not relevant here.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/phy/cadence/cdns-dphy.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index f79ec4fab409..7f8b70ec10c5 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -55,14 +55,6 @@
 #define DPHY_PSM_CFG_FROM_REG		BIT(0)
 #define DPHY_PSM_CLK_DIV(x)		((x) << 1)
 
-#define DSI_HBP_FRAME_OVERHEAD		12
-#define DSI_HSA_FRAME_OVERHEAD		14
-#define DSI_HFP_FRAME_OVERHEAD		6
-#define DSI_HSS_VSS_VSE_FRAME_OVERHEAD	4
-#define DSI_BLANKING_FRAME_OVERHEAD	6
-#define DSI_NULL_FRAME_OVERHEAD		6
-#define DSI_EOT_PKT_SIZE		4
-
 #define DPHY_TX_J721E_WIZ_PLL_CTRL	0xF04
 #define DPHY_TX_J721E_WIZ_STATUS	0xF08
 #define DPHY_TX_J721E_WIZ_RST_CTRL	0xF0C
@@ -117,10 +109,9 @@ static const unsigned int tx_bands[] = {
 	870, 950, 1000, 1200, 1400, 1600, 1800, 2000, 2200, 2500
 };
 
-static int cdns_dsi_get_dphy_pll_cfg(struct cdns_dphy *dphy,
-				     struct cdns_dphy_cfg *cfg,
-				     struct phy_configure_opts_mipi_dphy *opts,
-				     unsigned int *dsi_hfp_ext)
+static int cdns_get_dphy_pll_cfg(struct cdns_dphy *dphy,
+				 struct cdns_dphy_cfg *cfg,
+				 struct phy_configure_opts_mipi_dphy *opts)
 {
 	unsigned long pll_ref_hz = clk_get_rate(dphy->pll_ref_clk);
 	u64 dlane_bps;
@@ -289,15 +280,13 @@ static int cdns_dphy_config_from_opts(struct phy *phy,
 				      struct cdns_dphy_cfg *cfg)
 {
 	struct cdns_dphy *dphy = phy_get_drvdata(phy);
-	unsigned int dsi_hfp_ext = 0;
 	int ret;
 
 	ret = phy_mipi_dphy_config_validate(opts);
 	if (ret)
 		return ret;
 
-	ret = cdns_dsi_get_dphy_pll_cfg(dphy, cfg,
-					opts, &dsi_hfp_ext);
+	ret = cdns_get_dphy_pll_cfg(dphy, cfg, opts);
 	if (ret)
 		return ret;
 

-- 
2.43.0


