Return-Path: <linux-kernel+bounces-334973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F64597DF1E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 23:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC12281997
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 21:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E495153BD9;
	Sat, 21 Sep 2024 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="QBXhJMEc"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC418C0C;
	Sat, 21 Sep 2024 21:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726954759; cv=none; b=o2DtnuAlFpH8VugyVA9mi527VWBUmMp0AhRv18vDrc/2oTUghnSdXu92+dSck7d3sDvS2OzYEz9NVewLoWm2NenWT4fNsgRg6dGRyplzbhNUY5HW/3Pk0NVMTdIoRc1tLZ1RbvIpKmMzX/30LroA68RMdf5B0g3vbY2T8v2NqCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726954759; c=relaxed/simple;
	bh=M4oZCqXGhLLWYXbsYySGhb5yUmG3h65+XPYXSVQf2Tk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z7iYhwXVNhDDJhpRpgC6sFLOagkeT+cNuGFyIffIAbkLVBj6MZo2+N0O7I5lgOWzwIymy3QtrfmeNPeeek4qfmzoy5EqDbgpB7KlduPoZ4/9oLuNpECcHqx1oJuJNmskYVtPbcoBbl2ZkWz5dp6yhTePta8QS4KuOdPc5FbaoM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=QBXhJMEc; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1726954753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aK8KbRwCvuQHz3K5ucCXTTuDlPUMyQ/ggvKNYCR3JcM=;
	b=QBXhJMEch4SLR9LAsabdISlPq+wxxOxyvNxom8tqrZWy+AyEUyzJlHhZPU+hqMgMGSVjVm
	X61iJYA3awBeRoVaUhcu6JEhPpDnPivTjIyWG9ueCg05CuhRT7IhhJ9wojWnv/Qp5ZUwJn
	mIB6MUWRudUDy3r6Vqeq3lm2L2QJT1WGiPWmZ0Tjtkq2f5Pq7zDTp1rgIXQxntTgS1F7kb
	tENRJQCgZYtkaE1dJBWMaVlxxwFBUuEQ8XuNqijbK+o9vUtWyZ/FW6VK0zxKlz8K6mxh1F
	9FJiKbOwHKlFCwoCS6cx05DEBTu1KGktpTDvNbU7V1cPUtgocf4FRG7u8hzTgw==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	alchark@gmail.com
Subject: [PATCH] arm64: dts: rockchip: Start cooling maps numbering from zero on ROCK 5B
Date: Sat, 21 Sep 2024 23:39:05 +0200
Message-Id: <335ecd5841ab55f333e17bb391d0e1264fac257b.1726954592.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

The package cooling maps for the Radxa ROCK 5B were mistakenly named map1
and map2.  Their numbering should start from zero instead, because there are
no package cooling maps defined in the parent RK3588 SoC dtsi file, so let's
rename these cooling maps to map0 and map1.

Fixes: 4a152231b050 ("arm64: dts: rockchip: enable automatic fan control on Rock 5B")
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
index 966bbc582d89..6bd06e46a101 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
@@ -304,12 +304,12 @@ package_fan1: package-fan1 {
 	};
 
 	cooling-maps {
-		map1 {
+		map0 {
 			trip = <&package_fan0>;
 			cooling-device = <&fan THERMAL_NO_LIMIT 1>;
 		};
 
-		map2 {
+		map1 {
 			trip = <&package_fan1>;
 			cooling-device = <&fan 2 THERMAL_NO_LIMIT>;
 		};

