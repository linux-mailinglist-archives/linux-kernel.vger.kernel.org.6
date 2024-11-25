Return-Path: <linux-kernel+bounces-420653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 845509D7FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13654B27167
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171D318FC65;
	Mon, 25 Nov 2024 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="DA0YIWZd"
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6BD187849;
	Mon, 25 Nov 2024 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525376; cv=none; b=X0uyF4ZZJSUS12smzx/Zj1h29q6urXyfRvi35OqLgn1ghIYrorgNIlo5zKy9X1p6tqK7mFi2kCyHWajZaaJBqR0zzKaSNCHIeYv8lk5FydF+N2aBqztLz5KZS3B4ID9QR9pqD2egxbduAbdMqP97Oh6Ee/22N1xN7eqsyorSa10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525376; c=relaxed/simple;
	bh=Uda7953howVUmeNOhjn5oQVxx2RPhTS5RXjowq0nkqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huydMVxqo0BYteI+NFe4OsJjsjm8yAZp+pmmL42UPapp0mpsdNaG+1DSRjzr13fcGD1fbKMJxeChxfqhKa7SwJn3qSjSReUT/Efz00/BIRw2Yz5B3FM96p9SElwA55olp4So8NbxJun1iwsVK23X7escD6/skfitr9nIBorVRS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=DA0YIWZd; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8lEkVLzppht425ev0cm54WY5kvUL/Y39nOpsptm+9Ao=; b=DA0YIWZdrFTMRJKivwK+y4vlDi
	f3NStfIfYkEeE+DBnP+weK5f1ouJZH/bZXad7M7rTNHFcXm6IW0t/uL/xpCKEcXhrRJEyG5X9HMKd
	HLIJqnjxBPoCZWadlIAEQrUUaZxTrxN9eedCsw54cbWYYtWizKmph0WhLW7G4dVLuwNdIA2AD8uG7
	jkvt0fWJVwbwq9Glv+7Zof9h+2MakNgNgn67qPZtWMazX3sKDNIjaxRg1Xae6FeBWOWnqJ/P2NG8w
	Sq64wZlNaDGLAovoCOXmcsx+vNWEBVABikNYUIp+wBTUetzR/7jsho3Ru/ANsel4CC+sTHHoesA0L
	K7O/l0KQ==;
Received: from [91.26.50.162] (port=58340 helo=and-HP-Z4..)
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tFUIn-00Eq70-0P;
	Mon, 25 Nov 2024 09:18:36 +0100
From: Andrej Picej <andrej.picej@norik.com>
To: shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 01/15] arm64: dts: imx8mm-phycore-som: Keep LDO3 on in suspend
Date: Mon, 25 Nov 2024 09:18:00 +0100
Message-Id: <20241125081814.397352-2-andrej.picej@norik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125081814.397352-1-andrej.picej@norik.com>
References: <20241125081814.397352-1-andrej.picej@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Teresa Remmet <t.remmet@phytec.de>

LDO3 is also used as switch for enabling VDD_3V3_S and need to
be kept on during suspend. Disabling this can lead to an unwanted
reset during resume.

Set LDO3 to 2,5V as the voltage should be fix.

Signed-off-by: Teresa Remmet <t.remmet@phytec.de>
Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
index 6069678244f3..7761acc5c510 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-som.dtsi
@@ -161,11 +161,13 @@ reg_vcc_enet: ldo3 {
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-max-microvolt = <2500000>;
-				regulator-min-microvolt = <1500000>;
+				regulator-min-microvolt = <2500000>;
 				regulator-name = "VCC_ENET_2V5 (LDO3)";
 
 				regulator-state-mem {
-					regulator-off-in-suspend;
+					regulator-on-in-suspend;
+					regulator-suspend-max-microvolt = <2500000>;
+					regulator-suspend-min-microvolt = <2500000>;
 				};
 			};
 
-- 
2.34.1


