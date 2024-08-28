Return-Path: <linux-kernel+bounces-304929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59C89626D3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 14:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5535FB22A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 12:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3062517A591;
	Wed, 28 Aug 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="p7wOr0XO";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="WjjPNJ5w"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56E917A597;
	Wed, 28 Aug 2024 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847632; cv=none; b=LklTsTWOkJDVRGk0FpJVAwysuuMy2jN0lO2xL9CjhJncjKsEG2mhV5c1xzHwaMcKH76sG+LfaZ1tpbJmN11N0YhehFbzHqSGTaImsPtgrDJqTqRQdRQ7dSSUkb036ePj3YxZsiO4uoq8OKPxok2q+xeRFF7RUy1NM5CMycgXrFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847632; c=relaxed/simple;
	bh=PgH4QSGEcbjNGDYQZ7pZrhtA7Hdc6PM65Qd//PcMKPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q9mF05FM1XwoEa/+/d4wjRVueBU10tJtNtuWv7ZSb1VbdEFbYJRnEuhL/vjpSZwZu1ZZC8/CJVBMJdSGXLHMbuHX1ucmfwzdtIGeB+ExSotoWKOM8TFzwhgfasl1GJsyaXRClpeaLLL0SNtzkOh6aDCAjsjNC+3kjybpCjD8/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=p7wOr0XO; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=WjjPNJ5w reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1724847630; x=1756383630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5WESFWrSviHfbnmK6a8En190ZANAeT3QpIbcgtxHX+M=;
  b=p7wOr0XO1v8flVfbBhrL2wBujXQhxihvVH1IgxShb/jNxMy6FZCkybJr
   uW4NGscCei45GKRLwdMlmFPphYWB32LO/cn0Sil+A8mhVcRBhDisb8UE9
   MwQuTheYy7SyU1bONMp3O24EmHG7FDNRHT7ipFXsLQ7P88CLt4nT4hByo
   C2LQxwHw6C1p0Z3Zzd2ZrzTP/4ijYaYCIwvsIw47P2dHJKyqlul1eyqGm
   36dcRLCpLtIBDbsdJWdq/pa+cDL/mu0S1lWNtHfWCkeZ4Jk+QJWz6bSpw
   Tc1+jkyOrOuFM8Eex+IBSM9PooRXulBwb3JZXcoRNIm1libAYAw5b7NxU
   w==;
X-CSE-ConnectionGUID: 2Y+KRClEQye4uB8Tfqj2LQ==
X-CSE-MsgGUID: SBHI/VqZR3WFg/qRg3tq6w==
X-IronPort-AV: E=Sophos;i="6.10,182,1719871200"; 
   d="scan'208";a="38635579"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 28 Aug 2024 14:20:29 +0200
X-CheckPoint: {66CF160C-13-E520F13A-D17B83D9}
X-MAIL-CPID: 1D5CBC9955EDF77C39400D3A69EDF928_2
X-Control-Analysis: str=0001.0A782F21.66CF160C.00F2,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C5F511613C5;
	Wed, 28 Aug 2024 14:20:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1724847624; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=5WESFWrSviHfbnmK6a8En190ZANAeT3QpIbcgtxHX+M=;
	b=WjjPNJ5wuWnNQeR0ooX0PxBrHTx8rXtYvL5jeNC02IGX1unkKkJMm9+3ZVc0DshY1gQjB0
	ND3EAamTqd6voJ+oJ4u/qMhGmOLJ7b/tGotbQ86sclyPn42MYx0Mw+Y85+6SLYm9CRr+Wc
	Vks/7KPTrN675vJ/O6gHkYccINPK51oMgvG3M+Y6sk3dUbqogpiaUGw2NowuLH2Bal4VLq
	O1llhAIPN4xY16eEUxjOqbNqJ/9lifNsJ3zp88fqP2dzzHCLVG67IsjM2do3rrH1Yw5qRW
	PYJ+70qHYlvBsfX2mm6SLOw46vGAJVeOboU3ohie/rjzFqrOq2JbgCKUsXjQdg==
From: Markus Niebel <Markus.Niebel@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 4/4] ARM: dts: imx6qdl-mba6b: remove doubled entry for I2C1 pinmux
Date: Wed, 28 Aug 2024 14:19:59 +0200
Message-Id: <20240828121959.1268463-5-Markus.Niebel@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240828121959.1268463-1-Markus.Niebel@ew.tq-group.com>
References: <20240828121959.1268463-1-Markus.Niebel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Since the muxing is described already in imx6qdl-tqma6 can be reused
by this variant. No functional change.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
index eacd230b97d5d..c7bbd6195fef1 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
@@ -50,12 +50,3 @@ rtc0: rtc@68 {
 		reg = <0x68>;
 	};
 };
-
-&iomuxc {
-	pinctrl_i2c1: i2c1grp {
-		fsl,pins = <
-			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA 0x4001b899
-			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL 0x4001b899
-		>;
-	};
-};
-- 
2.34.1


