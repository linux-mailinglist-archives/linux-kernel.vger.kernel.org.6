Return-Path: <linux-kernel+bounces-364660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E821599D790
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF92B21250
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B3C1CC177;
	Mon, 14 Oct 2024 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rusEydND"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783193A1B6;
	Mon, 14 Oct 2024 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728934668; cv=none; b=kd1D/g4DZiKRstTOFpMYhpiDZfUa2T37mg7KEhdab7f814KGcb5tkBTxbn+og9jzF1FDMl6yT0ehUSPmUUcRhLG/qYrDals90F2RXrtF9E7aKswHAgN6DT6FzONmlkVRPuhyyR+QtYA3P0whxvoehrVWnY0MgO1ZmfyUkN32lVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728934668; c=relaxed/simple;
	bh=hZgVMIIvlSiElRRLPiOvCWNvKS24U8DsyY4C2AEMgkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxSh7ybynwuULU0kDLzFkCWa71BOTX9jAwF7KsWYAaah96aVyGlnVeUL06HNeumc2M9mGb8hxrlAMnhcCqNc/AS1mCEZHF4E8KK50cvITCtLWq/HIGCHjPYQY0U2/3kv/TzKxNaTys+DJKnH8H0SmWs02b8VJpjUvJ82Fh095yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rusEydND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE933C4CEC3;
	Mon, 14 Oct 2024 19:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728934668;
	bh=hZgVMIIvlSiElRRLPiOvCWNvKS24U8DsyY4C2AEMgkM=;
	h=From:To:Cc:Subject:Date:From;
	b=rusEydNDNp4pOzhRGecnr4WnpH7fUFJZvv8B5X3EIEl/eAYxVmUUvBFjDDAh0L4lc
	 aoXWtX9sviQoPVD32fayyxfNChv5oBwqYAv/ke8mwPke40c5JkTE7aBzOGFygx7Lte
	 eVk33rVufgQMwoySbGjgralvoSC7LhTmAKfAnozEz5j/7vkxF5sR6sEEhGq5W2XOTo
	 N+WsbpF1eVdwX9YGgxkClh38lphT5PTE6wOBAk3PQf/NI+mO5H+CpgqFR4dnmlNZ7F
	 aWfIjd5RRndtnRl5BOZmZEVCwJ5BFzesCJHzqFBTb+rMajj5fHcUO+MzM4frdQh7Zk
	 wep4T0EjPEIzw==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Wunderlich <linux@fw-web.de>
Subject: [PATCH] arm64: dts: marvell: Drop undocumented SATA phy names
Date: Mon, 14 Oct 2024 14:35:27 -0500
Message-ID: <20241014193528.1896905-2-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While "phy-names" is allowed for sata-port nodes, the names used aren't
documented and are incorrect ("sata-phy" is what's documented). The name
for a single entry is fairly useless, so just drop the property.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Cc: Frank Wunderlich <linux@fw-web.de>

There's also this 2 year old patch fixing other SATA errors[1] which 
was never picked up. :(

[1] https://lore.kernel.org/linux-arm-kernel/20220311210357.222830-3-linux@fw-web.de/

 arch/arm64/boot/dts/marvell/armada-7040-db.dts             | 1 -
 arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts       | 2 --
 arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 1 -
 arch/arm64/boot/dts/marvell/armada-8040-db.dts             | 2 --
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi         | 1 -
 arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts    | 2 --
 6 files changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-7040-db.dts b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
index 5e5baf6beea4..1e0ab35cc686 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-db.dts
@@ -214,7 +214,6 @@ &cp0_sata0 {
 
 	sata-port@1 {
 		phys = <&cp0_comphy3 1>;
-		phy-names = "cp0-sata0-1-phy";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
index 40b7ee7ead72..7af949092b91 100644
--- a/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
+++ b/arch/arm64/boot/dts/marvell/armada-7040-mochabin.dts
@@ -433,13 +433,11 @@ &cp0_sata0 {
 	/* 7 + 12 SATA connector (J24) */
 	sata-port@0 {
 		phys = <&cp0_comphy2 0>;
-		phy-names = "cp0-sata0-0-phy";
 	};
 
 	/* M.2-2250 B-key (J39) */
 	sata-port@1 {
 		phys = <&cp0_comphy3 1>;
-		phy-names = "cp0-sata0-1-phy";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index 67892f0d2863..7005a32a6e1e 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -475,7 +475,6 @@ &cp1_sata0 {
 
 	sata-port@1 {
 		phys = <&cp1_comphy0 1>;
-		phy-names = "cp1-sata0-1-phy";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-db.dts b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
index 92897bd7e6cf..2ec19d364e62 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-db.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-db.dts
@@ -145,11 +145,9 @@ &cp0_sata0 {
 
 	sata-port@0 {
 		phys = <&cp0_comphy1 0>;
-		phy-names = "cp0-sata0-0-phy";
 	};
 	sata-port@1 {
 		phys = <&cp0_comphy3 1>;
-		phy-names = "cp0-sata0-1-phy";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
index c864df9ec84d..e88ff5b179c8 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -245,7 +245,6 @@ &cp0_sata0 {
 	/* CPM Lane 5 - U29 */
 	sata-port@1 {
 		phys = <&cp0_comphy5 1>;
-		phy-names = "cp0-sata0-1-phy";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
index 42a60f3dd5d1..3e5e0651ce68 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-puzzle-m801.dts
@@ -408,12 +408,10 @@ &cp0_sata0 {
 
 	sata-port@0 {
 		phys = <&cp0_comphy2 0>;
-		phy-names = "cp0-sata0-0-phy";
 	};
 
 	sata-port@1 {
 		phys = <&cp0_comphy5 1>;
-		phy-names = "cp0-sata0-1-phy";
 	};
 };
 
-- 
2.45.2


