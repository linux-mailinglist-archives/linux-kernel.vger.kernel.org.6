Return-Path: <linux-kernel+bounces-568166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 052D4A68EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC0D427213
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E382B1D61B7;
	Wed, 19 Mar 2025 14:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="YqknWWQ+"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C031A4F0A;
	Wed, 19 Mar 2025 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394072; cv=none; b=lHGNKs6bfA2B76W/c+wH3L7mWtZSgSJqcS3ygMZymKee1HVMFzRb90u3dyhviL8roXivB7as1w9m0pqn3PI9DopM6KgFDuPk77+3eBUzOf8Te5pllY5hDUQCYxg7IKS5PnZBLQXDJPBBzdgzAKmrtNcYBxQkC3uWY02e2FSgxpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394072; c=relaxed/simple;
	bh=eJYjEqu12vr4aDjsHfJ1zkzh+1jhpt8qD8BFTNZ1Y7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dr3lQ4Z4XSW4gcpKKRSX2aZO1/w7apaIHzjg7AzD6kiwG2vZrbS0PJxdGBqYv3U/6e6ZkKLv2wGh2iNF5leKFQTwvniDrVr26+LkF/zGyLNZQkJeFnJoFhAGY/3jF4+xyNdnTJFeK1J0Xc2JXhHsKPtnSIqRIFW4MEXjLVpJkck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=YqknWWQ+; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 54A2723523;
	Wed, 19 Mar 2025 15:21:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742394067;
	bh=jkvfjPSrD11uByR00Ulclu2RX59e/7NrLBIItbOwwHM=; h=From:To:Subject;
	b=YqknWWQ+oiCpkrGjxdJMM2MCemJ8cUKm9B/4Iun+RtstE9rDLEQUlzdp2JRv4gLZg
	 vjaHmahDWGHMa6SoexFRfWMBFN+niRi7V6X+bEzt1JMkGCoNWSZ2j+Sw08e4kmI4yU
	 gL3vpfjI7lqJHNz6iiuvzegr1XMw+Qn6PJ2xZLQKimBDHSKHrDs95JY5uOsZ4phDHd
	 +EkLiIHCGMT+M4xdgBd+xapQJ/PYqRVnEj/j3tWuCb6+yKmh7lFMol3MlSKwgkosSI
	 YF4JMH4r3wcHWXWSFJNSUzR7OPaBLZG/r4TU1QcrY82GXuAPC8ppnR26w8MuzXxXCD
	 ZG5+cBiZ7TO0Q==
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
Subject: [PATCH v4 4/5] ASoC: wm8904: get platform data from DT
Date: Wed, 19 Mar 2025 15:20:58 +0100
Message-Id: <20250319142059.46692-5-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319142059.46692-1-francesco@dolcini.it>
References: <20250319142059.46692-1-francesco@dolcini.it>
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
- wlf,micbias-cfg
- wlf,drc-cfg-regs
- wlf,drc-cfg-names
- wlf,retune-mobile-cfg-regs
- wlf,retune-mobile-cfg-names
- wlf,retune-mobile-cfg-hz

Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
v4: Renamed "wlf,mic-cfg" to "wlf,micbias-cfg"
v3: Renamed "wlf,retune-mobile-cfg-rates" to "wlf,retune-mobile-cfg-hz"
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
index 2082ff12d336..bac54c8e45a9 100644
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
+		if (of_property_read_u32_index(np, "wlf,retune-mobile-cfg-hz", i,
+					       &pdata->retune_mobile_cfgs[i].rate)) {
+			dev_err(&i2c->dev,
+				"Invalid 'wlf,retune-mobile-cfg-hz[%i]'\n", i);
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
+	of_property_read_u32_array(np, "wlf,micbias-cfg", pdata->mic_cfg,
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


