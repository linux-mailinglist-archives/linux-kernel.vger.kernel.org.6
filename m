Return-Path: <linux-kernel+bounces-260983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EC693B139
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 15:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5EB4286E36
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 13:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BCC15B119;
	Wed, 24 Jul 2024 12:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ck7efMB/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="XZx0H1+X"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB8515A86D;
	Wed, 24 Jul 2024 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721825966; cv=none; b=bfLrs0Fy2LtNLYIux+X4JnfExnQc0fH8eKJ1BpgkuuRcVUWS24s/NczFBPBZE6xWsoVz2xOwsX2hkv4pLwUTeF/+iZ2BtOHlk7F15w/6lASqh8fJOZMNIAMbd+V8wjTlGRP8sKAU9o9drR1rHp9+Pz63/IjwmzZxcRYlKMiqvUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721825966; c=relaxed/simple;
	bh=QXVzrJiX54JxzATuKTRirTJQF0y83cMNqMKg4AhdhRc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrKhSuJniwNdLEROg6ZBsDiVGKCJqliIf+6tKU8qMjN2XBKNUjFuTx2tOKbvH/00Fw19K4U0q83oLi6khLuywILtE8Xs+rGIrpiAx6m4i9t/pIM8e9Djlls+GgWdcQmq6VIFaVne2xXfEeGIwH8xQ9QFVExAhCKf9npt5NdDjOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ck7efMB/; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=XZx0H1+X reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1721825964; x=1753361964;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/R5aDsx8hB6H/wOnLh4KBm0p+Aw8FGHV9al2OrWUyQU=;
  b=ck7efMB/BbcGnavLy+fd99JGLW/W35SD8aTuHbsIkti296m+FHd1xf3e
   eb+LLVEjz6Ae5HF0BpQ2MCWdOZSTeLl2y0dFkJUi/ML+lyxUCHVHetPIr
   TJNv0PxJhTOYa9w4lm+qfKM4n8Gd46S8SUkzlFXGgaNAkxy9/eBxFPmkB
   5zpNF5+xQSv8PPAIDbywEK6MTLjTbari792Z2S5FheQufaFO/V2KqB4Vt
   1Vcccbnf1Ayxdf++3YVr2YkAGt9Irbm1+Yiw3rTXFZGPxE9MbHbVG540o
   I60EAmfaTbWVjqH9aUD66y54mGnYICyoiROYnkeNAExypFKJIQkf4vbwO
   A==;
X-CSE-ConnectionGUID: EZXFhIG9ScmCF7RmqaT0Gg==
X-CSE-MsgGUID: BpKvwvZuRAulhPgI+Pdz9g==
X-IronPort-AV: E=Sophos;i="6.09,232,1716242400"; 
   d="scan'208";a="38058829"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 24 Jul 2024 14:59:22 +0200
X-CheckPoint: {66A0FAAA-11-CA1431AC-CF855369}
X-MAIL-CPID: 0C81C03454CAD8424C5C49CF2DD317FC_1
X-Control-Analysis: str=0001.0A782F26.66A0FAAA.00D0,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2016D16E009;
	Wed, 24 Jul 2024 14:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1721825961; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=/R5aDsx8hB6H/wOnLh4KBm0p+Aw8FGHV9al2OrWUyQU=;
	b=XZx0H1+Xq0MJtZxTxbR3zpgBC8QeoUNkZmtlerQJMo8sSHbRFgqd1lZ+mauGUAevB4WDoT
	axR4yZTAPNSE2eDkeJFmSzVZQwxdYkArmbzvp1aT2p3crDDFGngtuBsmj/If1MODtZIyRQ
	9VAPqdrjdKqaO02j/IeLqqvyfw+zDYwsR88XAa89qmoznjenHw2XXAwHjYXhQp4V0FM0Ux
	4tzx7EERMJA+1cXPSL6ynOAy1Txn+f3kRoUIpkYRtiB8xTDlFUde7wR59NKDaa+EdzCoY7
	zPVoJsl7jgUmjsw174Ik9fcT4HG8f8znjOUJ2jvW7hJv0spaGDjdKNdR34dHJQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/14] arm64: dts: freescale: imx93-tqma9352-mba93xxla: add irq for temp sensor
Date: Wed, 24 Jul 2024 14:58:54 +0200
Message-Id: <20240724125901.1391698-8-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
References: <20240724125901.1391698-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

This adds muxing and configuration of the irq output of the temp
sensor on TQMa93xx that is connected to a GPIO line on MBa93xxLA

While at it, add comment for RTC_EVENT for pcf85063 since the IRQ line
of both devices on SoM are routed to CPU GPIO on MBa93xxLA.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 .../boot/dts/freescale/imx93-tqma9352-mba93xxla.dts    | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
index c663b6585c3a..3038c94a1184 100644
--- a/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-tqma9352-mba93xxla.dts
@@ -452,13 +452,21 @@ &lpuart8 {
 };
 
 &pcf85063 {
-	/* RTC_EVENT# is connected on MBa93xxLA */
+	/* RTC_EVENT# from SoM is connected on mainboard */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcf85063>;
 	interrupt-parent = <&gpio1>;
 	interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
 };
 
+&se97_som {
+	/* TEMP_EVENT# from SoM is connected on mainboard */
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_temp_sensor_som>;
+	interrupt-parent = <&gpio1>;
+	interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+};
+
 &tpm5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_tpm5>;
-- 
2.34.1


