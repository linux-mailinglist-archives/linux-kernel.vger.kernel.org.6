Return-Path: <linux-kernel+bounces-427772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 240649E097C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D923B3757C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D957320C47C;
	Mon,  2 Dec 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="PUkoZ0sI"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9920896F;
	Mon,  2 Dec 2024 14:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733150659; cv=none; b=HgycZRBdh2rjIumAcqE+PlSpfhajjVcZnT9kuf9sebslIrogPUHHEKksZGlrgQwGYh46WE0dtgcwXRkKWHsFqO5E4OUlv0k8XZIH7SEJmatrLVE5UjSBOraBqblU6xxVQ4gSaQ67nUriFwe9LxlYCbj6sdB/utEHhxUDFc0SMQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733150659; c=relaxed/simple;
	bh=RhmgU2LQevOuNgGHPl7VYwtenvcTXhvRn2Ebadd1Sxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CwoTUroiHTqk94xE529g2EHF59SayaGCtBWNiVeKnonPJH+n1zoNesLkxPc0HT0NUfF1nWhBZKDb2dJMc6Sj7tNOPi0OIhME1sE4hjgu7LrTQ1W8TCHLZwU+1UBU/HTPA30zcZpDk9yhLVwkP8B3Aoaa/6ecqIHtjjqrZ9ONWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=PUkoZ0sI; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1733150655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yRJZlOcms6c9rbeZYvsX5MTDNXpRGMuOjccJ3gJk83o=;
	b=PUkoZ0sICV8QIm+TzgZgwT/vqL+UjIf3NGBGb4D6j6pG4v29Wgv3b4n0uv1BsxglBCNmIH
	uODreYlZFOZvBu6Bla55ay6k7a88JO2vegl7w/C1uKNt6atCe4rGTesKRxdMw1lf3ErBdZ
	SwZY/UPtaJtvmqUt0kSNhPAXX+KO5XvfrbS2EyKPYjw4IOKqcOtGR8FRvKqNT/X9F45v9z
	pCf63WuI1kut/xi52Pq4ZAZ/L8upFLkVLyChu8t/Es9LeaBkIPoioS66Z/PzSHaGNuSBbd
	UHXh4KwW+ec1Yq/jgzU8Pfrs1HSxEykI6tlI7PtH2l4+kKPJo3e497eV4UfaWQ==
To: linux-rockchip@lists.infradead.org
Cc: heiko@sntech.de,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	didi.debian@cknow.org,
	marcin.juszkiewicz@linaro.org
Subject: [PATCH] arm64: dts: rockchip: Describe why is HWRNG disabled in RK356x base dtsi
Date: Mon,  2 Dec 2024 15:44:06 +0100
Message-Id: <6b272e2f8f916c04b05db50df621659a5a7f29ab.1733149874.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Despite the presence of the hardware random number generator (HWRNG) in the
different Rockchip RK356x SoC variants, it remains disabled for the RK3566
SoC because testing showed [1] that it produces unacceptably low quality of
random data, for some yet unknown reason.  The HWRNG is enabled for the RK3568
SoC, on which the testing showed good quality of the generated random data.

To avoid possible confusion in the future, [2] let's have this described
briefly in the RK356x base SoC dtsi.

[1] https://lore.kernel.org/linux-rockchip/cover.1720969799.git.daniel@makrotopia.org/T/#u
[2] https://lore.kernel.org/linux-rockchip/20241201234613.52322-1-pbrobinson@gmail.com/T/#u

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
index 62be06f3b863..ab8f42c0a843 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x-base.dtsi
@@ -1032,6 +1032,11 @@ sdhci: mmc@fe310000 {
 		status = "disabled";
 	};
 
+	/*
+	 * Testing showed that the HWRNG found in RK3566 produces unacceptably
+	 * low quality of random data, so the HWRNG isn't enabled for all RK356x
+	 * SoC variants despite its presence.
+	 */
 	rng: rng@fe388000 {
 		compatible = "rockchip,rk3568-rng";
 		reg = <0x0 0xfe388000 0x0 0x4000>;

