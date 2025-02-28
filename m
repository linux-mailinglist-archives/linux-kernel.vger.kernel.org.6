Return-Path: <linux-kernel+bounces-538572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A19B6A49A58
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B330C18925FD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92D326D5CB;
	Fri, 28 Feb 2025 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="kCaYDqlg"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF841D555;
	Fri, 28 Feb 2025 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740748549; cv=none; b=j+nW/WScTWEU95gr898mXeul/PbpuWKgdSzZcya45tmXBq1EfUo5PbDSIgnpTYmcTl6bkQT95zqbj6mbCy5NqtdELL4ZgaZwdoDhIts6OVeRmjFXZKARaL9FG8WMWu0pMA1Kf3F6OjbkvZISOC9KS92d4tITRXOp8EXrE0wNDrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740748549; c=relaxed/simple;
	bh=SckwLTl7ZUjoZlVrJjk6dYXBPSpAwAFA5k7zKQwoW2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qC6Eb8Mb7y88d/dHhBCzGJPjteHbRbkkl1b/PcGrMC5xq53LueQrHn6Gob+MpdhvODxH88Xc58XdN4UrLufI3OpfPjbCbtbusUDprNGijjpGOg2DGB9W6mydmsUIk7lQF6/Yyn71uOX7VVYs1bwtbN+8Zm5ntP9JdEXDYSyy5AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=kCaYDqlg; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1740748540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olCRpjYr4qsqRXFdIM/b3JCKLN2vd78BQaVxj7nrTLE=;
	b=kCaYDqlg6pG/DvdWMsiG0vQHMiW09HzgzCV6Qz5Z4bMbRSx/crMZzxA1K+YvfdN+aXZcE0
	babArb1z2kp1on3hQ2n5AZyQKSybp4UPmzrT6U/8w54oL+mA0wW9RFF0cvfEehePrRaauz
	B+M+C6IFFZmG3cD9kedNv3lW+kmAVvYm06MSyIow3SZ6WR680DTcAPSQLhYe+ZQBv7Lnph
	ma9UcCyjt1VhWNRwNSGqdpW4e5ta3pKofGpvaQ7d02IyufA5B9mlXzfw8CT7jY/G5mHcB7
	6BvUtrCSWcEOZt6h1hmtV9nNR8p2aD1TTZkl9zzyOPL0ZNK/Q/tCwPmPBWHFeg==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Diederik de Haas <didi.debian@cknow.org>
Subject: [PATCH 2/2] arm64: dts: rockchip: Add missing PCIe supplies to RockPro64 board dtsi
Date: Fri, 28 Feb 2025 14:15:29 +0100
Message-Id: <83f2938bdd4ba49c1e840537d6ede0f8219b7b90.1740748439.git.dsimic@manjaro.org>
In-Reply-To: <cover.1740748439.git.dsimic@manjaro.org>
References: <cover.1740748439.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Add missing "vpcie0v9-supply" and "vpcie1v8-supply" properties to the "pcie0"
node in the Pine64 RockPro64 board dtsi file.  This eliminates the following
warnings from the kernel log:

  rockchip-pcie f8000000.pcie: supply vpcie1v8 not found, using dummy regulator
  rockchip-pcie f8000000.pcie: supply vpcie0v9 not found, using dummy regulator

There are no functional changes to the way board works after these changes,
because the "vcca_0v9" and "vcca_1v8" regulators are always enabled, [1][2]
but these additions improve the accuracy of hardware description.

Shuffle and reorder the "vpcie*-supply" properties a bit, so they're sorted
alphanumerically, which is a bit more logical and more useful than having
these properties listed in their strict alphabetical order.

These changes apply to the both supported hardware revisions of the Pine64
RockPro64, i.e. to the production-run revisions 2.0 and 2.1. [1][2]

[1] https://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
[2] https://files.pine64.org/doc/rockpro64/rockpro64_v20-SCH.pdf

Reported-by: Diederik de Haas <didi.debian@cknow.org>
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    Actually, these additions to the DT _might_ improve the way RockPro64
    works a bit, by _possibly_ resolving the longstanding issues with PCI
    Express enumeration, which have been observed with certain PCI Express
    cards only.  This was mentioned in the commit 43853e843aa6 (arm64: dts:
    rockchip: Remove unsupported node from the Pinebook Pro dts, 2024-04-01),
    together with a brief description of the out-of-tree enumeration delay
    that reportedly resolves those issues.
    
    Symptomatically enough, AFAIK only the RockPro64 has been reported to
    suffer from the PCI Express issues, and it's only the RockPro64 that has
    the missing supplies in its DT, so maybe there's something that causes
    issues when the PCI Express is probed before the RK808 PMIC, which the
    "vcca_1v8" regulator comes from.  The above-mentioned enumeration delay
    might actually be just a workaround for those underlying issues.
    
    Admittedly, the RockPro64 is a bit specific board by having a standard
    PCI Express slot, allowing use of various standard cards, but pretty much
    standard PCI Express cards have been attached to other RK3399 boards as
    well, and I can't recall similar issues being reported for them.
    
    The required reliability testing will be performed as the time permits,
    so we'll hopefully see are these assumptions valid.  In the meantime,
    this patch remains perfectly safe, from the standpoint of being unable
    to do any harm or cause some unforeseen regressions.

 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 47dc198706c8..41ee381ff81f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -673,8 +673,10 @@ &pcie0 {
 	num-lanes = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie_perst>;
-	vpcie12v-supply = <&vcc12v_dcin>;
+	vpcie0v9-supply = <&vcca_0v9>;
+	vpcie1v8-supply = <&vcca_1v8>;
 	vpcie3v3-supply = <&vcc3v3_pcie>;
+	vpcie12v-supply = <&vcc12v_dcin>;
 	status = "okay";
 };
 

