Return-Path: <linux-kernel+bounces-170932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DED8BDE00
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3336B22896
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F0B714D2BD;
	Tue,  7 May 2024 09:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asus.com header.i=@asus.com header.b="mr++0qhs"
Received: from ms.asus.com (ms.asus.com [103.10.4.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F50314D447;
	Tue,  7 May 2024 09:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.10.4.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073714; cv=none; b=YjjHF3Ih+Ztckhf2t0NO/u4oQ6U48zzqXU4xuydeUEFUxF1+M6XG8o9ajzDpIYgA1E5vpjDki/sIihEUMffyUY2+/aiQ0TDvWCTS7AhqpiyB2FE4QGA/IipbMjNwOCEZhJpO+Mj7Y6HfuvDpG+D6s3INI2dg1GWMaEALy9zNWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073714; c=relaxed/simple;
	bh=IqK7uwxw4v80ki+2QS5Uwd46zm6z/Ba2rQ+qoiCe76I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBUqsZuW5eJ9WacliKVXA1ry4k6s8e9FfWUA8xiieDjXuz9gdIeaUzE28XKngJjzkOwY6Te8QBMklesRni5hgZ68yUBt07fm9eeSy0hcYcqtdFeaPaaOC79vh+loU9SjP3hn702uOjfaxb3u7TqccyBO2RjlMJtgvgGFwE9SfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asus.com; spf=pass smtp.mailfrom=asus.com; dkim=pass (1024-bit key) header.d=asus.com header.i=@asus.com header.b=mr++0qhs; arc=none smtp.client-ip=103.10.4.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asus.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
  t=1715073712; x=1746609712;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IqK7uwxw4v80ki+2QS5Uwd46zm6z/Ba2rQ+qoiCe76I=;
  b=mr++0qhsOCC1e4mjYFudWC1hQWkJWJO/WH5JZlrVWvPXA/tnwZxqPU0C
   7er6e0SueWS2xzfLOJV8+FgvALM/DpfWnDi0FYjGCsewkiBfI+uS9Uj7/
   w/1pJvgZAftf5iAGOUPAgrrgyZ6OhxZINtiFsTOm+nAuwB/syLUljnutF
   o=;
X-IPAS-Result: =?us-ascii?q?A2HcAwBP8jlm/xEvFqxagRKGZx2WIpIni3qBag8BAQEBA?=
 =?us-ascii?q?QEBAQEIAUQEAQGFBgKIMSc4EwECBAEBAQEDAgMBAQEBAQEIAQEBBQEBAQEBA?=
 =?us-ascii?q?QYEAQEBAoEZhS9SgmcBg3gGJ1IQGCAZVgYOBYMAgmW1CDMaZ94xgWsJAYE+g?=
 =?us-ascii?q?WmGRQGEWIRpe4ILRCZvgTuBPm+DfAoIARIBA0oThgUEjjE7glxogl+HUoIEW?=
 =?us-ascii?q?Q+DFIU2SoEHCBQDWTIBVRMNCgs+CRYCFgMbFAQwDwkLJgMqBjYCEgwGBgZZI?=
 =?us-ascii?q?BYJBCMDCAQDRAMgcREDBBoECwd1gzEEE0QDgTiJeoM9KYF3hCBLhHaBeA5ih?=
 =?us-ascii?q?yMDBwUsHUADCxgNSBEsNRQbBiIfbgejLAoJaAEBBToQEC4BE14SK2URBBcnj?=
 =?us-ascii?q?0GDNIM/jlSgboQdgWEMiCOXHBozhAWMfoZBHgMYkjePCYlZoz2FIAIEAgQFA?=
 =?us-ascii?q?heBfIEPcDMaI4EKDlaBSVIXAo48FqIDazsCBwsBAQMJiG4FLywBO2ABAQ?=
IronPort-PHdr: A9a23:PleG/REryhXFaD1wbVvyi51Gf/FLhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k33RmTB9WQsqkMotGVmp6jcFRD26rJiGoFfp1IWk1NouQttCtkPvS4D1bmJuXhdS0wE
 ZcKflZk+3amLRodQ56mNBXdrXKo8DEdBAj0OxZrKeTpAI7SiNm82/yv95HJbAhEmj6wbalsI
 BmorgjdudQajIV/Iast1xXFpWdFdOtRyW50P1yfmAry6Nmt95B56SRQvPwh989EUarkeqkzU
 KJVAjc7PW0r/cPnrRbMQxeB6XsaSWUWjwFHAxPZ4xHgX5f+qTX1u+xg0ySHJ8L2TLQ0WTO/7
 6d3TRLjlSkKOyIl/GzRl8d9l7xQrg6/qBNjwo7UeICVO+R4fqPBZtMRWG5NUt9MWyBdHo+wa
 o0CBPcDM+lFtYnwv1sAowWgCAexCu3hyThGiX343aI13OouDQDG0Rc8H9IXqnnYsM/4OLsOX
 e2z0aLGzS/Db/RT2Trl7YbHbBQhofWMXLltc8TR1E8vFwzYhViXrILqITeV1uANsmaZ8upgU
 +2vhnU9pAFqvziv3d0ghZXOhoIQ013J8zhyz4kpK9OiUkF7fcKkH4VKtyGcL4Z7Qt8uTmFot
 ig01LAKp4K3cSYExpg5yRDSb/KJfpaH7xzjVuucLzV1iWxkdb++hhu/8lWtxvHgWsWozVtHs
 ihIn9/RvX4Ozxze8tWLR/lj8ku7xzqDyRrf5+5GLEwuiKbWKYYtz78tmpYJr0jPAy77lF/3g
 aKWbEko5+ul5ubhb777uJKcM5J0ihriMqswgMyxHOU4MwkQUGWD5eix0qDo81fjT7VQlPI2l
 7HUsJXdJcsGuKG0GxRV0oM/6xanCDemzcgYkWEHLF1bfBKHiJDkNU/ULvzhCvmxjU2gnzh3y
 /zbJLHuHpLNLmLbkLfnY7l991RQxxAozdBC/JJYErABIPTtVU/trNHUEx00PxKuz+r5Ftlxz
 IwTVGCVDqOEMq7eqVqI6fguI+mIao8VojH9K/096vDrk3A5nVsdfKmr05sKbnC4Ee9rLF+CY
 XrxmdcNC3sFvg07TODyjl2NSiZcZ2yuUKIk+jE7FIWmAJ/eSoywmLCBxju0HoVKZmBaDVCBC
 W3od4KfVPcMby6dP9NhnycHVbe/UY8h0w+htAvgx7pgNOrU9TUUtYj/29ht++3TiRYy+CR3D
 8SH0mCMT3p0n2IURz8x0qBzu099ylCC0Kh8hPxZG8dT5/BIUgs9KJHc0/d3C9TzWgLHZNiJU
 lGmTs+hATErQdI928UObFplG9W+khDD2DKnDKMSl7yNA5w06KXQ0GXtJ8tmyHbJyrMhj184T
 ctLL2GmgbR/9wfLC47Tj0qZj7qqdbgb3CPV9meDynSBvEVDXQ5yVKXFRmoTZkrLotjj/EzCU
 qeiCa47PQtZ1c6CNqxKZ8XzglVAWfjjIsrRYmyqlmisAhaH262DY5bte2UbxyXdFFIEkx0P8
 naaLwQxGiCho2fEADN0CFK8K3/rpL1kr3m7DUMo5wKHdUts0/yy4BFD1tKGTPZG/b8AvDZpi
 yhyEx7p/N/SD8ugugxuVKxHfMh761BCgzGK/zdhN4CtevgxzmUVdB566ga3j00fNw==
IronPort-Data: A9a23:g8CkHK8YwmMOhOOlzWhlDrUDNX+TJUtcMsCJ2f8bNWPcYEJGY0x3y
 WcdCm3XPa2CMWCjKoggbY3k80pTvMWAx9FnSwY5/C8xFiIbosfsO4+Ufxz6V8+wBpSYFRo4t
 a3ySTViwOQcFCK0SsKFb+CJQUFUjP3OHPynYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzBXf8s9JKGjNMg068gE431BjCkGtwlkAzY/lNoGjfmxE9ZH7IDfrpR5dQatA88t+SH
 44v/pnglo/q105F5ueer1rOWhZirog+neS5oiE+t6CK2nCur8Gpu0oxHKJ0hUx/011lkz3to
 TnkWFPZpQoBZ8XxdOohvxZwAQthGpRZ85L9IWW1lOCZ41OFeVTS6qA7ZK02FdVwFudfPVkL0
 NBdFmhUKBuEnfqwza79Q/JxnazPLuGyY9lZ4CsmkW6fVKlOrZPrGs0m4fd70TM0l+BTG/n2b
 tEEcnxkaxGojxhnYAtNV8xvxrjx7pX5WydG8nW5mJZt32uQ4gkv6qbwd8f1R9PfEK25mW7d/
 Aoq5V/RGBYQNJ+T1RKG/2iqi+uJmjn0MKoRDq+p7ex2h1PVxWsBDBoJTli64vWlokq/XdtFL
 AoT4CVGhaM18kuxDdXhdx61uniJulgbQdU4O+895QWlyK/PpQeVQGEZJhZIbtA8udAeTjsm2
 1SOmcj1HyFkrPueTnfb/6r8hT+/JykeIHMYaCIsUwQI+Z/grZs1gxaJScxseIaxj9voCXT52
 TXPryUkgbgXpcoKzLmgu1HBjSilqpXAQkgy/Aq/dmak6B5pIYe+f4Gl5XDf7O1cN8CeXF2It
 mNCnNKRhMgKDJeQhGmOTf8LEbWB+fmIKnvfjERpEp1n8C6ik1akZY1W6jR1DENoKdofPzj7Z
 EbZokVW/pA7FHCta6htJY62DMAn3IDlFN//UfvUb8IIaZ90HDJr5wk3OhTWhTqrzBdqyP5X1
 YqnTPtAxE0yUcxPpAdajc9EiOZDKvwWrY8Lea3G8g==
IronPort-HdrOrdr: A9a23:or6/TKlch1Ben9XDCR3DZmg4fe/pDfIE3DAbv31ZSRFFG/Fxl6
 iV8MjzsiWE7Ar5OUtQ/uxoV5PvfZqxz/RICMwqTNSftWrdyQ6VxeNZjLcKqgeIc0bDH6xmpM
 VdmsBFebvN5DNB4voSjjPULz52q+P3iJxA/d2/8547d3ASV0klhD0JcTqmLg==
X-Talos-CUID: 9a23:r/c9KWzaE5cKxGkVVFa6BgUGMN8CS2LW4U3QPkWdJWxFVv6fZmG5rfY=
X-Talos-MUID: 9a23:xX9XrAsWzN1d/gMVa82nni84E+tV3/6SCwMjlMs8pdTDKAxNNGLI
X-IronPort-Anti-Spam-Filtered: true
Received: from unknown (HELO TP-MD-V01.corpnet.asus) ([172.22.47.17])
  by ms.asus.com with ESMTP; 07 May 2024 17:21:23 +0800
Received: from localhost.localdomain (61.216.65.187) by TP-MD-V01.corpnet.asus
 (172.22.47.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Tue, 7 May
 2024 17:21:22 +0800
From: Kelly Hung <KellyHung@asus.com>
To: <robh+dt@kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <kelly_hung@asus.com>, <Allenyy_Hsu@asus.com>,
	Kelly Hung <KellyHung@asus.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 2/2] ARM: dts: aspeed: x4tf: Add dts for asus x4tf project
Date: Tue, 7 May 2024 17:21:09 +0800
Message-ID: <20240507092109.6018-3-KellyHung@asus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507092109.6018-1-KellyHung@asus.com>
References: <20240507092109.6018-1-KellyHung@asus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: APZA002EXB.corpnet.asus (172.22.6.14) To
 TP-MD-V01.corpnet.asus (172.22.47.17)
X-TM-SNTS-SMTP:
	18C1675AAF97219EE6E7D6FA2CDAC8D1DC0A65C15AD99EE009624A9B2B27B0DC2000:8

Base on aspeed-g6.dtsi and can boot into BMC console.

Signed-off-by: Kelly Hung <KellyHung@asus.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v7 -> v8:
- Modify Signed-off-by field with new ASUS smtp account.
- Add back Acked-by tag.
v6 -> v7:
- Remove incorrect tags.
- Modify Signed-off-by field.
v5 -> v6:
- add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
- add Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
- add Reviewed-by: Rob Herring <robh@kernel.org>
- add Acked-by: Conor Dooley <conor.dooley@microchip.com>
- remove the v3's Reviewed-by: Zev Weiss <zweiss@equinix.com>.
V4 -> V5: None
V3 -> V4: None
V2 -> V3:
- fmc lable change to bmc.
- use 64M partition layout.
- rename spi1 label to bios.
- remove bios partition section.
- add Reviewed-by: Zev Weiss <zweiss@equinix.com>
V1 -> V2:
- do schema check and remove all warings.
- remove all unnecessary sections.
---
 arch/arm/boot/dts/aspeed/Makefile             |   1 +
 .../boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts  | 581 ++++++++++++++++++
 2 files changed, 582 insertions(+)
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts

diff --git a/arch/arm/boot/dts/aspeed/Makefile b/arch/arm/boot/dts/aspeed/M=
akefile
index d3ac20e31..32c41f3d9 100644
--- a/arch/arm/boot/dts/aspeed/Makefile
+++ b/arch/arm/boot/dts/aspeed/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_ASPEED) +=3D \
        aspeed-bmc-arm-stardragon4800-rep2.dtb \
        aspeed-bmc-asrock-e3c246d4i.dtb \
        aspeed-bmc-asrock-romed8hm3.dtb \
+       aspeed-bmc-asus-x4tf.dtb \
        aspeed-bmc-bytedance-g220a.dtb \
        aspeed-bmc-delta-ahe50dc.dtb \
        aspeed-bmc-facebook-bletchley.dtb \
diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts b/arch/arm/b=
oot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
new file mode 100644
index 000000000..64f4ed07c
--- /dev/null
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-asus-x4tf.dts
@@ -0,0 +1,581 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+// Copyright 2024 ASUS Corp.
+
+/dts-v1/;
+
+#include "aspeed-g6.dtsi"
+#include "aspeed-g6-pinctrl.dtsi"
+#include <dt-bindings/i2c/i2c.h>
+#include <dt-bindings/gpio/aspeed-gpio.h>
+
+/ {
+       model =3D "ASUS-X4TF";
+       compatible =3D "asus,x4tf-bmc", "aspeed,ast2600";
+
+       aliases {
+               serial4 =3D &uart5;
+       };
+
+       chosen {
+               stdout-path =3D "serial4:115200n8";
+       };
+
+       memory@80000000 {
+               device_type =3D "memory";
+               reg =3D <0x80000000 0x40000000>;
+       };
+
+       reserved-memory {
+               #address-cells =3D <1>;
+               #size-cells =3D <1>;
+               ranges;
+
+               video_engine_memory: video {
+                       size =3D <0x04000000>;
+                       alignment =3D <0x01000000>;
+                       compatible =3D "shared-dma-pool";
+                       reusable;
+               };
+       };
+
+       iio-hwmon {
+               compatible =3D "iio-hwmon";
+               io-channels =3D <&adc0 0>, <&adc0 1>, <&adc0 2>, <&adc0 3>,
+                               <&adc0 4>, <&adc0 5>, <&adc0 6>, <&adc0 7>,
+                               <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+                               <&adc1 4>, <&adc1 5>, <&adc1 6>, <&adc1 7>;
+       };
+
+       leds {
+               compatible =3D "gpio-leds";
+
+               led-heartbeat {
+                       gpios =3D <&gpio0 ASPEED_GPIO(P, 7) GPIO_ACTIVE_LOW=
>;
+                       linux,default-trigger =3D "heartbeat";
+               };
+
+               led-uid {
+                       gpios =3D <&gpio0 ASPEED_GPIO(P, 1) (GPIO_ACTIVE_LO=
W | GPIO_OPEN_DRAIN)>;
+                       default-state =3D "off";
+               };
+
+               led-status_Y {
+                       gpios =3D <&gpio1 ASPEED_GPIO(B, 1) GPIO_ACTIVE_LOW=
>;
+                       default-state =3D "off";
+               };
+
+               led-sys_boot_status {
+                       gpios =3D <&gpio1 ASPEED_GPIO(B, 0) GPIO_ACTIVE_LOW=
>;
+                       default-state =3D "off";
+               };
+       };
+};
+
+&adc0 {
+       vref =3D <2500>;
+       status =3D "okay";
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_adc0_default &pinctrl_adc1_default
+               &pinctrl_adc2_default &pinctrl_adc3_default
+               &pinctrl_adc4_default &pinctrl_adc5_default
+               &pinctrl_adc6_default &pinctrl_adc7_default>;
+};
+
+&adc1 {
+       vref =3D <2500>;
+       status =3D "okay";
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_adc8_default &pinctrl_adc9_default
+               &pinctrl_adc10_default &pinctrl_adc11_default
+               &pinctrl_adc12_default &pinctrl_adc13_default
+               &pinctrl_adc14_default &pinctrl_adc15_default>;
+};
+
+&peci0 {
+       status =3D "okay";
+};
+
+&lpc_snoop {
+       snoop-ports =3D <0x80>;
+       status =3D "okay";
+};
+
+&mac2 {
+       status =3D "okay";
+       phy-mode =3D "rmii";
+       use-ncsi;
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_rmii3_default>;
+};
+
+&mac3 {
+       status =3D "okay";
+       phy-mode =3D "rmii";
+       use-ncsi;
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_rmii4_default>;
+};
+
+&fmc {
+       status =3D "okay";
+
+       flash@0 {
+               status =3D "okay";
+               m25p,fast-read;
+               label =3D "bmc";
+               spi-max-frequency =3D <50000000>;
+#include "openbmc-flash-layout-64.dtsi"
+       };
+};
+
+&spi1 {
+       status =3D "okay";
+       pinctrl-names =3D "default";
+       pinctrl-0 =3D <&pinctrl_spi1_default>;
+
+       flash@0 {
+               status =3D "okay";
+               label =3D "bios";
+               spi-max-frequency =3D <50000000>;
+       };
+};
+
+&i2c0 {
+       status =3D "okay";
+};
+
+&i2c1 {
+       status =3D "okay";
+};
+
+&i2c2 {
+       status =3D "okay";
+};
+
+&i2c3 {
+       status =3D "okay";
+};
+
+&i2c4 {
+       status =3D "okay";
+
+       temperature-sensor@48 {
+               compatible =3D "ti,tmp75";
+               reg =3D <0x48>;
+       };
+
+       temperature-sensor@49 {
+               compatible =3D "ti,tmp75";
+               reg =3D <0x49>;
+       };
+
+       pca9555_4_20: gpio@20 {
+               compatible =3D "nxp,pca9555";
+               reg =3D <0x20>;
+               gpio-controller;
+               #gpio-cells =3D <2>;
+       };
+
+       pca9555_4_22: gpio@22 {
+               compatible =3D "nxp,pca9555";
+               reg =3D <0x22>;
+               gpio-controller;
+               #gpio-cells =3D <2>;
+       };
+
+       pca9555_4_24: gpio@24 {
+               compatible =3D "nxp,pca9555";
+               reg =3D <0x24>;
+               gpio-controller;
+               #gpio-cells =3D <2>;
+               gpio-line-names =3D
+               /*A0 - A3 0*/   "", "STRAP_BMC_BATTERY_GPIO1", "", "",
+               /*A4 - A7 4*/   "", "", "", "",
+               /*B0 - B7 8*/   "", "", "", "", "", "", "", "";
+       };
+
+       pca9555_4_26: gpio@26 {
+               compatible =3D "nxp,pca9555";
+               reg =3D <0x26>;
+               gpio-controller;
+               #gpio-cells =3D <2>;
+       };
+
+       i2c-mux@70 {
+               compatible =3D "nxp,pca9546";
+               status =3D "okay";
+               reg =3D <0x70>;
+               #address-cells =3D <1>;
+               #size-cells =3D <0>;
+
+               channel_1: i2c@0 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <0>;
+               };
+
+               channel_2: i2c@1 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <1>;
+               };
+
+               channel_3: i2c@2 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <2>;
+               };
+
+               channel_4: i2c@3 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <3>;
+               };
+       };
+};
+
+&i2c5 {
+       status =3D "okay";
+
+       pca9555_5_24: gpio@24 {
+               compatible =3D "nxp,pca9555";
+               reg =3D <0x24>;
+               gpio-controller;
+               #gpio-cells =3D <2>;
+       };
+
+       i2c-mux@70  {
+               compatible =3D "nxp,pca9546";
+               status =3D "okay";
+               reg =3D <0x70 >;
+               #address-cells =3D <1>;
+               #size-cells =3D <0>;
+
+               channel_5: i2c@0 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <0>;
+
+                       pca9555_5_5_20: gpio@20 {
+                               compatible =3D "nxp,pca9555";
+                               reg =3D <0x20>;
+                               gpio-controller;
+                               #gpio-cells =3D <2>;
+                               gpio-line-names =3D
+                                       "", "", "", "", "", "", "", "",
+                                       "", "", "SYS_FAN6", "SYS_FAN5",
+                                       "SYS_FAN4", "SYS_FAN3",
+                                       "SYS_FAN2", "SYS_FAN1";
+                       };
+
+                       pca9555_5_5_21: gpio@21 {
+                               compatible =3D "nxp,pca9555";
+                               reg =3D <0x21>;
+                               gpio-controller;
+                               #gpio-cells =3D <2>;
+                       };
+
+                       power-monitor@44 {
+                               compatible =3D "ti,ina219";
+                               reg =3D <0x44>;
+                               shunt-resistor =3D <2>;
+                       };
+               };
+
+               channel_6: i2c@1 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <1>;
+               };
+
+               channel_7: i2c@2 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <2>;
+               };
+
+               channel_8: i2c@3 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <3>;
+               };
+       };
+};
+
+&i2c6 {
+       status =3D "okay";
+
+       pca9555_6_27: gpio@27 {
+               compatible =3D "nxp,pca9555";
+               reg =3D <0x27>;
+               gpio-controller;
+               #gpio-cells =3D <2>;
+       };
+
+       pca9555_6_20: gpio@20 {
+               compatible =3D "nxp,pca9555";
+               reg =3D <0x20>;
+               gpio-controller;
+               #gpio-cells =3D <2>;
+               gpio-line-names =3D
+               /*A0 0*/        "", "", "", "", "", "", "", "",
+               /*B0 8*/        "Drive_NVMe1", "Drive_NVMe2", "", "",
+               /*B4 12*/       "", "", "", "";
+       };
+
+       pca9555_6_21: gpio@21 {
+               compatible =3D "nxp,pca9555";
+               reg =3D <0x21>;
+               gpio-controller;
+               #gpio-cells =3D <2>;
+       };
+};
+
+&i2c7 {
+       status =3D "okay";
+
+       i2c-mux@70 {
+               compatible =3D "nxp,pca9546";
+               status =3D "okay";
+               reg =3D <0x70>;
+               #address-cells =3D <1>;
+               #size-cells =3D <0>;
+               idle-state =3D <1>;
+
+               channel_9: i2c@0 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <0>;
+
+                       temperature-sensor@48 {
+                               compatible =3D "ti,tmp75";
+                               reg =3D <0x48>;
+                       };
+
+                       temperature-sensor@49 {
+                               compatible =3D "ti,tmp75";
+                               reg =3D <0x49>;
+                       };
+
+                       power-monitor@40 {
+                               compatible =3D "ti,ina219";
+                               reg =3D <0x40>;
+                               shunt-resistor =3D <2>;
+                       };
+
+                       power-monitor@41 {
+                               compatible =3D "ti,ina219";
+                               reg =3D <0x41>;
+                               shunt-resistor =3D <5>;
+                       };
+               };
+
+               channel_10: i2c@1 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <1>;
+               };
+
+               channel_11: i2c@2 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <2>;
+               };
+
+               channel_12: i2c@3 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <3>;
+               };
+       };
+
+       i2c-mux@71 {
+               compatible =3D "nxp,pca9546";
+               status =3D "okay";
+               reg =3D <0x71>;
+               #address-cells =3D <1>;
+               #size-cells =3D <0>;
+               i2c-mux-idle-disconnect;
+
+               channel_13: i2c@0 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <0>;
+               };
+
+               channel_14: i2c@1 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <1>;
+               };
+
+               channel_15: i2c@2 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <2>;
+               };
+
+               channel_16: i2c@3 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <3>;
+               };
+       };
+};
+
+&i2c8 {
+       status =3D "okay";
+
+       i2c-mux@70 {
+               compatible =3D "nxp,pca9546";
+               status =3D "okay";
+               reg =3D <0x70>;
+               #address-cells =3D <1>;
+               #size-cells =3D <0>;
+               i2c-mux-idle-disconnect;
+
+               channel_17: i2c@0 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <0>;
+               };
+
+               channel_18: i2c@1 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <1>;
+
+                       temperature-sensor@48 {
+                               compatible =3D "ti,tmp75";
+                               reg =3D <0x48>;
+                       };
+
+                       power-monitor@41 {
+                               compatible =3D "ti,ina219";
+                               reg =3D <0x41>;
+                               shunt-resistor =3D <5>;
+                       };
+               };
+
+               channel_19: i2c@2 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <2>;
+               };
+
+               channel_20: i2c@3 {
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+                       reg =3D <3>;
+               };
+       };
+};
+
+&i2c9 {
+       status =3D "okay";
+};
+
+&i2c10 {
+       status =3D "okay";
+};
+
+&i2c11 {
+       status =3D "okay";
+};
+
+&i2c14 {
+       status =3D "okay";
+       multi-master;
+
+       eeprom@50 {
+               compatible =3D "atmel,24c08";
+               reg =3D <0x50>;
+       };
+
+       eeprom@51 {
+               compatible =3D "atmel,24c08";
+               reg =3D <0x51>;
+       };
+};
+
+&sgpiom0 {
+       status =3D "okay";
+       ngpios =3D <128>;
+};
+
+&video {
+       status =3D "okay";
+       memory-region =3D <&video_engine_memory>;
+};
+
+&sdc {
+       status =3D "okay";
+};
+
+&lpc_snoop {
+       status =3D "okay";
+       snoop-ports =3D <0x80>;
+};
+
+&kcs1 {
+       aspeed,lpc-io-reg =3D <0xca0>;
+       status =3D "okay";
+};
+
+&kcs2 {
+       aspeed,lpc-io-reg =3D <0xca8>;
+       status =3D "okay";
+};
+
+&kcs3 {
+       aspeed,lpc-io-reg =3D <0xca2>;
+       status =3D "okay";
+};
+
+&uart3 {
+       status =3D "okay";
+};
+
+&uart5 {
+       status =3D "okay";
+};
+
+&uart_routing {
+       status =3D "okay";
+};
+
+&vhub {
+       status =3D "okay";
+};
+
+&gpio0 {
+       gpio-line-names =3D
+       /*A0 0*/        "", "", "", "", "", "", "", "",
+       /*B0 8*/        "", "", "", "", "", "", "PS_PWROK", "",
+       /*C0 16*/       "", "", "", "", "", "", "", "",
+       /*D0 24*/       "", "", "", "", "", "", "", "",
+       /*E0 32*/       "", "", "", "", "", "", "", "",
+       /*F0 40*/       "", "", "", "", "", "", "", "",
+       /*G0 48*/       "", "", "", "", "", "", "", "",
+       /*H0 56*/       "", "", "", "", "", "", "", "",
+       /*I0 64*/       "", "", "", "", "", "", "", "",
+       /*J0 72*/       "", "", "", "", "", "", "", "",
+       /*K0 80*/       "", "", "", "", "", "", "", "",
+       /*L0 88*/       "", "", "", "", "", "", "", "",
+       /*M0 96*/       "", "", "", "", "", "", "", "",
+       /*N0 104*/      "", "", "", "",
+       /*N4 108*/      "POST_COMPLETE", "ESR1_GPIO_AST_SPISEL", "", "",
+       /*O0 112*/      "", "", "", "", "", "", "", "",
+       /*P0 120*/      "ID_BUTTON", "ID_OUT", "POWER_BUTTON", "POWER_OUT",
+       /*P4 124*/      "RESET_BUTTON", "RESET_OUT", "", "HEARTBEAT",
+       /*Q0 128*/      "", "", "", "", "", "", "", "",
+       /*R0 136*/      "", "", "", "", "", "", "", "",
+       /*S0 144*/      "", "", "", "", "", "", "", "",
+       /*T0 152*/      "", "", "", "", "", "", "", "",
+       /*U0 160*/      "", "", "", "", "", "", "", "",
+       /*V0 168*/      "", "", "", "", "", "", "", "",
+       /*W0 176*/      "", "", "", "", "", "", "", "",
+       /*X0 184*/      "", "", "", "", "", "", "", "",
+       /*Y0 192*/      "", "", "", "", "", "", "", "",
+       /*Z0 200*/      "", "", "", "", "", "", "", "";
+};
--
2.25.1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
This email and any attachments to it contain confidential information and a=
re intended solely for the use of the individual to whom it is addressed. I=
f you are not the intended recipient or receive it accidentally, please imm=
ediately notify the sender by e-mail and delete the message and any attachm=
ents from your computer system, and destroy all hard copies. Please be advi=
sed that any unauthorized disclosure, copying, distribution or any action t=
aken or omitted in reliance on this, is illegal and prohibited. Any views o=
r opinions expressed are solely those of the author and do not represent th=
ose of ASUSTeK.

For pricing information, ASUS is only entitled to set a recommendation resa=
le price. All customers are free to set their own price as they wish.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

