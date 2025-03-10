Return-Path: <linux-kernel+bounces-554106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23036A5930E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F943A64C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D4C226883;
	Mon, 10 Mar 2025 11:48:54 +0000 (UTC)
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4AD22488E;
	Mon, 10 Mar 2025 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607334; cv=none; b=ssXn8AwmqjYiT0GoFQjWB7n/OFHyrIr/YEOnDAszxcXasGuE5Ep8Q2zN/+L6/Bdm+wZmA8/qrem0pomKXSzIQKAw//vBfwonJt5p4ID8m//BBmsTqER99oi3pXsx+YAMRdqnT/INGa0TxQs1gxy66JvQKXG8ANSCJZ5UUeWpvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607334; c=relaxed/simple;
	bh=MvPXd3qEcQgukfVZwr/MRiMr3l0GliqXl4CwHKQSIJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBlwrH7JAufiRC7tetIFCQ/y2wniERWMNW1Py1eF+0o0GOSeaOKSn1FWJtimy030eT2YRKLa4Rd41vNLAMfg8GIEGw77P8eV8nNaTCIYT0vKx9Gjds2jwfws3jkH15uUKwr6cbRPPUy24PTXDLLT6SAy44IUYUXwcHTV3blA1+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 10 Mar
 2025 19:48:40 +0800
Received: from aspeed-fw03.aspeedtech.com (192.168.10.13) by
 TWMBX01.aspeed.com (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Mon, 10 Mar 2025 19:48:40 +0800
From: Kevin Chen <kevin_chen@aspeedtech.com>
To: <lee@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<derek.kiernan@amd.com>, <dragan.cvetic@amd.com>, <arnd@arndb.de>,
	<gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-aspeed@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
CC: Kevin Chen <kevin_chen@aspeedtech.com>
Subject: [PATCH v3 2/3] ARM: dts: aspeed-g6: Add AST2600 LPC PCC support
Date: Mon, 10 Mar 2025 19:48:38 +0800
Message-ID: <20250310114839.3098148-3-kevin_chen@aspeedtech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310114839.3098148-1-kevin_chen@aspeedtech.com>
References: <20250310114839.3098148-1-kevin_chen@aspeedtech.com>
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
 arch/arm/boot/dts/aspeed/aspeed-g6.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
index 8ed715bd53aa..87dcacb78692 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g6.dtsi
@@ -626,6 +626,13 @@ lpc_snoop: lpc-snoop@80 {
 					status = "disabled";
 				};
 
+				lpc_pcc: lpc-pcc@0 {
+					compatible = "aspeed,ast2600-lpc-pcc";
+					reg = <0x0 0x140>;
+					interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+					status = "disabled";
+				};
+
 				lhc: lhc@a0 {
 					compatible = "aspeed,ast2600-lhc";
 					reg = <0xa0 0x24 0xc8 0x8>;
-- 
2.34.1


