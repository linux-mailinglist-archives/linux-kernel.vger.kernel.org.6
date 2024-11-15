Return-Path: <linux-kernel+bounces-411227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1708E9CF4F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4059B2E5DE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DBC1E0DD6;
	Fri, 15 Nov 2024 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpLTEAdS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B5C1D460E;
	Fri, 15 Nov 2024 19:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699272; cv=none; b=AoJPTCdoI+dFD/Ic51390ONzOR+83YGL7dzIarViggPnucTR5+d23SdUj7AirfhxaUXE09IyZcnk4PwdGZwwBT+xuPXbjnKlh0CUExVjl5cvK6eYkJFsOFVqvFv7LoPb8+4OmykgR/CP/AcwQ/qWorbR9ehNfFyUOV2nGJonGEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699272; c=relaxed/simple;
	bh=4AWA2nkRIbgRzL+sZh1xMNPfawJdWekHH6+xzkmZw34=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HRW6gB8WoDtLru4MFuETElaAxMnM90AbSveNsz8rnwZ/32feEFt+mbtzi0l3uwVyixtLpFwAhYEdYGJyrJB4L3z8KwSFdZ6OC5YO7n9wimXOIpGyrQ8dxp+/rcMBElNkSor3e0qR6kAsKClpHpG1W41XOrdVnycapAQyFDo56As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpLTEAdS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D1DC4CECF;
	Fri, 15 Nov 2024 19:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731699272;
	bh=4AWA2nkRIbgRzL+sZh1xMNPfawJdWekHH6+xzkmZw34=;
	h=From:To:Cc:Subject:Date:From;
	b=tpLTEAdSnAAUXZMLog2jay57Avt9+PUVz5FqJiJGGFvQWEeHBgl1nODK5PfN+RoNh
	 H+Y123OdHJZwmbgyXB3mvVv/vB9JrzqD4uQ1pzI7Jt9E9YGY1kskH7QQO2NlDZkeRY
	 +vFBb05iyTWvWeVnnYvBEorLKysFu8QqRETBV6ngvnPG0shyEnJfa2DoKsnHNnN3NE
	 ThaQNTYMS69TeydeJJWxVq/IWcChTb53hYPys1KJYg1jMTCY8escTyyNXFz8T5LeQ4
	 bYPy40eZgv1l6QL5fHzITHDKjLTlbFZTB4k8DwlInc6Gyo/HQSw0jgnXRuvjKGJRJq
	 6DH33Nh1z45bQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Remove unused and undocumented "num-slots" property
Date: Fri, 15 Nov 2024 13:34:23 -0600
Message-ID: <20241115193424.3618568-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove "num-slots" property which is both unused in the kernel and
undocumented. Most likely they are leftovers from downstream.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
index cb81ba3f23ff..7c5f9be9a470 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s-plus.dts
@@ -24,7 +24,6 @@ &emmc {
 	disable-wp;
 	mmc-hs200-1_8v;
 	non-removable;
-	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_bus8>;
 	supports-emmc;
-- 
2.45.2


