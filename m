Return-Path: <linux-kernel+bounces-557549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006BA5DAAD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 11:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71C45179D84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14AB24166E;
	Wed, 12 Mar 2025 10:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="me4ni2wm"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A2123C8B6;
	Wed, 12 Mar 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776190; cv=none; b=G7Tdso7bfsu29pPlqoY5je173uMdlMJl7J6QYU7cX/t9p01lBc2jAxViCmKNkduhxVx9TUwL3iHl4acXxgmn40dKdCPeHGHgbLLTPO2E4kqXaZX0P+izkkT2MM782RCLG8XzhRBFUm5StZE7Fy1C1o3eqZewdVJITFFNvPWoxpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776190; c=relaxed/simple;
	bh=0gKnPVmVHUBpUUk3ArJhMBNpgB5hi6BK2B3xuxScZZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2BNeI13Tj7bu11wsKaTtQkYv86sChYD5iFkpbl/TASBT6LlJKJh1Pdik21Q/eIjI1tJQqPTKvm9MyHCVzWDUsSPOij5Sal1KpyTKv6MuRWGbevY9WkQGU/53dp+0i+JEYXMYV5NvnD9MUT5rzq2PRSpu9aGVMxaB1cCRz+9x+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=me4ni2wm; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=U9Xi6
	6zx3lYTMVUWU01S1uAKBY80ABWl/7wgerhiF4k=; b=me4ni2wmQEo6+W5IXUihN
	Me5D62b0Lzh3kTMAVLJjLYhFy1x5f2E27/va3siWu6kMnCODyuu3UinZshUbddAT
	EIe8sdv3Fm+dzApADqkB3OAHncUpyFNbTqq8rD30YN0yTnKC4bcz6lW7d+9g3YHU
	pMN56q5oOOv/q7EGm6Pazk=
Received: from ProDesk.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgAHUvcHZdFnEN_+Kg--.14177S8;
	Wed, 12 Mar 2025 18:42:27 +0800 (CST)
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
Subject: [PATCH v2 6/7] arm64: dts: rockchip: Enable DisplayPort for rk3588s Cool Pi 4B
Date: Wed, 12 Mar 2025 18:42:07 +0800
Message-ID: <20250312104214.525242-7-andyshrk@163.com>
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
X-CM-TRANSID:PSgvCgAHUvcHZdFnEN_+Kg--.14177S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur48WF43Gr4rGryxCw4Durg_yoW8AF13p3
	ZxArsYgrZ7urWUt3sYyr18JrsxCrs5ua97Jr13u34ftFW7Wr93trn3GrnYyry5ZF4fX3yr
	tr1kXasF9F1UXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07URyIbUUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/xtbBkAoOXmfRZFIQtwAAst

From: Andy Yan <andy.yan@rock-chips.com>

Enable the Mini DisplayPort on this board.
Note that ROCKCHIP_VOP2_EP_DP0 is defined as 10 in dt-binding header,
but it will trigger a dtc warning like "graph node unit address error,
expected "a"" if we use it directly after endpoint, so we use "a"
instead here.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v2:
- Sort in alphabetical order

 .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
index e892dd7c91aa..4f471da1d866 100644
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
@@ -215,6 +227,24 @@ &cpu_b2 {
 	cpu-supply = <&vdd_cpu_big1_s0>;
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
 &gpu {
 	mali-supply = <&vdd_gpu_s0>;
 	status = "okay";
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


