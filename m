Return-Path: <linux-kernel+bounces-233989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC5A91C079
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 16:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A2D01C22902
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC061C230E;
	Fri, 28 Jun 2024 14:07:35 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E201C0DF5;
	Fri, 28 Jun 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719583654; cv=none; b=GwI/SWG6FaJAlchi7G9UbNUkGrq/ZLPolQ2YXAi3t9lNPAybloUIgmaR1y38Yx4Y+Kq+6ZqCcNUZGmm2Z/XulRw09gO2KmD4fXWdFDVu/S80pq88GcQ4KMTfLlk1lq5VTx8g7UUBQfrYya/7mTLKMXjnEFcByThzY/OiS1ioscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719583654; c=relaxed/simple;
	bh=BsVSA6P+76cM9MVmtEFklGoe9kwKGfKnRaoDQlumoBw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEvs7dds+7N0YAmVL52gHpNPrCVNBRDfyiEbJE8ui84LgNh5L0i9WxuvYQ/BxPH2rL3QuWJvlxtTb021wxlQfgy6HZdeO0y3z+/+vOxVTC+pg9GGnp4eZIzu4ZYJn2r1ikpZBjHEW3yCc0prLRTQhskRxZbLDbVcj48H9s34r/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [IPV6:240e:3b3:2c01:1720:7e27:c507:902f:f5f3])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 92AB27E012B;
	Fri, 28 Jun 2024 22:01:16 +0800 (CST)
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
Subject: [PATCH 3/5] arm64: dts: rockchip: disable display subsystem for Lunzn Fastrhino R6xS
Date: Fri, 28 Jun 2024 22:01:02 +0800
Message-Id: <20240628140104.551760-3-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240628140104.551760-1-amadeus@jmu.edu.cn>
References: <20240628140104.551760-1-amadeus@jmu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZThhOVh8fQkIdSEhMTRgYHlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJT0seQUgZSEFJGEtKQUpMSUtBTB5JTEEYTktMQUJLSR1BHU4dSFlXWRYaDx
	IVHRRZQVlPS0hVSktJT09PS1VKS0tVS1kG
X-HM-Tid: 0a905f267f2903a2kunm92ab27e012b
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NAg6CBw*PjNWDRopGQg3Dz1P
	FRIwFBhVSlVKTEpCTkNISUxMSk5NVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUlP
	Sx5BSBlIQUkYS0pBSkxJS0FMHklMQRhOS0xBQktJHUEdTh1IWVdZCAFZQUlKQ0s3Bg++

The R66S and R68S boards do not have HDMI output, so disable
the display subsystem.

Fixes: c79dab407afd ("arm64: dts: rockchip: Add Lunzn Fastrhino R66S")
Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
index e08c9eab6f17..25c49bdbadbc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-fastrhino-r66s.dtsi
@@ -115,6 +115,10 @@ &cpu3 {
 	cpu-supply = <&vdd_cpu>;
 };
 
+&display_subsystem {
+	status = "disabled";
+};
+
 &gpu {
 	mali-supply = <&vdd_gpu>;
 	status = "okay";
-- 
2.25.1


