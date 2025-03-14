Return-Path: <linux-kernel+bounces-561296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45391A60FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB8947AEDF8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EA41FE46D;
	Fri, 14 Mar 2025 11:21:28 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D281FDE2A;
	Fri, 14 Mar 2025 11:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741951287; cv=none; b=T5iGas3NoDei8LbyQrHMcb+xNXFdah4llcMxquak+yQUxhin9EbUXL7ptspoQiXzkpyCqX2+fCtRQwlTuGvflNiiMPVHeI7T2J3ud+LNgv+gLdUB9NgBLptU3PsSuMY63mvW6a5fbr4VgPIyEuGK5PQmGdC9swIBPWBSRUeal28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741951287; c=relaxed/simple;
	bh=JlaPosHFcMTCduhHQ6vio5LbJwrALh+R4iVTfmW4Vwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QVjaY1BYmUcrrZUVVLiFfK+2R9aJNKJoASY1lUwkZ1FXLa++J+bvTgwiNNVa4mXZ4CoYJSOCctcs0YYX0pWNcAkeNMBsMNWrljEV9YvEKEEigkFuWA7mAC1w+8hYrkzo7wwmx2FngBvyO9esfkvtQRWlzCEkJ5YHPkUcld5s57M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 14 Mar
 2025 19:21:14 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Fri, 14 Mar 2025 19:21:14 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v4 2/3] ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
Date: Fri, 14 Mar 2025 19:21:12 +0800
Message-ID: <20250314112113.953238-3-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
References: <20250314112113.953238-1-kevin_chen@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The AST2600 has PCC controller in LPC, placed in LPC node.

Signed-off-by: Kevin Chen <kevin_chen@aspeedtech.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..f238337e02da 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -626,6 +626,14 @@ lpc_snoop: lpc-snoop@80 {
 					status = "disabled";
 				};
 
+				lpc_pcc: lpc-pcc@0 {
+					compatible = "aspeed,ast2600-lpc-pcc";
+					reg = <0x0 0x140>;
+					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+					pcc-ports = <0x80>;
+					status = "disabled";
+				};
+
 				lhc: lhc@a0 {
 					compatible = "aspeed,ast2600-lhc";
 					reg = <0xa0 0x24 0xc8 0x8>;
-- 
2.34.1


