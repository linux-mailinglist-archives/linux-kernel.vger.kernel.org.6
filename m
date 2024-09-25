Return-Path: <linux-kernel+bounces-339274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E289861FB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76FA628D351
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D58B183CBF;
	Wed, 25 Sep 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="NSoVUjDl"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ADB183CC8;
	Wed, 25 Sep 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276031; cv=none; b=lwfchHBcWm0WM2Sq9Kmu1pVDp8A/7sIjCDR87sW1VvAFyzYXZzShCLZhsSJD5SbwcOz18Vcd4p5AxF9ZYLvfTT3lPlpH8AlVBQCsVn86s1zWvG/THSwK9u4hHp/eUx+5mWuzq29O7Oh+mjAYaNi23NTroK9wEnS41I1iiod5yaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276031; c=relaxed/simple;
	bh=NnLRXSMZzP+WyoDgL+/k5WzlKe/yJxIc3P4cwdTEcyM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OjKtUbT/Ua7ZzdFNnqSGUQH6+B5EG6MiWZF4vKFPDzY+zAUb2sOCPs5OYmIBp/bD+eH88/MuOW5ApGmfjYjj40pcKqwh4ymjxEulbyNzNDEG/jKxqpHU+8kAjTP1dSUoLZBydOnDxWy1TdR4Q89INOGvYvQ2VOWhD8h0ag6AeUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=NSoVUjDl; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 5B7B310004C;
	Wed, 25 Sep 2024 17:53:40 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 5B7B310004C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1727276020;
	bh=Mt81a0M1hcX6VZziVoaLJ0f0JP+9C+zkMUm4eRJRzlo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=NSoVUjDlGabPvR/xoO/sR0hcAKs4EWYmYUMVJ86Uk1TTBknwzi+0JMu434IXgqKbD
	 TH6hEu9/DIz9gEi77bgEa4M+FVqRnKCNC0UlWKki0SfB6BqBtKW4qXNOm9+hsxkICW
	 5lYPaG730HxK2GZIZwVKYq+iY7Dkh+qd9dL3vM7y5td8SwmyQJpa7M0hWbSjfB1CMp
	 d7gkLvPa/G4ac+G9YvV6ftrhsaHVuA/V8QbvNFmug9iKhMCExMwn0eoEV3NkcQacxw
	 U1QWFVUURKj/IZRVKURIWOjXOP5gD8a4etcHiDTJIgmJkBd0GnSSfkYZj/MVBu0azR
	 +OVFFFwAUl3bQ==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 25 Sep 2024 17:53:40 +0300 (MSK)
From: Igor Prusov <ivprusov@salutedevices.com>
Date: Wed, 25 Sep 2024 17:52:42 +0300
Subject: [PATCH v3 4/6] ASoC: codecs: Add NeoFidelity NTP8918 codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240925-ntp-amps-8918-8835-v3-4-e2459a8191a6@salutedevices.com>
References: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
In-Reply-To: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	"Mark Brown" <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Igor Prusov <ivprusov@salutedevices.com>, Philipp
 Zabel <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <kernel@salutedevices.com>,
	<prusovigor@gmail.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187980 [Sep 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;datasheetspdf.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/25 12:44:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/25 12:44:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/25 13:22:00 #26670925
X-KSMG-AntiVirus-Status: Clean, skipped

The NeoFidelity NTP8918 is a two channel amplifier with mixer and
biquad filters.

Datasheet: https://datasheetspdf.com/pdf-down/N/T/P/NTP8918-NeoFidelity.pdf
Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 sound/soc/codecs/Kconfig   |   5 +
 sound/soc/codecs/Makefile  |   2 +
 sound/soc/codecs/ntp8918.c | 397 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 404 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index a911a81caf8b3941dc4a3117290739cb6ac802d3..03eb9512d2239782faf1ed3a3315e94c9e583c53 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2568,6 +2568,11 @@ config SND_SOC_NAU8825
 config SND_SOC_NTPFW
 	tristate
 
+config SND_SOC_NTP8918
+	select SND_SOC_NTPFW
+	tristate "NeoFidelity NTP8918 amplifier"
+	depends on I2C
+
 config SND_SOC_TPA6130A2
 	tristate "Texas Instruments TPA6130A2 headphone amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 12f97fc8a9e7c410b0e8859f34b303caa677fcd2..9e72c28d193b21a0b0ac4fb3dfbaea5e4252a66c 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -189,6 +189,7 @@ snd-soc-nau8821-y := nau8821.o
 snd-soc-nau8822-y := nau8822.o
 snd-soc-nau8824-y := nau8824.o
 snd-soc-nau8825-y := nau8825.o
+snd-soc-ntp8918-y := ntp8918.o
 snd-soc-ntpfw-y := ntpfw.o
 snd-soc-hdmi-codec-y := hdmi-codec.o
 snd-soc-pcm1681-y := pcm1681.o
@@ -592,6 +593,7 @@ obj-$(CONFIG_SND_SOC_NAU8821)   += snd-soc-nau8821.o
 obj-$(CONFIG_SND_SOC_NAU8822)   += snd-soc-nau8822.o
 obj-$(CONFIG_SND_SOC_NAU8824)   += snd-soc-nau8824.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
+obj-$(CONFIG_SND_SOC_NTP8918)	+= snd-soc-ntp8918.o
 obj-$(CONFIG_SND_SOC_NTPFW)	+= snd-soc-ntpfw.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC)	+= snd-soc-hdmi-codec.o
 obj-$(CONFIG_SND_SOC_PCM1681)	+= snd-soc-pcm1681.o
diff --git a/sound/soc/codecs/ntp8918.c b/sound/soc/codecs/ntp8918.c
new file mode 100644
index 0000000000000000000000000000000000000000..0493ab6acbe4ecab23cf062333b42a95a6462562
--- /dev/null
+++ b/sound/soc/codecs/ntp8918.c
@@ -0,0 +1,397 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the NTP8918 Audio Amplifier
+ *
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Igor Prusov <ivprusov@salutedevices.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+
+#include <sound/initval.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <sound/soc-component.h>
+#include <sound/tlv.h>
+
+#include "ntpfw.h"
+
+#define NTP8918_RATES   (SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 | \
+			 SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
+
+#define NTP8918_FORMATS     (SNDRV_PCM_FMTBIT_S16_LE | \
+			     SNDRV_PCM_FMTBIT_S20_3LE | \
+			     SNDRV_PCM_FMTBIT_S24_LE | \
+			     SNDRV_PCM_FMTBIT_S32_LE)
+
+#define NTP8918_INPUT_FMT			0x0
+#define  NTP8918_INPUT_FMT_MASTER_MODE		BIT(0)
+#define  NTP8918_INPUT_FMT_GSA_MODE		BIT(1)
+#define NTP8918_GSA_FMT				0x1
+#define  NTP8918_GSA_BS_MASK			GENMASK(3, 2)
+#define  NTP8918_GSA_BS(x)			((x) << 2)
+#define  NTP8918_GSA_RIGHT_J			BIT(0)
+#define  NTP8918_GSA_LSB			BIT(1)
+#define NTP8918_MCLK_FREQ_CTRL			0x2
+#define  NTP8918_MCLK_FREQ_MCF			GENMASK(1, 0)
+#define NTP8918_MASTER_VOL			0x0C
+#define NTP8918_CHNL_A_VOL			0x17
+#define NTP8918_CHNL_B_VOL			0x18
+#define NTP8918_SOFT_MUTE			0x33
+#define  NTP8918_SOFT_MUTE_SM1			BIT(0)
+#define  NTP8918_SOFT_MUTE_SM2			BIT(1)
+#define NTP8918_PWM_SWITCH			0x34
+#define NTP8918_PWM_MASK_CTRL0			0x35
+#define REG_MAX					NTP8918_PWM_MASK_CTRL0
+
+#define NTP8918_FW_NAME		"eq_8918.bin"
+#define NTP8918_FW_MAGIC	0x38393138	/* "8918" */
+
+struct ntp8918_priv {
+	struct i2c_client *i2c;
+	struct clk *bck;
+	struct reset_control *reset;
+	unsigned int format;
+};
+
+static const DECLARE_TLV_DB_SCALE(ntp8918_master_vol_scale, -12550, 50, 0);
+
+static const struct snd_kcontrol_new ntp8918_vol_control[] = {
+	SOC_SINGLE_RANGE_TLV("Playback Volume", NTP8918_MASTER_VOL, 0,
+			     0x04, 0xff, 0, ntp8918_master_vol_scale),
+	SOC_SINGLE("Playback Switch", NTP8918_PWM_MASK_CTRL0, 1, 1, 1),
+};
+
+static void ntp8918_reset_gpio(struct ntp8918_priv *ntp8918)
+{
+	/*
+	 * Proper initialization sequence for NTP8918 amplifier requires driving
+	 * /RESET signal low during power up for at least 0.1us. The sequence is,
+	 * according to NTP8918 datasheet, 6.2 Timing Sequence 1:
+	 * Deassert for T2 >= 1ms...
+	 */
+	reset_control_deassert(ntp8918->reset);
+	fsleep(1000);
+
+	/* ...Assert for T3 >= 0.1us... */
+	reset_control_assert(ntp8918->reset);
+	fsleep(1);
+
+	/* ...Deassert, and wait for T4 >= 0.5ms before sound on sequence. */
+	reset_control_deassert(ntp8918->reset);
+	fsleep(500);
+}
+
+static const struct reg_sequence ntp8918_sound_off[] = {
+	{ NTP8918_MASTER_VOL, 0 },
+};
+
+static const struct reg_sequence ntp8918_sound_on[] = {
+	{ NTP8918_MASTER_VOL, 0b11 },
+};
+
+static int ntp8918_load_firmware(struct ntp8918_priv *ntp8918)
+{
+	int ret;
+
+	ret = ntpfw_load(ntp8918->i2c, NTP8918_FW_NAME, NTP8918_FW_MAGIC);
+	if (ret == -ENOENT) {
+		dev_warn_once(&ntp8918->i2c->dev, "Could not find firmware %s\n",
+			      NTP8918_FW_NAME);
+		return 0;
+	}
+
+	return ret;
+}
+
+static int ntp8918_snd_suspend(struct snd_soc_component *component)
+{
+	struct ntp8918_priv *ntp8918 = snd_soc_component_get_drvdata(component);
+
+	regcache_cache_only(component->regmap, true);
+
+	regmap_multi_reg_write_bypassed(component->regmap,
+					ntp8918_sound_off,
+					ARRAY_SIZE(ntp8918_sound_off));
+
+	/*
+	 * According to NTP8918 datasheet, 6.2 Timing Sequence 1:
+	 * wait after sound off for T6 >= 0.5ms
+	 */
+	fsleep(500);
+	reset_control_assert(ntp8918->reset);
+
+	regcache_mark_dirty(component->regmap);
+	clk_disable_unprepare(ntp8918->bck);
+
+	return 0;
+}
+
+static int ntp8918_snd_resume(struct snd_soc_component *component)
+{
+	struct ntp8918_priv *ntp8918 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	ret = clk_prepare_enable(ntp8918->bck);
+	if (ret)
+		return ret;
+
+	ntp8918_reset_gpio(ntp8918);
+
+	regmap_multi_reg_write_bypassed(component->regmap,
+					ntp8918_sound_on,
+					ARRAY_SIZE(ntp8918_sound_on));
+
+	ret = ntp8918_load_firmware(ntp8918);
+	if (ret) {
+		dev_err(&ntp8918->i2c->dev, "Failed to load firmware\n");
+		return ret;
+	}
+
+	regcache_cache_only(component->regmap, false);
+	snd_soc_component_cache_sync(component);
+
+	return 0;
+}
+
+static int ntp8918_probe(struct snd_soc_component *component)
+{
+	int ret;
+	struct ntp8918_priv *ntp8918 = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
+
+	ret = snd_soc_add_component_controls(component, ntp8918_vol_control,
+			ARRAY_SIZE(ntp8918_vol_control));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add controls\n");
+
+	ret = ntp8918_load_firmware(ntp8918);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to load firmware\n");
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget ntp8918_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("AIFIN", "Playback", SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_OUTPUT("OUT1"),
+	SND_SOC_DAPM_OUTPUT("OUT2"),
+};
+
+static const struct snd_soc_dapm_route ntp8918_dapm_routes[] = {
+	{ "OUT1", NULL, "AIFIN" },
+	{ "OUT2", NULL, "AIFIN" },
+};
+
+static const struct snd_soc_component_driver soc_component_ntp8918 = {
+	.probe = ntp8918_probe,
+	.suspend = ntp8918_snd_suspend,
+	.resume = ntp8918_snd_resume,
+	.dapm_widgets = ntp8918_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ntp8918_dapm_widgets),
+	.dapm_routes = ntp8918_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(ntp8918_dapm_routes),
+};
+
+static int ntp8918_hw_params(struct snd_pcm_substream *substream,
+			    struct snd_pcm_hw_params *params,
+			    struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct ntp8918_priv *ntp8918 = snd_soc_component_get_drvdata(component);
+	unsigned int input_fmt = 0;
+	unsigned int gsa_fmt = 0;
+	unsigned int gsa_fmt_mask;
+	unsigned int mcf;
+	int bclk;
+	int ret;
+
+	bclk = snd_soc_params_to_bclk(params);
+	switch (bclk) {
+	case 3072000:
+	case 2822400:
+		mcf = 0;
+		break;
+	case 6144000:
+		mcf = 1;
+		break;
+	case 2048000:
+		mcf = 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = snd_soc_component_update_bits(component, NTP8918_MCLK_FREQ_CTRL,
+					     NTP8918_MCLK_FREQ_MCF, mcf);
+	if (ret)
+		return ret;
+
+	switch (ntp8918->format) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		input_fmt |= NTP8918_INPUT_FMT_GSA_MODE;
+		gsa_fmt |= NTP8918_GSA_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		input_fmt |= NTP8918_INPUT_FMT_GSA_MODE;
+		break;
+	}
+
+	ret = snd_soc_component_update_bits(component, NTP8918_INPUT_FMT,
+					    NTP8918_INPUT_FMT_MASTER_MODE |
+					    NTP8918_INPUT_FMT_GSA_MODE,
+					    input_fmt);
+
+	if (!(input_fmt & NTP8918_INPUT_FMT_GSA_MODE) || ret < 0)
+		return ret;
+
+	switch (params_width(params)) {
+	case 24:
+		gsa_fmt |= NTP8918_GSA_BS(0);
+		break;
+	case 20:
+		gsa_fmt |= NTP8918_GSA_BS(1);
+		break;
+	case 18:
+		gsa_fmt |= NTP8918_GSA_BS(2);
+		break;
+	case 16:
+		gsa_fmt |= NTP8918_GSA_BS(3);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	gsa_fmt_mask = NTP8918_GSA_BS_MASK |
+		       NTP8918_GSA_RIGHT_J |
+		       NTP8918_GSA_LSB;
+	return snd_soc_component_update_bits(component, NTP8918_GSA_FMT,
+					     gsa_fmt_mask, gsa_fmt);
+}
+
+static int ntp8918_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	struct ntp8918_priv *ntp8918 = snd_soc_component_get_drvdata(component);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_RIGHT_J:
+	case SND_SOC_DAIFMT_LEFT_J:
+		ntp8918->format = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int ntp8918_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+	unsigned int mute_mask = NTP8918_SOFT_MUTE_SM1 |
+				 NTP8918_SOFT_MUTE_SM2;
+
+	return snd_soc_component_update_bits(dai->component, NTP8918_SOFT_MUTE,
+					     mute_mask, mute ? mute_mask : 0);
+}
+
+static const struct snd_soc_dai_ops ntp8918_dai_ops = {
+	.hw_params = ntp8918_hw_params,
+	.set_fmt = ntp8918_set_fmt,
+	.mute_stream = ntp8918_digital_mute,
+};
+
+static struct snd_soc_dai_driver ntp8918_dai = {
+	.name = "ntp8918-amplifier",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = NTP8918_RATES,
+		.formats = NTP8918_FORMATS,
+	},
+	.ops = &ntp8918_dai_ops,
+};
+
+static const struct regmap_config ntp8918_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = REG_MAX,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int ntp8918_i2c_probe(struct i2c_client *i2c)
+{
+	struct ntp8918_priv *ntp8918;
+	int ret;
+	struct regmap *regmap;
+
+	ntp8918 = devm_kzalloc(&i2c->dev, sizeof(*ntp8918), GFP_KERNEL);
+	if (!ntp8918)
+		return -ENOMEM;
+
+	ntp8918->i2c = i2c;
+
+	ntp8918->reset = devm_reset_control_get_shared(&i2c->dev, NULL);
+	if (IS_ERR(ntp8918->reset))
+		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8918->reset), "Failed to get reset\n");
+
+	dev_set_drvdata(&i2c->dev, ntp8918);
+
+	ntp8918_reset_gpio(ntp8918);
+
+	regmap = devm_regmap_init_i2c(i2c, &ntp8918_regmap);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
+				     "Failed to allocate regmap\n");
+
+	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_ntp8918,
+					      &ntp8918_dai, 1);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,
+				     "Failed to register component\n");
+
+	ntp8918->bck = devm_clk_get_enabled(&i2c->dev, "bck");
+	if (IS_ERR(ntp8918->bck))
+		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8918->bck), "failed to get bck clock\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id ntp8918_i2c_id[] = {
+	{ "ntp8918", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ntp8918_i2c_id);
+
+static const struct of_device_id ntp8918_of_match[] = {
+	{.compatible = "neofidelity,ntp8918"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, ntp8918_of_match);
+
+static struct i2c_driver ntp8918_i2c_driver = {
+	.probe = ntp8918_i2c_probe,
+	.id_table = ntp8918_i2c_id,
+	.driver = {
+		.name = "ntp8918",
+		.of_match_table = ntp8918_of_match,
+	},
+};
+module_i2c_driver(ntp8918_i2c_driver);
+
+MODULE_AUTHOR("Igor Prusov <ivprusov@salutedevices.com>");
+MODULE_DESCRIPTION("NTP8918 Audio Amplifier Driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


