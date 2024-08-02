Return-Path: <linux-kernel+bounces-272097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD309456FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE691C22E51
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653E92C1A5;
	Fri,  2 Aug 2024 04:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="C1eJH1g6"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D0A955;
	Fri,  2 Aug 2024 04:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572767; cv=none; b=Au20grdyAwXq7/JFCXmjWViX3uVDVVzz1WEXVQbmKBt/+eB6hrNkwdUUr5ceqxocExV+fVmEyQGOJtPT8r3ncA8+7AqtFjOHtB03acuUif5Nm419lZS6WTk8PRaQ0fOVFpYFmvJ8sgjfb5TR+MvXbXeX7fIAOCk8l82Q93yIfW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572767; c=relaxed/simple;
	bh=zONA9SkyLWmDKc1n02F0BUeY+z/dBJmzao/S//vVnpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fayYC8zdF/ggddBcAUoEK7JyX5bwcdAUmZmR+jTbIgh8nxgm48RtLX1x45ScBYlBo1FthVzmDFfqdXyfOORCmNAELmk0XmghEEr77e48pBgCNej3lXxS5dhsETVWKKzR4vNuTB4r55qx9CyhKiOdO23Wgyqa757fn1Ek/vOzfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=C1eJH1g6; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722572764;
	bh=rZ69xzA8p2Oow4YuPdd/GjIQm3GsqDIn1wsPABwt06w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=C1eJH1g6eChP1SUlFJkV1MoHLeez3oJaLPt5iLRd4LozsFPF4EhhtyKXNmzQZMPZ4
	 H/aklXY3cTOr+7HgPYkMrt1EjhoZfKe9FRj7Bu4WYq21+oxU9zyNclkGM/tvEu+JnZ
	 20Z5bIh7dA6FUvEwh29s3NpraNohWdsTRvL056MC4dBhnB6Dlv8wY28fbOMXmP5vv/
	 pyRtwbeYka5BSGGArfY/owS405PzQm3fmZRZAggmG4xamlN85qIdHnTZfFaQp/lAeo
	 R/izlKQFlmcpziZVAuizR/h8cyhZWoBQwECN8cSnyZTk1Nt5ROGtdgSUeK8fab5gjG
	 Pa8HjdwyghrfQ==
Received: from [127.0.1.1] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 87CD866E06;
	Fri,  2 Aug 2024 12:26:03 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:19 +0930
Subject: [PATCH 2/7] ARM: dts: aspeed: Specify correct generic compatible
 for CVIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dt-warnings-bmc-dts-cleanups-v1-2-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eddie James <eajames@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1

The ASPEED CVIC binding documents `aspeed,cvic` as the required generic
compatible, but the devicetrees contained `aspeed-cvic`. Update the
devictrees to use `aspeed,cvic` as documented and as required by
the driver implementation. Presumably the bug was the result of some
incoherent thoughts while removing the SoC name at the time of
writing.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi | 2 +-
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
index 267a0c8e828b..ec9563c629df 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g4.dtsi
@@ -123,7 +123,7 @@ vic: interrupt-controller@1e6c0080 {
 		};
 
 		cvic: interrupt-controller@1e6c2000 {
-			compatible = "aspeed,ast2400-cvic", "aspeed-cvic";
+			compatible = "aspeed,ast2400-cvic", "aspeed,cvic";
 			valid-sources = <0x7fffffff>;
 			reg = <0x1e6c2000 0x80>;
 		};
diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 4d805cf344a1..a846df1a65ff 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -140,7 +140,7 @@ vic: interrupt-controller@1e6c0080 {
 		};
 
 		cvic: interrupt-controller@1e6c2000 {
-			compatible = "aspeed,ast2500-cvic", "aspeed-cvic";
+			compatible = "aspeed,ast2500-cvic", "aspeed,cvic";
 			valid-sources = <0xffffffff>;
 			copro-sw-interrupts = <1>;
 			reg = <0x1e6c2000 0x80>;

-- 
2.39.2


