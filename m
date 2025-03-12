Return-Path: <linux-kernel+bounces-557546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB49A5DAA5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB84A189C8F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3012923F36B;
	Wed, 12 Mar 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="PlrYWyD+"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABCF23E351;
	Wed, 12 Mar 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776187; cv=none; b=Ibf2/XVGKmpYvmSIgQ1WwFCc/dcF1jWg1wHqyk47d7Rr3KSQ73Km99rFq/1atQCuqL26B59nh9MS39jjoU+tMQqvgHZD7XwQNL7Z5KKoTr2/mOkAVyLVrqLm9NuouYIVK/E/SsiA6QC4aPmcIi1edzkzc4SkzOkHEhjOFGFkd4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776187; c=relaxed/simple;
	bh=tm8bYPpmnR7vi4qQxgtro5kKHnBdVI4YAJsnaf00svQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thgdsFdZNzM4mw7M6sewc883GqotftDAbbJ8mzAHz9uh1NlAjlvQKx+VhOtLks2l5gW970KgR3B0pJhZ5/vkKQ8nCF7bLHfn6nacnDsM8UDFv3vHHADKYFKuc9m3zGFfzTy+a1OQSFm0xaE4cwK0g/uXN2yeOi1GnwOy4QjWM64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=PlrYWyD+; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=R3PEx
	pSAgYFU633sginPVCP7ej78ofIXD9jecy4Y1r0=; b=PlrYWyD+WuSgp9buUMnxE
	y/i9/ncmWxY5yLKey7KJPrLcyrKfszTkeGAmrqc7ZaGSmPvH9C0UhG0itxLGiqcC
	7Y6LK1j8Nbwd5ns5FCSA5OOgC5yzeb4iUmWjgqYuoiqfJzfZYujOwDT9n0tiEHBv
	JACdSdOrjykW4KxtQjesqM=
Received: from ProDesk.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAHUvcHZdFnEN_+Kg--.14177S9;
	Wed, 12 Mar 2025 18:42:28 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: heiko@sntech.de
Cc: hjc@rock-chips.com,
	mripard@kernel.org,
	cristian.ciocaltea@collabora.com,
	neil.armstrong@linaro.org,
	yubing.zhang@rock-chips.com,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	lumag@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2 7/7] arm64: dts: rockchip: Enable DP2HDMI for ROCK 5 ITX
Date: Wed, 12 Mar 2025 18:42:08 +0800
Message-ID: <20250312104214.525242-8-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312104214.525242-1-andyshrk@163.com>
References: <20250312104214.525242-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgAHUvcHZdFnEN_+Kg--.14177S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW7WFyfCryfCFy7Gw4rXwb_yoW8Cr1xp3
	ZFyrs3Krn7CryYqwnavF18ZFn8Krs5ua97Ary2qry8tFW7uas3K3WrWr9Ygw1jvF1xZws0
	qrWkXa9F93WDWaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j15l8UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqB4OXmfRYalQtgAAs+

From: Andy Yan <andy.yan@rock-chips.com>

The HDMI Port next to Headphone Jack is drived by
DP1 on rk3588 via a dp2hdmi converter.

Add related dt nodes to enable it.

Note: ROCKCHIP_VOP2_EP_DP1 is defined as 11 in dt-binding header,
but it will trigger a dtc warning like "graph node unit address
error, expected "b"" if we use it directly after endpoint, so we
use "b" instead here.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

(no changes since v1)

 .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
index 67b886329248..29f10ec9f0c1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
@@ -57,6 +57,18 @@ analog-sound {
 			  "Headphone", "Headphones";
 	};
 
+	dp-con {
+		compatible = "dp-connector";
+		label = "DP OUT";
+		type = "full-size";
+
+		port {
+			dp_con_in: endpoint {
+				remote-endpoint = <&dp1_out_con>;
+			};
+		};
+	};
+
 	gpio-leds {
 		compatible = "gpio-leds";
 		pinctrl-names = "default";
@@ -268,6 +280,24 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
+&dp1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&dp1m0_pins>;
+};
+
+&dp1_in {
+	dp1_in_vp2: endpoint {
+		remote-endpoint = <&vp2_out_dp1>;
+	};
+};
+
+&dp1_out {
+	dp1_out_con: endpoint {
+		remote-endpoint = <&dp_con_in>;
+	};
+};
+
 &gpu {
 	mali-supply = <&vdd_gpu_s0>;
 	status = "okay";
@@ -1262,3 +1292,10 @@ vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
 		remote-endpoint = <&hdmi1_in_vp1>;
 	};
 };
+
+&vp2 {
+	vp2_out_dp1: endpoint@b {
+		reg = <ROCKCHIP_VOP2_EP_DP1>;
+		remote-endpoint = <&dp1_in_vp2>;
+	};
+};
-- 
2.34.1


