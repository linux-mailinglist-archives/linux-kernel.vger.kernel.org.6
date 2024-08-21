Return-Path: <linux-kernel+bounces-295059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34AFF959630
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 09:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3FE1B20B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AEB1A7ADF;
	Wed, 21 Aug 2024 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="bp1P0FN5"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4F11B81A8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 07:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724225894; cv=none; b=Issh2jmRslAPqUcZtYTOUMdx0BSZic2NhxCVIiuoZpDHalHjvCWZYGbal4heJ693FNE3JMKVYCK8U+f8WOxTZIHN+vTi4kcnl5UynunS5v9fRuSHvoR+Ew2gw24Iac6/jYQEZUh9cRKSfh8nHY/SHavREdlsnX2Ng7hxQS/12tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724225894; c=relaxed/simple;
	bh=cPNbpo4xoTZL2kQ8hIYKReFw9js7LB0aHS1cjVBN5SA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uv7t7CvsGBnSazMOnCortkPu2w1gdD5xCCe9totkucAzo57jdtB9sNGJ2pFWoov2u2MfXwRWvPcZmuyk9Fz6R/PCoCKtlxAQh8jtuvEv3WVNK+A6awwOx4iOoT3LgOdR/CWqJgxrbYPTwSqzWIj81tD6OIphguVTBQU5cxhpBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=bp1P0FN5; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1724225882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RT+xNvS91oUZmgrFm0whaj9pHE06IUbxucr47hS+SAk=;
	b=bp1P0FN5SUbljLV+qPoyYshQdGr/Ss6zbzGvldDpeAR8Jpt12GZE6QZBne6UW7v0kHgVC6
	NbEGsn51h972eBdHe8U7An8hbzoba85u0W/jdAm9GFy8nZ2bHpr7H8trpBg1nlzjDdiUE3
	psAMVGJ8kjOCiSXw4N9GjCD00aY8d7yx2u3Yob2/Alp1+tEHxeHZDtuQfAIMsSfgbD14KB
	LaZuMUy4bV5ZT8Y4XV3WJ2s18NrGGuzsbwUK0XKeZJ3aIl6UnvRQTiutL1l5xzsfMf6wQw
	Loqs8M+BagMZvzcUg3KAHSCemT0XWOj1qLTuTfGV67hktM9QlC5q9uVQgJUrZQ==
To: linux-rockchip@lists.infradead.org,
	linux-phy@lists.infradead.org
Cc: vkoul@kernel.org,
	kishon@kernel.org,
	heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] phy: phy-rockchip-inno-usb2: Perform trivial code cleanups
Date: Wed, 21 Aug 2024 09:37:53 +0200
Message-Id: <14167d6b025e18d2a06ee429feea6551ef6f9c44.1724225528.git.dsimic@manjaro.org>
In-Reply-To: <cover.1724225528.git.dsimic@manjaro.org>
References: <cover.1724225528.git.dsimic@manjaro.org>
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

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 27 +++++++------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 4f71373ae6e1..113bfc717ff0 100644
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
@@ -445,7 +445,6 @@ static int rockchip_usb2phy_extcon_register(struct rockchip_usb2phy *rphy)
 	}
 
 	rphy->edev = edev;
-
 	return 0;
 }
 
@@ -1327,21 +1326,19 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
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
@@ -1358,16 +1355,14 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
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
@@ -1386,8 +1381,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* find out a proper config which can be matched with dt. */
-	index = 0;
+	/* find a proper config that can be matched with the DT */
 	do {
 		if (phy_cfgs[index].reg == reg) {
 			rphy->phy_cfg = &phy_cfgs[index];
@@ -1407,10 +1401,9 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		return PTR_ERR(rphy->phy_reset);
 
 	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
-	if (IS_ERR(rphy->clk)) {
+	if (IS_ERR(rphy->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
 				     "failed to get phyclk\n");
-	}
 
 	ret = rockchip_usb2phy_clk480m_register(rphy);
 	if (ret) {
@@ -1446,13 +1439,11 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
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

