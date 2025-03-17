Return-Path: <linux-kernel+bounces-564126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1062FA64E27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 154727A32AA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369B3242929;
	Mon, 17 Mar 2025 12:07:51 +0000 (UTC)
Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DED23BD1A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213270; cv=none; b=s3jBBCaBw8aPjk8RS5d3WXd+jYgcA9alLGzjlZmAgkLYpX0mbPtegZ0arrQcZlmjGElG1rAec/WD0TxEWpO41w0LRY4Cd2OX4P2+Eh7iOhaVnGZ+PKrLOLNyZmFgMkieEqffNsQWV7eb2y5MJ0ExO/DWJsasH2BSgcn0enzkd3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213270; c=relaxed/simple;
	bh=dFOHClK5imTEBQ/EVsJnTmzN7/HN1axPkvTr63sRzVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cm0rEzgE8Ky4KyxK+Sv9Ts8Gcb9WhgXirqYnWM0YOL3jpYJhYAKiasUv8LybffJdpLBQUZYDF89Q/wjbs0BgCUpFNDgQDMqdM5tNgpxPHNoJ9hwGSNrkDTDPto4IEkqZ1caSsho1h9dkMMxdWrDWrBzfwrTiqdNVgufH3pEIFF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0leil.net
Received: from smtp-4-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:0])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZGYd86jb1zL3x;
	Mon, 17 Mar 2025 13:07:40 +0100 (CET)
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZGYd82pBvzKht;
	Mon, 17 Mar 2025 13:07:40 +0100 (CET)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Mon, 17 Mar 2025 13:07:26 +0100
Subject: [PATCH 1/2] arm64: dts: rockchip: Enable HDMI audio output for
 RK3588 Jaguar
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250317-tsd-rk3588-hdmi-audio-v1-1-0b8ceb9597a6@cherry.de>
References: <20250317-tsd-rk3588-hdmi-audio-v1-0-0b8ceb9597a6@cherry.de>
In-Reply-To: <20250317-tsd-rk3588-hdmi-audio-v1-0-0b8ceb9597a6@cherry.de>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.2
X-Infomaniak-Routing: alpha

From: Quentin Schulz <quentin.schulz@cherry.de>

HDMI audio is available on the RK3588 Jaguar HDMI TX port, so let's
enable it.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 9fceea6c1398e92114dcb735cf2babb7d05d67a5..ebe77cdd24e803b00fb848dc81258909472290f1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -303,6 +303,10 @@ hdmi0_out_con: endpoint {
 	};
 };
 
+&hdmi0_sound {
+	status = "okay";
+};
+
 &hdptxphy0 {
 	status = "okay";
 };
@@ -512,6 +516,10 @@ regulator-state-mem {
 	};
 };
 
+&i2s5_8ch {
+	status = "okay";
+};
+
 &mdio0 {
 	rgmii_phy: ethernet-phy@6 {
 		/* KSZ9031 or KSZ9131 */

-- 
2.48.1


