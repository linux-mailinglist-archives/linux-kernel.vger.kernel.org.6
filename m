Return-Path: <linux-kernel+bounces-553292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D86A586FF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A1C188B93E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F5620297A;
	Sun,  9 Mar 2025 18:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SJ7UHoVA"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F94415749F;
	Sun,  9 Mar 2025 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544172; cv=none; b=S4CxLKrh2Tz099Xk1Q0gKxHbHU+rXDRhz6yN0iqxzQlncyluHyjci/1l5AsvrSIZeLv1u3Hnx17uZ9nc3Ddsg5WVuTQ7uvclPpdKq1Q2uS8qEqm7VhI4QUeUlPHs+tra5zXbA7dK+kCdtrMcsfE5j91NmvQTJXdDJg9S3yxFlkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544172; c=relaxed/simple;
	bh=9Cw9pH0E/0u5mhZa5vKtWbIwnm9L19xrVFWZjmEXbwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4GDq8V0/F1gvTF/KISrwMpD5m/CQOSNB/qqgin6mmZ7ZwIrFFg4eSSjRjbUzNx2HZ7SJiolM7UwSfuTZMsvGYCxKqozrNq3xkGsznMQC6IPRs7iUAtMcsY6rDDdyMRylUOKzbr77oPtVD3n6HHmHi2NEkx6JxyLE/eXxsgFIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SJ7UHoVA; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 6C7C9120006;
	Sun,  9 Mar 2025 21:16:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6C7C9120006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544167;
	bh=sgZ5TA0paPDH75/eNcrHtc6x37F89OMtaKXUAsxSe4o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=SJ7UHoVAqJojzSa1EPwkkVJy4LYKnHEBWgcTvr4MaO3d1TdfLJC/U7kUXAlAVLNtD
	 lijI1pJScsd1mqWNLcda99/PYaUkHZJckRG9OImLNvSpaqL/TaqBUx0ZJUguNvCRal
	 aeZz5Z9ZAZF+kMJPtO+NV3cWzqI0MxjIg2k/pKcuiCa9HMJvkxEijqkar/G0MosGxE
	 0e0GbRIsmaI+6nyCOOetCCtUDnssH30RCsSIBC39Esv6ye1/xn5jyWtxfY4ru9f4hn
	 UYrtuJTWul63uaknesGoC44mjEDIMdMlNPMuDT3FDx80850n70p8GZJoq8uypkykcG
	 tCxPwW4Qdceag==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:16:07 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman
	<khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Takashi Iwai
	<tiwai@suse.com>
Subject: [PATCH v2 2/4] ASoC: meson: g12a-toacodec: drop the definition of bits
Date: Sun, 9 Mar 2025 21:15:58 +0300
Message-ID: <20250309181600.1322701-3-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309181600.1322701-1-jan.dakinevich@salutedevices.com>
References: <20250309181600.1322701-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191599 [Mar 09 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/03/09 17:18:00
X-KSMG-LinksScanning: Clean, bases: 2025/03/09 17:18:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

There are many of defines, but several of them are unused, other are
used once. It would easier to read if these values would occure in the
place of their usage.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
Also, there was an another attempt to rework bits' definition:

    https://lore.kernel.org/all/20240325235311.411920-1-jan.dakinevich@salutedevices.com/
---
 sound/soc/meson/g12a-toacodec.c | 45 ++++++++-------------------------
 1 file changed, 10 insertions(+), 35 deletions(-)

diff --git a/sound/soc/meson/g12a-toacodec.c b/sound/soc/meson/g12a-toacodec.c
index 531bb8707a3e..03bde8d8d192 100644
--- a/sound/soc/meson/g12a-toacodec.c
+++ b/sound/soc/meson/g12a-toacodec.c
@@ -20,26 +20,6 @@
 #define G12A_TOACODEC_DRV_NAME "g12a-toacodec"
 
 #define TOACODEC_CTRL0			0x0
-#define  CTRL0_ENABLE_SHIFT		31
-#define  CTRL0_DAT_SEL_SM1_MSB		19
-#define  CTRL0_DAT_SEL_SM1_LSB		18
-#define  CTRL0_DAT_SEL_MSB		15
-#define  CTRL0_DAT_SEL_LSB		14
-#define  CTRL0_LANE_SEL_SM1		16
-#define  CTRL0_LANE_SEL			12
-#define  CTRL0_LRCLK_SEL_SM1_MSB	14
-#define  CTRL0_LRCLK_SEL_SM1_LSB	12
-#define  CTRL0_LRCLK_SEL_MSB		9
-#define  CTRL0_LRCLK_SEL_LSB		8
-#define  CTRL0_LRCLK_INV_SM1		BIT(10)
-#define  CTRL0_BLK_CAP_INV_SM1		BIT(9)
-#define  CTRL0_BLK_CAP_INV		BIT(7)
-#define  CTRL0_BCLK_O_INV_SM1		BIT(8)
-#define  CTRL0_BCLK_O_INV		BIT(6)
-#define  CTRL0_BCLK_SEL_SM1_MSB		6
-#define  CTRL0_BCLK_SEL_MSB		5
-#define  CTRL0_BCLK_SEL_LSB		4
-#define  CTRL0_MCLK_SEL			GENMASK(2, 0)
 
 #define TOACODEC_OUT_CHMAX		2
 
@@ -69,6 +49,7 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 	struct snd_soc_dapm_context *dapm =
 		snd_soc_dapm_kcontrol_dapm(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	unsigned int mclk_sel = GENMASK(2, 0);
 	unsigned int mux, reg;
 
 	if (ucontrol->value.enumerated.item[0] >= e->items)
@@ -98,21 +79,18 @@ static int g12a_toacodec_mux_put_enum(struct snd_kcontrol *kcontrol,
 	 * source. For that, we will need regmap backed clock mux which
 	 * is a work in progress
 	 */
-	snd_soc_component_update_bits(component, e->reg,
-				      CTRL0_MCLK_SEL,
-				      FIELD_PREP(CTRL0_MCLK_SEL, mux));
+	snd_soc_component_update_bits(component, e->reg, mclk_sel,
+				      FIELD_PREP(mclk_sel, mux));
 
 	snd_soc_dapm_mux_update_power(dapm, kcontrol, mux, e, NULL);
 
 	return 1;
 }
 
-static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0,
-			    CTRL0_DAT_SEL_LSB,
+static SOC_ENUM_SINGLE_DECL(g12a_toacodec_mux_enum, TOACODEC_CTRL0, 14,
 			    g12a_toacodec_mux_texts);
 
-static SOC_ENUM_SINGLE_DECL(sm1_toacodec_mux_enum, TOACODEC_CTRL0,
-			    CTRL0_DAT_SEL_SM1_LSB,
+static SOC_ENUM_SINGLE_DECL(sm1_toacodec_mux_enum, TOACODEC_CTRL0, 18,
 			    g12a_toacodec_mux_texts);
 
 static const struct snd_kcontrol_new g12a_toacodec_mux =
@@ -126,8 +104,7 @@ static const struct snd_kcontrol_new sm1_toacodec_mux =
 			  g12a_toacodec_mux_put_enum);
 
 static const struct snd_kcontrol_new g12a_toacodec_out_enable =
-	SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0,
-				    CTRL0_ENABLE_SHIFT, 1, 0);
+	SOC_DAPM_SINGLE_AUTODISABLE("Switch", TOACODEC_CTRL0, 31, 1, 0);
 
 static const struct snd_soc_dapm_widget g12a_toacodec_widgets[] = {
 	SND_SOC_DAPM_MUX("SRC", SND_SOC_NOPM, 0, 0,
@@ -209,15 +186,13 @@ static struct snd_soc_dai_driver g12a_toacodec_dai_drv[] = {
 static int g12a_toacodec_component_probe(struct snd_soc_component *c)
 {
 	/* Initialize the static clock parameters */
-	return snd_soc_component_write(c, TOACODEC_CTRL0,
-				       CTRL0_BLK_CAP_INV);
+	return snd_soc_component_write(c, TOACODEC_CTRL0, BIT(7));
 }
 
 static int sm1_toacodec_component_probe(struct snd_soc_component *c)
 {
 	/* Initialize the static clock parameters */
-	return snd_soc_component_write(c, TOACODEC_CTRL0,
-				       CTRL0_BLK_CAP_INV_SM1);
+	return snd_soc_component_write(c, TOACODEC_CTRL0, BIT(9));
 }
 
 static const struct snd_soc_dapm_route g12a_toacodec_routes[] = {
@@ -229,11 +204,11 @@ static const struct snd_soc_dapm_route g12a_toacodec_routes[] = {
 };
 
 static const struct snd_kcontrol_new g12a_toacodec_controls[] = {
-	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL, 3, 0),
+	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, 12, 3, 0),
 };
 
 static const struct snd_kcontrol_new sm1_toacodec_controls[] = {
-	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, CTRL0_LANE_SEL_SM1, 3, 0),
+	SOC_SINGLE("Lane Select", TOACODEC_CTRL0, 16, 3, 0),
 };
 
 static const struct snd_soc_component_driver g12a_toacodec_component_drv = {
-- 
2.34.1


