Return-Path: <linux-kernel+bounces-433214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247979E5537
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B30E18838D6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9547B218E92;
	Thu,  5 Dec 2024 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RIR38fvd"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27250218ACE;
	Thu,  5 Dec 2024 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733400930; cv=none; b=JnYwFba4ebRaUmaxQHl8mfbA0GfFVWSQuNzY2NhoQmc0+r5cnnljPl0YsWyPFtTJyuI2ttnm6cBgKjql845hTMWW5WrKuVPhEWeHNAHqht4UXUQnjeknkTipKMyO241lFqrqnteeprYPKp3IUSK36BG/wvuZlTlU6dyrRbVVZdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733400930; c=relaxed/simple;
	bh=KyZ5CACimQSWxoWyn7gctVe0I3LE7LBdjabpyJ3Zld0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q37baMYUUBb17ZhMZJCB/3la3roTvr/RZV5M6+moMzNjUW8SheKF6D4uApjR0gVkh0MvvFjFXQDmcFF567e312K2iAS0Fj/kj+YnXaBPq0xfSljgbwJnDbCz+M1ASyG4sUvSSEqoj+BAemC1cgiWueIrNnfQrLpgbE48ZgffhZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RIR38fvd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733400927;
	bh=KyZ5CACimQSWxoWyn7gctVe0I3LE7LBdjabpyJ3Zld0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RIR38fvdP35N8NMfgWv85t7hMpo0egF0D84RDrw3gkyHSjpxkOLPR15B/z3TixfXV
	 Ezn7ZGlcHR773nq9JVyBZVFS66WTOQy71yg/tq4FHFegCAFWyHH6ydndKdNpzQn7ro
	 t70vmLOu7109IQECu2TSqAWMIDIx0vlGVFLHHuhPWEsqLZml3DxLPT8GoQ0ZuWIY6e
	 fsvWSlGNYmqEY8gztsy7xGb3dnSK+CxNwzV4IIBtjCoq49eyf9FlsixDFizkrum2MR
	 kN8YIQYd/+N2Fw5RcbZa4VGC+n29REGZM5Hij152p8RqRdLmEmH+ec/U+x1gEtyOlx
	 vUew3GSNnNwVQ==
Received: from [192.168.0.47] (unknown [IPv6:2804:14c:1a9:53ee::1000])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7ECF217E3661;
	Thu,  5 Dec 2024 13:15:23 +0100 (CET)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Thu, 05 Dec 2024 09:13:58 -0300
Subject: [PATCH 5/5] arm64: dts: mediatek: mt8390-genio-700-evk: Add sound
 output support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241205-genio700-audio-output-v1-5-0e955c78c29e@collabora.com>
References: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
In-Reply-To: <20241205-genio700-audio-output-v1-0-0e955c78c29e@collabora.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Trevor Wu <trevor.wu@mediatek.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-sound@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>, 
 Aary Patil <aary.patil@mediatek.com>, 
 Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>, 
 parkeryang <Parker.Yang@mediatek.com>
X-Mailer: b4 0.14.2

Describe all the components to get sound output working on the two audio
jacks, Earphone and Speaker, present on the Genio 700 EVK board with the
audio DSP enabled.

Co-developed-by: Aary Patil <aary.patil@mediatek.com>
Signed-off-by: Aary Patil <aary.patil@mediatek.com>
Co-developed-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
Signed-off-by: Suhrid Subramaniam <suhrid.subramaniam@mediatek.com>
Co-developed-by: parkeryang <Parker.Yang@mediatek.com>
Signed-off-by: parkeryang <Parker.Yang@mediatek.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 .../boot/dts/mediatek/mt8390-genio-700-evk.dts     | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
index bb68665f0b2da80397b833db0241a06648a322a0..2fded39078773e81d8e0313d6b118b3064be308d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
@@ -92,6 +92,24 @@ vpu_mem: memory@57000000 {
 			compatible = "shared-dma-pool";
 			reg = <0 0x57000000 0 0x1400000>; /* 20 MB */
 		};
+
+		adsp_mem: memory@60000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60000000 0 0xf00000>;
+			no-map;
+		};
+
+		afe_dma_mem: memory@60f00000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x60f00000 0 0x100000>;
+			no-map;
+		};
+
+		adsp_dma_mem: memory@61000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x61000000 0 0x100000>;
+			no-map;
+		};
 	};
 
 	common_fixed_5v: regulator-0 {
@@ -209,6 +227,16 @@ usb_p2_vbus: regulator-9 {
 	};
 };
 
+&adsp {
+	memory-region = <&adsp_dma_mem>, <&adsp_mem>;
+	status = "okay";
+};
+
+&afe {
+	memory-region = <&afe_dma_mem>;
+	status = "okay";
+};
+
 &gpu {
 	mali-supply = <&mt6359_vproc2_buck_reg>;
 	status = "okay";
@@ -912,6 +940,28 @@ &scp {
 	status = "okay";
 };
 
+&sound {
+	compatible = "mediatek,mt8390-mt6359-evk", "mediatek,mt8188-mt6359-evb";
+	model = "mt8390-evk";
+	pinctrl-names = "default";
+	pinctrl-0 = <&audio_default_pins>;
+	audio-routing =
+		"Headphone", "Headphone L",
+		"Headphone", "Headphone R";
+	mediatek,adsp = <&adsp>;
+	mediatek,dai-link = "DL_SRC_BE", "UL_SRC_BE", "AFE_SOF_DL2",
+		"AFE_SOF_DL3", "AFE_SOF_UL4", "AFE_SOF_UL5";
+	status = "okay";
+
+	dai-link-0 {
+		link-name = "DL_SRC_BE";
+
+		codec {
+			sound-dai = <&pmic 0>;
+		};
+	};
+};
+
 &spi2 {
 	pinctrl-0 = <&spi2_pins>;
 	pinctrl-names = "default";

-- 
2.47.0


