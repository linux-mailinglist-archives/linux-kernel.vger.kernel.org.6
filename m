Return-Path: <linux-kernel+bounces-316643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBEE96D247
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858901F2A708
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D923E194C6F;
	Thu,  5 Sep 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="X+qiO3OL"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE5815531A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725525392; cv=none; b=Ajq0ExkUd9oM9T/66kSg/elj4b0YYNHqssfvJAUVa1mKUt1IqLNaCKISpKxqjFxeYg7pv/aWRNvbjO+1/e69Aecp9Y4J3WGz7/VxpIFUutXHme1Te709alrtu4NttlZV0PChzYnZUZGsHzzDlQG09OMWZjuuijt8LlCMuhbxK7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725525392; c=relaxed/simple;
	bh=xMCWb6skLMNxAQ6p+2qa4aXUaUQjIIkmb3Z0HX3qBVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GHez+tkt0y1+8pPHDJ6HDZ6vA/+YlxnVCHY/wW0+cSzjcO/ZtRkahoad/2a3ugzQFlO2FkArNPgBTwPyMwdhP7JpAf4x4jPZA+XefJskQUu8bvfj8Y8CaxYznmKOnYUEP0BGT+xC93pEKV6ynoUblNDj0Dj8Ev0TwN+7DLWW1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=X+qiO3OL; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1725524909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SILV1WrR3UJ7DyuEqQANwCR/2kJL6kyxGoyeN1ndk4g=;
	b=X+qiO3OLfCIFoKIoel6usk08EArFCMOuddZShsWxJUk7v+khYMXEclo1qkt8vvHN9uxpLP
	FMGLh93KIdh6xCTzDfTBfkXhDaYXNDZqqgyCaKf6Y3noqzZf0sFC9q4vj7TbAB/d7sc7nA
	2jP4OXEl7Oa2Osr7RsrnI4zMwc0LoM8jxhtLgDlS5NuFlvC5WvmoChil4Ibq+ZRpCaUccp
	92R+hrUAEvZIMTEv/pWNljked/yE1jsxaC9OXvJlL44ytAMtZBDWXRV2775ex/+0WlvueX
	w2jTnLjClKfYDT7FecqV/u1DBPheIHSbLWe3CHZc7cJz6ZWrDl6Mo11EJRCMvQ==
To: linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] phy: phy-rockchip-inno-usb2: Perform trivial code cleanups
Date: Thu,  5 Sep 2024 10:28:22 +0200
Message-Id: <adce7309f6fd9e1191c53bab552a8531d1a71216.1725524802.git.dsimic@manjaro.org>
In-Reply-To: <cover.1725524802.git.dsimic@manjaro.org>
References: <cover.1725524802.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Perform a few trivial code cleanups, e.g. to obey the reverse Christmas tree
rule, to avoid use of "{ ... }" code blocks where they aren't really needed,
or to avoid line wrapping by using the 100-column width better.

No intended functional changes are introduced by these code cleanups.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 26 +++++++------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 4f71373ae6e1..03b772200fed 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -418,9 +418,9 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
 
 static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
 {
-	int ret;
 	struct device_node *node = rphy->dev->of_node;
 	struct extcon_dev *edev;
+	int ret;
 
 	if (of_property_read_bool(node, "extcon")) {
 		edev = extcon_get_edev_by_phandle(rphy->dev, 0);
@@ -1327,21 +1327,19 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	struct rockchip_usb2phy *rphy;
 	const struct rockchip_usb2phy_cfg *phy_cfgs;
 	unsigned int reg;
-	int index, ret;
+	int index = 0, ret;
 
 	rphy = devm_kzalloc(dev, sizeof(*rphy), GFP_KERNEL);
 	if (!rphy)
 		return -ENOMEM;
 
 	if (!dev->parent || !dev->parent->of_node) {
 		rphy->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,usbgrf");
 		if (IS_ERR(rphy->grf)) {
 			dev_err(dev, "failed to locate usbgrf\n");
 			return PTR_ERR(rphy->grf);
 		}
-	}
-
-	else {
+	} else {
 		rphy->grf = syscon_node_to_regmap(dev->parent->of_node);
 		if (IS_ERR(rphy->grf))
 			return PTR_ERR(rphy->grf);
@@ -1358,16 +1356,14 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_u32_index(np, "reg", 0, &reg)) {
-		dev_err(dev, "the reg property is not assigned in %pOFn node\n",
-			np);
+		dev_err(dev, "the reg property is not assigned in %pOFn node\n", np);
 		return -EINVAL;
 	}
 
 	/* support address_cells=2 */
 	if (of_property_count_u32_elems(np, "reg") > 2 && reg == 0) {
 		if (of_property_read_u32_index(np, "reg", 1, &reg)) {
-			dev_err(dev, "the reg property is not assigned in %pOFn node\n",
-				np);
+			dev_err(dev, "the reg property is not assigned in %pOFn node\n", np);
 			return -EINVAL;
 		}
 	}
@@ -1386,8 +1382,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* find out a proper config which can be matched with dt. */
-	index = 0;
+	/* find a proper config that can be matched with the DT */
 	do {
 		if (phy_cfgs[index].reg == reg) {
 			rphy->phy_cfg = &phy_cfgs[index];
@@ -1407,10 +1402,9 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		return PTR_ERR(rphy->phy_reset);
 
 	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
-	if (IS_ERR(rphy->clk)) {
+	if (IS_ERR(rphy->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
 				     "failed to get phyclk\n");
-	}
 
 	ret = rockchip_usb2phy_clk480m_register(rphy);
 	if (ret) {
@@ -1446,13 +1440,11 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 		/* initialize otg/host port separately */
 		if (of_node_name_eq(child_np, "host-port")) {
-			ret = rockchip_usb2phy_host_port_init(rphy, rport,
-							      child_np);
+			ret = rockchip_usb2phy_host_port_init(rphy, rport, child_np);
 			if (ret)
 				goto put_child;
 		} else {
-			ret = rockchip_usb2phy_otg_port_init(rphy, rport,
-							     child_np);
+			ret = rockchip_usb2phy_otg_port_init(rphy, rport, child_np);
 			if (ret)
 				goto put_child;
 		}

