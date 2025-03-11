Return-Path: <linux-kernel+bounces-556120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0F7A5C130
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 13:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 955833AE251
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8DD253B5C;
	Tue, 11 Mar 2025 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bw4y3Ld5"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB6254851;
	Tue, 11 Mar 2025 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696158; cv=none; b=tVjUDgdfK4Z7CtOvzspOmQ9YQDugJENIDL1sKcYJJBGhydnnNpG4uM34bPVWsv8BowYFrdjv77hS/qDgT83/PCtmspMpKihN22gJz3ETIohAO84BEBNU3xkRts0Z9kHdr8EehToPA3F8S0GvTSciLmdRPMc8CUJrPWiBcmeJwsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696158; c=relaxed/simple;
	bh=N5EXNlqtL69VGYYDyrDYpntJcNL/9MeXJc8QaKRw7gU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kFpAEubiOZ9YK71Zr4D/1FpSZyKsd0QLmf6WF8TZqUtp7lqjXCRER3FU0bQjL8r8FpTXB2DXMZ06G0ExzIDl5Gyr4ZOBdi8ZX4S0w6JuWkT9cbJNDhTIrpC0/g3BkjPu+YLpIPbP5b4+8QN/EyIw5KuFXj285CJxJBdfVyBP9Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bw4y3Ld5; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1741696156; x=1773232156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N5EXNlqtL69VGYYDyrDYpntJcNL/9MeXJc8QaKRw7gU=;
  b=bw4y3Ld5XRk6KLLj8G8hxReOgQV6QUVVoGbzd9o0GvZ9A/b0aBP02AcB
   yib/atQ58cH2pBLSG/KJ66iGe7hp8GuO9N6K/A8fmTcD+T6wsni4Me+/R
   1tj5lSO0huPBdWmZ9+mnG2xFwzS1fB/kyVRwWMWtqGqGvbSpKYd84eekY
   8C1cwcuOjlH68K4Htzw0CAnqbat4Z/SbXT+sRLM4kV5NXZTHOAlfC5aP0
   +f+9Wp4ivmD2ZL101DPRjf+mF6nAGiFxNJwPj07Hid1ILcWlr6CXAS9Ls
   5SMqS7y/ctkmjc5KvN6FmRs/crAVLv2ZpcyXXMZixGympAODBTCghLk1q
   A==;
X-CSE-ConnectionGUID: baDVeSDOToyF+0WNRKcbNA==
X-CSE-MsgGUID: ka0iJvLtR023JNL7dOig9g==
X-IronPort-AV: E=Sophos;i="6.14,239,1736838000"; 
   d="scan'208";a="206334035"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Mar 2025 05:29:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 11 Mar 2025 05:29:01 -0700
Received: from che-lt-i64410lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Tue, 11 Mar 2025 05:28:55 -0700
From: Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
To: <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <krzysztof.kozlowski+dt@linaro.org>
CC: <balamanikandan.gunasundar@microchip.com>,
	<linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] dt-bindings: mtd: microchip-nand: convert txt to yaml
Date: Tue, 11 Mar 2025 17:58:44 +0530
Message-ID: <20250311122847.90081-1-balamanikandan.gunasundar@microchip.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Convert microchip nand controllers from text to yaml

This patch is a respin of
https://lore.kernel.org/all/20240320-linux-next-nand-yaml-v1-0-2d2495363e88@microchip.com/

Summary of changes:

[PATCH v2 1/3] dt-bindings: mtd: microchip-nand: convert txt to yaml
- Change the filename to match the compatible string
- Drop items and oneOf in the compatible property as it is just an enum
- Remove the if in the #address-cells and #size-cells
- Remove the unwanted comments that refers to .txt files
- Fix reg property description
- Define the properties in a list and add constraints
- Fix DT coding style and droped unused labels

[PATCH v2 2/3] dt-bindings: mtd: microchip-nand: add atmel pmecc
- Rename filename to match compatible string
- Add constraints for sam9x7
- Droped unused dt labels 

[PATCH v2 3/3] dt-bindings: mtd: atmel-nand: add legacy nand
- Filename matching the compatibles
- Remove "bindings" from the subject
- Remove "deprecated" as these are the only bindings available for the devices
- Add missing constraints.
- Add default for nand-ecc-mode
- Add 32 in pmecc-cap for sama5d2
- Add default for sector-size, pmecc-lookup-table-offset, nand-bus-width

Balamanikandan Gunasundar (3):
  dt-bindings: mtd: microchip-nand: convert txt to yaml
  dt-bindings: mtd: microchip-nand: add atmel pmecc
  dt-bindings: mtd: atmel-nand: add legacy nand controllers

 .../devicetree/bindings/mtd/atmel-nand.txt    | 227 ------------------
 .../devicetree/bindings/mtd/atmel-nand.yaml   | 163 +++++++++++++
 .../mtd/microchip,nand-controller.yaml        | 175 ++++++++++++++
 .../bindings/mtd/microchip,pmecc.yaml         |  67 ++++++
 4 files changed, 405 insertions(+), 227 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mtd/atmel-nand.txt
 create mode 100644 Documentation/devicetree/bindings/mtd/atmel-nand.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/microchip,nand-controller.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/microchip,pmecc.yaml

-- 
2.34.1


