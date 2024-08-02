Return-Path: <linux-kernel+bounces-272095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6239456FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0F0F1C22EFB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B991A20B28;
	Fri,  2 Aug 2024 04:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="XTzwrr3J"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBAF1849;
	Fri,  2 Aug 2024 04:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722572767; cv=none; b=h71MzLml4xwJdeG17hx4xsrL6tIi5/6e+OtSqqrZ+cnpwCXohef/meHswUM2umKIOdDs5wcd72ghDQcLlHzGW/d0b2tZRH8wpOvraE8+CZMuJFrfp/tD9ZWFP3bCO9WDRmew+CAdqqlUyOltgiUGsPrMOCkcLQhecQaKSGGAp7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722572767; c=relaxed/simple;
	bh=3hBRJvntTiyYuzIFnkhSopf0xqfMOU6zKl3VkRH1WZ0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jo8BNY1iX6STyVsyNB6kapDBBjb0WlKQ2d8rSGVrh4KgVOogxrgfCiomI4qh06Pg0BgikLX3sd+JA/fhd97WZvujGuJnEMq/06tF6SxSCEjBzbriVQgbAjVIsyGERe46KI28SWF42nsJVJCatv4j2v+PWEOSIX8m32iC7Jcb+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=XTzwrr3J; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1722572762;
	bh=zOz6JpiahHTKjU39EjbGDoJvjEGQPwoBp3gU7ztZvHE=;
	h=From:Subject:Date:To:Cc;
	b=XTzwrr3JXHrpV90rv9mqQnOvJhUgUkMIoxq95Qzu95jrIqGuaqHJMd+rfPn3WKH84
	 NAJd7CCVuNc2hXm+80BD7Y+GAY7+Qal0AxYR+iLERV5nfRErbLiVfF8FgFbkGG9fue
	 woAEvuco9LIw+rMwIo8KgxCLTOm5YxX/dD7Ro1ce3VJ+AhpBDE886GWgTAxJlfNK/S
	 cToYvo2FzjE+pQScyIk1f0c6RKJJ+dBWtjU996wvWAByKwkizOt+Bjh5wokTq6J4U9
	 TJdfTgcXNR+5eSTwfkPCn069ocolONEDROExlBpCaCey1HNGMAixcM2q8DA1f90QF0
	 73jE7UTUTVazw==
Received: from [127.0.1.1] (ppp118-210-29-70.adl-adc-lon-bras31.tpg.internode.on.net [118.210.29.70])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 8B72765665;
	Fri,  2 Aug 2024 12:26:00 +0800 (AWST)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PATCH 0/7] ARM: dts: aspeed: Miscellaneous devicetree cleanups
Date: Fri, 02 Aug 2024 13:55:17 +0930
Message-Id: <20240802-dt-warnings-bmc-dts-cleanups-v1-0-1cb1378e5fcd@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK1frGYC/x3MwQqDMAwA0F+RnBeoZVjdr8gObc1qwEVp1Aniv
 1t2fJd3glJmUnhVJ2TaWXmWgvpRQRy9JEIeisEa+zStsTis+PNZWJJi+MZixTiRl21RpCY0LnT
 emtpBKZZMHz7+ff++rhuMRX+fbgAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eddie James <eajames@linux.ibm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.1

Hello,

As mentioned elsewhere the Aspeed devicetrees are in a bit of a sad
state. This series is a collection of fixes that make them a little
less so.

If there no concerns raised in the near future I'll queue them up for
the BMC tree.

Andrew

---
Andrew Jeffery (7):
      ARM: dts: aspeed: Fix coprocessor interrupt controller node name
      ARM: dts: aspeed: Specify correct generic compatible for CVIC
      ARM: dts: aspeed: Specify required properties for sram node
      ARM: dts: aspeed: Remove undocumented XDMA nodes
      ARM: dts: aspeed: Clean up AST2500 pinctrl properties
      ARM: dts: aspeed-g6: Use generic 'ethernet' for ftgmac100 nodes
      ARM: dts: aspeed-g6: Drop cells properties from ethernet nodes

 .../boot/dts/aspeed/aspeed-bmc-ampere-mtjade.dts   |  4 ---
 .../aspeed/aspeed-bmc-arm-stardragon4800-rep2.dts  |  4 ---
 .../boot/dts/aspeed/aspeed-bmc-asrock-x570d4u.dts  |  4 ---
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts |  5 ----
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts |  5 ----
 .../arm/boot/dts/aspeed/aspeed-bmc-ibm-rainier.dts |  5 ----
 .../boot/dts/aspeed/aspeed-bmc-inspur-fp5280g2.dts |  4 ---
 .../boot/dts/aspeed/aspeed-bmc-inspur-on5263m5.dts |  4 ---
 .../boot/dts/aspeed/aspeed-bmc-intel-s2600wf.dts   |  4 ---
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-lanyang.dts |  4 ---
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-nicole.dts |  4 ---
 .../arm/boot/dts/aspeed/aspeed-bmc-opp-romulus.dts |  4 ---
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-swift.dts  |  4 ---
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts |  5 ----
 .../boot/dts/aspeed/aspeed-bmc-opp-witherspoon.dts |  9 -------
 arch/arm/boot/dts/aspeed/aspeed-bmc-opp-zaius.dts  |  2 --
 .../dts/aspeed/aspeed-bmc-supermicro-x11spi.dts    |  4 ---
 arch/arm/boot/dts/aspeed/aspeed-g4.dtsi            |  7 ++++--
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi            | 18 ++++----------
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi            | 29 +++-------------------
 20 files changed, 14 insertions(+), 115 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240802-dt-warnings-bmc-dts-cleanups-e6b67b9a2017

Best regards,
-- 
Andrew Jeffery <andrew@codeconstruct.com.au>


