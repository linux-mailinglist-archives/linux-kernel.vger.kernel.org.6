Return-Path: <linux-kernel+bounces-382311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 717C09B0C33
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2300B212D2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6596A18CC19;
	Fri, 25 Oct 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kaYr7tDP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92F20C316;
	Fri, 25 Oct 2024 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878852; cv=none; b=NkumanOXZUPuaFk/EeqYIbl/f+NDVSKhAUFN7lG5etYBN8iY0SZMk+U9K2dvQdrmUvJaKwRKTBpE4H+qGrE6h+cmPGb6WAdCenK32X+1qsp+3IqqlmjWlzcftkrzuMZuKzYcFqehY490Ns+uGEBk/1vXe0SP3tCLMJYPfc7dUFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878852; c=relaxed/simple;
	bh=mCSQEoQ4CLulrEpBMf3oT0z+1iz4xIqJLNRGjUOnX3s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZqOckJiMXCmF0UnW+MNp/jaOBVkNDjfTM+uwkRgZIghkViwyQzvdbE12rKhqs4xhbwO8WA4VoWlPvsehQLL8IY5WO9TJ7yOp122ZX9KFd+jPFXV1sPzZRYNnBBDj1jKx5J3egpEi3DRKZGEKGRof0Rz1xV2/PF30d7uKkwVFDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kaYr7tDP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BFAC4CEC3;
	Fri, 25 Oct 2024 17:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729878852;
	bh=mCSQEoQ4CLulrEpBMf3oT0z+1iz4xIqJLNRGjUOnX3s=;
	h=From:To:Cc:Subject:Date:From;
	b=kaYr7tDPrtQYRnnrNxTUY65Y/NGEFW8a67VMDDtDDuMv+ICEcvrD0MOMAsQzKZFmc
	 OEsp5hbf0DPhkLq5hX9PzA6D2ZoYc55Qezemi2QXqBu6LykZfRIyb1Pa4juzhtLXFu
	 DNFEpF5SDJQG2eWbZc8xGlKmNhRdwS9sxfkl7A3rD80OOBQWxWcc7l7atW46yBFaWx
	 aK8ojgM6aiD0r8hTJcYRiFX8e1nZDI+v6H28tZqNQumR2SH83jxGm0hgC9XEH7+Kma
	 XDFLka9p0pdgiiGAk69vkF0B3gaPyKsFRwDmglezv8ZQ35UYvduyt+AXBDSLnR/x+B
	 wVE7OxDFfpM4Q==
Received: by wens.tw (Postfix, from userid 1000)
	id DB8C35FCB4; Sat, 26 Oct 2024 01:54:09 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Chen-Yu Tsai <wens@csie.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: orangepi-5-plus: Enable GPU
Date: Sat, 26 Oct 2024 01:54:09 +0800
Message-Id: <20241025175409.886260-1-wens@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen-Yu Tsai <wens@csie.org>

Enable the Mali GPU in the Orange Pi 5 Plus.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
index b826c5e368aa..7edebc47f1ef 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-orangepi-5-plus.dts
@@ -287,6 +287,11 @@ &cpu_l3 {
 	cpu-supply = <&vdd_cpu_lit_s0>;
 };
 
+&gpu {
+	mali-supply = <&vdd_gpu_s0>;
+	status = "okay";
+};
+
 &hdmi0 {
 	status = "okay";
 };
-- 
2.39.5


