Return-Path: <linux-kernel+bounces-283231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C1594EEE6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE30B1F214F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43EC18732D;
	Mon, 12 Aug 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bJbOFdPb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F8181CE1;
	Mon, 12 Aug 2024 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470780; cv=none; b=Gsr9VeWLMh+ffF251gzSxiCrj2agMfG0/hJnicQ1YPMMK6i/EjAPXtR7lmUET++fR5xpl9PvdO86Bu7y0AzGy0bpzZE8JyMZPfg5Xq50fIoY2WUlEZguymbiWg8+6E7vQiiSl9XwX/Ag2pAMPk9fT/a26rAl/mYi0T2ZcwnUk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470780; c=relaxed/simple;
	bh=+fqK2xiCZ17sJmDteh/4puTfNOMETKuDEFhcth0uoGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/j1mhiPIJuRRLcRRJMdskYjBO/t92qEg0B/mZirY+VWjfs75Xq5YwGiijgIOkNCyYMNeodnTKNF4sCtauWH4fxP2m61X2GvjOVRq1/A31bQ1OYGrCosRgvFuWdOOed60+zYgZno1gNUkIvboRjrx1DN7Ck3/gCPNjNQ3Df/d/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bJbOFdPb; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470778; x=1755006778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+fqK2xiCZ17sJmDteh/4puTfNOMETKuDEFhcth0uoGg=;
  b=bJbOFdPbC/N/4Ta92kQwv+dTrqzSg5xlFkqppCNSKIap6hEYFvyhIpVQ
   t/UEx4SZFkynAXFCr17AOYtjvIYHbw7k6YCprfUs7RJxU/xVoynSx6o27
   IgDpS8YUDbt+c2oDINVhUJrUnWcLNJMB7DWP5yOaHFVMfBJjGWciOYQOq
   edkyqPFuB7hbkF8UkJBjv527mczP3C2M8+P0tPpXBkZ4amaVlocI0qlpX
   ymE0ccOx3rnNQGBRf8c1wD4skepEI52fG6H9ARau+PZmJ5zXwcB8FltZ3
   K6zCx0PQNiO2wT6MwHeQczHHozYQEHU/ZvLQUezspx9TMBz0HJWWAbvBU
   g==;
X-CSE-ConnectionGUID: PAl1FAApTqKXjGx6IFLj/w==
X-CSE-MsgGUID: WbSHPGvlQlyBJKwjEL8f7g==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="197806944"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:52:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:52:52 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:52:50 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 5/7] ARM: dts: microchip: at91-sama5d2_icp: Add reg_5v to supply PMIC nodes
Date: Mon, 12 Aug 2024 16:52:29 +0300
Message-ID: <20240812135231.43744-6-andrei.simion@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812135231.43744-1-andrei.simion@microchip.com>
References: <20240812135231.43744-1-andrei.simion@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Align with the datasheet by adding regulator-5v which
supplies each node from the regulator using phandle to
regulator-5v through pvin[1-4]-supply and lvin-supply.

Co-developed-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
---
v1 -> v2:
- drop (lvin|pvin[1-4])-supply from each regulators sub-node
- add lvin-supply, pvin[1-4]-supply to PMIC node
---
 arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
index 999adeca6f33..5e2bb517a480 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
+++ b/arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts
@@ -78,6 +78,14 @@ led-blue {
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_MAIN_5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
 };
 
 &adc {
@@ -190,6 +198,11 @@ i2c6: i2c@600 {
 		mcp16502@5b {
 			compatible = "microchip,mcp16502";
 			reg = <0x5b>;
+			lvin-supply = <&reg_5v>;
+			pvin1-supply = <&reg_5v>;
+			pvin2-supply = <&reg_5v>;
+			pvin3-supply = <&reg_5v>;
+			pvin4-supply = <&reg_5v>;
 			status = "okay";
 			lpm-gpios = <&pioBU 7 GPIO_ACTIVE_LOW>;
 
-- 
2.34.1


