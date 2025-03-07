Return-Path: <linux-kernel+bounces-551220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F09A56989
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38D9B178BC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84F221CA1D;
	Fri,  7 Mar 2025 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="j8BOWY4M"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087FD21B9F3;
	Fri,  7 Mar 2025 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741355583; cv=none; b=bvL7be4uUIC0MbaXe5QivzAVW74L8L8uOr4xZs0DeSEwaY5pOzazrYJFjxvKpgCvYTAK7mQkCNMLR6+fQ657M5txSPJ4cipdLe4HU/+AzsHnPI8x+MVfN/5lAmafcBQeejxKSS/uqCbJjf736+WlftQ23sJder72WCJ7XwaiBTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741355583; c=relaxed/simple;
	bh=sHRLAO4wCiytD5iI8SH+wtX/O42fBKBwUxkn8F6qv20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOVSZELJrFpYwCCN0mhOkNamsBxkWWOMa4DRsJ3ISazoahOgQGyuBJlB81Jc6M0X01Wo1i2mlXbBQQjAFhMvRW/FA4pvXZiHsn49nN4rN6+wNVRZIVvEbjHQZrbbKMwI1c0hnsiMEr37eRwqV8+X4dgMJKHW2iKokcOUdmMZ8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=j8BOWY4M; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 876051FA6D;
	Fri,  7 Mar 2025 14:52:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1741355572;
	bh=VPoVv1lgA88o7hB5e7PVRv/YBZy3UtnhyURhz1siZbw=; h=From:To:Subject;
	b=j8BOWY4M+xQVPsNz1XHATLeJwTeKK2fMRuh/zyJv8dqv6yL4eKHdpY4EG2Qm8LSHb
	 n3EZENEaukjRVWCx8nOFUtKDuxJKXmVPGAo+RV+jS5ZcBIS1UAG8OfcatQ5Y9O233p
	 FymIBLmLofnAIa9B0dJl9asEOY/HTYSF00jnLRx2B0fSYM00H2th6UyINaAZHpGlon
	 E77ADh2zC2A1tKNsPgTHIy2blvZ36CbxR8qjj9dA43aY09I7PI0gY5gVWks61tx+cc
	 JI72X9jPLgnjmoGGcHihnavo1AK+fAxW0jFzkHwDlLGt65kJ2R1fzlwnjAKWi5/yXG
	 sw5iY5USpJgfg==
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
Subject: [PATCH v3 5/5] ASoC: wm8904: add DMIC support
Date: Fri,  7 Mar 2025 14:52:44 +0100
Message-Id: <20250307135244.100443-6-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250307135244.100443-1-francesco@dolcini.it>
References: <20250307135244.100443-1-francesco@dolcini.it>
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
index 8a2b98745964..b85872a373c1 100644
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


