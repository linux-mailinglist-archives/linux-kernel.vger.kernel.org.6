Return-Path: <linux-kernel+bounces-283232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F6694EEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6D31C20C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E5717E455;
	Mon, 12 Aug 2024 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1l5cM/0m"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA76181B99;
	Mon, 12 Aug 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723470781; cv=none; b=hu+TzG8pHnv4RGHUEXz0vGdVuyZMmnuK5ixwnh+HcLAysdgon0wd6+X4pSR+uBTIH84JGx/vO36x5+FaXy5rZv8B37kAKSSnKvY0/AXjt+3HtB5Rbx2nkSEHPh/pLK54/fFcgE/+9k/o4zA6YsNSJgZ0MMQqYgQ85cIt+ypRKMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723470781; c=relaxed/simple;
	bh=8KaDYa+r86zA7mubqEAnVFZYtU8rZQrt0Eb5vqfzNM4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlFqd3+dPfte4fkXjq5qhNLRcqbeA0/XexuX4Qtsy2aBOeXiJcPm27YvrEqw6i258tyhNEEtRAA5L8HNlUtCywqtLdcI+wci8iTEzwMluGCihipoNCZ9C4wQorPNaR7ZX4NAH1FkesFGUKKRHfZ70OAXK2JS+fgBWNoio3Yjg6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1l5cM/0m; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723470778; x=1755006778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8KaDYa+r86zA7mubqEAnVFZYtU8rZQrt0Eb5vqfzNM4=;
  b=1l5cM/0mszcgJH/od8UAR8TnbAHDu2NxA8FY9UGplC7pOyYnxq1RkrIh
   ZtG40qEEhYUOAxfff7653TZBFtlWBTrgMVTAfGZxlMd4Tk+wWfTfOJU0Q
   eiAgL2RvKTlQXYvr5HvZNVNgNw+P6MD5AyVhN1wlKbnI3qDVGIe5esDX4
   /fbFmcJy3AvboOPejksnJWUySdatgZFk0NUIl+dwnSyZ1nOzgH0fsPVra
   TVxs6C/J1NqI7i6+X9CqDPJqEBGOOk5iAmpPkimkUEv6muUJmKQ714iYz
   FAuonD/R5Xr4HfkPvpD0c5jjtXZROLQtn5NaNtOf1InGPaFRJ2kxe763S
   A==;
X-CSE-ConnectionGUID: PBrTB/MiTDi13LaLj3S1lQ==
X-CSE-MsgGUID: Ni8j6hcsQCO1jJ8OsjZwig==
X-IronPort-AV: E=Sophos;i="6.09,283,1716274800"; 
   d="scan'208";a="33289890"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 06:52:56 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 06:52:55 -0700
Received: from ROB-ULT-M76677.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 06:52:53 -0700
From: Andrei Simion <andrei.simion@microchip.com>
To: <claudiu.beznea@tuxon.dev>, <broonie@kernel.org>, <lgirdwood@gmail.com>,
	<nicolas.ferre@microchip.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<robh@kernel.org>, <alexandre.belloni@bootlin.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Andrei Simion <andrei.simion@microchip.com>,
	Mihai Sain <mihai.sain@microchip.com>
Subject: [PATCH v2 6/7] ARM: dts: microchip: at91-sama5d27_wlsom1: Add reg_5v to supply PMIC nodes
Date: Mon, 12 Aug 2024 16:52:30 +0300
Message-ID: <20240812135231.43744-7-andrei.simion@microchip.com>
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
 .../boot/dts/microchip/at91-sama5d27_wlsom1.dtsi    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
index 4617805c7748..c173f49cb910 100644
--- a/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
+++ b/arch/arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi
@@ -31,6 +31,14 @@ main_xtal {
 		};
 	};
 
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_MAIN";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-wilc1000";
 		reset-gpios = <&pioA PIN_PA27 GPIO_ACTIVE_HIGH>;
@@ -70,6 +78,11 @@ &i2c1 {
 	mcp16502@5b {
 		compatible = "microchip,mcp16502";
 		reg = <0x5b>;
+		lvin-supply = <&reg_5v>;
+		pvin1-supply = <&reg_5v>;
+		pvin2-supply = <&reg_5v>;
+		pvin3-supply = <&reg_5v>;
+		pvin4-supply = <&reg_5v>;
 		status = "okay";
 		lpm-gpios = <&pioBU 0 GPIO_ACTIVE_LOW>;
 
-- 
2.34.1


