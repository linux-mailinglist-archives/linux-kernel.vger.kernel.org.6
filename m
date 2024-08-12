Return-Path: <linux-kernel+bounces-283294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D3994EFAE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07111B249DD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE99D1836D5;
	Mon, 12 Aug 2024 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="RiGLqX8O";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="smODH/lR"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14747184534;
	Mon, 12 Aug 2024 14:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473299; cv=none; b=ObRzR8eXbQYCTR+PY4YcZoZjC1pORHG1+AijeYk6GczAdQ7bt7WwmnU1S9ugVrZnbCvJhZCutGKRrRZ9MIAWO4zEvrw9IByx53Z43i1c6t1HuqANAoU8+ZhrCMEKKZpRlBb60xBEEIzMd/WowpveQ+Ip9Fi+WW43BIXzUWcaRbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473299; c=relaxed/simple;
	bh=unCLAr90LFRPxa8iYW53qq+ijgxPy33i0GA/ckYq/xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cIlkhqg5JUkSMEBfzEZvoOr+YAnBXw9YbkpwfKFEtiRwJNVw3TH1dFE8c8x7gA1b2YD+CZo0wou1v7wwZUw90hT/jb/F0qjGxAQwHYLqa+lnL7Lx/J2p5pWVHaG8agDiDuSxpwjyD9XDvpXe8Dn82vsd74k2YtzX0rFEbR1Wm6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=RiGLqX8O; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=smODH/lR reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723473297; x=1755009297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eghM8hUwT4/I5cQZwq2gxvLgN3Js+MPb2HK+BYmg+gU=;
  b=RiGLqX8OsHWhnxNh8GTgT5k+kmIe70kdaMdqxMVTifvwCh1jkhluLUAC
   9GaQMdnersnxLXqjraScHKWUc5YBcc9fqRKaYLU68goUI1UFdYEXqAIbZ
   INF4/DDz3uqbPf9FvCQ5r+qvLO17eZ5ffbwXbMjk9fs9HsT+OKIvlgRHJ
   /caXlYPWR7Q2GxR9+ZdTbIlbkC8EE/Di4pllsgP+YoDmHzULg2nv1i9xF
   78xcOqVieZBhYQmkVNIdnANc8DDVRa+AY7i/5ibXXn5bhldb+eGxgruBI
   o/6A0olumgbalrfuN24DljRXBxRRRZiShkjwNWjSipyRYtR2PlHdhF3PI
   w==;
X-CSE-ConnectionGUID: 9SOPj4v8RdmZNUAPwzFhYQ==
X-CSE-MsgGUID: l7bALpPoQpeuUENzB8reog==
X-IronPort-AV: E=Sophos;i="6.09,283,1716242400"; 
   d="scan'208";a="38365809"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2024 16:34:55 +0200
X-CheckPoint: {66BA1D8F-A-45EF2B36-F6E28480}
X-MAIL-CPID: 4AED41F6C2D4443F7053FA744FEF28ED_0
X-Control-Analysis: str=0001.0A782F29.66BA1D8F.00F9,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E2903164635;
	Mon, 12 Aug 2024 16:34:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723473291; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=eghM8hUwT4/I5cQZwq2gxvLgN3Js+MPb2HK+BYmg+gU=;
	b=smODH/lR8VNa4dkmniiocmcT0HhFCFgXZ8b49zUcMiCL5Q1HKwA9B3cc7kOV7JFz6qxFjP
	y78bGaHA3+zceiBN35p8Z0ZVAKtwbcgtI2z8I2hjy1N7uBWMK28yjkMRJ4gnLADcJgCbBg
	1LgicU3sDOUlnrU2RQjDcPlVklmnxXW2Xqh/w7fnwYVcLxhzVEFLRRgW0itWAz4lxqDyGA
	f/arxbCda/tCAhx3hxDGas9TdhnT1y1EwkTUeVMwC9lDejEFPe5rUTZiOcs6HzFc1x1ElD
	XechDgAVlhr0jRY90eRCwo+s0B8UlXpvFm09P50/U/cNmzDfHr8tsYSLRav/MQ==
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
	linux@ew.tq-group.com,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH 3/5] arm: dts: imx6qdl-mba6: improve compatible for LM75 temp sensor
Date: Mon, 12 Aug 2024 16:34:29 +0200
Message-Id: <20240812143431.98323-4-Markus.Niebel@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812143431.98323-1-Markus.Niebel@ew.tq-group.com>
References: <20240812143431.98323-1-Markus.Niebel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Use national,lm75a to specify exact variant used. This should cause
no functional changes.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi | 2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi
index 807f3c95e3ce..aca320ee8f47 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6a.dtsi
@@ -13,7 +13,7 @@ &fec {
 
 &i2c1 {
 	lm75: temperature-sensor@49 {
-		compatible = "national,lm75";
+		compatible = "national,lm75a";
 		reg = <0x49>;
 		vs-supply = <&reg_mba6_3p3v>;
 	};
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
index 789733a45b95..eacd230b97d5 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6b.dtsi
@@ -23,7 +23,7 @@ &i2c1 {
 
 &i2c3 {
 	lm75: temperature-sensor@49 {
-		compatible = "national,lm75";
+		compatible = "national,lm75a";
 		reg = <0x49>;
 		vs-supply = <&reg_mba6_3p3v>;
 	};
-- 
2.34.1


