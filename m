Return-Path: <linux-kernel+bounces-244297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5637B92A250
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70401F2142A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2038913E029;
	Mon,  8 Jul 2024 12:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="NganzT7N"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8E13DB8C;
	Mon,  8 Jul 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440599; cv=none; b=J4dHAshS6h/Kd5IRAoiUCvxrvAbtCvTjpkB5Yus0nmJD1VMsoo+p7nq7tXfgXltAmInO1yU1N/cxfKXHOzmpoAPbtqhHsfdQerc5PHKOW3dtZ8SScOI5+SHwoJEHXFq/t1Fw9PHnAU/BU0bv/IeCHSFme4CvxnTTHPAA9O/XMKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440599; c=relaxed/simple;
	bh=GKh2e7qWA5HsZ7T0GUHBoY32vMBZY1omyDv7U9SNINk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ue1c97Kojt0+oNvdZHwrdH/XvQrn1VnUO8LB5nJD1WEm8OLykODBHsDenYMNmEMOQGWU8QwP9CQ31zkWKpvEY/PFgliFFLuNirzzLsIzRR1LbDoKk/8UoYEqOe4V+H9jlHYKrs3UH01bUTgloEOmsKYMbmcUBwkJgdUPS1SWl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=NganzT7N; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from localhost (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 896DB41830;
	Mon,  8 Jul 2024 14:09:55 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
	by localhost (disroot.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TobvjB_VNwxu; Mon,  8 Jul 2024 14:09:52 +0200 (CEST)
From: Yao Zi <ziyao@disroot.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1720440590; bh=GKh2e7qWA5HsZ7T0GUHBoY32vMBZY1omyDv7U9SNINk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NganzT7NufEAIE8f1SUQBP6m7CK+Jj5e3DISmVjHcOtihzo58wlViRJ6YiVazxp2n
	 BbekamtWZRmsJkelmtO//DPm69sMOXgxIO0y6px3cYwcSUn/gNO8/9qWA3U42lT9Df
	 kfZ117c5jwF55VXOKpKsFXe2hNGqwxWEQp55FoFoKe6RFFrCScFQVLC9izGp76c67K
	 31CLsI6uOzpikUeDhJ8/DpxQm3SDkEiVXK7ArAEqwFbarIcNhGifXCpJBDqZdzBw3K
	 6nlkjdgt89IQSNbNKy8WM/3CPkJeqDXdtFQjz+MV8AMJZwNW3jpQNYj/J6PTxYKiHh
	 LHmJBVoSoZb1g==
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jisheng Zhang <jszhang@kernel.org>,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Yao Zi <ziyao@disroot.org>
Subject: [PATCH 3/3] phy: sophgo: add usb phy driver for Sophgo CV1800 SoCs
Date: Mon,  8 Jul 2024 12:08:30 +0000
Message-ID: <20240708120830.5785-4-ziyao@disroot.org>
In-Reply-To: <20240708120830.5785-1-ziyao@disroot.org>
References: <20240708120830.5785-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new driver for USB2 phys integrated in Sophgo CV1800 and
SG200x SoCs, which have the same design.

Most CV1800/SG200x boards have broken VBUS/ID detection, so we force
ID status to be specified in the device tree. This phy also supports
charger detection, which could be implemented later.

Unfortunately, there is no description about the phy in the public
datasheet. The driver was written by reading Sophgo GPL kernel source
and dumping registers on actual SG2002 devices.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/phy/Kconfig                 |   1 +
 drivers/phy/Makefile                |   1 +
 drivers/phy/sophgo/Kconfig          |  10 ++
 drivers/phy/sophgo/Makefile         |   2 +
 drivers/phy/sophgo/phy-cv1800-usb.c | 213 ++++++++++++++++++++++++++++
 5 files changed, 227 insertions(+)
 create mode 100644 drivers/phy/sophgo/Kconfig
 create mode 100644 drivers/phy/sophgo/Makefile
 create mode 100644 drivers/phy/sophgo/phy-cv1800-usb.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 787354b849c7..596b37ab3191 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -92,6 +92,7 @@ source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/samsung/Kconfig"
 source "drivers/phy/socionext/Kconfig"
+source "drivers/phy/sophgo/Kconfig"
 source "drivers/phy/st/Kconfig"
 source "drivers/phy/starfive/Kconfig"
 source "drivers/phy/sunplus/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 868a220ed0f6..7ff32f0ae08a 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -31,6 +31,7 @@ obj-y					+= allwinner/	\
 					   rockchip/	\
 					   samsung/	\
 					   socionext/	\
+					   sophgo/	\
 					   st/		\
 					   starfive/	\
 					   sunplus/	\
diff --git a/drivers/phy/sophgo/Kconfig b/drivers/phy/sophgo/Kconfig
new file mode 100644
index 000000000000..6feb5795f1fc
--- /dev/null
+++ b/drivers/phy/sophgo/Kconfig
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config PHY_SOPHGO_CV1800_USB
+	tristate "SOPHGO CV1800 USB 2.0 PHY driver"
+	depends on OF && (ARCH_SOPHGO || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable this to support the USB 2.0 PHY on Sophgo CV1800
+	  and SG200x SoCs.
+	  If unsure, say N.
diff --git a/drivers/phy/sophgo/Makefile b/drivers/phy/sophgo/Makefile
new file mode 100644
index 000000000000..b4b9de0697e7
--- /dev/null
+++ b/drivers/phy/sophgo/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_PHY_SOPHGO_CV1800_USB)	+= phy-cv1800-usb.o
diff --git a/drivers/phy/sophgo/phy-cv1800-usb.c b/drivers/phy/sophgo/phy-cv1800-usb.c
new file mode 100644
index 000000000000..873c72bd95cf
--- /dev/null
+++ b/drivers/phy/sophgo/phy-cv1800-usb.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * USB PHY driver for Sophgo CV1800 SoCs.
+ *
+ * Copyright 2024 Yao Zi <ziyao@disroot.org>
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/phy/phy.h>
+
+#define CV1800_REG04				0x04
+#define CV1800_REG14				0x14
+#define  CV1800_REG14_UTMI_OVERRIDE		BIT(0)
+#define  CV1800_REG14_OPMODE_MASK		(0x3 << 1)
+#define  CV1800_REG14_OPMODE_SHIFT		1
+#define  CV1800_REG14_XCVRSEL_MASK		(0x3 << 3)
+#define  CV1800_REG14_XCVRSEL_SHIFT		3
+#define  CV1800_REG14_TERMSEL			BIT(5)
+#define  CV1800_REG14_DPPULLDOWN		BIT(6)
+#define  CV1800_REG14_DMPULLDOWN		BIT(7)
+#define  CV1800_REG14_UTMI_RESET		BIT(8)
+#define CV1800_REG20				0x20
+#define  CV1800_REG20_BC_EN			BIT(0)
+#define  CV1800_REG20_DCD_EN			BIT(1)
+#define  CV1800_REG20_DP_CMP_EN			BIT(2)
+#define  CV1800_REG20_DM_CMP_EN			BIT(3)
+#define  CV1800_REG20_VDP_SRC_EN		BIT(4)
+#define  CV1800_REG20_VDM_SRC_EN		BIT(5)
+#define  CV1800_REG20_CHG_DET			BIT(16)
+#define  CV1800_REG20_DP_DET			BIT(17)
+
+#define CV1800_PIN_ID_OVERWRITE_EN		BIT(6)
+#define CV1800_PIN_ID_OVERWRITE_VALUE(v)	((v) << 7)
+
+enum cv1800_usb_phy_role {
+	CV1800_USB_PHY_HOST	= 0,
+	CV1800_USB_PHY_DEVICE	= 1,
+};
+
+struct cv1800_usb_phy_priv {
+	void __iomem *regs;
+	void __iomem *pinreg;
+	struct clk *clk_apb;
+	struct clk *clk_125m;
+	struct clk *clk_33k;
+	struct clk *clk_12m;
+	enum cv1800_usb_phy_role role;
+};
+
+static void
+cv1800_usb_phy_set_role(struct cv1800_usb_phy_priv *priv,
+			enum cv1800_usb_phy_role role)
+{
+	writel(CV1800_PIN_ID_OVERWRITE_EN | CV1800_PIN_ID_OVERWRITE_VALUE(role),
+	       priv->pinreg);
+}
+
+static int cv1800_usb_phy_init(struct phy *phy)
+{
+	struct cv1800_usb_phy_priv *priv = phy_get_drvdata(phy);
+	int ret = 0;
+
+	ret = clk_prepare_enable(priv->clk_apb);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(priv->clk_125m);
+	if (ret)
+		goto err_clk_125m;
+
+	ret = clk_prepare_enable(priv->clk_33k);
+	if (ret)
+		goto err_clk_33k;
+
+	ret = clk_prepare_enable(priv->clk_12m);
+	if (ret)
+		goto err_clk_12m;
+
+	writel(0xa, priv->regs + CV1800_REG04);		/* magic number	*/
+	writel(0, priv->regs + CV1800_REG14);
+	writel(0, priv->regs + CV1800_REG20);
+
+	cv1800_usb_phy_set_role(priv, priv->role);
+
+	return 0;
+
+err_clk_12m:
+	clk_disable_unprepare(priv->clk_33k);
+err_clk_33k:
+	clk_disable_unprepare(priv->clk_125m);
+err_clk_125m:
+	clk_disable_unprepare(priv->clk_apb);
+
+	return ret;
+}
+
+static int cv1800_usb_phy_exit(struct phy *phy)
+{
+	struct cv1800_usb_phy_priv *priv = phy_get_drvdata(phy);
+
+	clk_disable_unprepare(priv->clk_33k);
+	clk_disable_unprepare(priv->clk_125m);
+	clk_disable_unprepare(priv->clk_apb);
+
+	return 0;
+}
+
+static const struct phy_ops cv1800_usb_phy_ops = {
+	.init = cv1800_usb_phy_init,
+	.exit = cv1800_usb_phy_exit,
+};
+
+static int
+cv1800b_usb_phy_parse_dt(struct cv1800_usb_phy_priv *priv, struct device *dev)
+{
+	const char *role;
+
+	if (!of_property_read_string(dev->of_node, "dr_role", &role)) {
+		if (!strcmp(role, "host")) {
+			priv->role = CV1800_USB_PHY_HOST;
+		} else if (!strcmp(role, "device")) {
+			priv->role = CV1800_USB_PHY_DEVICE;
+		} else {
+			dev_err(dev, "invalid dr_role %s", role);
+			return -EINVAL;
+		}
+	} else {
+		priv->role = CV1800_USB_PHY_DEVICE;
+	}
+
+	return 0;
+}
+
+static int cv1800_usb_phy_probe(struct platform_device *pdev)
+{
+	struct cv1800_usb_phy_priv *priv;
+	struct phy_provider *provider;
+	struct device *dev = &pdev->dev;
+	struct phy *phy;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = cv1800b_usb_phy_parse_dt(priv, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to parse dt");
+
+	priv->regs = devm_platform_ioremap_resource_byname(pdev, "phy");
+	if (IS_ERR(priv->regs))
+		return dev_err_probe(dev, PTR_ERR(priv->regs),
+				     "failed to map phy registers");
+
+	priv->pinreg = devm_platform_ioremap_resource_byname(pdev, "pin");
+	if (IS_ERR(priv->pinreg))
+		return dev_err_probe(dev, PTR_ERR(priv->pinreg),
+				     "failed to map pin register");
+
+	priv->clk_apb = devm_clk_get(dev, "apb");
+	if (IS_ERR(priv->clk_apb))
+		return dev_err_probe(dev, PTR_ERR(priv->clk_apb),
+				     "failed to get apb clock");
+
+	priv->clk_125m = devm_clk_get(dev, "125m");
+	if (IS_ERR(priv->clk_125m))
+		return dev_err_probe(dev, PTR_ERR(priv->clk_125m),
+				     "failed to get 125m clock");
+
+	priv->clk_33k = devm_clk_get(dev, "33k");
+	if (IS_ERR(priv->clk_33k))
+		return dev_err_probe(dev, PTR_ERR(priv->clk_33k),
+				     "failed to get 33k clock");
+
+	priv->clk_12m = devm_clk_get(dev, "12m");
+	if (IS_ERR(priv->clk_12m))
+		return dev_err_probe(dev, PTR_ERR(priv->clk_12m),
+				     "failed to get 12m clock");
+
+	phy = devm_phy_create(dev, NULL, &cv1800_usb_phy_ops);
+	if (IS_ERR(phy))
+		return dev_err_probe(dev, PTR_ERR(phy),
+				     "cannot create phy");
+
+	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	phy_set_drvdata(phy, priv);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id cv1800_usb_phy_of_match_table[] = {
+	{ .compatible = "sophgo,cv1800-usb-phy" },
+	{ },
+};
+
+static struct platform_driver cv1800_usb_phy_platform_driver = {
+	.driver = {
+		.name = "cv1800-usb-phy",
+		.of_match_table = cv1800_usb_phy_of_match_table,
+	},
+	.probe = cv1800_usb_phy_probe,
+};
+
+module_platform_driver(cv1800_usb_phy_platform_driver);
+
+MODULE_DESCRIPTION("Sophgo CV1800 USB PHY Driver");
+MODULE_AUTHOR("Yao Zi <ziyao@disroot.org>");
+MODULE_LICENSE("GPL");
-- 
2.45.2


