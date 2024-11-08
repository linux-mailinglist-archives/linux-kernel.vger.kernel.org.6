Return-Path: <linux-kernel+bounces-401733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5940C9C1E7C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 14:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98903B25AF2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31251F4FCD;
	Fri,  8 Nov 2024 13:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="JFPz4a0+";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="qN7EopXF"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7C1F667A;
	Fri,  8 Nov 2024 13:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073806; cv=none; b=YT8NQLizSDFYbwMJJ2TpfwQSijmRRn2NAUED3Sccuaa9x9IpxaISIBo+ihZGBVyiKZEmrYbvYEI8vJ8glap+/PTPi8TbjphnVrWYoBljH1xQnn5wZcScRoX5FtWuNLmSrRboEXKeQbe+kDieQSZ5OgYOuZMLke+Q+Vvq0oqb4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073806; c=relaxed/simple;
	bh=ek2MF9xLnq9aTIvJrdM8SWSodirYGcahXo6M5Q+jvqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHAP8QedTR4W7RKojABCRGvSi2211VpF1DWdFbA+EM1dRF7t5XGhSe6tA55pLxX0AwVbjRNzYOtwXshKd6ffgVVFhR2qmZoj5gVnkGkHDuqRSf5uClL3e8IuKzpGM9upXfYf3GAkP1RMEIDqqU0wb8YVwL9MxTq3FQR8u3ijYKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=JFPz4a0+; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=qN7EopXF reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1731073804; x=1762609804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6VEdBueLI1ZjfkzMCSa/X/pKgPcRao7Q2giqmCeJUg0=;
  b=JFPz4a0+7MJQgshn5NQVEbSuqD0JCd8Jmr6L7JxoPzJaYpvwn4vTIowl
   kJNUwFEbzDEUfzNnRerV4V2F48XuN9e6DGKpKlUkWrjjY+FSu8SbM8jCp
   /ZxK9Irne3cqjUwjNKz08EJk150YiTMNWHDnIjOfyJVp4HeBCVvn/0cLZ
   O4JGjO6JeEqO05Dy3YfOISxNTQY0/YR67l6v+NptpMoSC5y6MuzZ5soiy
   1R1GrjQGsI7gQ0rdUc90SSMj4yKjP+8ciRsO7z39FA+fInSY3NoxOuET5
   P62REAApi/PxV9t6q+unRN+ay37x/zLSjYp4zIjrZb2+X/qsueVHyzwgG
   g==;
X-CSE-ConnectionGUID: aoI2RKBZT2ibGUF/b80EQA==
X-CSE-MsgGUID: r4S1ie5dR1KMX8z8cbsF8A==
X-IronPort-AV: E=Sophos;i="6.12,138,1728943200"; 
   d="scan'208";a="39936931"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 08 Nov 2024 14:50:03 +0100
X-CheckPoint: {672E170B-6-1E10F2A5-CC0651E5}
X-MAIL-CPID: 120CD5C5C687A142EBA8A2F52FDF6C04_4
X-Control-Analysis: str=0001.0A682F16.672E170B.006B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2D01F163B29;
	Fri,  8 Nov 2024 14:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1731073798; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=6VEdBueLI1ZjfkzMCSa/X/pKgPcRao7Q2giqmCeJUg0=;
	b=qN7EopXFZllRLFdKTRqqAw/9lu/6zxCkLqnHEOZwd1CfRbVqr1sGVEa6ps2DmDMGt+BPgq
	H7MowwxAOh8aQMFlpvkVyg5eZZEwe4heHOTBtJzlamwxZZoBaBmO0car6OUWcN7Yz6PS97
	Sa28QKLbe5VnL32e5ErQ06Q2WV6sPJyeV5ibiCL/356II0xVgVUw0q4731dX6/90iVptJZ
	j0I0sR9vwj3QE7ippPxeyjncxYTcS980SWbwmxgAlKuQrgbBiJ4B4Qgtaa5A3PGo0q4el0
	0ebPCCEUZ5iDMe5GcShF9KeLkrdXlU3wivsLTF7T+FGg4FyCg9x6t5FmCZIBqQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	=?UTF-8?q?Jo=C3=A3o=20Rodrigues?= <jrodrigues@ubimet.com>,
	Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] ARM: dts: imx7-mba7: Fix SD card vmmc-supply
Date: Fri,  8 Nov 2024 14:49:23 +0100
Message-Id: <20241108134926.1324626-6-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
References: <20241108134926.1324626-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The SD card is directly supplied by VCC3V3. Remove superfluous regulator.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
index a23d7b0a195f1..077700a5f4c3d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
@@ -87,14 +87,6 @@ iio-hwmon {
 			      <&adc2 0>, <&adc2 1>, <&adc2 2>, <&adc2 3>;
 	};
 
-	reg_sd1_vmmc: regulator-sd1-vmmc {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC3V3_SD1";
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
-		regulator-always-on;
-	};
-
 	reg_fec1_pwdn: regulator-fec1-pwdn {
 		compatible = "regulator-fixed";
 		regulator-name = "PWDN_FEC1";
@@ -676,7 +668,7 @@ &usdhc1 {
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz>, <&pinctrl_usdhc1_gpio>;
 	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
-	vmmc-supply = <&reg_sd1_vmmc>;
+	vmmc-supply = <&reg_mba_3v3>;
 	bus-width = <4>;
 	no-1-8-v;
 	no-sdio;
-- 
2.34.1


