Return-Path: <linux-kernel+bounces-568167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2385A68EFD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4519E3A3700
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10861DB14C;
	Wed, 19 Mar 2025 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="BeQK5WRI"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5B41CC89D;
	Wed, 19 Mar 2025 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742394073; cv=none; b=HGUhqN8dJ8DcqhfCE9EjIjtZloii5uadc2Cc0nHabbzqRZJHa/Nj/DszQn3pkLUAWNvNylgXjpvHKBrS0B2SRxkV8Z6+yk/xUTUKCKLC7OAePZUnQq55ZAYS5W2oMJsYDw7QB/VBBPjzbZIhgvYrV4BKRIXN0O8k4cjKbf0LjRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742394073; c=relaxed/simple;
	bh=UPrvgxs1AioBmdUGE+vUXXuJ3vLEumqsNdNnl2J/ZYo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NiVGWIq++x4Sd6SBFVKULcx7TAKNXW3mJXX9PMDtkMCKFCQ+XSpLLjrmxWnZp5wOPcOgQNt4Rhl0PprYMAoNaMBCBOXH4k9jKFDYdjdvlCtlE7i34TJJzJ3/XAh+Mcx5+9bZIXHDBuUXiW7D/YrJJdSQtsR6DTjm8M9hRdtAKOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=BeQK5WRI; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 0A13523524;
	Wed, 19 Mar 2025 15:21:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1742394068;
	bh=s4GUy3eExK4JSUHKIm0FsdvRmjkUsABh6A9R7Rhil0E=; h=From:To:Subject;
	b=BeQK5WRIDuL3smkbfxu9clrN3T08RETmEFy0CMJipMRiix30CIoGNKK7dySXh7DTD
	 8aADn2iwqJNxG9zRTch9KIHJEl7gsfVJ+v4tFVpsymNohkClNkJytJoO1f1K9fNSdp
	 cRvsLgMjt89C4SMcLbc8ubPZE7BnHNC+8F7/T1SJcJ25yzHyeQjdXqsr3NXtyyCwbB
	 Suw36g3Uqv5YuL3yvK+C+sGU41X95nG1kjOJSjDzGNa/XfrwAL8MiGkvKWKuGYjwms
	 Q4R+WUN4kHTc+grWZ7eN+qa8s/UJGp+R5B9ew2tWyVEtG7s13i78mtfnLuRzMU6tNZ
	 KIkdzGrSoXSkQ==
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
Subject: [PATCH v4 5/5] ASoC: wm8904: add DMIC support
Date: Wed, 19 Mar 2025 15:20:59 +0100
Message-Id: <20250319142059.46692-6-francesco@dolcini.it>
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

The WM8904 codec supports both ADC and DMIC inputs.

Get input pin functionality from the platform data and add the necessary
controls depending on the possible additional routing.

The ADC and DMIC share the IN1L/DMICDAT1 and IN1R/DMICDAT2 pins.

This leads to a few scenarios requiring different DAPM routing:
- When both are connected to an analog input, only the ADC is used.
- When one line is a DMIC and the other an analog input, the DMIC source
  is set from the platform data and a mux is added to select whether to
  use the ADC or DMIC.
- When both are connected to a DMIC, another mux is added to this to
  select the DMIC source. Note that we still need to be able to select
  the ADC system for use with the IN2L, IN2R, IN3L and IN3R pins.

Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
v4: no changes
v3: no changes
v2: DAPM routes have been reworked, please see the commit message body.
    The previous approach forgot that the ADC is still needed for the
    IN2L/R and IN3L/R pins, and did not properly disconnect the PGAs
    from the ADC when only the DMIC was in use.
v1: https://lore.kernel.org/lkml/20250206163152.423199-6-francesco@dolcini.it/

Cc: ckeepax@opensource.cirrus.com
---
 sound/soc/codecs/wm8904.c | 125 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/wm8904.c b/sound/soc/codecs/wm8904.c
index bac54c8e45a9..1c49e600eb6f 100644
--- a/sound/soc/codecs/wm8904.c
+++ b/sound/soc/codecs/wm8904.c
@@ -844,6 +844,26 @@ static int out_pga_event(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
+static const char * const dmic_text[] = {
+	"DMIC1", "DMIC2"
+};
+
+static SOC_ENUM_SINGLE_DECL(dmic_enum, WM8904_DIGITAL_MICROPHONE_0,
+			    WM8904_DMIC_SRC_SHIFT, dmic_text);
+
+static const struct snd_kcontrol_new dmic_mux =
+	SOC_DAPM_ENUM("DMIC Mux", dmic_enum);
+
+static const char * const cin_text[] = {
+	"ADC", "DMIC"
+};
+
+static SOC_ENUM_SINGLE_DECL(cin_enum, WM8904_DIGITAL_MICROPHONE_0,
+			    WM8904_DMIC_ENA_SHIFT, cin_text);
+
+static const struct snd_kcontrol_new cin_mux =
+	SOC_DAPM_ENUM("Capture Input", cin_enum);
+
 static const char *input_mode_text[] = {
 	"Single-Ended", "Differential Line", "Differential Mic"
 };
@@ -963,6 +983,15 @@ SND_SOC_DAPM_AIF_OUT("AIFOUTL", "Capture", 0, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_AIF_OUT("AIFOUTR", "Capture", 1, SND_SOC_NOPM, 0, 0),
 };
 
+static const struct snd_soc_dapm_widget wm8904_dmic_dapm_widgets[] = {
+SND_SOC_DAPM_MUX("DMIC Mux", SND_SOC_NOPM, 0, 0, &dmic_mux),
+};
+
+static const struct snd_soc_dapm_widget wm8904_cin_dapm_widgets[] = {
+SND_SOC_DAPM_MUX("Left Capture Input", SND_SOC_NOPM, 0, 0, &cin_mux),
+SND_SOC_DAPM_MUX("Right Capture Input", SND_SOC_NOPM, 0, 0, &cin_mux),
+};
+
 static const struct snd_soc_dapm_widget wm8904_dac_dapm_widgets[] = {
 SND_SOC_DAPM_AIF_IN("AIFINL", "Playback", 0, SND_SOC_NOPM, 0, 0),
 SND_SOC_DAPM_AIF_IN("AIFINR", "Playback", 1, SND_SOC_NOPM, 0, 0),
@@ -1101,12 +1130,45 @@ static const struct snd_soc_dapm_route adc_intercon[] = {
 	{ "AIFOUTR", NULL, "AIFOUTR Mux" },
 
 	{ "ADCL", NULL, "CLK_DSP" },
-	{ "ADCL", NULL, "Left Capture PGA" },
-
 	{ "ADCR", NULL, "CLK_DSP" },
+};
+
+/* No DMICs, always connect PGAs */
+static const struct snd_soc_dapm_route cin_nodmic_con[] = {
+	{ "ADCL", NULL, "Left Capture PGA" },
 	{ "ADCR", NULL, "Right Capture PGA" },
 };
 
+/* DMIC system in use: mux between ADC and DMICDAT1, 2 or both */
+static const struct snd_soc_dapm_route cin_adc_dmic_con[] = {
+	{ "Left Capture Input", "ADC", "Left Capture PGA" },
+	{ "Right Capture Input", "ADC", "Right Capture PGA" },
+
+	{ "ADCL", NULL, "Left Capture Input" },
+	{ "ADCR", NULL, "Right Capture Input" },
+};
+
+/*  IN1L as DMICDAT1 */
+static const struct snd_soc_dapm_route cin_dmic1_con[] = {
+	{ "Left Capture Input", "DMIC", "IN1L" },
+	{ "Right Capture Input", "DMIC", "IN1L" },
+};
+
+/* IN1R as DMICDAT2 */
+static const struct snd_soc_dapm_route cin_dmic2_con[] = {
+	{ "Left Capture Input", "DMIC", "IN1R" },
+	{ "Right Capture Input", "DMIC", "IN1R" },
+};
+
+/* DMICDAT1 and DMICDAT2: mux between them, ADC still used for IN2 and IN3 */
+static const struct snd_soc_dapm_route cin_2dmics_con[] = {
+	{ "DMIC Mux", "DMIC1", "IN1L" },
+	{ "DMIC Mux", "DMIC2", "IN1R" },
+
+	{ "Left Capture Input", "DMIC", "DMIC Mux" },
+	{ "Right Capture Input", "DMIC", "DMIC Mux" },
+};
+
 static const struct snd_soc_dapm_route dac_intercon[] = {
 	{ "DACL Mux", "Left", "AIFINL" },
 	{ "DACL Mux", "Right", "AIFINR" },
@@ -2050,18 +2112,70 @@ static void wm8904_handle_retune_mobile_pdata(struct snd_soc_component *componen
 			"Failed to add ReTune Mobile control: %d\n", ret);
 }
 
+static void wm8904_handle_dmic_pdata(struct snd_soc_component *component)
+{
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
+	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
+	struct wm8904_pdata *pdata = wm8904->pdata;
+	unsigned int dmic_src;
+
+	if (!pdata->in1l_as_dmicdat1 && !pdata->in1r_as_dmicdat2) {
+		snd_soc_dapm_add_routes(dapm, cin_nodmic_con,
+					ARRAY_SIZE(cin_nodmic_con));
+		snd_soc_component_update_bits(component, WM8904_DIGITAL_MICROPHONE_0,
+					      WM8904_DMIC_ENA_MASK, 0);
+		return;
+	}
+
+	/* Need a control and routing to switch between DMIC and ADC */
+	snd_soc_dapm_new_controls(dapm, wm8904_cin_dapm_widgets,
+				  ARRAY_SIZE(wm8904_cin_dapm_widgets));
+	snd_soc_dapm_add_routes(dapm, cin_adc_dmic_con,
+				ARRAY_SIZE(cin_adc_dmic_con));
+
+	if (pdata->in1l_as_dmicdat1 && pdata->in1r_as_dmicdat2) {
+		/* Need a control and routing to mux between DMICDAT1 and 2 */
+		dev_dbg(component->dev, "DMICDAT1 and DMICDAT2 in use\n");
+		snd_soc_dapm_new_controls(dapm, wm8904_dmic_dapm_widgets,
+					  ARRAY_SIZE(wm8904_dmic_dapm_widgets));
+		snd_soc_dapm_add_routes(dapm, cin_2dmics_con,
+					ARRAY_SIZE(cin_2dmics_con));
+		return;
+	}
+
+	/* Either DMICDAT1 or DMICDAT2 is in use, not both */
+	if (pdata->in1l_as_dmicdat1) {
+		dmic_src = 0;
+		snd_soc_dapm_add_routes(dapm, cin_dmic1_con,
+					ARRAY_SIZE(cin_dmic1_con));
+	} else {
+		dmic_src = 1;
+		snd_soc_dapm_add_routes(dapm, cin_dmic2_con,
+					ARRAY_SIZE(cin_dmic2_con));
+	}
+	dev_dbg(component->dev, "DMIC_SRC (0 or 1): %d\n", dmic_src);
+	snd_soc_component_update_bits(component, WM8904_DIGITAL_MICROPHONE_0,
+				      WM8904_DMIC_SRC_MASK,
+				      dmic_src << WM8904_DMIC_SRC_SHIFT);
+}
+
 static void wm8904_handle_pdata(struct snd_soc_component *component)
 {
+	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	struct wm8904_priv *wm8904 = snd_soc_component_get_drvdata(component);
 	struct wm8904_pdata *pdata = wm8904->pdata;
 	int ret, i;
 
 	if (!pdata) {
+		snd_soc_dapm_add_routes(dapm, cin_nodmic_con,
+					ARRAY_SIZE(cin_nodmic_con));
 		snd_soc_add_component_controls(component, wm8904_eq_controls,
-				     ARRAY_SIZE(wm8904_eq_controls));
+					       ARRAY_SIZE(wm8904_eq_controls));
 		return;
 	}
 
+	wm8904_handle_dmic_pdata(component);
+
 	dev_dbg(component->dev, "%d DRC configurations\n", pdata->num_drc_cfgs);
 
 	if (pdata->num_drc_cfgs) {
@@ -2117,10 +2231,11 @@ static int wm8904_probe(struct snd_soc_component *component)
 		return -EINVAL;
 	}
 
-	wm8904_handle_pdata(component);
-
 	wm8904_add_widgets(component);
 
+	/* This can add dependent widgets, so it is done after add_widgets */
+	wm8904_handle_pdata(component);
+
 	return 0;
 }
 
-- 
2.39.5


