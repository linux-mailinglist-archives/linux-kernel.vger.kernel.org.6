Return-Path: <linux-kernel+bounces-263609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F3793D83E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1E55B2441A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 18:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00C115380A;
	Fri, 26 Jul 2024 18:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="A5/P1Rgq"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7751E493;
	Fri, 26 Jul 2024 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722017887; cv=none; b=aXXlg8s3YuqTBRVHaLOMiziJP6E5aAHFcSTnkm4B7oZCbZJZ8DRRF4n8Pj9tfQ/93smgoCgdsOvfjcLiB7fyEpu+zVOgu1Xc4Z6SoZ+0y8iA0+ityrft8roY73fSdCU3tHce2dpmz8bo/013qPVI723EsZV6dNv78wq8yQ/MVfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722017887; c=relaxed/simple;
	bh=ahpHSbsY5snByWpT+psWqdNXneHz5eR2UhTXSOpSJuo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WrTwSsQiw4djyqoXwD5XFQrbeLB4j+njwfLRHXEJLLG45asIt64Q97fUWqwocvBX90JOrGnJKe9FcR2PY8Q/ZOluoBTkSX7XIFy2L1WadZB1TkoXZPry/4a3AMHKMynaHbtvCnUmjkWy83JddcnWAyzqBuAdyNbZsvCNP8eruOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=A5/P1Rgq; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1148BC0011;
	Fri, 26 Jul 2024 18:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722017883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzzwZRIMf3Tzxd7N00x3LQAknBs3IrccO6DEWuel4oQ=;
	b=A5/P1RgqlIFjF5ttDIOfjWKIeVVj56YVzB3p0s8T2Il7RtaZRahYcaiLSXMpgmmAhPAvLD
	ip7/SUDvfi30x5DYnHTyAtxyq+wu9Y+a4XlTiCVwrbqegCSy/TrUp5AcM0KIyJ/BcVIZuw
	ndNENrH4uTdyp0HPps44ihMR6udGO01j/2yzFI8+F3ir+NWplXrlfr4AVwPQqc86b7pupI
	COXVA5z8Wzy3yOmsns9q2fKRxz2PXIuPmCUqLqWv1OR56LyGuOm0rlFT7jo4RiMR/pon9L
	Hr6Tq92iXBSQirjgIm3lHBq3wrt3/G2+w1uu748soK3HONgIEcJDrNtd2/c0KA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date: Fri, 26 Jul 2024 20:18:00 +0200
Subject: [PATCH v5 12/12] arm64: dts: ti: k3-am64: add USB fallback
 compatible to J721E
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240726-s2r-cdns-v5-12-8664bfb032ac@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
In-Reply-To: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>, 
 Mathias Nyman <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Kevin Hilman <khilman@kernel.org>, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: theo.lebrun@bootlin.com

USB on AM64 is the same peripheral as on J721E. It has a specific
compatible for potential integration details. Express this
relationship, matching what the dt-bindings indicate.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
index f8370dd03350..02c8ed93730f 100644
--- a/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am64-main.dtsi
@@ -759,7 +759,7 @@ timesync_router: pinctrl@a40000 {
 	};
 
 	usbss0: cdns-usb@f900000 {
-		compatible = "ti,am64-usb";
+		compatible = "ti,am64-usb", "ti,j721e-usb";
 		reg = <0x00 0xf900000 0x00 0x100>;
 		power-domains = <&k3_pds 161 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 161 9>, <&k3_clks 161 1>;

-- 
2.45.2


