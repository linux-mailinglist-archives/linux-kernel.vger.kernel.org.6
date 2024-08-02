Return-Path: <linux-kernel+bounces-272102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B18D94570E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBFC1C23123
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275DC6A347;
	Fri,  2 Aug 2024 04:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="McD/rsNu"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3B4778E;
	Fri,  2 Aug 2024 04:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572771; cv=none; b=G2CXSJ//dM4b3s0DsdjbgZG8Cb2MZNwiNwaj483gQZHPcR9nJtwTrGbEb4NAPsltbUc4qR5bGIpY79PgSAaEdLQlhhp9lyrCxtG13RZ55J8dCgANIDNekq4sX5RUVmpOCkSgKdQqlUKNql+dlNEEgSuPdBb3n0wFz8WFq5OoPRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572771; c=relaxed/simple;
	bh=IQb18GsEsQhhNQVCdjoBsLAJRtJgr3iLIQ62bcFMy1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JCSfAvf3u3h/v7cb7WIrO+roth5HHrxCAUe5TL0+AFqqk5jkqvVRJ/tcsLTfN5+7e4xcII+g5x7D0/ntSosEvi6KJLQj86YGAuvfd6pjCGFpK79z5l0AARom5ZPA6TqjDXJX+hjthogaAsCrX8OlBxnYe03UdtsuKFCuvU2kX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=McD/rsNu; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722572767;
	bh=cZGQunjjz3bBRdwK5TaMAYgHuGZTvp+2LbpR3fHMKp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=McD/rsNu+SHROYSlJH8AL3nzTcujMWcuCEbLIfovl8Otm/4YGGT2tgCd9vc1RLDFP
	 xsLO0IjMcXScs22DM5Iuq94kZhwYi4qj8Bp9G1FhJZVLrnWlVG1nqYp/t7v1x627vd
	 K/mO6IrwSLXV56b30SJkif27yxIzrtDgZ/aDRhrLoelDmLi82Wvq5Xe+ZeNP6OK8E0
	 DiWuZo45V+6yqZgvsgHRXBNRgfkdRX5HJJI+tOoemxTQrlUm92zonwaELMkOuM3+GM
	 rQZWzqUGsPwP3wAdyQyKo+l+Z9gll0+647wTcvfTVkGM+dIgTTaL3tDGh6Trml6uHd
	 p1VOJfDIwvYCQ==
Received: from [127.0.1.1] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4223C66E0D;
	Fri,  2 Aug 2024 12:26:07 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Fri, 02 Aug 2024 13:55:24 +0930
Subject: [PATCH 7/7] ARM: dts: aspeed-g6: Drop cells properties from
 ethernet nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240802-dt-warnings-bmc-dts-cleanups-v1-7-1cb1378e5fcd@codeconstruct.com.au>
References: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
In-Reply-To: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eddie James <eajames@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1

These are not specified in the binding and produce warnings such as
the following:

```
...
arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:254.27-262.5: Warning (avoid_unnecessary_addr_size): /ahb/ethernet@1e670000: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property
...
arch/arm/boot/dts/aspeed/aspeed-g6.dtsi:264.27-272.5: Warning (avoid_unnecessary_addr_size): /ahb/ethernet@1e690000: unnecessary #address-cells/#size-cells without "ranges", "dma-ranges" or child "reg" property
...
arch/arm/boot/dts/aspeed/aspeed-ast2600-evb-a1.dtb: ethernet@1e660000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
```

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index ae8aa54508b2..8ed715bd53aa 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -234,8 +234,6 @@ mdio3: mdio@1e650018 {
 		mac0: ethernet@1e660000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
 			status = "disabled";
@@ -244,8 +242,6 @@ mac0: ethernet@1e660000 {
 		mac1: ethernet@1e680000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e680000 0x180>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
 			status = "disabled";
@@ -254,8 +250,6 @@ mac1: ethernet@1e680000 {
 		mac2: ethernet@1e670000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e670000 0x180>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC3CLK>;
 			status = "disabled";
@@ -264,8 +258,6 @@ mac2: ethernet@1e670000 {
 		mac3: ethernet@1e690000 {
 			compatible = "aspeed,ast2600-mac", "faraday,ftgmac100";
 			reg = <0x1e690000 0x180>;
-			#address-cells = <1>;
-			#size-cells = <0>;
 			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&syscon ASPEED_CLK_GATE_MAC4CLK>;
 			status = "disabled";

-- 
2.39.2


