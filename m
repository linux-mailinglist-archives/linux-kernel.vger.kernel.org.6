Return-Path: <linux-kernel+bounces-234873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9D791CBDE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FA551C21489
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 09:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390BB3BB25;
	Sat, 29 Jun 2024 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="O4zLoHSX"
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA83B1AC
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719652795; cv=none; b=dU9hTBwx4R+PZF7LnlqtCfRt5V94QsXU9R08DaEuIvJTvJt2ncd94vzdVpkVYP7XpKnFTToY6Q6C5Ey9oehw99C9ltej+S7qo48BcRtDUo7jIN2LpalPowkIbU+Z272dOPK0lp5eSQDWskwvtCEyXpFyl3YMD7ngNSOGCQsY0Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719652795; c=relaxed/simple;
	bh=AR/cuiqPTJDQLi2Gey2ZejTL45Qo897DCKmhdoxbNhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAy7hoYod4XOguBmK+2IVn+E6u/2qIlqx6gqBhN/hyd4aXkLo8WW6AQvLEhcpIXTMwAWWFjiSqqi1d/hd30inWxOgCf9GY5x51M1RycrDtPkd79jMkmhiZjiG8PduJGPHj/cAcSFZWwKh7MUjA8lZBratVqo2cOHlDpfm9HomCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=O4zLoHSX; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id NUF6sgiHDa7etNUFDs5cq9; Sat, 29 Jun 2024 11:19:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1719652783;
	bh=BV1I0wL1udnb3DdFseFHu4DwTEbjoNWY9BRWJUO9U+4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=O4zLoHSXsi5p0+T5JwMoe1v7kS+ChfSJrgmjcpEcg4JYndJOWiHxGOoi5PjHULZpq
	 OtMpuJr/VfTutjWv4vsVjY+1bil5EvJTFnAaKwWJ4FFvpU+WrD+25gGb2TG6cgkdnd
	 9SekrXH6RbwdJ/gDzgU0k6zy11HO+XwCzKPhYBulcNAuewKUL78gwQwGIcB5LamHh/
	 9cBFgwN2a6sqFTIulKCgPdGjXXN21pr76ACNnTeycagATvpeKw6KEnaxo05P0kE4Z3
	 FPO3Qumr+NYmV0iwGZVGG5Ye5mgjnIo+yQi8rCiABbCw2bzotsByrMK2Shw6buzUxT
	 HD6UsXdhCjirg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 29 Jun 2024 11:19:43 +0200
X-ME-IP: 86.243.222.230
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	fparent@baylibre.com,
	fchiby@baylibre.com,
	s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/4] soc: mediatek: pwrap: Use devm_clk_get_[optional_]enabled()
Date: Sat, 29 Jun 2024 11:19:32 +0200
Message-ID: <07b3745819c8ba818d4508ed12e93f14f29b80a2.1719652155.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1719652155.git.christophe.jaillet@wanadoo.fr>
References: <cover.1719652155.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_clk_get_enabled() and devm_clk_get_optional_enabled() to simplify
the code and to make sure that clk_disable_unprepare() is called if the
driver is unloaded.

Fixes: 55924157da8c ("soc: mediatek: pwrap: add support for sys & tmr clocks")
Fixes: 1f022d84bd19 ("soc: mediatek: Add PMIC wrapper for MT8135 and MT8173 SoCs")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 85 ++++++++--------------------
 1 file changed, 25 insertions(+), 60 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index d57553486383..6981d6a1ab93 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1366,10 +1366,6 @@ struct pmic_wrapper {
 	struct regmap *regmap;
 	const struct pmic_wrapper_type *master;
 	const struct pwrap_slv_type *slave;
-	struct clk *clk_spi;
-	struct clk *clk_wrap;
-	struct clk *clk_sys;
-	struct clk *clk_tmr;
 	struct reset_control *rstc;
 
 	struct reset_control *rstc_bridge;
@@ -2471,6 +2467,7 @@ static int pwrap_probe(struct platform_device *pdev)
 {
 	int ret, irq;
 	u32 mask_done;
+	struct clk *clk;
 	struct pmic_wrapper *wrp;
 	struct device_node *np = pdev->dev.of_node;
 	const struct of_device_id *of_slave_id = NULL;
@@ -2521,50 +2518,34 @@ static int pwrap_probe(struct platform_device *pdev)
 		}
 	}
 
-	wrp->clk_spi = devm_clk_get(wrp->dev, "spi");
-	if (IS_ERR(wrp->clk_spi)) {
+	clk = devm_clk_get_enabled(wrp->dev, "spi");
+	if (IS_ERR(clk)) {
 		dev_dbg(wrp->dev, "failed to get clock: %ld\n",
-			PTR_ERR(wrp->clk_spi));
-		return PTR_ERR(wrp->clk_spi);
+			PTR_ERR(clk));
+		return PTR_ERR(clk);
 	}
 
-	wrp->clk_wrap = devm_clk_get(wrp->dev, "wrap");
-	if (IS_ERR(wrp->clk_wrap)) {
+	clk = devm_clk_get_enabled(wrp->dev, "wrap");
+	if (IS_ERR(clk)) {
 		dev_dbg(wrp->dev, "failed to get clock: %ld\n",
-			PTR_ERR(wrp->clk_wrap));
-		return PTR_ERR(wrp->clk_wrap);
+			PTR_ERR(clk));
+		return PTR_ERR(clk);
 	}
 
-	wrp->clk_sys = devm_clk_get_optional(wrp->dev, "sys");
-	if (IS_ERR(wrp->clk_sys)) {
-		return dev_err_probe(wrp->dev, PTR_ERR(wrp->clk_sys),
+	clk = devm_clk_get_optional_enabled(wrp->dev, "sys");
+	if (IS_ERR(clk)) {
+		return dev_err_probe(wrp->dev, PTR_ERR(clk),
 				     "failed to get clock: %pe\n",
-				     wrp->clk_sys);
+				     clk);
 	}
 
-	wrp->clk_tmr = devm_clk_get_optional(wrp->dev, "tmr");
-	if (IS_ERR(wrp->clk_tmr)) {
-		return dev_err_probe(wrp->dev, PTR_ERR(wrp->clk_tmr),
+	clk = devm_clk_get_optional_enabled(wrp->dev, "tmr");
+	if (IS_ERR(clk)) {
+		return dev_err_probe(wrp->dev, PTR_ERR(clk),
 				     "failed to get clock: %pe\n",
-				     wrp->clk_tmr);
+				     clk);
 	}
 
-	ret = clk_prepare_enable(wrp->clk_spi);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(wrp->clk_wrap);
-	if (ret)
-		goto err_out1;
-
-	ret = clk_prepare_enable(wrp->clk_sys);
-	if (ret)
-		goto err_out2;
-
-	ret = clk_prepare_enable(wrp->clk_tmr);
-	if (ret)
-		goto err_out3;
-
 	/* Enable internal dynamic clock */
 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_DCM)) {
 		pwrap_writel(wrp, 1, PWRAP_DCM_EN);
@@ -2579,7 +2560,7 @@ static int pwrap_probe(struct platform_device *pdev)
 		ret = pwrap_init(wrp);
 		if (ret) {
 			dev_dbg(wrp->dev, "init failed with %d\n", ret);
-			goto err_out4;
+			return ret;
 		}
 	}
 
@@ -2592,8 +2573,7 @@ static int pwrap_probe(struct platform_device *pdev)
 
 	if (!(pwrap_readl(wrp, PWRAP_WACS2_RDATA) & mask_done)) {
 		dev_dbg(wrp->dev, "initialization isn't finished\n");
-		ret = -ENODEV;
-		goto err_out4;
+		return -ENODEV;
 	}
 
 	/* Initialize watchdog, may not be done by the bootloader */
@@ -2622,42 +2602,27 @@ static int pwrap_probe(struct platform_device *pdev)
 		pwrap_writel(wrp, wrp->master->int1_en_all, PWRAP_INT1_EN);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err_out2;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_irq(wrp->dev, irq, pwrap_interrupt,
 			       IRQF_TRIGGER_HIGH,
 			       "mt-pmic-pwrap", wrp);
 	if (ret)
-		goto err_out4;
+		return ret;
 
 	wrp->regmap = devm_regmap_init(wrp->dev, NULL, wrp, wrp->slave->regops->regmap);
-	if (IS_ERR(wrp->regmap)) {
-		ret = PTR_ERR(wrp->regmap);
-		goto err_out2;
-	}
+	if (IS_ERR(wrp->regmap))
+		return PTR_ERR(wrp->regmap);
 
 	ret = of_platform_populate(np, NULL, NULL, wrp->dev);
 	if (ret) {
 		dev_dbg(wrp->dev, "failed to create child devices at %pOF\n",
 				np);
-		goto err_out4;
+		return ret;
 	}
 
 	return 0;
-
-err_out4:
-	clk_disable_unprepare(wrp->clk_tmr);
-err_out3:
-	clk_disable_unprepare(wrp->clk_sys);
-err_out2:
-	clk_disable_unprepare(wrp->clk_wrap);
-err_out1:
-	clk_disable_unprepare(wrp->clk_spi);
-
-	return ret;
 }
 
 static struct platform_driver pwrap_drv = {
-- 
2.45.2


