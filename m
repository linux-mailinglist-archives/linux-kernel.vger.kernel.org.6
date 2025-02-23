Return-Path: <linux-kernel+bounces-527701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15FEA40E4B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 12:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC3D177006
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 11:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36FA72063C5;
	Sun, 23 Feb 2025 11:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JQeth/Oj"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD8A202F97;
	Sun, 23 Feb 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740310284; cv=none; b=gMWA8pEtCb4xs/EtZY/TBTqloykOPPjPag/CcwixLpTnCDYkfwHSwkDfQe+V4ev0oDoNxkOJ3VIhPakkr+C09I5yUsYc4i+CTk7vgIqz3SPVHyic6fdNyNMulrlzgAdS+9DuR6CDyIVdP899hXuSOGClTnwr2yAVZofOxD4LS48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740310284; c=relaxed/simple;
	bh=hVMu8VtGeKrTwSBZVq1KuB7zMqYJFmxDJUTXP0RlTpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHTBnc8dApaqGaxwOFflYF2uei7btzIKLiohdmZdxyKplFoAtQk4U5l7kIshXOb9IFFjjrQAW/9cuFyoWMqVQddumc+pOs/Y4fiARnes3p5iztESdCl1nrhDY6Fra5ca/RVOyLnWgJzfKbBwUT7fLUn9bOqXmWTVUnKIzCfT/Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JQeth/Oj; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=EHczv
	SSk5h351i00BwsKZf8PI4LoDDRa7hJpbsRqGqM=; b=JQeth/Oj8PqnJ/7Xc69V8
	0q18sNMHKMpvnUHYpbvxUtKPRNab5OxjRFaduMGS25RZDFYBUkPemhCsT5rY5oPJ
	Jl1yfxCIdEm2/jiLsUeVLytyJV5pVsvDPf6ZRRxTzQfNHVbZo7w6fosQoE2MYI3Z
	Ny/WRhY1UlO9DuTaUv4oZQ=
Received: from ProDesk.. (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgBHWqbdBrtnleHpAg--.47651S8;
	Sun, 23 Feb 2025 19:30:49 +0800 (CST)
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
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	robh@kernel.org,
	sebastian.reichel@collabora.com,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 6/6] arm64: dts: rockchip: Enable DisplayPort for rk3588s Cool Pi 4B
Date: Sun, 23 Feb 2025 19:30:29 +0800
Message-ID: <20250223113036.74252-7-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250223113036.74252-1-andyshrk@163.com>
References: <20250223113036.74252-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgBHWqbdBrtnleHpAg--.47651S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur48WF43Jw4ktFWxJw4fZrb_yoW8WFykp3
	ZxArsYgFs7urW7t3s5tF4xJFs8Ars5ua97Jr13Za43KFW7W3s5t34fGw1vyrWYvF4fX3yr
	tr1kXasF93WDXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UXjjkUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbB0hv8Xme6-oyBhQAAsA

From: Andy Yan <andy.yan@rock-chips.com>

Enable the Mini DisplayPort on this board.
Note that ROCKCHIP_VOP2_EP_DP0 is defined as 10 in dt-binding header,
but it will trigger a dtc warning like "graph node unit address error,
expected "a"" if we use it directly after endpoint, so we use "a"
instead here.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index e892dd7c91aa..0f58eb56557f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
@@ -39,6 +39,18 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	dp-con {
+		compatible = "dp-connector";
+		label = "DP OUT";
+		type = "mini";
+
+		port {
+			dp_con_in: endpoint {
+				remote-endpoint = <&dp0_out_con>;
+			};
+		};
+	};
+
 	hdmi-con {
 		compatible = "hdmi-connector";
 		type = "d";
@@ -220,6 +232,24 @@ &gpu {
 	status = "okay";
 };
 
+&dp0 {
+	status = "okay";
+	pinctrl-0 = <&dp0m0_pins>;
+	pinctrl-names = "default";
+};
+
+&dp0_in {
+	dp0_in_vp2: endpoint {
+		remote-endpoint = <&vp2_out_dp0>;
+	};
+};
+
+&dp0_out {
+	dp0_out_con: endpoint {
+		remote-endpoint = <&dp_con_in>;
+	};
+};
+
 &hdmi0 {
 	status = "okay";
 };
@@ -889,3 +919,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
 		remote-endpoint = <&hdmi0_in_vp0>;
 	};
 };
+
+&vp2 {
+	vp2_out_dp0: endpoint@a {
+		reg = <ROCKCHIP_VOP2_EP_DP0>;
+		remote-endpoint = <&dp0_in_vp2>;
+	};
+};
-- 
2.34.1


