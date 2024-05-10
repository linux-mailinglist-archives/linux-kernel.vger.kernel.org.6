Return-Path: <linux-kernel+bounces-175512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC9E8C2097
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8767D28488C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7C617167F;
	Fri, 10 May 2024 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="BZgcQ6Cq"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD814901F;
	Fri, 10 May 2024 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332383; cv=none; b=ghM2L5XLGHAXDoZe6+Bv0WMYOP8qaEjUsW/a2Jsep7E96yyqEXethuwVm1PNeAiByx1w7k/oc0H4uv77iJj44e1jlAOmFrJAtKN8vCcsBQi8rOtkIzSdhDw6XkGEuedMXZkYE/Ao0H6Eq3hfEQbAHqONdTl7haE02rIj/VJwpjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332383; c=relaxed/simple;
	bh=uSjslWhdNNi2fGiyV9jejXP2u12pUMnKo3RJ0zTp1yA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcfODz86qi38hb8KvIiIMGIb8ZISdgGfsVPAByazcchYOE/BjhRopoAF+eCx0sQOHnA79C0YNxjmxVzHgO1rlftzPYfirNcly2XFhnFb7yTpT+9OnCHqpU174A0o82iaTJS2EuemtwXoYRn6ALgvmAHTBXH4iyRn1Lmn2GswDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=BZgcQ6Cq; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 3D0C8100007;
	Fri, 10 May 2024 12:13:00 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3D0C8100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1715332380;
	bh=Qg4pXQQl5Lta582hsxBt1jkX2lzQKNXAMhqzfSLdzUI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=BZgcQ6Cq/su+5ejJmXEURFGJdKwzScavwUXNFiZQu/eT3oteTQ1YFAS8R9N53ZjMZ
	 F/CQnSED1jjoi9RQCQKDUDOVqN3z2pOGvzDsej5Fqnd0REFVlRbO3Ca7nK9Mj54Q1i
	 OZAUz7xGiHE71rE7Gwr+XZ5E8mdT/U+hBj0Oz0a5bD5G2NCI28bEL+OFPXqnMnbwYH
	 fjRgdJ1ewNXGkGJHRERqp0H9w2lJcIwIVzxZhmNEIEDtL9JMgFGB7/8D0NriuX1cUI
	 FJST16/Rhfc5WK9uhS5P9gVshyKGKpSIoCdZqzmmDxlVEK0NU+bt5OCZ6JZlICtRHR
	 xtZJrPKhxygTg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 10 May 2024 12:13:00 +0300 (MSK)
Received: from CAB-WSD-L081021.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 10 May 2024 12:12:59 +0300
From: Dmitry Rokosov <ddrokosov@salutedevices.com>
To: <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <khilman@baylibre.com>,
	<martin.blumenstingl@googlemail.com>
CC: <kernel@salutedevices.com>, <rockosov@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Dmitry Rokosov
	<ddrokosov@salutedevices.com>
Subject: [PATCH v2 2/4] arm64: dts: amlogic: a1: declare cpu clock controller
Date: Fri, 10 May 2024 12:12:24 +0300
Message-ID: <20240510091251.20086-3-ddrokosov@salutedevices.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240510091251.20086-1-ddrokosov@salutedevices.com>
References: <20240510091251.20086-1-ddrokosov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185158 [May 10 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ddrokosov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/05/10 07:36:00 #25144647
X-KSMG-AntiVirus-Status: Clean, skipped

The Amlogic A1 SoC family relies on the CPU clock controller to generate
CPU clocks, serving a crucial function. It has 4 inputs: main
oscillator, fixed clocks and system pll.

Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
index feed2bd7ae48..afb5d7361177 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2019 Amlogic, Inc. All rights reserved.
  */
 
+#include <dt-bindings/clock/amlogic,a1-cpu-clkc.h>
 #include <dt-bindings/clock/amlogic,a1-pll-clkc.h>
 #include <dt-bindings/clock/amlogic,a1-peripherals-clkc.h>
 #include <dt-bindings/clock/amlogic,a1-audio-clkc.h>
@@ -94,6 +95,19 @@ soc {
 		#size-cells = <2>;
 		ranges;
 
+		clkc_cpu: clock-controller@fd000000 {
+			compatible = "amlogic,a1-cpu-clkc";
+			reg = <0 0xfd000080 0 0x8>;
+			#clock-cells = <1>;
+
+			clocks = <&clkc_pll CLKID_FCLK_DIV2>,
+				 <&clkc_pll CLKID_FCLK_DIV3>,
+				 <&clkc_pll CLKID_SYS_PLL>,
+				 <&xtal>;
+			clock-names = "fclk_div2", "fclk_div3",
+				      "sys_pll", "xtal";
+		};
+
 		spifc: spi@fd000400 {
 			compatible = "amlogic,a1-spifc";
 			reg = <0x0 0xfd000400 0x0 0x290>;
-- 
2.43.0


