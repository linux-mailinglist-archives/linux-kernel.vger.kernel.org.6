Return-Path: <linux-kernel+bounces-519308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07023A39B69
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381F4173F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E47D241106;
	Tue, 18 Feb 2025 11:49:41 +0000 (UTC)
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1986239563;
	Tue, 18 Feb 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879381; cv=none; b=mAcH6DNioEeSUSiQjPQB74/NBNL9M8PzFDPOkTAJMu9sFVcDUM/+vTgrbv40Tf5OeAv4yriW2iuXIQvGDxl29OSj6hps9oT99ze9P9GBr18JocUmC038CdREg2EdjeDB1ZGHdKIm5K/R6XvpLFEOTfDvwN2h+p/qdIcvZ9JHSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879381; c=relaxed/simple;
	bh=Ol3PdG7TXSBGTvdUg7iseCBh1c9B8ysNU1Mvm04nl1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uE8MfR/cVGNW/KJkv0EmE0Op1TBlA5/UUt5mMvU4f9FlEtqXx3MGFNkGEKjwHue8UVDxLuEm/YE4LLEtyMYyYoVUORc9YbiHuhF2Li4j02/DeZPs6QL5+eR1tkoxIIWJgguHQMne7CByPTjSbIr/Yg+WvbYuk/2PCZyChcVTGHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YxyVg2sRSz6J3;
	Tue, 18 Feb 2025 12:49:31 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YxyVf6L2mzkNs;
	Tue, 18 Feb 2025 12:49:30 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Tue, 18 Feb 2025 12:49:15 +0100
Subject: [PATCH 4/9] arm64: dts: rockchip: disable I2C6 on Puma DTSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-tsd-align-haikou-v1-4-5c44d1dd8658@cherry.de>
References: <20250218-tsd-align-haikou-v1-0-5c44d1dd8658@cherry.de>
In-Reply-To: <20250218-tsd-align-haikou-v1-0-5c44d1dd8658@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

The bus is only exposed on Q7 Camera FFC connector which accepts
external adapters such as Q7 Camera Demo.

The enabling of I2C6 should therefore be done in the adapter Device Tree
Overlay and not in the SoM DTSI, so let's disable it by default.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index f398a55408ee2c8259085cf2325da97cdce3e4de..548bd7b486c185c80be87d433f149c3fac65ae8a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -395,7 +395,6 @@ &hdmi {
 
 &i2c6 {
 	clock-frequency = <400000>;
-	status = "okay";
 };
 
 &i2c7 {

-- 
2.48.1


