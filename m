Return-Path: <linux-kernel+bounces-380198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4399D9AEA15
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF92EB223B9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 15:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04921EC01C;
	Thu, 24 Oct 2024 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jFfH2AG9"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214B31CFEA9;
	Thu, 24 Oct 2024 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729782852; cv=none; b=RhlotWesELqUk4Uh3YVCVNrtizbCmBsL/n2X2cxhs0zY6JMFw8T6rINnkgT8gfwXZdFWJn5T0cnxWN6JNs41DF4Bp0vbYvLXGcRE/b7+Y642Fr1/CSlW3J9QAXJTO39HUpTexr3R50lvJORBfySGkbYW4wQ3oGztdP2LYV/fVOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729782852; c=relaxed/simple;
	bh=Ndp3SJ/8KKLrReY9CNUxED4Pd1m4po2RC7IbR4fRxXM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z73JDkXTQM/gDEUKwInyve3vNOzfkStRb25StDQy1TMzs+3kYWa6OZkk7SWB5pTQ6dEfnEeiC3sX4drdef4GXx4peRQStroi1WE4q8+ajumTKJRTnfoyDPXJz9uwskqPA1hKOM/SPr1vsCTwpUN+7y5Ix1geEbVq77IKRIt3JDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jFfH2AG9; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FuuE2DfjRA1FWJIBJRKhJNQLLqzau7vyr2ycbZbbPws=; b=jFfH2AG9XtE7VrCasB/T4rs65O
	lIfHfZr1jtQ/1kBDTspQU3MMAQESkm4j+ZsnvbKX2GEZ9n2lzQkHtVmAm9vfpQU0TDObEGCuPVc5A
	exRVNIkmgxeN5dWwEKFdNFN8oS1L3rY5QfuoRh3/BKnMWWaV5eARt0Rh0+Cl7ZMuSmKuzORMSuvKC
	ndjRyULbvfeJxUHgkT26UekaZ4wK6MBIYxd0knwDSDw3OeEgUVTcGjwr2cT8s0TzX8ThhsKVPY+fN
	4E3+KmQwTOgdtRLwyfu4prD4Wnm7SKg3DwqDI/OxIOisqMoghXOUuBbwr/iKaE+WtXFH3hUWFjc+B
	GLaVzTDg==;
Received: from i53875b34.versanet.de ([83.135.91.52] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1t3zXK-0004at-OH; Thu, 24 Oct 2024 17:14:06 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH v2 1/3] arm64: dts: rockchip: add HDMI pinctrl to rk3588-tiger SoM
Date: Thu, 24 Oct 2024 17:14:01 +0200
Message-ID: <20241024151403.1748554-2-heiko@sntech.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024151403.1748554-1-heiko@sntech.de>
References: <20241024151403.1748554-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The Tiger SoM routes all relevant HDMI pins to its Q7 connector.
Some from the M0 and some from the M1 set of pins.

Add the necessary pinctrl entry to the hdmi controller for the SoM.
Not all baseboards may use all pins, but even for them it'll serve
documentation purposes.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
index 615094bb8ba3..11c1cb27f9c3 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-tiger.dtsi
@@ -152,6 +152,12 @@ &gpu {
 	status = "okay";
 };
 
+&hdmi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmim1_tx0_cec &hdmim0_tx0_hpd &hdmim1_tx0_scl
+		     &hdmim1_tx0_sda>;
+};
+
 &i2c1 {
 	pinctrl-0 = <&i2c1m0_xfer>;
 };
-- 
2.45.2


