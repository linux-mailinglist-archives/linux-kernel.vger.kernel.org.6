Return-Path: <linux-kernel+bounces-286941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C729520A2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A81DB26965
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCF21BBBEE;
	Wed, 14 Aug 2024 17:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b="BXrTPXh5"
Received: from xn--80adja5bqm.su (xn--80adja5bqm.su [198.44.140.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5821A1BBBCC;
	Wed, 14 Aug 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.44.140.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654894; cv=none; b=CyGxZSl4+061jMjVq9zi9TbQy47JuP1dQyHAeaUbZppFW9D0gLn9K9fbDEQwaLnIpQm2DAsTpa01kR8lXp1cUN0pM/uAQgfxD2/9avvpRLWUwrNdJcx/CsxqYox0XFw29GSEFoBJQr3B6QI137zE36FSy82mlIoxh7QeC6OOWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654894; c=relaxed/simple;
	bh=ACf6VgbHVRXgS+SfXwLNva9kdcJ56r93s9Sim2553XU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R45qDaD0xZoLjgtbI2ALwn4Kwgi76b/DhXMhZFUE31LzG0Wxv1WEFIBGbCTuRLNVLoaOayzGgmMl1fBKgAybiiGNCqJ7LoBGCrFsxHbKjdp8GfKrPjsGdmZ8/Ke3BEfjzLnqilPEOkNDUmg1wGiAZGYxiCjlfq8sJVBgWsIiAtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc; spf=pass smtp.mailfrom=xn--80adja5bqm.su; dkim=pass (2048-bit key) header.d=mediatomb.cc header.i=@mediatomb.cc header.b=BXrTPXh5; arc=none smtp.client-ip=198.44.140.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mediatomb.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xn--80adja5bqm.su
Received: by xn--80adja5bqm.su (Postfix, from userid 1000)
	id ADA7340460CF; Wed, 14 Aug 2024 17:01:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 xn--80adja5bqm.su ADA7340460CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mediatomb.cc;
	s=default; t=1723654875;
	bh=ACf6VgbHVRXgS+SfXwLNva9kdcJ56r93s9Sim2553XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BXrTPXh5uUagGPopLbSjTJE+04t339oOT9bQgn2PzWBtwXPg355OBnLtjR1nR+uNE
	 YtrHEk1RQm8Gd2IRYYPSClwFAxG9eI5A3fbiHXiWIRO2P774jXpR4DNT3zxa+HVI/N
	 5EfPr8JYGwC9KW9IKhZ29OnNP1N0oQTp2Zy1+8qiFQxFpRhDE6B8Yo4jzqGEsfTdUQ
	 YwTF335CQOUAV5lcjQnVrz9IgRyXyBOlODit4CLEPCMZIlC1R5MJ3w2e6cqDFjcUhN
	 3QDSkzEKscjAQ9h2YK54jS7zcsAGG4dZAK29xozr/uYYmZ+lUo6nGV+ADsKOcZ2u1f
	 nHadmjNvyMUFw==
From: Sergey Bostandzhyan <jin@mediatomb.cc>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sergey Bostandzhyan <jin@mediatomb.cc>
Subject: [PATCH v3 1/3] arm64: dts: rockchip: Add DTS for FriendlyARM NanoPi R2S Plus
Date: Wed, 14 Aug 2024 17:00:46 +0000
Message-Id: <20240814170048.23816-2-jin@mediatomb.cc>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20240814170048.23816-1-jin@mediatomb.cc>
References: <20240814170048.23816-1-jin@mediatomb.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The R2S Plus is basically an R2S with additional eMMC.

The eMMC configuration for the DTS has been extracted and copied from
rk3328-nanopi-r2.dts, v2017.09 branch from the friendlyarm/uboot-rockchip
repository.

Signed-off-by: Sergey Bostandzhyan <jin@mediatomb.cc>
---
 arch/arm64/boot/dts/rockchip/Makefile         |  1 +
 .../dts/rockchip/rk3328-nanopi-r2s-plus.dts   | 31 +++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index fda1b980eb4b..36258dc8dafd 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2c-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus-lts.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
new file mode 100644
index 000000000000..12eabdbf8fe8
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * (C) Copyright 2018 FriendlyElec Computer Tech. Co., Ltd.
+ * (http://www.friendlyarm.com)
+ *
+ * (C) Copyright 2016 Rockchip Electronics Co., Ltd
+ */
+
+/dts-v1/;
+#include "rk3328-nanopi-r2s.dts"
+
+/ {
+	model = "FriendlyElec NanoPi R2S Plus";
+	compatible = "friendlyarm,nanopi-r2s-plus", "rockchip,rk3328";
+
+	aliases {
+		mmc1 = &emmc;
+	};
+};
+
+&emmc {
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	supports-emmc;
+	disable-wp;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
+	status = "okay";
+};
-- 
2.20.1


