Return-Path: <linux-kernel+bounces-233757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4D991BCA9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0651F24514
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D225415358F;
	Fri, 28 Jun 2024 10:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUxtLCh+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C22D249F9;
	Fri, 28 Jun 2024 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719570646; cv=none; b=rXJaM73rbvt4tgDylVVvJ7VafZU91oiai9C4vMOiCIXM0lT6t2KBX+zwXRHHEqYgVgIXWAroO2HXYCVVatXsGqM9fUEODU4OZvoPWUAzvzjhSyfEQ6LwS4b4wzOZJRS05tabJdOGVfw20SfFen6xRK+sFNBsMbp5ZA3oBT5Vcm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719570646; c=relaxed/simple;
	bh=7s5ogNzyt8BizN/SoVLnkRF+hEWXvPTRujMkUyZErLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DkQPGnAipKufoiA6Thd5B03pNMQWbW4U9sWhSkOQEC8QaQcOcK7ewnKxeMxcrVm3B6Dh7LR8nXwar09MAdXvLd/SGDfBaRa9R/cR/y6VTpXmKNiMBa0VclKW1RRHlX3LOP2cnqSSt35glg8d9pg4ElFzBQ59zFX/eKSYU+x5SLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUxtLCh+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BD0C116B1;
	Fri, 28 Jun 2024 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719570645;
	bh=7s5ogNzyt8BizN/SoVLnkRF+hEWXvPTRujMkUyZErLY=;
	h=From:Date:Subject:To:Cc:From;
	b=ZUxtLCh+gISZAFfU51+R9ukNxdOpfXfdMATsOR0bnFGwYxMe6UJbh/5XxEJu8IL3J
	 J0q7xUcOQjz4sfcb/y2vLYPFx0rHXfUO4mL3p9xYmaP1OU7AIuJCs+IE4Um8Swbluc
	 Dq36N+cfPOsMZHAGv3QU/sUFXfkqbySgggleXJYCgNn3Be85HUPWOLcE3Sv7h6tRYT
	 /HNG3vq4Q0jUZlMzdB7ydkYb5QcNhCDk3PX1yeophQ9lFmSrZK4ydbA2etTvMdlmDt
	 RL7ONioUrUbMivKrSqiBs8FdZY/1FnFRDKKY4SY3mEor/yT4bl1lTdn3vzA7yWkJlW
	 r55wM+GDKgFUQ==
From: Roger Quadros <rogerq@kernel.org>
Date: Fri, 28 Jun 2024 13:30:38 +0300
Subject: [PATCH v2] arm: dts: k3-am642-evm-nand: Add bootph-all to NAND
 related nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240628-am642-evm-nand-bootph-v2-1-387bfa1533a6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAM2QfmYC/4WNQQ6CMBBFr0Jm7ZgyJSiuvIdhUdqBNkpLWtJoC
 He3cgGX7yX//Q0SR8cJbtUGkbNLLvgCdKpAW+UnRmcKAwlqREsS1dw2hJxn9MobHEJYF4tCDu1
 1aHRnOoayXSKP7n10H31h69Ia4ue4yfXP/ivmGms0WqpRXpSURPcnR8+vc4gT9Pu+fwHvnuWfu
 wAAAA==
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: srk@ti.com, praneeth@ti.com, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=7s5ogNzyt8BizN/SoVLnkRF+hEWXvPTRujMkUyZErLY=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBmfpDSZOU8hSI99GVUPgn9G3ICVU+3t9tzQvw0H
 V5QhXeLqE+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZn6Q0gAKCRDSWmvTvnYw
 k8H+EACSdGr548OGGWaZq4OAozn6mmUvihviAE7ad0oY0H/4C59IXrIUkdsZ3UJl7WTae9CyjEg
 Jot18sY0gg08MreYNdVIgVlX299CLkiYpp2dwwEhNQY2NHVbXDkrkePJSkMFSgi/5Iw3u508oue
 2hwHXWjui2fWftiDiftjU2JH0JMn/vMn5KCDcxRHJVWlO0iGb7bhwfGkQABfEA1oJlXwjUZZBCe
 xPl8ALxcd8snGHT9DacvFHCCFyMb/htv4c4/BVhIuaYsF3EMQeH/yVdPIhz/R8MbDO8JGOFZrD2
 tw0qNOmM9fJTroFxQSg4sOmEfDU4JpqX7c5FEx2gCIcA+2xAyXIF4Imx+UfDX+qJTP2IjQdWWOp
 lhi2J1vbJ4rm0GSo29EZMbrrGMKfQATe0YhqaaN8fiOxiwDOEA4FRKS3jT0JdGTBETG3ysM+5UG
 HOdQLR4PMxlPulb7+9/kA7QxDOctI1YMzkppzWSbz/+ypP0J/DQZNFUnIjzh+S+LkFvsjnDju4n
 nE2Mwsi6t+AtOBQb2exd+Il5eGON3giMpCaN0Ce66ZY5OM8nCIZaHFN48gUaS+TNCPwaSXcQhhd
 xIR2l/ODpTm1a7iw9U9E8ZqfFgyy2j+z5FEFHaM0ZW01hy7Ucjjb+K8OKpgw5nE5qp7oV0ka//8
 3tzizn/FjFu0AjA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

NAND boot would require these nodes to be present at early stage.
Ensure that by adding "bootph-all" to relevant nodes.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
Changes in v2:
- Add 'bootph-all' only to leaf nodes
---
 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
index dc70b6fbc3d7..f08c0e272b53 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso
@@ -13,6 +13,7 @@
 
 &main_pmx0 {
 	gpmc0_pins_default: gpmc0-pins-default {
+		bootph-all;
 		pinctrl-single,pins = <
 			AM64X_IOPAD(0x0094, PIN_INPUT, 7) /* (T19) GPMC0_BE1n.GPIO0_36 */
 			AM64X_IOPAD(0x003c, PIN_INPUT, 0) /* (T20) GPMC0_AD0 */
@@ -50,6 +51,7 @@ AM64X_IOPAD(0x00a4, PIN_OUTPUT, 0) /* (N17) GPMC0_DIR */
 
 &main_gpio0 {
 	gpio0-36 {
+		bootph-all;
 		gpio-hog;
 		gpios = <36 0>;
 		input;
@@ -58,6 +60,7 @@ gpio0-36 {
 };
 
 &elm0 {
+	bootph-all;
 	status = "okay";
 };
 
@@ -106,30 +109,37 @@ partitions {
 			#size-cells = <1>;
 
 			partition@0 {
+				bootph-all;
 				label = "NAND.tiboot3";
 				reg = <0x00000000 0x00200000>;	/* 2M */
 			};
 			partition@200000 {
+				bootph-all;
 				label = "NAND.tispl";
 				reg = <0x00200000 0x00200000>;	/* 2M */
 			};
 			partition@400000 {
+				bootph-all;
 				label = "NAND.tiboot3.backup";	/* 2M */
 				reg = <0x00400000 0x00200000>;	/* BootROM looks at 4M */
 			};
 			partition@600000 {
+				bootph-all;
 				label = "NAND.u-boot";
 				reg = <0x00600000 0x00400000>;	/* 4M */
 			};
 			partition@a00000 {
+				bootph-all;
 				label = "NAND.u-boot-env";
 				reg = <0x00a00000 0x00040000>;	/* 256K */
 			};
 			partition@a40000 {
+				bootph-all;
 				label = "NAND.u-boot-env.backup";
 				reg = <0x00a40000 0x00040000>;	/* 256K */
 			};
 			partition@a80000 {
+				bootph-all;
 				label = "NAND.file-system";
 				reg = <0x00a80000 0x3f580000>;
 			};

---
base-commit: 4031a2866a9f0f5c585cfee65b3fb5ab17c95276
change-id: 20240623-am642-evm-nand-bootph-03b68b4c9d9e

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


