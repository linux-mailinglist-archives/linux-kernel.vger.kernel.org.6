Return-Path: <linux-kernel+bounces-283296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DFA194EFB2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FD9F1C20BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDD2186295;
	Mon, 12 Aug 2024 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="V0nNrHon";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EeCCcjRG"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DFD1850B6;
	Mon, 12 Aug 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473307; cv=none; b=QzYY7yLPYcdLYttAcIxGuFHSfSGI9gAfgOd232RcqDfSAxK7/HCFLWLrR+GYOoj1CR9UM5F9R/uZYGvzdIILOFndCnIFxbjzmVL9zL73ev3JkOIO8zSwNI35WDVAQEQkldNVjJgyrchhMEEwzirJGFQNRxcIehsZ0aNtllFl+fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473307; c=relaxed/simple;
	bh=xjqAuhJpA0xZWEigQoCmxwh+5iQGcDcAu0cT4Y6ew0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ohuAZr/0+Uq3VaIlPOLyV4rmXvG4Bbo6H1rF0qIK3x0f+IJ9K4N3rBlyX7fuLfdVcxbWekFG4UUyktFlUwJqTQZu9FtTWOV48YVMMSyaAmVonleEWGHu1DUOxc4XmHUsWBZxk+QbFgFtVRE4lOIlzJ4xaVFZCEvIaefPpYtwnz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=V0nNrHon; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=EeCCcjRG reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1723473305; x=1755009305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E8Kth3fA3aTsIi3zi/z1NJuU2FBB7BRl6ZUueJYtQlU=;
  b=V0nNrHonQwEtwAxZgOc1Cq5m+e0XdkqNoBL3COkZK+jUe+iVEt/yY2Hp
   rsQXgyI2SN3ksHCadbsS3nJLzhKQI22tw6q8cT2z3EWLgQtasf0bbjDPU
   7GZC5kLte8E018hnq3TYc/m/kVgZk/z1shJjrQfob/rxVeKM3eoM0hQQL
   epQGB8N7jxrxM/XZfaXnKtI1+qyZkBFj4ab6veYpZwHDnj7kWQ+t2FihJ
   NlwiFNfbVmFJ+3XS/celKF6f+WmjoF2cwUetgeG2lgVteml1Dwf8EcYsL
   nguhORxMRvcZ8yPWKL0IW4W6X1mmZgFgVnjp58reYa4FKoSV103LfieYY
   Q==;
X-CSE-ConnectionGUID: midpRNUzQkKSXEAy+2ubdw==
X-CSE-MsgGUID: PuwqICoMR3WRKO0yQCPSyA==
X-IronPort-AV: E=Sophos;i="6.09,283,1716242400"; 
   d="scan'208";a="38365816"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 12 Aug 2024 16:35:04 +0200
X-CheckPoint: {66BA1D98-D-751552D8-F91D2344}
X-MAIL-CPID: 095354DFB4E9CC4285F0E89EE3615953_4
X-Control-Analysis: str=0001.0A782F25.66BA1D98.011C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F2247164776;
	Mon, 12 Aug 2024 16:34:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1723473300; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=E8Kth3fA3aTsIi3zi/z1NJuU2FBB7BRl6ZUueJYtQlU=;
	b=EeCCcjRG+2Zmi/c3b7/iJzYo8reaNBemR4qCEffyvC7onJhF7uoWb+ZBOQYcFq8FlZYkUa
	zaAsmsM5t926leadNEaWwvDLESjPkmB7A9o4mfY3qd/60SIH70CmcbOIGOIwNBORh9Pr+w
	d/HOSMJMzzLN1DyvCTq8T1UDpC/Ytp2rnylntB0XZnGR2fB6kyPcgwStIFVWSxN3FF30Wh
	1l9dfqcepd+zk0H62GO/D0C1N+b0o58K88KLUgEtV6aP4amaPe0lNcHS6wUWw6+a3Tp9RT
	PCl1g/3kzwFndTSQnp+9PwNIRYXQYbRVIrJmzlt7PZS6nPYAFyb18wSgezNrxQ==
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
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 5/5] ARM: dts: imx6qdl: Rename USB hub node name
Date: Mon, 12 Aug 2024 16:34:31 +0200
Message-Id: <20240812143431.98323-6-Markus.Niebel@ew.tq-group.com>
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

From: Alexander Stein <alexander.stein@ew.tq-group.com>

According to microchip,usb2514.yaml the node name shall be usb-hub.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
index 60aa1e947f62..d03f7065ddfd 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-mba6.dtsi
@@ -293,7 +293,7 @@ &usbh1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
 
-	hub@1 {
+	usb-hub@1 {
 		compatible = "usb424,2517";
 		reg = <1>;
 		#address-cells = <1>;
-- 
2.34.1


