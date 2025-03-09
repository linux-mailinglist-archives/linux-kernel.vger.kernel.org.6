Return-Path: <linux-kernel+bounces-553297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A90E6A58713
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AAEB7A48E0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248F7206F0A;
	Sun,  9 Mar 2025 18:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ndJi+8NN"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE101F8754;
	Sun,  9 Mar 2025 18:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544202; cv=none; b=EP7BkH+Ok+7SeLdTcCbIcPaxYvCMRiPG7y03sznN66V1VUdi7Z18VwR6Apm/ZxXD0UG0dBfG6BUbKvK5McyB/wdwVcQhW/2YJ6vYB/w6VXdhfmiV5FezoUfYg9GPAcTM3CVIrPHbVTtVtyTFV4Wt9jXF371OW46k5v2QS+CYgbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544202; c=relaxed/simple;
	bh=SHmpreG2T1a9QRnDBr4tVtexygEdChVXHsQTPn9qc/Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQROLp2Nao+ETQc1/A3nuAqIg8V0LLJVmXXnY/uFFfPMFmb6TkUDjPWspf4DkOWtIUnn9gNPMntfaZ5m15Da7HfT1ZjosONjFQoZx+eqEDIglNY9MqMHNIIdcxRR1Ba3xb58SkcH/bjR3Yf8gBmQp4OFtR0Kou2hjkXo7oJNX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ndJi+8NN; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 93EAD100008;
	Sun,  9 Mar 2025 21:16:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 93EAD100008
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544197;
	bh=TJFk5NHLtZYLy9ZnApxjg1fiKnICocpIHuwZzGhlBLo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ndJi+8NNB+Ns6nZM1caLri75nrifKRgiAmrVlyr3a0AP6Aq8UvOoV8Wx+dfdV8GSx
	 8dlNl78yNbKuEl3zFqJoOvLWKDVoOnjrV6m0gdh6otNiaxWVC+VQIbz5c7+Pb3WD9i
	 Zc/evgVoKp2zTn2f3MVnNa1OJ30/AA2p7B7L+oIzNAT8CfoJrqlDePTC0PA1nLDrm1
	 UDGCSeSShY78c7qPIZldN9q6nw6sGQVhjJCSdSoeDLt5/JaTq9FbC1ye6s3i7o+OUI
	 VZMr11QRuOgI6aj6CL32zQK0Ups1APuVPDCN/c9+vNO1+UWMBjkxDGRt4q/o0rbs3G
	 C+JRSKmMb/NoA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:16:37 +0300 (MSK)
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
Subject: [PATCH v2 3/3] ASoC: meson: t9015: add support for A1 SoC family
Date: Sun, 9 Mar 2025 21:16:30 +0300
Message-ID: <20250309181630.1322745-4-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309181630.1322745-1-jan.dakinevich@salutedevices.com>
References: <20250309181630.1322745-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, 127.0.0.199:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

A1's internal codec is very close to t9015. The main difference, that it
has ADC. This commit introduces support for capturing from it.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
---
 sound/soc/meson/t9015.c | 312 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 312 insertions(+)

diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
index 919a2413038d..fe3e62d94fa3 100644
--- a/sound/soc/meson/t9015.c
+++ b/sound/soc/meson/t9015.c
@@ -19,16 +19,33 @@
 #define  LOLP_EN	3
 #define  DACR_EN	4
 #define  DACL_EN	5
+#define  ADCR_EN	6
+#define  ADCL_EN	7
+#define  PGAR_ZCD_EN	8
+#define  PGAL_ZCD_EN	9
+#define  PGAR_EN	10
+#define  PGAL_EN	11
+#define  ADCR_INV	16
+#define  ADCL_INV	17
+#define  ADCR_SRC	18
+#define  ADCL_SRC	19
 #define  DACR_INV	20
 #define  DACL_INV	21
 #define  DACR_SRC	22
 #define  DACL_SRC	23
+#define  ADC_DEM_EN	26
+#define  ADC_FILTER_MODE 28
+#define  ADC_FILTER_EN	29
 #define  REFP_BUF_EN	BIT(12)
 #define  BIAS_CURRENT_EN BIT(13)
 #define  VMID_GEN_FAST	BIT(14)
 #define  VMID_GEN_EN	BIT(15)
 #define  I2S_MODE	BIT(30)
 #define VOL_CTRL0	0x04
+#define  PGAR_VC	0
+#define  PGAL_VC	8
+#define  ADCR_VC	16
+#define  ADCL_VC	24
 #define  GAIN_H		31
 #define  GAIN_L		23
 #define VOL_CTRL1	0x08
@@ -46,6 +63,28 @@
 #define  LOLN_POL	8
 #define  LOLP_POL	12
 #define POWER_CFG	0x10
+#define LINEIN_CFG	0x14
+#define  MICBIAS_LEVEL	0
+#define  MICBIAS_EN	3
+#define  PGAR_CTVMN	8
+#define  PGAR_CTVMP	9
+#define  PGAL_CTVMN	10
+#define  PGAL_CTVMP	11
+#define  PGAR_CTVIN	12
+#define  PGAR_CTVIP	13
+#define  PGAL_CTVIN	14
+#define  PGAL_CTVIP	15
+
+#define PGAR_MASK	(BIT(PGAR_CTVMP) | BIT(PGAR_CTVMN) | \
+			 BIT(PGAR_CTVIP) | BIT(PGAR_CTVIN))
+#define PGAR_DIFF	(BIT(PGAR_CTVIP) | BIT(PGAR_CTVIN))
+#define PGAR_POSITIVE	(BIT(PGAR_CTVIP) | BIT(PGAR_CTVMN))
+#define PGAR_NEGATIVE	(BIT(PGAR_CTVIN) | BIT(PGAR_CTVMP))
+#define PGAL_MASK	(BIT(PGAL_CTVMP) | BIT(PGAL_CTVMN) | \
+			 BIT(PGAL_CTVIP) | BIT(PGAL_CTVIN))
+#define PGAL_DIFF	(BIT(PGAL_CTVIP) | BIT(PGAL_CTVIN))
+#define PGAL_POSITIVE	(BIT(PGAL_CTVIP) | BIT(PGAL_CTVMN))
+#define PGAL_NEGATIVE	(BIT(PGAL_CTVIN) | BIT(PGAL_CTVMP))
 
 struct t9015 {
 	struct regulator *avdd;
@@ -103,6 +142,31 @@ static struct snd_soc_dai_driver t9015_dai = {
 	.ops = &t9015_dai_ops,
 };
 
+static struct snd_soc_dai_driver a1_t9015_dai = {
+	.name = "t9015-hifi",
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = (SNDRV_PCM_FMTBIT_S8 |
+			    SNDRV_PCM_FMTBIT_S16_LE |
+			    SNDRV_PCM_FMTBIT_S20_LE |
+			    SNDRV_PCM_FMTBIT_S24_LE),
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_96000,
+		.formats = (SNDRV_PCM_FMTBIT_S8 |
+			    SNDRV_PCM_FMTBIT_S16_LE |
+			    SNDRV_PCM_FMTBIT_S20_LE |
+			    SNDRV_PCM_FMTBIT_S24_LE),
+	},
+	.ops = &t9015_dai_ops,
+};
+
 static const DECLARE_TLV_DB_MINMAX_MUTE(dac_vol_tlv, -9525, 0);
 
 static const char * const ramp_rate_txt[] = { "Fast", "Slow" };
@@ -179,6 +243,103 @@ static const struct snd_soc_dapm_route t9015_dapm_routes[] = {
 	{ "LOLP", NULL, "Left+ Driver",  },
 };
 
+static const DECLARE_TLV_DB_MINMAX_MUTE(a1_adc_vol_tlv, -29625, 0);
+static const DECLARE_TLV_DB_MINMAX_MUTE(a1_adc_pga_vol_tlv, -1200, 0);
+
+static const char * const a1_adc_right_txt[] = { "Right", "Left" };
+static SOC_ENUM_SINGLE_DECL(a1_adc_right, BLOCK_EN, ADCR_SRC, a1_adc_right_txt);
+
+static const char * const a1_adc_left_txt[] = { "Left", "Right" };
+static SOC_ENUM_SINGLE_DECL(a1_adc_left, BLOCK_EN, ADCL_SRC, a1_adc_left_txt);
+
+static const struct snd_kcontrol_new a1_adc_right_mux =
+	SOC_DAPM_ENUM("ADC Right Source", a1_adc_right);
+static const struct snd_kcontrol_new a1_adc_left_mux =
+	SOC_DAPM_ENUM("ADC Left Source", a1_adc_left);
+
+static const char * const a1_adc_filter_mode_txt[] = { "Voice", "HiFi"};
+static SOC_ENUM_SINGLE_DECL(a1_adc_filter_mode, BLOCK_EN, ADC_FILTER_MODE,
+			    a1_adc_filter_mode_txt);
+
+static const struct snd_kcontrol_new a1_t9015_snd_controls[] = {
+	/* Volume Controls */
+	SOC_ENUM("Playback Channel Mode", mono_enum),
+	SOC_SINGLE("Playback Switch", VOL_CTRL1, DAC_SOFT_MUTE, 1, 1),
+	SOC_DOUBLE_TLV("Playback Volume", VOL_CTRL1, DACL_VC, DACR_VC,
+		       0xff, 0, dac_vol_tlv),
+
+	/* Ramp Controls */
+	SOC_ENUM("Ramp Rate", ramp_rate_enum),
+	SOC_SINGLE("Volume Ramp Switch", VOL_CTRL1, VC_RAMP_MODE, 1, 0),
+	SOC_SINGLE("Mute Ramp Switch", VOL_CTRL1, MUTE_MODE, 1, 0),
+	SOC_SINGLE("Unmute Ramp Switch", VOL_CTRL1, UNMUTE_MODE, 1, 0),
+
+	/* ADC Controls */
+	SOC_DOUBLE_TLV("ADC Volume", VOL_CTRL0, ADCL_VC, ADCR_VC,
+		       0x7f, 0, a1_adc_vol_tlv),
+	SOC_SINGLE("ADC Filter Switch", BLOCK_EN, ADC_FILTER_EN, 1, 0),
+	SOC_ENUM("ADC Filter Mode", a1_adc_filter_mode),
+	SOC_SINGLE("ADC DEM Switch", BLOCK_EN, ADC_DEM_EN, 1, 0),
+	SOC_DOUBLE_TLV("ADC PGA Volume", VOL_CTRL0, PGAR_VC, PGAL_VC,
+		       0x1f, 0, a1_adc_pga_vol_tlv),
+	SOC_DOUBLE("ADC PGA Zero Cross-detection Switch", BLOCK_EN,
+		   PGAL_ZCD_EN, PGAR_ZCD_EN, 1, 0),
+};
+
+static const struct snd_soc_dapm_widget a1_t9015_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("Right IN", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("Left IN", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_MUX("Right DAC Sel", SND_SOC_NOPM, 0, 0,
+			 &t9015_right_dac_mux),
+	SND_SOC_DAPM_MUX("Left DAC Sel", SND_SOC_NOPM, 0, 0,
+			 &t9015_left_dac_mux),
+	SND_SOC_DAPM_DAC("Right DAC", NULL, BLOCK_EN, DACR_EN, 0),
+	SND_SOC_DAPM_DAC("Left DAC",  NULL, BLOCK_EN, DACL_EN, 0),
+	SND_SOC_DAPM_OUT_DRV("Right+ Driver", BLOCK_EN, LORP_EN, 0, NULL, 0),
+	SND_SOC_DAPM_OUT_DRV("Left+ Driver",  BLOCK_EN, LOLP_EN, 0, NULL, 0),
+	SND_SOC_DAPM_OUTPUT("LORP"),
+	SND_SOC_DAPM_OUTPUT("LOLP"),
+
+	SND_SOC_DAPM_INPUT("ADC IN Right"),
+	SND_SOC_DAPM_INPUT("ADC IN Left"),
+	SND_SOC_DAPM_PGA("ADC PGA Right", BLOCK_EN, PGAR_EN, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("ADC PGA Left", BLOCK_EN, PGAL_EN, 0, NULL, 0),
+	SND_SOC_DAPM_ADC("ADC Right", NULL, BLOCK_EN, ADCR_EN, 0),
+	SND_SOC_DAPM_ADC("ADC Left", NULL, BLOCK_EN, ADCL_EN, 0),
+	SND_SOC_DAPM_MUX("ADC Right Sel", SND_SOC_NOPM, 0, 0, &a1_adc_right_mux),
+	SND_SOC_DAPM_MUX("ADC Left Sel", SND_SOC_NOPM, 0, 0, &a1_adc_left_mux),
+	SND_SOC_DAPM_AIF_OUT("ADC OUT Right", NULL, 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("ADC OUT Left", NULL, 0, SND_SOC_NOPM, 0, 0),
+};
+
+static const struct snd_soc_dapm_route a1_t9015_dapm_routes[] = {
+	{ "Right IN", NULL, "Playback" },
+	{ "Left IN", NULL, "Playback" },
+	{ "Right DAC Sel", "Right", "Right IN" },
+	{ "Right DAC Sel", "Left", "Left IN" },
+	{ "Left DAC Sel", "Right", "Right IN" },
+	{ "Left DAC Sel", "Left", "Left IN" },
+	{ "Right DAC", NULL, "Right DAC Sel" },
+	{ "Left DAC", NULL, "Left DAC Sel" },
+	{ "Right+ Driver", NULL, "Right DAC" },
+	{ "Left+ Driver", NULL, "Left DAC" },
+	{ "LORP", NULL, "Right+ Driver", },
+	{ "LOLP", NULL, "Left+ Driver", },
+
+	{ "ADC PGA Right", NULL, "ADC IN Right" },
+	{ "ADC PGA Left", NULL, "ADC IN Left" },
+	{ "ADC Right", NULL, "ADC PGA Right" },
+	{ "ADC Left", NULL, "ADC PGA Left" },
+	{ "ADC Right Sel", "Right", "ADC Right" },
+	{ "ADC Right Sel", "Left", "ADC Left" },
+	{ "ADC Left Sel", "Right", "ADC Right" },
+	{ "ADC Left Sel", "Left", "ADC Left" },
+	{ "ADC OUT Right", NULL, "ADC Right Sel" },
+	{ "ADC OUT Left", NULL, "ADC Left Sel" },
+	{ "Capture", NULL, "ADC OUT Right" },
+	{ "Capture", NULL, "ADC OUT Left" },
+};
+
 static int t9015_set_bias_level(struct snd_soc_component *component,
 				enum snd_soc_bias_level level)
 {
@@ -241,6 +402,134 @@ static int t9015_component_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static int a1_t9015_line_cfg(struct snd_soc_component *component,
+			     const char *propname, unsigned int reg,
+			     unsigned int mask, const char **names,
+			     const unsigned int *values, unsigned int count)
+{
+	const char *propval;
+	unsigned int i;
+	int ret;
+
+	ret = device_property_read_string(component->dev, propname, &propval);
+	if (ret)
+		propval = names[0];
+
+	for (i = 0; i < count; i++) {
+		if (strcmp(propval, names[i]))
+			continue;
+
+		snd_soc_component_update_bits(component, reg, mask, values[i]);
+		return 0;
+	}
+
+	dev_err(component->dev, "wrong '%s' property value: '%s'",
+		 propname, propval);
+	return -EINVAL;
+}
+
+static int a1_t9015_lineout_cfg(struct snd_soc_component *component)
+{
+	const char *right_names[] = { "none", "right", "left-inverted" };
+	unsigned int right_values[] = { 0, 0x2000, 0x4000, };
+	const char *left_names[] = { "none", "left", "right-inverted" };
+	unsigned int left_values[] = { 0, 0x20, 0x40, };
+	int ret;
+
+	ret = a1_t9015_line_cfg(component, "lineout-right", LINEOUT_CFG, 0x7000,
+				right_names, right_values, ARRAY_SIZE(right_names));
+	if (ret)
+		return ret;
+
+	ret = a1_t9015_line_cfg(component, "lineout-left", LINEOUT_CFG, 0x70,
+				left_names, left_values, ARRAY_SIZE(left_names));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int a1_t9015_linein_cfg(struct snd_soc_component *component)
+{
+	const char *names[] = { "none", "differential", "positive",
+		"negative" };
+	unsigned int right_values[] = { 0, PGAR_DIFF, PGAR_POSITIVE,
+		PGAR_NEGATIVE };
+	unsigned int left_values[] = { 0, PGAL_DIFF, PGAL_POSITIVE,
+		PGAL_NEGATIVE };
+	int ret;
+
+	ret = a1_t9015_line_cfg(component, "linein-right", LINEIN_CFG, PGAR_MASK,
+				names, right_values, ARRAY_SIZE(names));
+	if (ret)
+		return ret;
+
+	ret = a1_t9015_line_cfg(component, "linein-left", LINEIN_CFG, PGAL_MASK,
+				names, left_values, ARRAY_SIZE(names));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int a1_t9015_micbias_cfg(struct snd_soc_component *component)
+{
+	const char *names[] = { "2.0V", "2.1V", "2.3V", "2.5V", "2.8V" };
+	const unsigned int values[] = { 0, 1, 2, 3, 7 };
+	const char *propname = "micbias";
+	const char *propval;
+	unsigned int i;
+	int ret;
+
+	ret = device_property_read_string(component->dev, propname, &propval);
+	if (ret) {
+		snd_soc_component_update_bits(component, LINEIN_CFG,
+					      BIT(MICBIAS_EN), 0);
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(names); i++) {
+		if (strcmp(propval, names[i]))
+			continue;
+
+		snd_soc_component_update_bits(component, LINEIN_CFG, 0x7,
+					      values[i]);
+		snd_soc_component_update_bits(component, LINEIN_CFG,
+					      BIT(MICBIAS_EN), BIT(MICBIAS_EN));
+		return 0;
+	}
+
+	dev_err(component->dev, "wrong '%s' property value: '%s'",
+		 propname, propval);
+	return -EINVAL;
+}
+
+static int a1_t9015_component_probe(struct snd_soc_component *component)
+{
+	int ret;
+
+	ret = a1_t9015_lineout_cfg(component);
+	if (ret)
+		return ret;
+
+	ret = a1_t9015_linein_cfg(component);
+	if (ret)
+		return ret;
+
+	ret = a1_t9015_micbias_cfg(component);
+	if (ret)
+		return ret;
+
+	/*
+	 * This configuration was stealed from original Amlogic's driver to
+	 * reproduce the behavior of the driver more accurately. However, it is
+	 * not known for certain what it actually affects.
+	 */
+	snd_soc_component_write(component, POWER_CFG, 0x00010000);
+
+	return 0;
+}
+
 static const struct snd_soc_component_driver t9015_codec_driver = {
 	.probe			= t9015_component_probe,
 	.set_bias_level		= t9015_set_bias_level,
@@ -254,6 +543,19 @@ static const struct snd_soc_component_driver t9015_codec_driver = {
 	.endianness		= 1,
 };
 
+static const struct snd_soc_component_driver a1_t9015_codec_driver = {
+	.probe			= a1_t9015_component_probe,
+	.set_bias_level		= t9015_set_bias_level,
+	.controls		= a1_t9015_snd_controls,
+	.num_controls		= ARRAY_SIZE(a1_t9015_snd_controls),
+	.dapm_widgets		= a1_t9015_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(a1_t9015_dapm_widgets),
+	.dapm_routes		= a1_t9015_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(a1_t9015_dapm_routes),
+	.suspend_bias_off	= 1,
+	.endianness		= 1,
+};
+
 static int t9015_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -315,11 +617,21 @@ static const struct t9015_match_data t9015_match_data = {
 	.max_register = POWER_CFG,
 };
 
+static const struct t9015_match_data a1_t9015_match_data = {
+	.component_drv = &a1_t9015_codec_driver,
+	.dai_drv = &a1_t9015_dai,
+	.max_register = LINEIN_CFG,
+};
+
 static const struct of_device_id t9015_ids[] __maybe_unused = {
 	{
 		.compatible = "amlogic,t9015",
 		.data = &t9015_match_data,
 	},
+	{
+		.compatible = "amlogic,t9015-a1",
+		.data = &a1_t9015_match_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, t9015_ids);
-- 
2.34.1


