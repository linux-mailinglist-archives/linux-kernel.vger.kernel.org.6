Return-Path: <linux-kernel+bounces-409587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906359C8F0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2E4BB32E29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82146150997;
	Thu, 14 Nov 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ONY1OLPI"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255815573F;
	Thu, 14 Nov 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599359; cv=none; b=A9pqkbPCNFtPkLPEGgXbAJphHFj6DC1pwsgw2dWcgZzPa6KI7igvUpVqnjqPVVNrOv5H7QkeyrY5+w8M2Y/rKkbxiwA5kFzkPKIQ9Nz0JzOGpJcN4mnA6dnj4XW0jmfnikXoMpqolagoxpM70F6r/nMT0fLuPd2v0ptOx2PMRIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599359; c=relaxed/simple;
	bh=MMtvKkrxYd5A9OpPxLdSQQGxb7pDXcHZuVkcnKJaXBM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0meK1Xwb2reP+cx74ySV60crZ6LirwpwugACPks+dNLdmwUA58YhK9xZZzumF1sic4ccvMG7PKx/C5xZL7WvVoAcRerYDpfvdiTb7eqlgLUdg2Ic5RwWLD7fzZAfk3oIEqsH9DzaU5O11wWK83et0O/iBS+OmRMPE5WW9lyEqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ONY1OLPI; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id ACC2610000C;
	Thu, 14 Nov 2024 18:49:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru ACC2610000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731599342;
	bh=+AzLdEYWocJzcvwOs9QW6zaf0G7mUCi6/CpG3lyJBi4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ONY1OLPIHNtrXIygBNIWANblBcCwFiQLFl88mNeGWZFyP8PnCF30oTcKrCNUpQSCN
	 b6+CD/UEubCvAo18TLsjKQaFcD9IFA0O15jnLHsfeK6hgQ2UC2cEVAzdJ+HIYIR/4v
	 Ly5LC2TKF74zutTetixZCSGrQqpIePG39uR+o3qS4fnqd1isMDcx4/qBXyRk7GeEav
	 R1ScHkaMk3U130TdFvqWM+DvqRmNE62maAtGV3lQlnA4/JuZvhfg5cnGWsKVeaVS7Z
	 AMSKcXeqHR4kXoaAtVZFfZ2kcoM4c9yVIIwiJc3+03G+ugP4W4jkLq9GF7MnRr7cPV
	 +wotGnb0y5esA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 14 Nov 2024 18:49:02 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Christian Hewitt
	<christianshewitt@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, Jerome Brunet <jbrunet@baylibre.com>, "Kevin
 Hilman" <khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Xianwei Zhao
	<xianwei.zhao@amlogic.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: amlogic: document AC200 support
Date: Thu, 14 Nov 2024 18:48:55 +0300
Message-ID: <20241114154856.3353691-2-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114154856.3353691-1-jan.dakinevich@salutedevices.com>
References: <20241114154856.3353691-1-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189183 [Nov 14 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_smtp_not_equal_from}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;smtp.sberdevices.ru:7.1.1,5.0.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/14 14:31:00 #26861614
X-KSMG-AntiVirus-Status: Clean, skipped

Add compatible string for the Amlogic AC200 board.

Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 0647851ae1f5..ed0071695d29 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -193,6 +193,7 @@ properties:
           - enum:
               - amediatech,x96-air
               - amediatech,x96-air-gbit
+              - amlogic,ac200
               - bananapi,bpi-m2-pro
               - bananapi,bpi-m5
               - cyx,a95xf3-air
-- 
2.34.1


