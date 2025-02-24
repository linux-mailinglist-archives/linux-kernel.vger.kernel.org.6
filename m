Return-Path: <linux-kernel+bounces-529510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C77A4272C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B53C188AC09
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 15:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862D261575;
	Mon, 24 Feb 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="AgrR/Iqz"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F71233714;
	Mon, 24 Feb 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412517; cv=none; b=JlzEy6bwNkoy9KKGoJ18jMZrE+TFtRSMHxu/9P7RN/dsCloBe9UtKvLelWynPRl4YR/uHtlA9fqgUZ4pv25s7o77BYmUpEOix7uccbGwmlC8G9wmxWE9x0qIDApdHi3LC1jHOXK3u7GKcT601K8NPRa0K13Mgqx/abtq5f4t2RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412517; c=relaxed/simple;
	bh=b7FaFj06eG3NydoTECTJkSmRx8X6pGTreLFj5Z0+02A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPbMkbWc01Oe1QPQ6h+pDh8otbjvpmNBcU7kwQCYrKFY8q/KTLGNUkZ9MnhL1LXFbOKr9iW2UCM0U3K3LpNYkhM5z8tJ3JC1WaZKaMGbOBmPVMjCEFDzKF3f9WQmDyJYmuR/GNoWw8O1AHogEYtAK80Il2KKk7nGdTfSQKTt01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=AgrR/Iqz; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id BFB271FB8C;
	Mon, 24 Feb 2025 16:55:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740412508;
	bh=lEX6XPbraoU2mAPkLBWD9pXLXIQQnoMkWm/NaiyYKYE=; h=From:To:Subject;
	b=AgrR/IqzsveuHFSqCthzpjXhoycPAzH1DuvpASASqGv6vTYTNOCHvSG3+af6HnLPR
	 iS33eekimvaeevtwksv3P/Kyrtiu/0caNoVvFUnNR9DNwlNlmEAjqiReQRBMeEbHPl
	 0XjKfjmDb/IofUPD4wdE5+ZnwJ5gHm93pMQRzyzKidRs4GTSzhjJRKmhRbyEvwQOQI
	 UVtdn2rk2msO6PGZoSHvMn+Hax6EvL2D8fbYekrDNGM+eWaSxLzTGRMUbsvm7hE8cT
	 LDJ7IJ51ieD42z0TyktzZYSaevgYQgI/JWEM5KRSwcbNTUAirE6eQducQ/e36uJadC
	 72zAF6f6407hQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	patches@opensource.cirrus.com
Cc: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH v2 4/5] ASoC: wm8904: get platform data from DT
Date: Mon, 24 Feb 2025 16:54:59 +0100
Message-Id: <20250224155500.52462-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224155500.52462-1-francesco@dolcini.it>
References: <20250224155500.52462-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>

Read in optional codec-specific properties from the device tree.

The platform_data structure is not populated when using device trees.
This change parses optional dts properties to populate it.

- wlf,in1l-as-dmicdat1
- wlf,in1r-as-dmicdat2
- wlf,gpio-cfg
- wlf,mic-cfg
- wlf,drc-cfg-regs
- wlf,drc-cfg-names
- wlf,retune-mobile-cfg-regs
- wlf,retune-mobile-cfg-names
- wlf,retune-mobile-cfg-rates

Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
v2: Fixed wm8904_parse_retune_cfg_from_of: refer to
    pdata->retune_mobile_cfgs[i].name instead of pdata->drc_cfgs[i].name
v1: https://lore.kernel.org/lkml/20250206163152.423199-5-francesco@dolcini.it/
---
 include/sound/wm8904.h    |   3 +
 sound/soc/codecs/wm8904.c | 189 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 191 insertions(+), 1 deletion(-)

diff --git a/include/sound/wm8904.h b/include/sound/wm8904.h
index 88ac1870510e..8b2c16b524f7 100644
--- a/include/sound/wm8904.h
+++ b/include/sound/wm8904.h
@@ -151,6 +151,9 @@ struct wm8904_pdata {
 	int num_retune_mobile_cfgs;
 	struct wm8904_retune_mobile_cfg *retune_mobile_cfgs;
 
+	bool in1l_as_dmicdat1;
+	bool in1r_as_dmicdat2;
+
 	u32 gpio_cfg[WM8904_GPIO_REGS];
 	u32 mic_cfg[WM8904_MIC_REGS];
 };
diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index 2082ff12d336..83cf59f6e879 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -2168,6 +2168,184 @@ static const struct of_device_id wm8904_of_match[] = {
 MODULE_DEVICE_TABLE(of, wm8904_of_match);
 #endif
 
+/**
+ * wm8904_read_cfg_reg_arr() - Reads a subarray from a DT u16 array
+ *
+ * @np: pointer to the device_node struct
+ * @regs_property: DT property of interest
+ * @size: size of subarrays within the array
+ * @idx: index of the subarray of interest
+ * @out: output
+ *
+ * Helper to read a subarray from a DT uint16-array,
+ *  divided into equally sized arrays of size `size`
+ *
+ * Subset starts at `idx * size` and is of size `size`
+ *
+ * Return: 0 on success, negative error code otherwise
+ */
+static int wm8904_read_cfg_reg_arr(const struct device_node *np,
+				   const char * const regs_property,
+				   int size, int idx,
+				   u16 * const out)
+{
+	int i, offset, ret;
+
+	offset = idx * size;
+
+	for (i = 0; i < size; i++) {
+		ret = of_property_read_u16_index(np, regs_property, i + offset, &out[i]);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
+static int wm8904_parse_retune_cfg_regs(const struct device_node *np,
+					struct wm8904_pdata *pdata, int cfg_idx)
+{
+	return wm8904_read_cfg_reg_arr(np, "wlf,retune-mobile-cfg-regs",
+				       WM8904_EQ_REGS, cfg_idx,
+				       &pdata->retune_mobile_cfgs[cfg_idx].regs[0]);
+}
+
+static int wm8904_parse_drc_cfg_regs(const struct device_node *np,
+				     struct wm8904_pdata *pdata, int cfg_idx)
+{
+	return wm8904_read_cfg_reg_arr(np, "wlf,drc-cfg-regs",
+				       WM8904_DRC_REGS, cfg_idx,
+				       &pdata->drc_cfgs[cfg_idx].regs[0]);
+}
+
+static int wm8904_parse_drc_cfg_from_of(struct i2c_client *i2c,
+					struct wm8904_pdata *pdata)
+{
+	const struct device_node *np = i2c->dev.of_node;
+	int i, n_cfgs;
+
+	n_cfgs = of_property_count_strings(np, "wlf,drc-cfg-names");
+	if (n_cfgs == -EINVAL)
+		return 0;
+
+	if (n_cfgs <= 0) {
+		dev_err(&i2c->dev, "Could not get wlf,drc-cfg-names length: %d",
+			n_cfgs);
+		return n_cfgs;
+	}
+
+	pdata->drc_cfgs = devm_kzalloc(&i2c->dev,
+				       n_cfgs * sizeof(struct wm8904_drc_cfg),
+				       GFP_KERNEL);
+	if (!pdata->drc_cfgs)
+		return -ENOMEM;
+
+	for (i = 0; i < n_cfgs; i++) {
+		if (wm8904_parse_drc_cfg_regs(np, pdata, i)) {
+			dev_err(&i2c->dev,
+				"Invalid 'wlf,drc-cfg-regs[%i,:]'\n", i);
+			return -EINVAL;
+		}
+
+		if (of_property_read_string_index(np, "wlf,drc-cfg-names", i,
+						  &pdata->drc_cfgs[i].name)) {
+			dev_err(&i2c->dev,
+				"Invalid 'wlf,drc-cfg-names[%i]'\n", i);
+			return -EINVAL;
+		}
+	}
+
+	pdata->num_drc_cfgs = n_cfgs;
+	return 0;
+}
+
+static int wm8904_parse_retune_cfg_from_of(struct i2c_client *i2c,
+					   struct wm8904_pdata *pdata)
+{
+	const struct device_node *np = i2c->dev.of_node;
+	int i, n_cfgs;
+
+	n_cfgs = of_property_count_strings(np, "wlf,retune-mobile-cfg-names");
+	if (n_cfgs == -EINVAL)
+		return 0;
+
+	if (n_cfgs <= 0) {
+		dev_err(&i2c->dev,
+			"Could not get wlf,retune-mobile-cfg-names length: %d",
+			n_cfgs);
+		return n_cfgs;
+	}
+
+	pdata->retune_mobile_cfgs = devm_kzalloc(&i2c->dev,
+						 n_cfgs * sizeof(struct wm8904_retune_mobile_cfg),
+						 GFP_KERNEL);
+	if (!pdata->retune_mobile_cfgs)
+		return -ENOMEM;
+
+	for (i = 0; i < n_cfgs; i++) {
+		if (wm8904_parse_retune_cfg_regs(np, pdata, i)) {
+			dev_err(&i2c->dev,
+				"Invalid 'wlf,retune-mobile-cfg-regs[%i,:]'\n", i);
+			return -EINVAL;
+		}
+
+		if (of_property_read_u32_index(np, "wlf,retune-mobile-cfg-rates", i,
+					       &pdata->retune_mobile_cfgs[i].rate)) {
+			dev_err(&i2c->dev,
+				"Invalid 'wlf,retune-mobile-cfg-rates[%i]'\n", i);
+			return -EINVAL;
+		}
+
+		if (of_property_read_string_index(np, "wlf,retune-mobile-cfg-names", i,
+						  &pdata->retune_mobile_cfgs[i].name)) {
+			dev_err(&i2c->dev,
+				"Invalid 'wlf,retune-mobile-cfg-names[%i]'\n", i);
+			return -EINVAL;
+		}
+	}
+
+	pdata->num_retune_mobile_cfgs = n_cfgs;
+	return 0;
+}
+
+static int wm8904_set_pdata_from_of(struct i2c_client *i2c,
+				    struct wm8904_priv *wm8904)
+{
+	const struct device_node *np = i2c->dev.of_node;
+	struct wm8904_pdata *pdata;
+	int ret, i;
+
+	pdata = devm_kzalloc(&i2c->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
+
+	pdata->in1l_as_dmicdat1 =
+		of_property_read_bool(np, "wlf,in1l-as-dmicdat1");
+
+	pdata->in1r_as_dmicdat2 =
+		of_property_read_bool(np, "wlf,in1r-as-dmicdat2");
+
+	/* If absent, default to 0xFFFF for GPIO config (i.e.: don't set) */
+	for (i = 0; i < WM8904_GPIO_REGS; i++)
+		pdata->gpio_cfg[i] = 0xFFFF;
+
+	of_property_read_u32_array(np, "wlf,gpio-cfg", pdata->gpio_cfg,
+				   ARRAY_SIZE(pdata->gpio_cfg));
+
+	of_property_read_u32_array(np, "wlf,mic-cfg", pdata->mic_cfg,
+				   ARRAY_SIZE(pdata->mic_cfg));
+
+	ret = wm8904_parse_drc_cfg_from_of(i2c, pdata);
+	if (ret)
+		return ret;
+
+	ret = wm8904_parse_retune_cfg_from_of(i2c, pdata);
+	if (ret)
+		return ret;
+
+	wm8904->pdata = pdata;
+	return 0;
+}
+
 static const struct i2c_device_id wm8904_i2c_id[];
 
 static int wm8904_i2c_probe(struct i2c_client *i2c)
@@ -2199,7 +2377,16 @@ static int wm8904_i2c_probe(struct i2c_client *i2c)
 	wm8904->devtype = (uintptr_t)i2c_get_match_data(i2c);
 
 	i2c_set_clientdata(i2c, wm8904);
-	wm8904->pdata = i2c->dev.platform_data;
+
+	if (i2c->dev.of_node) {
+		ret = wm8904_set_pdata_from_of(i2c, wm8904);
+		if (ret) {
+			dev_err(&i2c->dev, "Failed to set platform data from of: %d\n", ret);
+			return ret;
+		}
+	} else {
+		wm8904->pdata = i2c->dev.platform_data;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(wm8904->supplies); i++)
 		wm8904->supplies[i].supply = wm8904_supply_names[i];
-- 
2.39.5


