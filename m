Return-Path: <linux-kernel+bounces-524295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748DDA3E1A6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373753B16F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E1F2135BB;
	Thu, 20 Feb 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8tNCes7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BD220FA98;
	Thu, 20 Feb 2025 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070260; cv=none; b=DkCMVRZLjGmnaEko2yO8xePVZyfFN33joqdBCAS5j9BzkQAat+XIZbSUtVJjg+B/iWQ+h8FhoUt2U30OCkvL69eIUo6hw2weoV9OBpTMhZQe/mzWhAOpiCJTaWhcmdBwnYG7X/kuey9UKYnVzJBCkv431yKrpuzvNm8Pvk+wLWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070260; c=relaxed/simple;
	bh=9xnTEjnQhes40qnNUz2hg5pdStiqILnkPcPo73VxwE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r7jfQ5hP7zn3oe4kL8oha/cS42NnIFWT/Nh8N0eXR75nJCrSx2kDNOPmGH5W77Fsyad22JqXwg4J58eRAjXFdso1WGjYxNyUb/lmDN+ylFLrYgnxAEyY/CnYacR3BP/AMhg+3Y7/Kbnm5RztDKd+nUpT+7JVuIRmShgRzG2FTiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8tNCes7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80C4C4CED1;
	Thu, 20 Feb 2025 16:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740070259;
	bh=9xnTEjnQhes40qnNUz2hg5pdStiqILnkPcPo73VxwE0=;
	h=From:To:Cc:Subject:Date:From;
	b=k8tNCes7z0/TK6ne9UBLeCCHhFNFhsKBuRLRWAJuG1O59ZNUwaTILEK4WJI//9S5y
	 6t1B09kRjVBOQ0Hh6pTK5fsDXAtc1QGiCcwxYO/xC13fcKY4nPpwckLCVoUBtnmGqW
	 Wa7HQdSvnArJco/gm/jpVggrB1uFeCL1Ct+AjjkEv6vn/4w0/Ul+BPcXZM/nO800Cc
	 wwV7K1u7EIFrjLXlxkHLN/UEmtdoGzoXW5pFPRcW/BtBjxdAnJ1KEuF7DKkbyXoCuO
	 LjBGLxOnnt7Ao3hQRs7M8idp464yoHOl9Z/vGxky1/9BslO4QyrYf2cTEZBDg81gXa
	 AjILnOxviEGAg==
Received: by wens.tw (Postfix, from userid 1000)
	id 2DBAC5FB8F; Fri, 21 Feb 2025 00:50:57 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH] arm64: dts: rockchip: rock-3a: Remove bluetooth node
Date: Fri, 21 Feb 2025 00:50:51 +0800
Message-Id: <20250220165051.1889055-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

The Bluetooth node described in the device tree is actually on an M.2
slot. What module is present depends on what the end user installed,
and should be left to an overlay.

Remove the existing bluetooth node. This gets rid of bogus timeout
errors.

Fixes: 8cf890aabd45 ("arm64: dts: rockchip: Add nodes for SDIO/UART Wi-Fi/Bluetooth modules to Radxa Rock 3A")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
index ac79140a9ecd..44cfdfeed668 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-rock-3a.dts
@@ -778,20 +778,6 @@ &uart1 {
 	pinctrl-0 = <&uart1m0_xfer &uart1m0_ctsn &uart1m0_rtsn>;
 	uart-has-rtscts;
 	status = "okay";
-
-	bluetooth {
-		compatible = "brcm,bcm43438-bt";
-		clocks = <&rk809 1>;
-		clock-names = "lpo";
-		device-wakeup-gpios = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
-		host-wakeup-gpios = <&gpio4 RK_PB4 GPIO_ACTIVE_HIGH>;
-		shutdown-gpios = <&gpio4 RK_PB2 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&bt_host_wake &bt_wake &bt_enable>;
-		vbat-supply = <&vcc3v3_sys>;
-		vddio-supply = <&vcc_1v8>;
-		/* vddio comes from regulator on module, use IO bank voltage instead */
-	};
 };
 
 &uart2 {
-- 
2.39.5


