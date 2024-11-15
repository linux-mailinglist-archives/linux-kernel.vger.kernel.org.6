Return-Path: <linux-kernel+bounces-411225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBC39CF4E7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57DB6289EB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6F613D297;
	Fri, 15 Nov 2024 19:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITABjjG3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D51D460E;
	Fri, 15 Nov 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699246; cv=none; b=KxTKqa48XiFIR3c4rRkfHvjBFrjmdGHaJDNpVlVHCjS79as/CxRYtbiFYVjJMZGRZVq+mZvjdKJzweX6FAhPCbBX9+/htIt22AUBZzWLsUXLwtPZv9z8JZ0AUZg6V6rplTfkrxLBaSZX3DYT4fc74rxNN6bvZgwNJ5cPUdgx9QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699246; c=relaxed/simple;
	bh=ZimSmYTYEdCO/HuGAE0r6zdmsNnecnPZd2u48S1TEAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Waw65IFTRAnAK6N94GGGlxiakSF268fW5qPa3BZzpEhVyfMVtusyixI+D8UrvUC21CVA8PWtnStdjto4LRmdCU5beGwf7QbasB+u13wMjaOp35hdRDbnAn/rVY1Imt9/0BoqbiWhMN9w9xmdIP3ohY9vkclHs1arb0O8q/zJG3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITABjjG3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599EBC4CECF;
	Fri, 15 Nov 2024 19:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731699245;
	bh=ZimSmYTYEdCO/HuGAE0r6zdmsNnecnPZd2u48S1TEAQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ITABjjG3H9hZVuc8EnvbwpRtzzKpDXMuTmuZB4KocLheWinw6ngSY5juRbAHy1BK9
	 1nAgSjxQyRD1EuSWt5ontGn6jwcvrjOt2/wOxGH4gXLGkUejKvuPL3BUnnFN+sjcJT
	 3yu+Sa1qvt3TBfM2QlgjeIkwDPYZOTPrlh3oyTqfGb8zkRp30gkF1zwCvqkuntWsvO
	 DKF0eETjPjw0+djUunjUAE0y/5gE4dycvLhLY8tcVE2fBQVg1HzCU6dYj1HSfXfPfm
	 psR99A0K3BxCGCnSrnmNre0/l0BF8zy1Viq41o2bybkLHbLviUPheWkHAI47qbtoGd
	 VF/1aHPRk1jRQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: ti: Remove unused and undocumented "ti,(rx|tx)-fifo-depth" properties
Date: Fri, 15 Nov 2024 13:33:59 -0600
Message-ID: <20241115193359.3618020-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove "ti,(rx|tx)-fifo-depth" properties which are both unused in the
kernel and undocumented. Most likely they are leftovers from downstream.

There are similar properties, but DP83867_PHYCR_FIFO_DEPTH_4_B_NIB
represents the default value so adding them is not necessary.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
index e06a3b178b34..8f64d6272b1b 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
+++ b/arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
@@ -201,8 +201,6 @@ cpsw3g_phy0: ethernet-phy@0 {
 		reset-gpios = <&main_gpio0 44 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <1000>;
 		reset-deassert-us = <1000>;
-		ti,rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-		ti,tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 	};
@@ -230,8 +228,6 @@ icssg1_phy03: ethernet-phy@3 {
 		reset-gpios = <&main_gpio1 47 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <1000>;
 		reset-deassert-us = <1000>;
-		ti,rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-		ti,tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 	};
@@ -242,8 +238,6 @@ icssg1_phy0c: ethernet-phy@c {
 		reset-gpios = <&main_gpio1 51 GPIO_ACTIVE_LOW>;
 		reset-assert-us = <1000>;
 		reset-deassert-us = <1000>;
-		ti,rx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
-		ti,tx-fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 		ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
 		ti,clk-output-sel = <DP83867_CLK_O_SEL_OFF>;
 	};
-- 
2.45.2


