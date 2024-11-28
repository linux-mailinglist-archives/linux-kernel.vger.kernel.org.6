Return-Path: <linux-kernel+bounces-424867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB149DBA79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 16:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D6E281BA4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB8D1BD9D5;
	Thu, 28 Nov 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hmWY0Zt+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9AF1BD9C1;
	Thu, 28 Nov 2024 15:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732807565; cv=none; b=VDaakH4LX3n115xLOssb4iPVIXr9wt48GKuYpImnnY5d/8f6qI8U5ns1DJMfH6KvETRUFoktwLI/wfKitz/v4XTpF4KQF8GPIdsnY9j8S+NGbbFd2ima1DqNM9irReWZzHa2gNDuepwykoMbVloWAZSCi4g4CoUeVBBAw9fGosQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732807565; c=relaxed/simple;
	bh=g810kAl+76OQ/4YxppQXydRnBCHRq1jvESwrtTuhF6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IshvZHiUqBQjMFYHLEbmk08iJW7fqnwnBKja3zQhuvC0S9qJmgAAxe+rvJE7iXqDxewYj7omEZosgKNB1dlf8cGR56o80cXUlFtDgel1YpKPfZf6gXVbPWBXpXzmuLQKnbxkEuJVNUAT7tH/WDKEfphWPPmndzkvEV26VfogIDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hmWY0Zt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE71C4CED3;
	Thu, 28 Nov 2024 15:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732807564;
	bh=g810kAl+76OQ/4YxppQXydRnBCHRq1jvESwrtTuhF6I=;
	h=From:To:Cc:Subject:Date:From;
	b=hmWY0Zt+AHRBnOkCBzBNQSAP8i5XhfJvJWqTn6KhkHhw+W852QT1POwbL516InTRa
	 x4p5ROfbEWlyCPd6qpg4ax9VeYkd8/PRudEFKB+eWrbFdrqLBTBJ4aGI0bFgLWtR1b
	 sL9NZ50nkWF0q7+Ngk1XsUfjHNqPcap73qcINJp/1hGyWH8HDJWOQM4TSYUn+aXRSh
	 VUGpRnZZepYLzn8Vp7UpxG1J6iRiKOGGIerJN9iYuq8KOWAIyx6uqx/CjKjQ1M48aI
	 CwxPvee9vYyBbq54QwAWRk9FQP0hpB8FfJS0i9hcUxNtN0zh+jLZ/Y0aNtExqWQoTy
	 dP4RgqGCTr5Vg==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH] arm64: dts: fvp: Update bus-range property
Date: Thu, 28 Nov 2024 20:55:43 +0530
Message-ID: <20241128152543.1821878-1-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These days, the Fixed Virtual Platforms(FVP) Base RevC model supports
more PCI devices. Update the max bus number so that Linux can enumerate
them correctly. Without this, the kernel throws the below error while
booting with the default hierarchy

pci_bus 0000:01: busn_res: [bus 01] end is updated to 01
pci_bus 0000:02: busn_res: can not insert [bus 02-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
pci_bus 0000:02: busn_res: [bus 02-01] end is updated to 02
pci_bus 0000:02: busn_res: can not insert [bus 02] under [bus 00-01] (conflicts with (null) [bus 00-01])
pci_bus 0000:03: busn_res: can not insert [bus 03-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
pci_bus 0000:03: busn_res: [bus 03-01] end is updated to 03
pci_bus 0000:03: busn_res: can not insert [bus 03] under [bus 00-01] (conflicts with (null) [bus 00-01])
pci_bus 0000:04: busn_res: can not insert [bus 04-01] under [bus 00-01] (conflicts with (null) [bus 00-01])
pci_bus 0000:04: busn_res: [bus 04-01] end is updated to 04
pci_bus 0000:04: busn_res: can not insert [bus 04] under [bus 00-01] (conflicts with (null) [bus 00-01])
pci 0000:00:01.0: BAR 14: assigned [mem 0x50000000-0x500fffff]

The change is using 0xff as max bus nr because the ECAM window is 256MB in size.

pci-host-generic 40000000.pci: ECAM at [mem 0x40000000-0x4fffffff] for [bus 00-01]

lspci output with and without the change
without fix:
00:00.0 Host bridge: ARM Device 00ba (rev 01)
00:01.0 PCI bridge: ARM Device 0def
00:02.0 PCI bridge: ARM Device 0def
00:03.0 PCI bridge: ARM Device 0def
00:04.0 PCI bridge: ARM Device 0def
00:1e.0 Unassigned class [ff00]: ARM Device ff80
00:1e.1 Unassigned class [ff00]: ARM Device ff80
00:1f.0 SATA controller: Device 0abc:aced (rev 01)
01:00.0 SATA controller: Device 0abc:aced (rev 01)

with fix:
00:00.0 Host bridge: ARM Device 00ba (rev 01)
00:01.0 PCI bridge: ARM Device 0def
00:02.0 PCI bridge: ARM Device 0def
00:03.0 PCI bridge: ARM Device 0def
00:04.0 PCI bridge: ARM Device 0def
00:1e.0 Unassigned class [ff00]: ARM Device ff80
00:1e.1 Unassigned class [ff00]: ARM Device ff80
00:1f.0 SATA controller: Device 0abc:aced (rev 01)
01:00.0 SATA controller: Device 0abc:aced (rev 01)
02:00.0 Unassigned class [ff00]: ARM Device ff80
02:00.4 Unassigned class [ff00]: ARM Device ff80
03:00.0 PCI bridge: ARM Device 0def
04:00.0 PCI bridge: ARM Device 0def
04:01.0 PCI bridge: ARM Device 0def
04:02.0 PCI bridge: ARM Device 0def
05:00.0 SATA controller: Device 0abc:aced (rev 01)
06:00.0 Unassigned class [ff00]: ARM Device ff80
06:00.7 Unassigned class [ff00]: ARM Device ff80
07:00.0 Unassigned class [ff00]: ARM Device ff80
07:00.3 Unassigned class [ff00]: ARM Device ff80
08:00.0 Unassigned class [ff00]: ARM Device ff80
08:00.1 Unassigned class [ff00]: ARM Device ff80

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
 arch/arm64/boot/dts/arm/fvp-base-revc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/arm/fvp-base-revc.dts b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
index 289c5f9d1c8d..225a1ed8aa08 100644
--- a/arch/arm64/boot/dts/arm/fvp-base-revc.dts
+++ b/arch/arm64/boot/dts/arm/fvp-base-revc.dts
@@ -233,7 +233,7 @@ pci: pci@40000000 {
 		#interrupt-cells = <0x1>;
 		compatible = "pci-host-ecam-generic";
 		device_type = "pci";
-		bus-range = <0x0 0x1>;
+		bus-range = <0x0 0xff>;
 		reg = <0x0 0x40000000 0x0 0x10000000>;
 		ranges = <0x2000000 0x0 0x50000000 0x0 0x50000000 0x0 0x10000000>;
 		interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


