Return-Path: <linux-kernel+bounces-197539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB78D6BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 23:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8737A1C258FD
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF83981207;
	Fri, 31 May 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KTACTn4Q"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8730EAD59;
	Fri, 31 May 2024 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717192291; cv=none; b=lBbMhtOgpNk5Ca+zZLPuwnw3aMcMpsa5eLpr99I2dtDAjZw2fDsOgOW154WLzWx/xH/6jRwMQ+XNs3FUo9XQWxd1ofME/7wsz7VFVnaXo9DYx62YVuFZ3ux5zylcKl830pCMUH+qi+tiFUg0XAWtN0iSRxrtelrX4FfCVJd1IPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717192291; c=relaxed/simple;
	bh=04+WeNiKlZeRvQNUcqF3z/qfK0uGdQPsEySldyyd/QE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nlIMgZT0/kBTFjlm4Q3KKOo1k9uZkEOdswZDFLrauUE4wJdkyhWE2aRGfbNcVSpU8NV/QlV7m/U6cVXJl3xE29l0WpCCgU5YTEWTLoiz1JrywmSSEJX0UPAiTANdnOoClpiSq8t55GGUfCazCdKlcgTp630uC2mG8skMI8BLo1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KTACTn4Q; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717192287;
	bh=04+WeNiKlZeRvQNUcqF3z/qfK0uGdQPsEySldyyd/QE=;
	h=From:Date:Subject:To:Cc:From;
	b=KTACTn4QyLzhjtURNz0GjuGW8Y0d56XUFT9jEe1aFuXv59WRB+MkgToQwUTV7Gcoc
	 ucHZWhCfGhNTmPcId6sBnT5AJLYdErTgSy55+/LpZsje9MWONalK80s7uo22HP9x6K
	 UPcLZT+PYnw9i1c3UDa32oG6HBWctx6340MIC5JX/g5MCymPOe4asWqDdODXlNoLUm
	 UoNGHrJcUaumiLBM2wsFlxm12AJKpcsFmOiAjV+HPTNn1G0QmzY1Be8ENRpB1YcZK+
	 YuX8dVOcZQ3aMVyhu1cpL0IUxQhpOKc92lX3Jr5FN+rT6B3pLENIltxJJaZqalgYFT
	 7PcmATw6Dn98g==
Received: from [192.168.1.231] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 754AA3780EC6;
	Fri, 31 May 2024 21:51:25 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Fri, 31 May 2024 17:51:09 -0400
Subject: [PATCH] arm64: dts: mediatek: cherry: Specify pull resistance for
 RSEL GPIOs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240531-tomato-rsel-gpio34-35-fix-v1-1-64ab2545f182@collabora.com>
X-B4-Tracking: v=1; b=H4sIAExGWmYC/x2MQQqAIBAAvyJ7bkFTKfpKdBDbaqFSNCKQ/p50n
 IGZApkSU4ZBFEh0c+ZwVlCNAL+5cyXkuTK0sjXSaoVXONwVMGXacY0ctEFtceEHVW+dn520XnV
 Q+5io6v89Tu/7AUpzSuprAAAA
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

GPIOs 34 and 35 on MT8195 are of type MTK_PULL_PU_PD_RSEL_TYPE, meaning
not only can they be configured as pull-up or pull-down, but the pull
resistance can also be configured.

The current bias setting however doesn't specify a resistance value,
resulting on the following errors:

mt8195-pinctrl 10005000.pinctrl: Not support rsel value 1 Ohm for pin = 34 (GPIO34)
mt8195-pinctrl 10005000.pinctrl: Not support rsel value 1 Ohm for pin = 35 (GPIO35)

Specify the pull resistance for those GPIOs to fix the errors.

Fixes: 5bf7dabe40f2 ("arm64: dts: mediatek: cherry: Document gpios and add default pin config")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts   | 11 ++++++++---
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts | 11 ++++++++---
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts | 11 ++++++++---
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts
index 88123842c818..49664de99b88 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dts
@@ -82,12 +82,17 @@ &pio_default {
 	pins-low-power-hdmi-disable {
 		pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
 			 <PINMUX_GPIO32__FUNC_GPIO32>,
-			 <PINMUX_GPIO33__FUNC_GPIO33>,
-			 <PINMUX_GPIO34__FUNC_GPIO34>,
-			 <PINMUX_GPIO35__FUNC_GPIO35>;
+			 <PINMUX_GPIO33__FUNC_GPIO33>;
 		input-enable;
 		bias-pull-down;
 	};
+
+	pins-low-power-hdmi-rsel-disable {
+		pinmux = <PINMUX_GPIO34__FUNC_GPIO34>,
+			 <PINMUX_GPIO35__FUNC_GPIO35>;
+		input-enable;
+		bias-pull-down = <75000>;
+	};
 };
 
 &sound {
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
index 2fe20e0dad83..2d6522c144b7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
@@ -19,13 +19,18 @@ &pio_default {
 	pins-low-power-hdmi-disable {
 		pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
 			 <PINMUX_GPIO32__FUNC_GPIO32>,
-			 <PINMUX_GPIO33__FUNC_GPIO33>,
-			 <PINMUX_GPIO34__FUNC_GPIO34>,
-			 <PINMUX_GPIO35__FUNC_GPIO35>;
+			 <PINMUX_GPIO33__FUNC_GPIO33>;
 		input-enable;
 		bias-pull-down;
 	};
 
+	pins-low-power-hdmi-rsel-disable {
+		pinmux = <PINMUX_GPIO34__FUNC_GPIO34>,
+			 <PINMUX_GPIO35__FUNC_GPIO35>;
+		input-enable;
+		bias-pull-down = <75000>;
+	};
+
 	pins-low-power-pcie0-disable {
 		pinmux = <PINMUX_GPIO19__FUNC_GPIO19>,
 			 <PINMUX_GPIO20__FUNC_GPIO20>,
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
index dd294ca98194..9049d362a5e0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
@@ -20,13 +20,18 @@ &pio_default {
 	pins-low-power-hdmi-disable {
 		pinmux = <PINMUX_GPIO31__FUNC_GPIO31>,
 			 <PINMUX_GPIO32__FUNC_GPIO32>,
-			 <PINMUX_GPIO33__FUNC_GPIO33>,
-			 <PINMUX_GPIO34__FUNC_GPIO34>,
-			 <PINMUX_GPIO35__FUNC_GPIO35>;
+			 <PINMUX_GPIO33__FUNC_GPIO33>;
 		input-enable;
 		bias-pull-down;
 	};
 
+	pins-low-power-hdmi-rsel-disable {
+		pinmux = <PINMUX_GPIO34__FUNC_GPIO34>,
+			 <PINMUX_GPIO35__FUNC_GPIO35>;
+		input-enable;
+		bias-pull-down = <75000>;
+	};
+
 	pins-low-power-pcie0-disable {
 		pinmux = <PINMUX_GPIO19__FUNC_GPIO19>,
 			 <PINMUX_GPIO20__FUNC_GPIO20>,

---
base-commit: 0e1980c40b6edfa68b6acf926bab22448a6e40c9
change-id: 20240531-tomato-rsel-gpio34-35-fix-185acda05c17

Best regards,
-- 
Nícolas F. R. A. Prado <nfraprado@collabora.com>


