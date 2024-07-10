Return-Path: <linux-kernel+bounces-247765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A83492D442
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7EA61F23917
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A537F1946D5;
	Wed, 10 Jul 2024 14:31:06 +0000 (UTC)
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92419413C;
	Wed, 10 Jul 2024 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621866; cv=none; b=EBmOpS9ztSON/1g+zoA4bhRBGL4jhDyVtsvOLWPgQBbXvHTHyX7OuJEQ/yTfrDGEMdyMvznwb0qbjueK9p/GT9TRX7cV81Ll/vIv9DDwIWHNXJddq98aixHevDUQQt3yFkVp0t2wuWbMmZkDZcNnN83LUz+GgKW4cMSD2StEr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621866; c=relaxed/simple;
	bh=Ka8TDxRrvq/QMKiwR/kAJmsQAcG8YwV5EicJrDLe8mI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CfvnHd2t93tRjTqNLHu0yI2R+F/VRelutjx4et/uQV90GMJZnpbbgs5ciBwgqdDVsGlNV5cS5nVkTdsNf/kyiA3iRumwiwpSBCj94EbyUhGFTquDdPSGkqUIB5Enyn06hFdUzZ1WnPB3LtMRrKfq5K4XA8qeJ5rP48EvB2e6t9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c00:fb60:82c0:6879:f4d2:caf4])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 6D51A7E014F;
	Wed, 10 Jul 2024 22:30:42 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v3 2/3] arm64: dts: rockchip: remove useless tx/rx_delay for Lunzn Fastrhino R68S
Date: Wed, 10 Jul 2024 22:30:16 +0800
Message-Id: <20240710143017.685905-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240710143017.685905-1-amadeus@jmu.edu.cn>
References: <20240710143017.685905-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTRpDVk9CTUgZH0kaSU9KHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtLQR0ZTUtBQ0kYS0FNQ0xCQR1PH0lBGBodT1lXWRYaDx
	IVHRRZQVlPS0hVSktJT09PS1VKS0tVS1kG
X-HM-Tid: 0a909d0dc0de03a2kunm6d51a7e014f
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6Ejo4DTI1LjAvS0sZPRVO
	N1YaFAJVSlVKTElLTUlKQ09IS09NVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0tBHRlNS0FDSRhLQU1DTEJBHU8fSUEYGh1PWVdZCAFZQUlIQ0w3Bg++

Since we use rgmii-id as the phy mode, remove the useless
tx_delay and rx_delay properties.

Fixes: b9f8ca655d80 ("arm64: dts: rockchip: Add Lunzn Fastrhino R68S")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
index 02d966d218fd..d27eb37b5b35 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r68s.dts
@@ -39,8 +39,6 @@ &gmac0_tx_bus2
 		     &gmac0_rx_bus2
 		     &gmac0_rgmii_clk
 		     &gmac0_rgmii_bus>;
-	tx_delay = <0x3c>;
-	rx_delay = <0x2f>;
 	status = "okay";
 };
 
@@ -57,8 +55,6 @@ &gmac1m1_tx_bus2
 		     &gmac1m1_rx_bus2
 		     &gmac1m1_rgmii_clk
 		     &gmac1m1_rgmii_bus>;
-	tx_delay = <0x4f>;
-	rx_delay = <0x26>;
 	status = "okay";
 };
 
-- 
2.25.1


