Return-Path: <linux-kernel+bounces-550219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95B1A55CB0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 02:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF3C188750B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 01:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E0B17DE2D;
	Fri,  7 Mar 2025 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4viKKi9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC0916A395;
	Fri,  7 Mar 2025 01:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309687; cv=none; b=YiGLa4mdtHukhAwhDkBt+j6keInX6JWrLJWqT1pvfiK6mnFG4KAYXX/JwGbioL5vpBraRqehGYdbz5saI4FGllKAmSUlnsn4UJQZ8i+sIbB4LkmmbptzPQaqa3JyjcVC00nJekYnNxwLDeSVd+FMW++OBWEzqhjsKBVZtWhHGVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309687; c=relaxed/simple;
	bh=ZCVNFRDSXRUDXXDBJrUUmwQobvHH8nnw4004/660Esc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOGbIRtjTPOiXDfu8CmblnYUogoo/nezTqiYIefM8H036kXM0SIppNChoPh7z7UNEX166kuwK3NXit4mq0sb0HayWkee5zKLlDznjaaGGdqejBqlMUWXYJFK13f6icDDarqCFraN7Sg8EgKDYW8HV8yQ8PWTNizu6RSNljrJq/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4viKKi9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F500C4CEE0;
	Fri,  7 Mar 2025 01:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741309687;
	bh=ZCVNFRDSXRUDXXDBJrUUmwQobvHH8nnw4004/660Esc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=J4viKKi95ytYPjdBYZ6n3MS1mhk0DPLe7a1Muz1DQOrXoJ4r6i5GKf8EVERZwUH8v
	 Qu3fpTjz3xMBYbcVJySNwIfWILQ15/0HSOxnHIwcZhpBv1mbse48zjYIJQ/egesL9H
	 66v66zJ9sNH4x00ZS7RBD595eTlvHn+8opYF2sXmViz1nQkkUdRM9G18iMp1wg3M4E
	 RAmknpkqIWaujCey21a4L0oFYb6EvkZvU+QRE7Gtsf2TGEnJUDzfRAzV3PteotgG/J
	 tdj1IkS+oxzux+Y3yOIFWO8R34oa79BBYOZ2BuptxCa7SscGWzTQvbiguqP0jCmPOH
	 XOMY1y2COR4QQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Thu, 06 Mar 2025 19:07:46 -0600
Subject: [PATCH 4/4] arm64: dts: amd/seattle: Drop undocumented
 "spi-controller" properties
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-dt-amd-fixes-v1-4-011c423ba99a@kernel.org>
References: <20250306-dt-amd-fixes-v1-0-011c423ba99a@kernel.org>
In-Reply-To: <20250306-dt-amd-fixes-v1-0-011c423ba99a@kernel.org>
To: soc@kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

"spi-controller" is not a documented property nor used anywhere, so drop
it.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index aa7fe884a458..a611f8288b3e 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -121,7 +121,6 @@ spi0: spi@e1020000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0 0xe1020000 0 0x1000>;
-			spi-controller;
 			interrupts = <0 330 4>;
 			clocks = <&uartspiclk_100mhz>, <&uartspiclk_100mhz>;
 			clock-names = "sspclk", "apb_pclk";
@@ -131,7 +130,6 @@ spi1: spi@e1030000 {
 			status = "disabled";
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0 0xe1030000 0 0x1000>;
-			spi-controller;
 			interrupts = <0 329 4>;
 			clocks = <&uartspiclk_100mhz>, <&uartspiclk_100mhz>;
 			clock-names = "sspclk", "apb_pclk";

-- 
2.47.2


