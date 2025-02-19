Return-Path: <linux-kernel+bounces-521251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200CBA3BAAF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A497617B880
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C74E1DC184;
	Wed, 19 Feb 2025 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="ZMxTfHK3"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DC01DB546
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957615; cv=none; b=eHjp9V/fHONMKBIN+D8fap6BBeYQaHUMfrreRAB5JVVQGY2aAhun5pUoe0IXnPDc9kUo14ax+GL5sF7hgaYPJnN7r9chRX7ghsyM+DeuQFpAWnodLU+PK+SUPfaXB5sDYgIGFNF7J+OGh8Bb91nZLnmwTWZMGAvfD52xAWuH1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957615; c=relaxed/simple;
	bh=i8aNidPun3DtIlzFxXzJEdtnpQpHVl8+k00jsorDxEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogMXUGPpolvrPOXecINm4ZNrFRrYfYTHnkeygYSqtUXojjNxotrDPeqKVNTwWnYbMfll912xR2ftTBfK1ODT7xF98H7q0IFdXNh37ZX2c9JxtOiafZzB8nMiSDBjacbKqMJ2IlR6ZuLZ8ZB3UjlTwhRbXNwGyPJS238T4iX/AuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=ZMxTfHK3; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MCzguZ2VgyYgHmOIRQ6dYHRDQlMI99iWe+pm1t5HaZc=; b=ZMxTfHK3LL/374MHiPUzZPlx2F
	barGkQnwynwgyHGyPaj4UB5v+4Rl0RtTPzjh0uqUFZsfjlo9Pu6Ym3yQmKFyBQMmddcGRFnRAT9Vm
	145fXiC3iPRUsoDS2AN/6pgfpBO5WpdSRKhYXmtSjHmgVqnkAuU1v8D7hepw7pAfOoSRG1afZTIQA
	IaNdimQxhxP25KxKaEIUd0xTzj35xKKlPVN+0WdC+FfaEpExyr3zOy6CPcCuibnOO35Nue//zmLS6
	ZzD21JwJQuNm8TNgg2b1HGP+SX/Faf1/Y8XUEVOio63b8fwW4YgQL+cIQAhCwvGmINCsSDMScBnPq
	qgQr7Y7w==;
Received: from i53875bc0.versanet.de ([83.135.91.192] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tkgSQ-0007nl-Qz; Wed, 19 Feb 2025 10:33:30 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: quentin.schulz@cherry.de,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lukasz.czechowski@thaumatec.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/2] arm64: dts: rockchip: remove supports-cqe from rk3588 jaguar
Date: Wed, 19 Feb 2025 10:33:02 +0100
Message-ID: <20250219093303.2320517-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The sdhci controller supports cqe it seems and necessary code also is in
place - in theory.

At this point Jaguar and Tiger are the only boards enabling cqe support
on the rk3588 and we are seeing reliability issues under load.

This can be caused by either a controller-, hw- or driver-issue and
definitly needs more investigation to work properly it seems.

So disable cqe support on Jaguar for now.

Fixes: d1b8b36a2cc5 ("arm64: dts: rockchip: add Theobroma Jaguar SBC")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
index 7e8f0a452ca0..be5426b61cac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588-jaguar.dts
@@ -613,7 +613,6 @@ &sdhci {
 	non-removable;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_bus8 &emmc_cmd &emmc_clk &emmc_data_strobe>;
-	supports-cqe;
 	vmmc-supply = <&vcc_3v3_s3>;
 	vqmmc-supply = <&vcc_1v8_s3>;
 	status = "okay";
-- 
2.47.2


