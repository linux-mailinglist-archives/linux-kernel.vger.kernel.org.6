Return-Path: <linux-kernel+bounces-411242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECED9CF519
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0B5AB3432E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DEC1E104F;
	Fri, 15 Nov 2024 19:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYqgzqe8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEBD1E104E;
	Fri, 15 Nov 2024 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699423; cv=none; b=HcSr6ylWZYcLVUy8UiqXO2GsmGwlBqqxxyNFyFhRhN2DLeW9nSWWXRrJ5PgLHEqChfc0wPAeb8XiSeEg6UYKi024JIgGCNrPJq4L5T/BCDe5RtE0b7gwF6zGStUn/n2OCvy+yGYzfLpgFh6/dirQtUUo2oaf/gnoHSKOlyty/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699423; c=relaxed/simple;
	bh=5gtlYI2MCfM1gZEz84quZbuIloCltAo6go5Vp4w+L0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=peFKx1QT7atn+NU7wD/FpxRVXvdI+66NI2xmXVBWKtc5QJfhpSI+YnH3KUl9LBmF6O5iprD5K1doBaKa1UXr6oCQeVyWngMMusk+Kb3xzEvUSYa8YxqRgg2aIdP9oZTMQeRAUrm9j8bk/aGW8MjRT0Ckk/0sex1vwA+/uyzC+fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYqgzqe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8B0C4CECF;
	Fri, 15 Nov 2024 19:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731699423;
	bh=5gtlYI2MCfM1gZEz84quZbuIloCltAo6go5Vp4w+L0Y=;
	h=From:To:Cc:Subject:Date:From;
	b=WYqgzqe8NIGiWEjOtDUt6xxJ+KRMfbhmW50qoU4P5sZWlEUGap+OzautnwZm2ckpZ
	 isohZQtYoGCPU4Or+QSy/vMCAV4MmvNU92M7qowugYH7jYdr7XyRnYdHT9GD0EFCnG
	 BHftIgtQja89cyaq3x2YrhDisdAcdVYHy6oudsEbN1T7LDkBXw0c5/+ZydMIb4Ph2+
	 xv1RJDLiXPjHxPmhAHBZFz45aPWvmkaRpCahZ91ThGyQ5v3I2/o64C8A3Re5u9e3MA
	 T1He21Hb/nKMZVBGvYSKrK8yFnROzdd3Ks81AuFtWCxWPdL4DM/6iJ4M5HD4cmFIH6
	 /MJEgeqvSU6wA==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Khuong Dinh <khuong@os.amperecomputing.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: apm: Remove unused and undocumented "bus_num" property
Date: Fri, 15 Nov 2024 13:35:16 -0600
Message-ID: <20241115193514.3619790-3-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove "bus_num" property which is both unused in the kernel and
undocumented. Most likely they are leftovers from downstream.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
To: soc@kernel.org

Please take directly.

 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 2 --
 arch/arm64/boot/dts/apm/apm-storm.dtsi     | 1 -
 2 files changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
index ea5721ea02f0..5a64239b4708 100644
--- a/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
@@ -809,7 +809,6 @@ i2c1: i2c@10511000 {
 			interrupts = <0 0x45 0x4>;
 			#clock-cells = <1>;
 			clocks = <&sbapbclk 0>;
-			bus_num = <1>;
 		};
 
 		i2c4: i2c@10640000 {
@@ -819,7 +818,6 @@ i2c4: i2c@10640000 {
 			reg = <0x0 0x10640000 0x0 0x1000>;
 			interrupts = <0 0x3a 0x4>;
 			clocks = <&i2c4clk 0>;
-			bus_num = <4>;
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 6ad4703925dc..872093b05ce1 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -851,7 +851,6 @@ i2c0: i2c@10512000 {
 			interrupts = <0 0x44 0x4>;
 			#clock-cells = <1>;
 			clocks = <&ahbclk 0>;
-			bus_num = <0>;
 		};
 
 		phy1: phy@1f21a000 {
-- 
2.45.2


