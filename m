Return-Path: <linux-kernel+bounces-293926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3568B958691
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7786B284FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104218FC81;
	Tue, 20 Aug 2024 12:07:51 +0000 (UTC)
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA6E18F2CF;
	Tue, 20 Aug 2024 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155670; cv=none; b=QR7e48UWWD3gWh2XNGypuuLFwO7kicsS3fevaEcjqv4iAigV6WpiSqUyfFbw0icEyDIzHuSgnq0jVxswu1trQflm4kzkukmB0OqPG5KFU6OdJSX7JqAWV6/mA8bTL2ppM1/YTvyKmRCW8LwFC+hVK6jelWa0sNQlNZIqRxsI5hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155670; c=relaxed/simple;
	bh=/SZuHBGqjAKoW9j5beiJcU4fi/GezdNAPEqm2pmIg6M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ANZX+bekbR6OeobG1uxm8zVl0qXJ551dLdHu7fycA5B/n2gWsWmIs1g/uvjTRPbj3yMVFA+WlyV58cVJPsjh7zZfBxvS1BtJCqk4QKAneueqcI2YBolLQfLcKhq7PAID2IAURZfAUXm7iIZrlnc2VxlsIJHdIag4KZt9BvW4/IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn; spf=pass smtp.mailfrom=jmu.edu.cn; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jmu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jmu.edu.cn
Received: from amadeus-Vostro-3710.lan (unknown [119.122.213.221])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 417517E0202;
	Tue, 20 Aug 2024 20:00:24 +0800 (CST)
From: Chukun Pan <amadeus@jmu.edu.cn>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH 1/1] arm64: dts: rockchip: disable display subsystem only for Radxa E25
Date: Tue, 20 Aug 2024 20:00:20 +0800
Message-Id: <20240820120020.469375-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGB4aVkgZTxlKS04aSR4aT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKSkJVSklJVUlKSFVJSUpZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-HM-Tid: 0a916fa8e1c603a2kunm417517e0202
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRA6Qxw6PzIwFjUvMxIKPEkw
	MiMaFDNVSlVKTElPSk5OSUlOSUJMVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
	QlVKSUlVSUpIVUlJSllXWQgBWUFJT0NLNwY+

The SoM board has reserved HDMI output, while the Radxa E25
is not connected. So disable the display subsystem only for
Radxa E25.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
 arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi | 4 ----
 arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts   | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
index 45b03dcbbad4..19d309654bdb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568-radxa-cm3i.dtsi
@@ -108,10 +108,6 @@ &cpu3 {
 	cpu-supply = <&vdd_cpu>;
 };
 
-&display_subsystem {
-	status = "disabled";
-};
-
 &gpu {
 	mali-supply = <&vdd_gpu>;
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
index 72ad74c38a2b..84a0789fad96 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-radxa-e25.dts
@@ -103,6 +103,10 @@ &combphy1 {
 	phy-supply = <&vcc3v3_pcie30x1>;
 };
 
+&display_subsystem {
+	status = "disabled";
+};
+
 &pcie2x1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie20_reset_h>;
-- 
2.25.1


