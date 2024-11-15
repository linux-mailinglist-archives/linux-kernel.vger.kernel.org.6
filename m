Return-Path: <linux-kernel+bounces-411230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E61E19CF4F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 20:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DF181F218F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AFA1E1C1A;
	Fri, 15 Nov 2024 19:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5UryV3L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBBF13D297;
	Fri, 15 Nov 2024 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731699301; cv=none; b=UiKKZUIhDHi2CapQR5xPz17qo2O7gcy/HnNJHpkFYIGM7E62tPjqdqUWQu2Mf+lEO69Bt8ZmZKnURUFv2yCGnUtKgqEa0rqGNXTR0RYKqQmsG0r527xa15DMv0usIt0YUSNE9xtvFL6fSQzTYbPJuumwHgY6glX4fdnSA61LezM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731699301; c=relaxed/simple;
	bh=cmST9DFI8ds26UZFq/m/WSYh7IDIxmikdV0lJCKC9ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMY5xMOxcey2+PlWdxsRbiz6IsO4MtNdLzuKryNL9UwqQ6fmjzg0e+mMoi9GWYkJyPVj9AM7AOUxDPDUyEp2Eigy34P05aPNxg5vnvmt+nB24PGSxmzC0VzM6rAdISj92bljbiFgFVHh/McRc6Ks6qz/n1R5dHysANZQBejmIHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5UryV3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C1BC4CECF;
	Fri, 15 Nov 2024 19:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731699300;
	bh=cmST9DFI8ds26UZFq/m/WSYh7IDIxmikdV0lJCKC9ZA=;
	h=From:To:Cc:Subject:Date:From;
	b=j5UryV3LaOLA3YOK0yVvdYTxviiVdsA1cYD4efiLanuX/gvQCUC3njDN24RsBQAQU
	 8YiRBKYktuisyuLV0G12QIk2H3wK/lH3gQBSAkKT5N4NOSsL5xOHk3ewDwMGNxMXaO
	 bTAovmY260amQh7gVegxljYAB9qS33Df606ajL3j7XFb04lXgQNjUED6eBqYk/1dmS
	 l08WDgyVJHORcgbpYx2tyCq2eNT0Mj7+TyJgAn+Ya7FTpBLCoAZtapa9Q3+/F7q9i4
	 LHFLyfqNnrQnkhB+jgiaKfRi4dlkA4sTqyvDw3rVpGIi2qH2RDZ+m24q7EAI3B3SuG
	 Lac+eGQ1iBPRg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Xu <xuwei5@hisilicon.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: hisilicon: Remove unused and undocumented "enable-dma" property
Date: Fri, 15 Nov 2024 13:34:53 -0600
Message-ID: <20241115193454.3619297-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove "enable-dma" property which is both unused in the kernel and
undocumented. Most likely they are leftovers from downstream.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index a589954c29e2..12f621cedf89 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -728,7 +728,6 @@ spi0: spi@f7106000 {
 			reg = <0x0 0xf7106000 0x0 0x1000>;
 			interrupts = <0 50 4>;
 			bus-id = <0>;
-			enable-dma = <0>;
 			clocks = <&sys_ctrl HI6220_SPI_CLK>, <&sys_ctrl HI6220_SPI_CLK>;
 			clock-names = "sspclk", "apb_pclk";
 			pinctrl-names = "default";
-- 
2.45.2


