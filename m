Return-Path: <linux-kernel+bounces-260374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E77593A7E7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2A82859D9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F316114387F;
	Tue, 23 Jul 2024 19:56:36 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363C1143872
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 19:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721764596; cv=none; b=YQm36r+8pjotxI52DXcz1Uyv0Y93Uce09nIpUGd4Ymwg52Vgm4tVIKgKRLbb6eGSthtkP7lTVVF2bhmbTtowEQT/yUKTywr//7x8TVTtopjfsSOeX/W62DGuC2KWIuVSMSVKDN1VN7Xo7Q0YI9Amf3BRGHF9c5w/j0CwlrjX6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721764596; c=relaxed/simple;
	bh=8WDJzS9rh2ltn4bUgPc1mUlJDlkJyS0u0mV1zeMHqRU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ww9Z6IWKIvtpLnKyMxyfcd4YXm6wYrF9PEmI93s1F/MjA5qYI2KwDpQzmhGfombtrfh0AJAu7ChYoJdo3WrkguudA5nxv5+VHDsSb9k/el6Z6iJP0AB/DAOQgS/TTd2AUtvH3hjk2OjiOc0LBLj8WwoSBfQ1q7ZJbJS2rTasxvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sWLbv-0005iD-S2; Tue, 23 Jul 2024 21:55:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: ukleinek@debian.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/14] arm64: dts: rockchip: add 2 pmu_io_domain supplies for Qnap-TS433
Date: Tue, 23 Jul 2024 21:55:38 +0200
Message-Id: <20240723195538.1133436-15-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240723195538.1133436-1-heiko@sntech.de>
References: <20240723195538.1133436-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the two supplies for the pmu-io-domains that are defined in the
vendor devicetree for the TS433.

Tested-by: Uwe Kleine-König <ukleinek@debian.org>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
index 9a0cb69c3cfa0..6c4269b3d9597 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-qnap-ts433.dts
@@ -531,6 +531,11 @@ vcc5v0_otg_en: vcc5v0-otg-en {
 	};
 };
 
+&pmu_io_domains {
+	vccio4-supply = <&vcc_1v8>;
+	vccio6-supply = <&vcc_1v8>;
+};
+
 &sata1 {
 	status = "okay";
 };
-- 
2.39.2


