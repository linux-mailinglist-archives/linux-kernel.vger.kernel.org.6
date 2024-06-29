Return-Path: <linux-kernel+bounces-235000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3F191CE24
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 18:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B08282D60
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 16:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A6C85285;
	Sat, 29 Jun 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mHsrmg7R"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45039ADD;
	Sat, 29 Jun 2024 16:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719679151; cv=none; b=LDS8ME/zboxKYclFPSACGCEe4hmWpN9kHgJrErTPi4Vgf9irAxyuZwO/UgpnPwZEASlnQpSDN4oG/XAvlegAP8vfUkRbAL7Cvd4P+maPQW5AtekyeSsjcpzMEX+3neb86wcOH1EXZTiUYJypoCfLALmfAVrutX76yppqDic4QNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719679151; c=relaxed/simple;
	bh=e8RshKlnrfnftSesiXsqDCgRDMQ1wcycEq/ANed21o0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dy1IwDMeAI410ON/30jjV0S+Qc9aZNEbNPJnI74rhZVXbEmQA528zKoQSOgvzqs4S7yK/QNY52dDaEKCR6+nXa7TRNQVhbp1QL5dr/ozW2cDoOveD6meOR9u24nHY4wjWJVn75s9lqxvXdJio/EvH53cV5JGt0bggl/qcPFEO5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mHsrmg7R; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1719679146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XD2ROucdrug5HlrYnko9mz+aWaTwM0vQIU29PZm8nNw=;
	b=mHsrmg7RpdUSIgVRYZJHGUNTukimbIyMl8gFF5FzuG2N3FEMqGJVqQ9CI3upWWoXjK5tgv
	3OkwBUtKdZPeglqFjUG91QU1gveIhQjby0m3Es8cK6WNQAJCBRY/NfK4TlnITf4dTXqck3
	foy+ZFii+GtS4/uTy7hNjPLg7BgXnkU09OquAhOF3IhS+1Tpu5YL2a14UUvs9uSPjI6hPE
	qS1mYzWCnPIHt4VdSFDqqrdTwQPTDkX2Ai8Crcm86xNIPFFCKvSPSlJfhpQ/PlidhdwhiS
	4ycQxa8nSKlWkG5YlBBbyjIA1zB7MVEs9ej9m7ZAqCqyoy6yHppWKR65hNC8Fw==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	Diederik de Haas <didi.debian@cknow.org>,
	Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2] arm64: dts: rockchip: Add GPU OPP voltage ranges to RK356x SoC dtsi
Date: Sat, 29 Jun 2024 18:39:02 +0200
Message-Id: <bdb60f1f793166cd65f58ab7aea025347076019c.1719679068.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add support for voltage ranges to the GPU OPPs defined in the SoC dtsi for
RK356x.  These voltage ranges are useful for RK356x-based boards that are
designed to use the same power supply for the GPU and NPU portions of the
SoC, which is described further in the following documents:

  - Rockchip RK3566 Hardware Design Guide, version 1.1.0, page 37
  - Rockchip RK3568 Hardware Design Guide, version 1.2, page 78

The values for the exact GPU OPP voltages and the lower limits for the GPU
OPP voltage ranges differ from the values found in the vendor kernel source
(cf. downstream commit f8b9431ee38e ("arm64: dts: rockchip: rk3568: support
adjust opp-table by otp")). [1][2]  However, our values have served us well
so far, so let's keep them for now, until we actually start supporting the
CPU and GPU binning, together with the related voltage adjustments.

[1] https://github.com/rockchip-linux/kernel/commit/f8b9431ee38ed561650be7092ab93f564598daa9
[2] https://raw.githubusercontent.com/rockchip-linux/kernel/f8b9431ee38ed561650be7092ab93f564598daa9/arch/arm64/boot/dts/rockchip/rk3568.dtsi

Suggested-by: Diederik de Haas <didi.debian@cknow.org>
Helped-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Changes in v2:
      - Dropped support for optional GPU OPP voltage ranges, which may
        actually hide some misconfiguration issues in board dts files, [3]
        but that will be covered by other debugging patches [4]
    
    Link to v1: https://lore.kernel.org/linux-rockchip/446399362bd2dbeeaecd8351f68811165429749a.1719637113.git.dsimic@manjaro.org/T/#u
    
    [3] https://lore.kernel.org/linux-rockchip/f10d5a3c425c2c4312512c20bd35073c@manjaro.org/
    [4] https://lore.kernel.org/linux-rockchip/36170f8485293b336106e92346478daa@manjaro.org/

 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index d8543b5557ee..ec772bce359a 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -195,32 +195,32 @@ gpu_opp_table: opp-table-1 {
 
 		opp-200000000 {
 			opp-hz = /bits/ 64 <200000000>;
-			opp-microvolt = <825000>;
+			opp-microvolt = <825000 825000 1000000>;
 		};
 
 		opp-300000000 {
 			opp-hz = /bits/ 64 <300000000>;
-			opp-microvolt = <825000>;
+			opp-microvolt = <825000 825000 1000000>;
 		};
 
 		opp-400000000 {
 			opp-hz = /bits/ 64 <400000000>;
-			opp-microvolt = <825000>;
+			opp-microvolt = <825000 825000 1000000>;
 		};
 
 		opp-600000000 {
 			opp-hz = /bits/ 64 <600000000>;
-			opp-microvolt = <825000>;
+			opp-microvolt = <825000 825000 1000000>;
 		};
 
 		opp-700000000 {
 			opp-hz = /bits/ 64 <700000000>;
-			opp-microvolt = <900000>;
+			opp-microvolt = <900000 900000 1000000>;
 		};
 
 		opp-800000000 {
 			opp-hz = /bits/ 64 <800000000>;
-			opp-microvolt = <1000000>;
+			opp-microvolt = <1000000 1000000 1000000>;
 		};
 	};
 

