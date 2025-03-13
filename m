Return-Path: <linux-kernel+bounces-559734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A01D1A5F8BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 15:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BE3166349
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 14:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25989267F5C;
	Thu, 13 Mar 2025 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPn4BgYo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C06267396;
	Thu, 13 Mar 2025 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876926; cv=none; b=dp/s4r2RwIpCBIem9tdOj2rDGvrSQBKgFAs7eEQ+lN30q7PFWPiaa1hLpssIAknjXNERS18hLunsWWmx3/E2U7Kj7dySHKBq7rrH/YyLG1N1/niBpSMEcIR9pm1LBeAYIUZ+KeI/p2IZt/K8+eeOubb45xXhrxfHnptSoxCIpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876926; c=relaxed/simple;
	bh=OqmxZ0VZnr16HlRT5VfWg8ZyCe63kc9gmBUWsIt79+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MBVuFtKHGqUxnJc/5yv5s8ikgwRJstxeS3g1/OOw1+nDppmOVPuQrVIN1cRwaXpfUbQ6OS3fRVcFg/RsJT2OOLGYhcej6swoR3Q2X4MnFDOSCwm76PTVuqFsRgeWUYHmZc+c3UqDZKD7Az+4DdSkcU3RCh+sDRjt843mo1hwztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPn4BgYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4141C4CEE5;
	Thu, 13 Mar 2025 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741876926;
	bh=OqmxZ0VZnr16HlRT5VfWg8ZyCe63kc9gmBUWsIt79+8=;
	h=From:To:Cc:Subject:Date:From;
	b=WPn4BgYoeIEGfTC75rPPB0YmdhCcuNobSsfJMMyruuDpY4eR2et6+TZnf4/0LXQSr
	 tfYu1KOuAzHpCuW296x+tDsESkQR3TO3vGqjRtHLo+EykkQSBv+dTaxIh5VJuRoWqb
	 pK/gOpPQBnN4T4pCtIgQwz7Ki3QmWHDF1YXMsQOD4DXq25LarnKdfgMuiwBIummy+4
	 +rnHug5ThUP9ZYWI5pUqsBVFuOIeaQxCCMCq1Sq2gISZhs8euORfjsLsTg860i1H3c
	 B9W2Vi4aAQfJK3u/ihs1aIuPdBcXmC3zlbeTBB+4aRWzSlpAbyCD3q6+3cXPaY6d7o
	 LJRPovaOPkQUQ==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH] arm64: dts: ti: k3-am62p-j722s: add rng node
Date: Thu, 13 Mar 2025 15:41:55 +0100
Message-Id: <20250313144155.2382316-1-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the node for the random number generator inside the crypto module.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
This was tested on a J722S/AM67A. Also, according to the TRM this is the
MCU instance of the SA3UL. But it's defined in -main.dtsi. Is this
correct?
---
 arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
index 6e3beb5c2e01..e868e006318e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62p-j722s-common-main.dtsi
@@ -227,9 +227,17 @@ crypto: crypto@40900000 {
 		reg = <0x00 0x40900000 0x00 0x1200>;
 		#address-cells = <2>;
 		#size-cells = <2>;
+		ranges = <0x00 0x40900000 0x00 0x40900000 0x00 0x30000>;
+
 		dmas = <&main_pktdma 0xf501 0>, <&main_pktdma 0x7506 0>,
 		       <&main_pktdma 0x7507 0>;
 		dma-names = "tx", "rx1", "rx2";
+
+		rng: rng@40910000 {
+			compatible = "inside-secure,safexcel-eip76";
+			reg = <0x00 0x40910000 0x0 0x7d>;
+			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	secure_proxy_sa3: mailbox@43600000 {
-- 
2.39.5


