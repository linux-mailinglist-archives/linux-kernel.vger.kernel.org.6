Return-Path: <linux-kernel+bounces-246484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BB892C285
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 19:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 869CDB25A3A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 17:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3D118563D;
	Tue,  9 Jul 2024 17:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="BmN34fZs"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AF618002A;
	Tue,  9 Jul 2024 17:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546138; cv=none; b=sQVAajp+VMu2pmRvFlW8tlcqTRCFxfJ+6yDZqbR7uhhfUe+T+3Rx0YnluT77qi1Tv2LmoQhxMqEuztUu9zdh7HXmic2nuXdZql4Isx9g4rJY046soQMzXQXbbCiTC5CHqxXIK6X4DvImIpIzhWs5CUfb0Ah2cxO7GgbaGEkvkGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546138; c=relaxed/simple;
	bh=xjT8WW2svCMOY9fr4Kc/Wz9LwaUXQYyYK2DJ3x1om+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pToB8mJNnBIDejwkwnipP6M3ida7/FncmaiiyMOYJglNHx6/ds1UC6KsDN8ggoLcZpr925WbzSUMsWIMOg6IMIUwVeWZOS0Kz/lX6FSGiQecqyQJcJ8h+36VKwTnyjU7yroLLpM1Mknli5geI2+m5H+GmFPioajVwnlb4SYzrqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=BmN34fZs; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id AA54E100029;
	Tue,  9 Jul 2024 20:28:54 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AA54E100029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720546134;
	bh=TH9GMqEQBDvfR0/+9rnebD1UAn7nTz2hWEt091Y4gEo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=BmN34fZsFO/RQoSkPRY1+hUqdyHxPxfHO9iUYKv6lM082OncJpiiDrKMYz5RaZLlk
	 1RPvihsEK6cRwa8y9dOQKGJ9JbBLikfNf8pSbMG0XPEYKuJjC7yfl3z7SEKCv1Icf8
	 xoWHOqULWiFIXgwwz4OXM+39ZMnl9Covn6m9abfF1aY8SJayAb7FHN3++rvazfrF6r
	 7zVDzdQm217pJVpM4Un8zIWcsJC9begJqZTeT2Wu2q7TBbcZeaoiTV9OqCv6QDlslM
	 Nj0PztQ9WabFS3dkFxevmpspXscymQR57D8kK8v/QSYVxB2NbfMxn33ABaQ4XmxvZZ
	 IjIEk+scjLMwQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  9 Jul 2024 20:28:54 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jul 2024 20:28:54 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Igor Prusov
	<ivprusov@salutedevices.com>
CC: <prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] ASoC: codecs: Add NeoFidelity NTP8835 codec
Date: Tue, 9 Jul 2024 20:28:34 +0300
Message-ID: <20240709172834.9785-7-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709172834.9785-1-ivprusov@salutedevices.com>
References: <20240709172834.9785-1-ivprusov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186397 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;salutedevices.com:7.1.1;100.64.160.123:7.1.2;www.cpbay.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/09 14:24:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/09 15:33:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/09 15:25:00 #25923573
X-KSMG-AntiVirus-Status: Clean, skipped

The NeoFidelity NTP8835 adn NTP8835C are 2.1 channel amplifiers with
mixer and biquad filters. Both amplifiers have identical programming
interfaces but differ in output signal characteristics.

Datasheet: https://www.cpbay.com/Uploads/20210225/6037116a3ea91.pdf
Datasheet: https://www.cpbay.com/Uploads/20210918/61458b2f2631e.pdf
Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
---
 sound/soc/codecs/Kconfig   |   5 +
 sound/soc/codecs/Makefile  |   2 +
 sound/soc/codecs/ntp8835.c | 432 +++++++++++++++++++++++++++++++++++++
 3 files changed, 439 insertions(+)
 create mode 100644 sound/soc/codecs/ntp8835.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index d16c983fcb7a..2235727f0d41 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -2500,6 +2500,11 @@ config SND_SOC_NTP8918
 	tristate "NeoFidelity NTP8918 amplifier"
 	depends on I2C
 
+config SND_SOC_NTP8835
+	select SND_SOC_NTPFW
+	tristate "NeoFidelity NTP8835 and NTP8835C amplifiers"
+	depends on I2C
+
 config SND_SOC_TPA6130A2
 	tristate "Texas Instruments TPA6130A2 headphone amplifier"
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index a49ab11a98ec..49fc78bc631e 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -183,6 +183,7 @@ snd-soc-nau8821-y := nau8821.o
 snd-soc-nau8822-y := nau8822.o
 snd-soc-nau8824-y := nau8824.o
 snd-soc-nau8825-y := nau8825.o
+snd-soc-ntp8835-y := ntp8835.o
 snd-soc-ntp8918-y := ntp8918.o
 snd-soc-ntpfw-y := ntpfw.o
 snd-soc-hdmi-codec-y := hdmi-codec.o
@@ -577,6 +578,7 @@ obj-$(CONFIG_SND_SOC_NAU8821)   += snd-soc-nau8821.o
 obj-$(CONFIG_SND_SOC_NAU8822)   += snd-soc-nau8822.o
 obj-$(CONFIG_SND_SOC_NAU8824)   += snd-soc-nau8824.o
 obj-$(CONFIG_SND_SOC_NAU8825)   += snd-soc-nau8825.o
+obj-$(CONFIG_SND_SOC_NTP8835)	+= snd-soc-ntp8835.o
 obj-$(CONFIG_SND_SOC_NTP8918)	+= snd-soc-ntp8918.o
 obj-$(CONFIG_SND_SOC_NTPFW)	+= snd-soc-ntpfw.o
 obj-$(CONFIG_SND_SOC_HDMI_CODEC)	+= snd-soc-hdmi-codec.o
diff --git a/sound/soc/codecs/ntp8835.c b/sound/soc/codecs/ntp8835.c
new file mode 100644
index 000000000000..ec16660478c2
--- /dev/null
+++ b/sound/soc/codecs/ntp8835.c
@@ -0,0 +1,432 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the NTP8835/NTP8835C Audio Amplifiers
+ *
+ * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
+ *
+ * Author: Igor Prusov <ivprusov@salutedevices.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/bits.h>
+#include <linux/gpio.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/reset.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
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
+#define NTP8835_FORMATS     (SNDRV_PCM_FMTBIT_S16_LE | \
+			     SNDRV_PCM_FMTBIT_S20_3LE | \
+			     SNDRV_PCM_FMTBIT_S24_LE | \
+			     SNDRV_PCM_FMTBIT_S32_LE)
+
+#define NTP8835_INPUT_FMT			0x0
+#define  NTP8835_INPUT_FMT_MASTER_MODE		BIT(0)
+#define  NTP8835_INPUT_FMT_GSA_MODE		BIT(1)
+#define NTP8835_GSA_FMT				0x1
+#define  NTP8835_GSA_BS_MASK			GENMASK(3, 2)
+#define  NTP8835_GSA_BS(x)			((x) << 2)
+#define  NTP8835_GSA_RIGHT_J			BIT(0)
+#define  NTP8835_GSA_LSB			BIT(1)
+#define NTP8835_SOFT_MUTE			0x26
+#define  NTP8835_SOFT_MUTE_SM1			BIT(0)
+#define  NTP8835_SOFT_MUTE_SM2			BIT(1)
+#define  NTP8835_SOFT_MUTE_SM3			BIT(2)
+#define NTP8835_PWM_SWITCH			0x27
+#define  NTP8835_PWM_SWITCH_POF1		BIT(0)
+#define  NTP8835_PWM_SWITCH_POF2		BIT(1)
+#define  NTP8835_PWM_SWITCH_POF3		BIT(2)
+#define NTP8835_PWM_MASK_CTRL0			0x28
+#define  NTP8835_PWM_MASK_CTRL0_OUT_LOW		BIT(1)
+#define  NTP8835_PWM_MASK_CTRL0_FPMLD		BIT(2)
+#define NTP8835_MASTER_VOL			0x2e
+#define NTP8835_CHNL_A_VOL			0x2f
+#define NTP8835_CHNL_B_VOL			0x30
+#define NTP8835_CHNL_C_VOL			0x31
+#define REG_MAX					NTP8835_CHNL_C_VOL
+
+#define NTP8835_FW_NAME				"eq_8835.bin"
+#define NTP8835_FW_MAGIC			0x38383335	/* "8835" */
+
+struct ntp8835_priv {
+	struct i2c_client *i2c;
+	struct reset_control *reset;
+	unsigned int format;
+};
+
+static const DECLARE_TLV_DB_RANGE(ntp8835_vol_scale,
+	0, 1, TLV_DB_SCALE_ITEM(-15000, 0, 0),
+	2, 6, TLV_DB_SCALE_ITEM(-15000, 1000, 0),
+	7, 0xff, TLV_DB_SCALE_ITEM(-10000, 50, 0),
+);
+
+static int ntp8835_mute_info(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	uinfo->value.integer.step = 1;
+
+	return 0;
+}
+
+static int ntp8835_mute_get(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	unsigned int val;
+
+	val = snd_soc_component_read(component, NTP8835_SOFT_MUTE);
+
+	ucontrol->value.integer.value[0] = val ? 0 : 1;
+	return 0;
+}
+
+static int ntp8835_mute_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
+	unsigned int val;
+
+	val = ucontrol->value.integer.value[0] ? 0 : 7;
+
+	snd_soc_component_write(component, NTP8835_SOFT_MUTE, val);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new ntp8835_vol_control[] = {
+	SOC_SINGLE_TLV("Playback Volume", NTP8835_MASTER_VOL, 0,
+		       0xff, 0, ntp8835_vol_scale),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Playback Switch",
+		.info = ntp8835_mute_info,
+		.access = SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_READWRITE,
+		.get = ntp8835_mute_get,
+		.put = ntp8835_mute_put,
+	},
+};
+
+static void ntp8835_reset_gpio(struct ntp8835_priv *ntp8835, bool active)
+{
+	if (active) {
+		/*
+		 * According to NTP8835 datasheet, 6.2 Timing Sequence (recommended):
+		 * Deassert for T2 >= 1ms...
+		 */
+		reset_control_deassert(ntp8835->reset);
+		fsleep(1000);
+
+		/* ...Assert for T3 >= 0.1us... */
+		reset_control_assert(ntp8835->reset);
+		fsleep(1);
+
+		/* ...Deassert, and wait for T4 >= 0.5ms before sound on sequence. */
+		reset_control_deassert(ntp8835->reset);
+		fsleep(500);
+	} else {
+		reset_control_assert(ntp8835->reset);
+	}
+}
+
+static const struct reg_sequence ntp8835_sound_on[] = {
+	{ NTP8835_PWM_MASK_CTRL0,	NTP8835_PWM_MASK_CTRL0_FPMLD },
+	{ NTP8835_PWM_SWITCH,		0x00 },
+	{ NTP8835_SOFT_MUTE,		0x00 },
+};
+
+static const struct reg_sequence ntp8835_sound_off[] = {
+	{ NTP8835_SOFT_MUTE,		NTP8835_SOFT_MUTE_SM1 |
+					NTP8835_SOFT_MUTE_SM2 |
+					NTP8835_SOFT_MUTE_SM3 },
+
+	{ NTP8835_PWM_SWITCH,		NTP8835_PWM_SWITCH_POF1 |
+					NTP8835_PWM_SWITCH_POF2 |
+					NTP8835_PWM_SWITCH_POF3 },
+
+	{ NTP8835_PWM_MASK_CTRL0,	NTP8835_PWM_MASK_CTRL0_OUT_LOW |
+					NTP8835_PWM_MASK_CTRL0_FPMLD },
+};
+
+static int ntp8835_load_firmware(struct ntp8835_priv *ntp8835)
+{
+	int ret;
+
+	ret = ntpfw_load(ntp8835->i2c, NTP8835_FW_NAME, NTP8835_FW_MAGIC);
+	if (ret == -ENOENT) {
+		dev_warn_once(&ntp8835->i2c->dev,
+			      "Could not find firmware %s\n", NTP8835_FW_NAME);
+		return 0;
+	}
+
+	return ret;
+}
+
+static int ntp8835_snd_suspend(struct snd_soc_component *component)
+{
+	struct ntp8835_priv *ntp8835 = snd_soc_component_get_drvdata(component);
+
+	regcache_cache_only(component->regmap, true);
+
+	regmap_multi_reg_write_bypassed(component->regmap,
+					ntp8835_sound_off,
+					ARRAY_SIZE(ntp8835_sound_off));
+
+	/*
+	 * According to NTP8835 datasheet, 6.2 Timing Sequence (recommended):
+	 * wait after sound off for T6 >= 0.5ms
+	 */
+	fsleep(500);
+	ntp8835_reset_gpio(ntp8835, false);
+
+	regcache_mark_dirty(component->regmap);
+
+	return 0;
+}
+
+static int ntp8835_snd_resume(struct snd_soc_component *component)
+{
+	struct ntp8835_priv *ntp8835 = snd_soc_component_get_drvdata(component);
+	int ret;
+
+	ntp8835_reset_gpio(ntp8835, true);
+
+	regmap_multi_reg_write_bypassed(component->regmap,
+					ntp8835_sound_on,
+					ARRAY_SIZE(ntp8835_sound_on));
+
+	ret = ntp8835_load_firmware(ntp8835);
+	if (ret) {
+		dev_err(&ntp8835->i2c->dev, "Failed to load firmware\n");
+		return ret;
+	}
+
+	regcache_cache_only(component->regmap, false);
+	snd_soc_component_cache_sync(component);
+
+	return 0;
+}
+
+static int ntp8835_probe(struct snd_soc_component *component)
+{
+	int ret;
+	struct ntp8835_priv *ntp8835 = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
+
+	ret = snd_soc_add_component_controls(component, ntp8835_vol_control,
+					     ARRAY_SIZE(ntp8835_vol_control));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add controls\n");
+
+	ret = ntp8835_load_firmware(ntp8835);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to load firmware\n");
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget ntp8835_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC("AIFIN", "Playback", SND_SOC_NOPM, 0, 0),
+
+	SND_SOC_DAPM_OUTPUT("OUT1"),
+	SND_SOC_DAPM_OUTPUT("OUT2"),
+	SND_SOC_DAPM_OUTPUT("OUT3"),
+};
+
+static const struct snd_soc_dapm_route ntp8835_dapm_routes[] = {
+	{ "OUT1", NULL, "AIFIN" },
+	{ "OUT2", NULL, "AIFIN" },
+	{ "OUT3", NULL, "AIFIN" },
+};
+
+static const struct snd_soc_component_driver soc_component_ntp8835 = {
+	.probe = ntp8835_probe,
+	.suspend = ntp8835_snd_suspend,
+	.resume = ntp8835_snd_resume,
+	.dapm_widgets = ntp8835_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(ntp8835_dapm_widgets),
+	.dapm_routes = ntp8835_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(ntp8835_dapm_routes),
+};
+
+static int ntp8835_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct ntp8835_priv *ntp8835 = snd_soc_component_get_drvdata(component);
+	unsigned int input_fmt = 0;
+	unsigned int gsa_fmt = 0;
+	unsigned int gsa_fmt_mask;
+	int ret;
+
+	switch (ntp8835->format) {
+	case SND_SOC_DAIFMT_I2S:
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		input_fmt |= NTP8835_INPUT_FMT_GSA_MODE;
+		gsa_fmt |= NTP8835_GSA_RIGHT_J;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		input_fmt |= NTP8835_INPUT_FMT_GSA_MODE;
+		break;
+	}
+
+	ret = snd_soc_component_update_bits(component, NTP8835_INPUT_FMT,
+					    NTP8835_INPUT_FMT_MASTER_MODE |
+					    NTP8835_INPUT_FMT_GSA_MODE,
+					    input_fmt);
+
+	if (!(input_fmt & NTP8835_INPUT_FMT_GSA_MODE) || ret < 0)
+		return ret;
+
+	switch (params_width(params)) {
+	case 24:
+		gsa_fmt |= NTP8835_GSA_BS(0);
+		break;
+	case 20:
+		gsa_fmt |= NTP8835_GSA_BS(1);
+		break;
+	case 18:
+		gsa_fmt |= NTP8835_GSA_BS(2);
+		break;
+	case 16:
+		gsa_fmt |= NTP8835_GSA_BS(3);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	gsa_fmt_mask = NTP8835_GSA_BS_MASK |
+		       NTP8835_GSA_RIGHT_J |
+		       NTP8835_GSA_LSB;
+	return snd_soc_component_update_bits(component, NTP8835_GSA_FMT,
+					     gsa_fmt_mask, gsa_fmt);
+}
+
+static int ntp8835_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	struct ntp8835_priv *ntp8835 = snd_soc_component_get_drvdata(component);
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+	case SND_SOC_DAIFMT_RIGHT_J:
+	case SND_SOC_DAIFMT_LEFT_J:
+		ntp8835->format = fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+};
+
+static const struct snd_soc_dai_ops ntp8835_dai_ops = {
+	.hw_params = ntp8835_hw_params,
+	.set_fmt = ntp8835_set_fmt,
+};
+
+static struct snd_soc_dai_driver ntp8835_dai = {
+	.name = "ntp8835-amplifier",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 3,
+		.rates = SNDRV_PCM_RATE_8000_192000,
+		.formats = NTP8835_FORMATS,
+	},
+	.ops = &ntp8835_dai_ops,
+};
+
+static struct regmap_config ntp8835_regmap = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = REG_MAX,
+	.cache_type = REGCACHE_MAPLE,
+};
+
+static int ntp8835_i2c_probe(struct i2c_client *i2c)
+{
+	struct ntp8835_priv *ntp8835;
+	struct regmap *regmap;
+	int ret;
+
+	ntp8835 = devm_kzalloc(&i2c->dev, sizeof(struct ntp8835_priv), GFP_KERNEL);
+	if (!ntp8835)
+		return -ENOMEM;
+
+	ntp8835->i2c = i2c;
+
+	ntp8835->reset = devm_reset_control_get_shared(&i2c->dev, NULL);
+	if (IS_ERR(ntp8835->reset))
+		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8835->reset),
+				     "Failed to get reset\n");
+
+	ret = reset_control_deassert(ntp8835->reset);
+	if (ret)
+		return dev_err_probe(&i2c->dev, PTR_ERR(ntp8835->reset),
+				     "Failed to deassert reset\n");
+
+	dev_set_drvdata(&i2c->dev, ntp8835);
+
+	ntp8835_reset_gpio(ntp8835, true);
+
+	regmap = devm_regmap_init_i2c(i2c, &ntp8835_regmap);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&i2c->dev, PTR_ERR(regmap),
+				     "Failed to allocate regmap\n");
+
+	ret = devm_snd_soc_register_component(&i2c->dev, &soc_component_ntp8835,
+					      &ntp8835_dai, 1);
+	if (ret)
+		return dev_err_probe(&i2c->dev, ret,
+				     "Failed to register component\n");
+
+	return 0;
+}
+
+static const struct i2c_device_id ntp8835_i2c_id[] = {
+	{ "ntp8835", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ntp8835_i2c_id);
+
+static const struct of_device_id ntp8835_of_match[] = {
+	{.compatible = "neofidelity,ntp8835",},
+	{.compatible = "neofidelity,ntp8835c",},
+	{}
+};
+MODULE_DEVICE_TABLE(of, ntp8835_of_match);
+
+static struct i2c_driver ntp8835_i2c_driver = {
+	.probe = ntp8835_i2c_probe,
+	.id_table = ntp8835_i2c_id,
+	.driver = {
+		.name = "NTP8835",
+		.of_match_table = ntp8835_of_match,
+	},
+};
+module_i2c_driver(ntp8835_i2c_driver);
+
+MODULE_AUTHOR("Igor Prusov <ivprusov@salutedevices.com>");
+MODULE_DESCRIPTION("NTP8835 Audio Amplifier Driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


