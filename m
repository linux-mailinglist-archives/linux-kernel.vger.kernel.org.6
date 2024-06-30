Return-Path: <linux-kernel+bounces-235299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E50CB91D33F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 20:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6212813FC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 18:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C6015665B;
	Sun, 30 Jun 2024 18:37:34 +0000 (UTC)
Received: from mail-m17216.xmail.ntesmail.com (mail-m17216.xmail.ntesmail.com [45.195.17.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A78153BE2;
	Sun, 30 Jun 2024 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719772653; cv=none; b=RY5WJmQ77o/2rSuwvjbwahhv+i91zT+6xq7qB6vxLDsdPIZgX2GcWunH3ed0iVuAUN4YvlMVvYU4iPd6o1BpTQj+F8H0sC7CEGQP4OqTsdrLveHrlucnQv0SiHPQfUQR28O8rfPJo6vxAhRv8JXI2v4DM3b+W9AUZEHYQvJ0124=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719772653; c=relaxed/simple;
	bh=FbPLGAdPKDgVaxAJAVLqZmYC+GPn3gPqG4v8AyTchtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7CXnb2/KYqFAxc9KbRYaNY11K3hLrYyoYV+NuBOSw+ZKyGMzTFNwC4E4ik3auFgYkX/mfCW2QATuNXDngeH8+6M2IvWbcUI7JvBzA7mW0gPel12BQiEvx00bLkA+XR+c42ATu1LDUirw+1h/n0LPLBHuXBGPE+Sdyp+zAX3gGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.195.17.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:1720:3110:52ea:d52a:84f0])
	by smtp.qiye.163.com (Hmail) with ESMTPA id E81567E018E;
	Sun, 30 Jun 2024 23:00:19 +0800 (CST)
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
Subject: [PATCH v2 9/9] arm64: dts: rockchip: Enable UHS-I SDR-50 for Lunzn FastRhino R66S
Date: Sun, 30 Jun 2024 23:00:10 +0800
Message-Id: <20240630150010.55729-10-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240630150010.55729-1-amadeus@jmu.edu.cn>
References: <20240630150010.55729-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGR1PVkxLSUoaGh8ZSElKT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtKQUpMSUtBSEpKS0FOSR4aQR9OSRpBQ08dS1lXWRYaDx
	IVHRRZQVlPS0hVSktJSEJLQ1VKS0tVSkJZBg++
X-HM-Tid: 0a9069a9484b03a2kunme81567e018e
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PQw6PRw5QjMCThwoPTcoSCsw
	Lx4aCk1VSlVKTEpCTE5CTUlLT05DVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBSkxJS0FISkpLQU5JHhpBH05JGkFDTx1LWVdZCAFZQUlITU83Bg++

This board can work in UHS-I SDR-104 mode, but may not be stable,
use SDR-50 instead. Remove the max-frequency property, which is
already defined in rk356x.dtsi.

Fixes: c79dab407afd ("arm64: dts: rockchip: Add Lunzn Fastrhino R66S")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
index b5e67990dd0f..8e5c182ef76c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dts
@@ -20,9 +20,9 @@ &sdmmc0 {
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	disable-wp;
-	max-frequency = <150000000>;
 	no-sdio;
 	no-mmc;
+	sd-uhs-sdr50;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc0_bus4 &sdmmc0_clk &sdmmc0_cmd &sdmmc0_det>;
 	vmmc-supply = <&vcc3v3_sd>;
-- 
2.25.1


