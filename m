Return-Path: <linux-kernel+bounces-273510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6F9946A17
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 16:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373E3281B31
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 14:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBAC1509A9;
	Sat,  3 Aug 2024 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="wBAcmHgH"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC90C8F3;
	Sat,  3 Aug 2024 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722695656; cv=none; b=RcZCVRChwst4mfHgdlYkhJPDPxkSEtLTFqVrlagrvPOobuX4XaXGhGQT4WlaC4qM2UQ1cLWB+1x+8+QDEiCztG3gjU2L8sVeQonjExNo0+POMoGpSZa0FtQlcOvIDATR/I1AKcT/PJQHmwJv9P75aVz9BpdchA+zcVVo/Fl+pkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722695656; c=relaxed/simple;
	bh=owOHmulNCYiFLR9S5cHIHYrchcu6rmh/Rs/wsMUcUNI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=P4/FZOwMvExe9ZwOW0TI/TPs8PvgUehXZGnVfHaj0M+piDRExoTMhfPDXSRRRWowCrCrP8wKFk+9WiQD/yFXZut/ymgh8T/rLLDpmITlNvQmdexe/0A0Y3ejT0Y0od1YPOJ2Jqb3rrqChR1vcj7mtzirjvkV5r5LH2F4KFBSz00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=wBAcmHgH; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722695647;
	bh=owOHmulNCYiFLR9S5cHIHYrchcu6rmh/Rs/wsMUcUNI=;
	h=From:Date:Subject:To:Cc:From;
	b=wBAcmHgHiJsDWuOYvZphH6cDoDrjqrvyB/fdB7/Eroxv1CKLF24N7pCy3U7iNZ4B0
	 Jl0bztbbX/zMMRHzZsDPQ9fQzJpnIfi6r1c48LEkjh6+Fu7MRE/VPLBciCfGWwLN24
	 vGV6GTAB0oiAdtlZEQLHybq/bzshmOD6xrSMZsB1T1Y100iSbb/pseC0DQAI/8+HD7
	 d1bzbhHdUtiup+qSeOA7unNqLAbUNeBeXYvkPfjGLuCOAb/0fiaEksUTzaaNRwuSum
	 yCmwPJ9qLrh+ZJrDYNU/rCc3LU57GIW56OyrVtY34BFmQ+MCU2blUqRD8euzPU+4/J
	 mZ6JoXxlYG6kw==
Received: from [192.168.1.67] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C2E133781480;
	Sat,  3 Aug 2024 14:34:04 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Sat, 03 Aug 2024 10:33:25 -0400
Subject: [PATCH v3] arm64: dts: mediatek: mt8183-kukui: Disable unused
 efuse at 8000000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240803-mtk-socinfo-no-data-probe-err-v3-1-09cfffc7241a@collabora.com>
X-B4-Tracking: v=1; b=H4sIALQ/rmYC/5XNvQ6CMBSG4VshnT0GWkiJk/dhHPpzKo3QQ1rSa
 Aj3bmF00vH9hudbWcLoMbFLtbKI2SdPoYQ4VcwMKjwQvC3NeM3bWtY9TMsTEhkfHEEgsGpRMEf
 SCBgjWNl1vWiFNT1nxZgjOv86/Nu99ODTQvF93OVmX3+VcwMNOM2VsUK1UruroXFUmqI6G5rYr
 mf+l8iLKBXyrqDaGP4tbtv2AXSn/7sgAQAA
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.0

MT8183's Devicetree describes two eFuse regions: one at 8000000 and
another at 11f10000.

The efuse at 8000000, unlike the one at 11f10000 and the efuse on all
other MediaTek SoCs, does not define any cell, including the
socinfo-data ones which the mtk-efuse driver expects to always be
present, resulting in the following errors in the log:

  mtk-socinfo mtk-socinfo.0.auto: error -ENOENT: Failed to get socinfo data
  mtk-socinfo mtk-socinfo.0.auto: probe with driver mtk-socinfo failed with error -2

The efuse at 8000000 is disabled by default but enabled on mt8183-kukui.
Since it is unused, and to prevent the errors from being thrown, disable
it on mt8183-kukui.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
Changes in v3:
- Switched to removing the node from MT8183-kukui's DT instead of
  controlling whether the mtk-socinfo device was registered by mtk-efuse
- Link to v2: https://lore.kernel.org/r/20240708-mtk-socinfo-no-data-probe-err-v2-1-7ae252acbcc2@collabora.com

Changes in v2:
- Added missing include for of.h
- Link to v1: https://lore.kernel.org/r/20240708-mtk-socinfo-no-data-probe-err-v1-1-fb2acd3a47bf@collabora.com
---
 arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
index 6345e969efae..7c8221fe62eb 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
@@ -868,10 +868,6 @@ &mfg {
 	domain-supply = <&mt6358_vgpu_reg>;
 };
 
-&soc_data {
-	status = "okay";
-};
-
 &spi0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&spi0_pins>;

---
base-commit: f524a5e4dfb75b277c9a5ad819ca5f035f490f14
change-id: 20240708-mtk-socinfo-no-data-probe-err-d7558343dc82

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


