Return-Path: <linux-kernel+bounces-338019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6798E985278
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A30F1F24139
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 05:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED5E1547C8;
	Wed, 25 Sep 2024 05:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b="E05DyR1R"
Received: from lf-2-39.ptr.blmpb.com (lf-2-39.ptr.blmpb.com [101.36.218.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265B5132103
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 05:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727242390; cv=none; b=KxebMC81cv568Nr7q8WKXTBjw2sx/XCBC0wNevBxwHlQysSW4vFY/uN1eFAKGwrVBQINKCITwauAPGcSDhFPHxHyGDfoU8DG+Lip5mzF6DphbjToyJW4hNqb08IzTb781iNf+F2x9tgM2FG8mLGTeGXmo9r391XBknqF8c6OBlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727242390; c=relaxed/simple;
	bh=pY5HGIlMKAd5za9b7tsGT6njGR3a4mg2/8YoQIaVdJ0=;
	h=To:Subject:Date:Message-Id:Content-Type:Cc:Mime-Version:From; b=oDr2dk3PLp3TOiwoW4pAoTHhkeJ+gMn+GkIrVuaPZdNYcDiHE35jHIfFblhxg/2hI+nmcUKYls1aXv2nDiC0KT5/MBsd0k19NaKvPBFRKqiVk92frC1GGTDiklX+VoYlH/Hc+MsgTRlvDQW1SvEdHfxM80fiJH+DnpTkORfmVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io; spf=pass smtp.mailfrom=deepcomputing.io; dkim=pass (2048-bit key) header.d=deepcomputing-io.20200927.dkim.feishu.cn header.i=@deepcomputing-io.20200927.dkim.feishu.cn header.b=E05DyR1R; arc=none smtp.client-ip=101.36.218.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=deepcomputing.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deepcomputing.io
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=deepcomputing-io.20200927.dkim.feishu.cn; t=1727242314;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=iy42TWjLv/vDM34ep/68yh7Y4irPt0UekOnR/gtNfl0=;
 b=E05DyR1RNb8queUCubKTEN3uMM6XfAn6VsNShwMqcLw1tMfezT7op6z/ZRV2LXHVI9vbm/
 frqjCWzUyfnYBKV1HBKbFeHM5tEX7s3KOM0mRn9a0ostCmhQvxEWtC4lSHLOTAUQBqLRU3
 ioSWiL9k04u/QS0q1o73LlqP0q6difjzDIDigvLRmjyTrkZjD3rNdRPd9iX1/wGvhnO6ZL
 cXnNahRAz1Fkq+bcOSXLrO60oWTYznKr0v9mc6INcz/iiXMqVwXaJhj24HTCMFWo7ltJnf
 IsGwS1Ezvg25SCGa/nlzhLJGNKH9KDT4Pam0dKRypvkeNl/dyYP5JN804hXdrQ==
To: "Emil Renner Berthing" <kernel@esmil.dk>
Content-Transfer-Encoding: 7bit
X-Original-From: Sandie Cao <sandie.cao@deepcomputing.io>
Subject: [PATCH v3 2/3] dt-bindings: riscv: starfive: add deepcomputing,fm7110
Date: Wed, 25 Sep 2024 13:31:22 +0800
Message-Id: <20240925053123.1364574-3-sandie.cao@deepcomputing.io>
Received: from roma-MacBookPro.. ([61.141.249.39]) by smtp.feishu.cn with ESMTPS; Wed, 25 Sep 2024 13:31:52 +0800
Content-Type: text/plain; charset=UTF-8
Cc: "Conor Dooley" <conor@kernel.org>, "Rob Herring" <robh@kernel.org>, 
	"Krzysztof Kozlowski" <krzk+dt@kernel.org>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Albert Ou" <aou@eecs.berkeley.edu>, 
	"Heiko Stuebner" <heiko.stuebner@cherry.de>, 
	"Neil Armstrong" <neil.armstrong@linaro.org>, <rafal@milecki.pl>, 
	"Linus Walleij" <linus.walleij@linaro.org>, 
	"Michael Zhu" <michael.zhu@starfivetech.com>, 
	"Drew Fustini" <drew@beagleboard.org>, <linux-riscv@lists.infradead.org>, 
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<dhs@frame.work>, <ams@frame.work>, <gregkh@linuxfoundation.org>, 
	<yuning.liang@deepcomputing.io>, <huiming.qiu@deepcomputing.io>, 
	"Sandie Cao" <sandie.cao@deepcomputing.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1
X-Lms-Return-Path: <lba+266f3a049+90373d+vger.kernel.org+sandie.cao@deepcomputing.io>
From: "Sandie Cao" <sandie.cao@deepcomputing.io>

Add deepcomputing,fm7110 into compatible list.

DeepComputing is creating a RISC-V Framework Laptop 13 Mainboard 
powered by a StarFive JH7110 processor.This is a developer-focused 
product, aimed at making tinkering with RISC-V more accessible.
The Mainboard is under development and we'll share more on functionality, 
compatibility, and availability as the program progresses.

For this Mainboard, the Model name in Framework is Framework FRANME0000;
the Model name in DeepComputing is DeepComputing fm7110.

The board features:

- JH7110 SoC
- 8 GiB LPDDR4 DRAM
- 1x Type-c(PD3.0:60W Max;usb3.2 Gen1;usb2.0;DP1.4:4K@30Hz/2.5K@60Hz)
- 1x Type-c(PD3.0:60W Max,usb3.2 Gen1;usb2.0)
- 2x Type-c(usb3.2 Gen1;usb2.0)
- 1x eMMC slot Support 32G/128G
- 1x MicroSD slot
- 1x QSPI Flash
- 1x PCIe Wi-Fi (Support AMD RZ616 Wi-Fi 6E,Intel Wi-Fi 6E AX210 No vPro)

Signed-off-by: Sandie Cao <sandie.cao@deepcomputing.io>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index 4d5c857b3cac..778617e1dc43 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -26,6 +26,7 @@ properties:
 
       - items:
           - enum:
+              - deepcomputing,fm7110
               - milkv,mars
               - pine64,star64
               - starfive,visionfive-2-v1.2a
-- 
2.34.1

