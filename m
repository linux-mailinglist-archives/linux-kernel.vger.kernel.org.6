Return-Path: <linux-kernel+bounces-519319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B947A39B82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6EB53B628D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1332243365;
	Tue, 18 Feb 2025 11:55:20 +0000 (UTC)
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58912243361
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739879720; cv=none; b=Hg6gwwtGuN9sTH0bHYEUWZKtS/rNWHXnxm4JTSpN9n1487wc4Fds6vKQaPPQGbHKWRlFjxwewujj8UHKMW2lLmkueMRGlDgQrO2cUWlJwa8ZDletGDbjAuhj+S1PL2AkB5S4xn7dTtDPA0JbmQI6Lgm7YKdnAI+hIR9mxKpGdSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739879720; c=relaxed/simple;
	bh=1iREl1slHWLwuF/fAg28Gip6xABxxBSUHFSCpd2Z5So=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TbvSBlseBkyg8zt8CJeBTnqq3LVrJ1Amuda3Rv2N/9jBsC1Z4f/FSdQGlCZHL5JI6ZRrGjvlJrJX4Ck7tIMHoDCT7NP6WmADI2FQXplddqj4/zNl9/RGswzZP9xynQbGhfmu9j7qcV+gRG+SftEsB+gUcrLWE7ySQ92v1M0TK+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YxyVh6rg5z5v6;
	Tue, 18 Feb 2025 12:49:32 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4YxyVh2lmRzjHM;
	Tue, 18 Feb 2025 12:49:32 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Tue, 18 Feb 2025 12:49:18 +0100
Subject: [PATCH 7/9] arm64: dts: rockchip: enable Ethernet in Haikou
 carrierboard, not Puma DTSI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-tsd-align-haikou-v1-7-5c44d1dd8658@cherry.de>
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

The signals are exposed on Q7 golden fingers but it's not a given that
the carrierboard will have an Ethernet jack. So let's move the enabling
of the Ethernet controller to the carrierboard DTS instead.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi       | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
index bea146d0d3f02afaf5e406d61d9a8ab7476fa8df..47775005874308e217a523659bfd92dc56fba8e8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
@@ -149,6 +149,10 @@ vddd_codec: regulator-vddd-codec {
 	};
 };
 
+&gmac {
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
index 399c86bcbfefa5c667f11f31b3491eb693cfae76..e00fbaa8acc1685af46495c0dfc9bdac7e6e991c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
@@ -183,7 +183,6 @@ &gmac {
 	snps,reset-delays-us = <0 10000 50000>;
 	tx_delay = <0x10>;
 	rx_delay = <0x23>;
-	status = "okay";
 };
 
 &gpu {

-- 
2.48.1


