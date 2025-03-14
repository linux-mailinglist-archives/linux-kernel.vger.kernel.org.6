Return-Path: <linux-kernel+bounces-561709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08542A61514
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9311890C3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E940F200105;
	Fri, 14 Mar 2025 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="eQVWLrCZ"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0641EF0B4;
	Fri, 14 Mar 2025 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741966585; cv=pass; b=RitO3HJPcFNqM3WHs9ga9md1uqZQKiDrLJm672I9AOI6gP+H5Sb+BbTi32hSIVtXR8pTxd6DrbABaERzZaySFYAfSZj2BvKx1D2YRayL48jqOa9K5yhYpWabbLn8OKLUlaGO5ip77hwvqNtk3fIghX4pykYG5gYyKkEf1cSWDd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741966585; c=relaxed/simple;
	bh=G/zFVmG+15Lykj6GYWMVfaK7lRRiARK4M5/b5w2bulA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jt6yfF9GpnyzbVOCb9Yyej03+glBfXpE9Wanj9715bRNOx9KihLPMTTv90gwscln7fn1HxIDRdBcH9ElsYeAII8D/HaWe1a+S2byygoPxTMrIHJyEutvi+HBOUbBOu3HvaaKAG0ThI/5k8YZfc24aRhdhvH0mDHFWZROoLNLYfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=eQVWLrCZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1741966565; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PH0peLsQ4tiFcVGS74DvmopCRtbGLfiedDR3mEUFVsIwmAl6NFJb/3GXqmc+LPcdInqS9Ry/Oahq1EkdK0asI1sn7uSIlTCSL6DLypuT+H5bWUrAOK60djkTEWDJL9CD1AiQV3u3LBLF+08Gf3j+mOTn17ZAa89fzFTJKUv5kCY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1741966565; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eNFlSyQCkPuL0ajw/pLDK4UmjuztRI2TDMkUK/3j3oY=; 
	b=SryHhGeBYSOe849kXQn2PFWJIyrWBQYBD0hx958FvuHVr0Nii7ECR8b2SEiKokwa6jN9QgUegg+4xlvuEUOQRw/7W8ioz48DQmjOl8OZmsLgDfO7OQvXaolrPKD6Wi5q2pue/7c9PGizzbt1rFn+x3gF/5ZWGG4x3eVLehDQ1nM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1741966565;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=eNFlSyQCkPuL0ajw/pLDK4UmjuztRI2TDMkUK/3j3oY=;
	b=eQVWLrCZK2/8GkddSXPLqkBegW219WZnCOtTiV+S/RP9YbH1OqpotbmdNqZoPBPX
	ilzcXGSiCCdwUfZAE9SCCWRXbvsLqqgQl7QUNr8es8CKLd/8fi7/F3VRJl66/3trg8K
	GEEDLPwJeQaVhVTITxwiyiTq+HUYORYNvzBvk8ks=
Received: by mx.zohomail.com with SMTPS id 1741966563898497.5207724506298;
	Fri, 14 Mar 2025 08:36:03 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Fri, 14 Mar 2025 16:35:50 +0100
Subject: [PATCH] arm64: dts: rockchip: remove ethm0_clk0_25m_out from Sige5
 gmac0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250314-rk3576-sige5-eth-clk-begone-v1-1-2858338fc555@collabora.com>
X-B4-Tracking: v=1; b=H4sIANVM1GcC/zWNQQ6CMBQFr0L+2p9QsKBcxbCA8iw/SNG2GhLC3
 W0kLmcWMxsFeEGgJtvI4yNBFpdAnTIyY+csWIbEVOSFzkt1Zj+Vuq44iIVmxJHNY+IednHgUg3
 q2tVGobpQKjw97rL+6rf2YI/XO03iIanvAtgs8yyxyRzWyP8Rtfv+BbfMeRKeAAAA
X-Change-ID: 20250314-rk3576-sige5-eth-clk-begone-31d19a7c1e68
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Detlev Casanova <detlev.casanova@collabora.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

The GPIO3 A4 pin on the ArmSoM Sige5 is routed to the 40-pin GPIO
header. This pin can serve a variety of functions, including ones of
questionable use to us on a GPIO header such as the 25MHz clock of the
ethernet controller.

Unfortunately, this is the precise function that it is being claimed for
by the gmac0 node in the Sige5 board dts, meaning it can't be used for
anything else despite serving no useful function in this role. Since it
goes through a RS0108 bidirectional voltage level translator with a
maximum data rate of 24Mbit/s in push-pull mode and 2Mbit/s data rate in
open-drain mode, it's doubtful as to whether the 25MHz clock signal
would even survive to the actual user-accessible pin it terminates in.

Remove it to leave the pin for users to play with. It's infinitely more
useful as a GPIO or even as a PWM.

Fixes: 40f742b07ab2 ("arm64: dts: rockchip: Add rk3576-armsom-sige5 board")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
While working on a PWM driver for RK3576 and needing a PWM pin to test
with, I noticed this questionable pinctrl assignment.
---
 arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts b/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
index 78798b0722a3f36831b1d2c9f29acb83910631cf..828bde7fab68dc6bcbd13d75c8a72540b3666071 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3576-armsom-sige5.dts
@@ -194,8 +194,7 @@ &gmac0 {
 		     &eth0m0_tx_bus2
 		     &eth0m0_rx_bus2
 		     &eth0m0_rgmii_clk
-		     &eth0m0_rgmii_bus
-		     &ethm0_clk0_25m_out>;
+		     &eth0m0_rgmii_bus>;
 
 	phy-handle = <&rgmii_phy0>;
 	status = "okay";

---
base-commit: 40a111d0a777f60b71369d835cfe46308a212235
change-id: 20250314-rk3576-sige5-eth-clk-begone-31d19a7c1e68

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


