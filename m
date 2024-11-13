Return-Path: <linux-kernel+bounces-407433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0999C6D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30F48B250EA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1BC41FF604;
	Wed, 13 Nov 2024 11:05:43 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BDB1FF04B
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 11:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495943; cv=none; b=e3nufeyNJbU9bHwcgS9g4oAwAx6QePAKULcAIVtTDd9eXB2fap+GROo/V+WtfU+jpjRVeg2p1yN/+ytNWfL8a/D9D9FUSDIVyZwnZUNfTTzsTr2m81rJDCMLExwHi6qXNwQc5zH29vCOYCBYA9AsHbppWL6ztj4TLPrVBKBYzCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495943; c=relaxed/simple;
	bh=vG//sQZhtcwAZ/vmCZGBDAof70cWBIWhc+yVz2PZyS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sDKA6+wdndzDIRRXHRqtuE10TXX4+THvwAaNpMk68gCQQNkMI/uszxz1Q34wu6XwFvo7kxjQah+RRIGpLzf4wlBOAI4kvL8K5nL4DVRWyNTfVWASgjJZ3+MK+2eobhnPx+EHmeCpaaajYfHT5RCg0KQtv6HTp1y2yiIaX6abT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4ADB5UG5009896;
	Wed, 13 Nov 2024 19:05:30 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4XpL5N3tZhz2L0nH8;
	Wed, 13 Nov 2024 19:04:24 +0800 (CST)
Received: from zeshkernups01.spreadtrum.com (10.29.55.99) by
 shmbx06.spreadtrum.com (10.0.1.11) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 13 Nov 2024 19:05:28 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, Cixi
 Geng <cixi.geng@linux.dev>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <devicetree@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>,
        Zhaochen Su <Zhaochen.Su@unisoc.com>,
        Zhirong Qiu
	<Zhirong.Qiu@unisoc.com>
Subject: [PATCH 2/2] dt-bindings: serial: Add a new compatible string for ums9632
Date: Wed, 13 Nov 2024 19:05:16 +0800
Message-ID: <20241113110516.2166328-3-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113110516.2166328-1-Wenhua.Lin@unisoc.com>
References: <20241113110516.2166328-1-Wenhua.Lin@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 4ADB5UG5009896

The UMS9632 uses the SC9632 serial device.

Signed-off-by: Wenhua Lin <Wenhua.Lin@unisoc.com>
---
 Documentation/devicetree/bindings/serial/sprd-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.yaml b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
index f4dbb6dc2b6e..a2a5056eba04 100644
--- a/Documentation/devicetree/bindings/serial/sprd-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/sprd-uart.yaml
@@ -17,6 +17,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - sprd,sc9632-uart
               - sprd,sc9860-uart
               - sprd,sc9863a-uart
               - sprd,ums512-uart
-- 
2.34.1


