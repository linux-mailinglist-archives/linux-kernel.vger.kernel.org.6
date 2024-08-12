Return-Path: <linux-kernel+bounces-283262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DDD94EF49
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228741C21F41
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829A817F4F7;
	Mon, 12 Aug 2024 14:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="TXvRYRYq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="dF27kJQ+"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4EE17F374;
	Mon, 12 Aug 2024 14:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472096; cv=none; b=g/bGp5pe00lN6UW5ghfpX1ozHBt/nl3p1UNP7qUoQxEKY4RxcTx7tkDvpxuCF2krbLgVAKh5IgjjeES2oKDBCENoVmqAIomybu4APCsIPs5yaML0PMEMQaXVthaFkwrM3/yBNjP8S7EhE1YOsAP47nLKHvZp25aWTKuHr3trFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472096; c=relaxed/simple;
	bh=rlEDsgMkkb7eGkG0js8s5j1Rd4al26HGUBB0E2KoTz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GxH7Bmpc/n0F2E0OEWXsx44BteucFQ+4dGad0JV2K2A4PA4mgdRlSxf7Pw3/sJh62VUPgNXpkYRK6d1dSs1CLUhcvj3jX8NzCeeMq2XM9qXkovCCc5jesT0kS9Qj4TytRotrZeEYUuiyaQx1+X88WpKyWqNHRc1OVvIkDu7c4dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=TXvRYRYq; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=dF27kJQ+ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723472094; x=1755008094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ckAfo9DkYiPyASgk9rjcpynWjMEuUnfqHOAIkiICZ44=;
  b=TXvRYRYq3xLBOifzKcLq0VDQfTiRlrY8zSktR5XyfzdNxTnHpEoKpzo0
   NfyKfhLc9A9FlKpPYQ7maiquhKIbKsLcaIYmtki0Eqdy+g+Bhj+ov9OQO
   6yw7q3QYFv4bClisJUiWtsbT/eps2Hg68kxTOzqLVYxka01mzP5yOmU3l
   VJtnXbEs0lz5aHyk+6I8kZcWBMGsed3zkhCZ1yTxp21kpXRW6IG43wW7C
   ySTihLewsdt+HvjjusWgb5J4HpDqFLmHhPY00L5QhlR64Moz0QYKuDpmY
   XH57H1Jrfsz2zW50Q/llz1WnO7VHYgJ1oi4eKomSRyfsANQu0q14PFQ8F
   w==;
X-CSE-ConnectionGUID: /qyWjhVuTEi1WDKqoYhieA==
X-CSE-MsgGUID: 6/P48u4sQUaleAIVpuicSA==
X-IronPort-AV: E=Sophos;i="6.09,283,1716242400"; 
   d="scan'208";a="38365462"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2024 16:14:53 +0200
X-CheckPoint: {66BA18DD-12-186E37A7-E5B59163}
X-MAIL-CPID: B363F36F4468971141EAEAC69CA01F0C_2
X-Control-Analysis: str=0001.0A782F24.66BA18DD.0133,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3899A16414E;
	Mon, 12 Aug 2024 16:14:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723472089; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ckAfo9DkYiPyASgk9rjcpynWjMEuUnfqHOAIkiICZ44=;
	b=dF27kJQ+9WPrz2vHEPr9ZQ100Z2hAj6hsDgi4Bo1Hex3pHb6iqu71lgSMDcFC/xRi0MtWn
	x35sp8FYUIJS2M5704SX/LBePP0pOVAfxbn7XxVO1KWmPGjWbKQFLikqeMq7KxLoly6pAO
	s0Ng1aQj6PlrHwrRG2yUgqC6bqe05ua6a6rPMsJrpsosTNmePfcR+tXVEN52vd362/GgvA
	IEwtdLKCmjsAr2Ty+KsgoaXG+slR0fgcsH8IpZLytBfs0uSTLYjyrMXzPlAVzQnM7ZMY/z
	izm6fLjyLUBLVruBHCY/xFvBE9gl8m7w211W5U2k8cR+4garD9ncyFRno8Mliw==
From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 1/2] arm: dts: imx7-mba7: add iio-hwmon support
Date: Mon, 12 Aug 2024 16:14:13 +0200
Message-Id: <20240812141414.96334-2-Markus.Niebel@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812141414.96334-1-Markus.Niebel@ew.tq-group.com>
References: <20240812141414.96334-1-Markus.Niebel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Enable IIO hwmon support for ADC1 and ADC2. All channels are
available on X23 (ADC2) and X24 (ADC1) of MBa7x.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
index 52869e68f833..775bd3066b87 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7-mba7.dtsi
@@ -81,6 +81,12 @@ led2 {
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc1 0>, <&adc1 1>, <&adc1 2>, <&adc1 3>,
+			      <&adc2 0>, <&adc2 1>, <&adc2 2>, <&adc2 3>;
+	};
+
 	reg_sd1_vmmc: regulator-sd1-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "VCC3V3_SD1";
-- 
2.34.1


