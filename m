Return-Path: <linux-kernel+bounces-519310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C37A39B68
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D93B47C6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E76F241108;
	Tue, 18 Feb 2025 11:49:41 +0000 (UTC)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D8823C39F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879381; cv=none; b=GM9Nh9gzaI9Ca4Hq9McomBGo7oEGZvj9crERaQdX4Kxd1JBtLCP7OVxlWQW6Xav8mUhLEBBksAWTPWR+vKjcGstcMbhKBzZDIwq1dvbKNHm9l1WeaITp729kn1hm6cT69V0T6IgRvzxqQZSrrhmzL78v9bXV6fLor1G4zKpOJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879381; c=relaxed/simple;
	bh=wgoHvz58JJGD9JlV3m/wFKrPILZxV9WCPYQ6p71paRU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALwhWjVcVUZ8SdPEayNZvAZz8gf140vuypgMu5Nhg3+uBEz9dS9gV4Gw2OcvEvqD72QVy38fY+nA6aRBGwEQaL8Pw0FHuE3cLF8E18/ltMgwTWGLQVE/F9WM2kcYDWXUSHoN83Z0fBoumpYLWgS0xJZVij9UcwGDwXkEBVFIJQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YxyVf6QLBz7Gv;
	Tue, 18 Feb 2025 12:49:30 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YxyVf32JtzmXD;
	Tue, 18 Feb 2025 12:49:30 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Tue, 18 Feb 2025 12:49:14 +0100
Subject: [PATCH 3/9] arm64: dts: rockchip: move I2C6 from Haikou
 carrierboard to Puma DTSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-tsd-align-haikou-v1-3-5c44d1dd8658@cherry.de>
References: <20250218-tsd-align-haikou-v1-0-5c44d1dd8658@cherry.de>
In-Reply-To: <20250218-tsd-align-haikou-v1-0-5c44d1dd8658@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

I2C6 is not exposed on Q7 golden fingers which is for routing signals to
the carrierboard but on Q7 Camera connector, for routing signals to an
additional adapter (e.g. Q7 Camera Demo adapter).

Therefore, let's move the modification of I2C6 bus to Puma DTSI.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 4 ----
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi       | 5 +++++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index 4a1a71995bf5da65d59214711671d87c9ea2de62..327fbc0a56655d5e544a99cedbfb1bcd39ad769a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -185,10 +185,6 @@ sgtl5000: codec@a {
 	};
 };
 
-&i2c6 {
-	status = "okay";
-	clock-frequency = <400000>;
-};
 
 &pcie_phy {
 	status = "okay";
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index f7548613ac46e190972d549271ec0bbc0c8a9b92..f398a55408ee2c8259085cf2325da97cdce3e4de 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -393,6 +393,11 @@ &hdmi {
 	ddc-i2c-bus = <&i2c3>;
 };
 
+&i2c6 {
+	clock-frequency = <400000>;
+	status = "okay";
+};
+
 &i2c7 {
 	status = "okay";
 	clock-frequency = <400000>;

-- 
2.48.1


