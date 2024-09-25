Return-Path: <linux-kernel+bounces-339273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 590D79861F9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C7B1F28C54
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E17D145A09;
	Wed, 25 Sep 2024 14:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="Tog2cbwO"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4225D18452C;
	Wed, 25 Sep 2024 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276031; cv=none; b=pr5LC7rtemo7MA5z4U9KU8CbeML0AOVpWGoRVYtj9VFYywLRluv8iROJt4i0BbnWoSezTxwgO4spR4L/cWWeTGw1wtvX6VeIqXz0o+hYxk2a67pqrPhFFIMtSb4jsTeKQbGXciUW9v7Ho9ipVWUKXkfCb3WTEYG28LH2ACyAITU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276031; c=relaxed/simple;
	bh=PBbRfvkwiOjSNn1yKbtNDs5vy8pfVkwIAcDmBzBty/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hbnZRh2GxAEoglsVFT07ZMODCjJwl+yq6GwJvs3YH5QuayC1VabPEpGW2CP8MlRrtg8KjsDB6QMxuECw61GlHm1pXWeG32XZUV8mRu1n2zBOT6LB3JFnjO3Kh88NRR2VQRXRZUPL6fX9c6ZDzGYNk085lgHY3mE7d2sMaNImY54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=Tog2cbwO; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id CAFB812001D;
	Wed, 25 Sep 2024 17:53:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CAFB812001D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1727276019;
	bh=G27jlkm39yu3utaJV1Mp2ey0c89I6kdGqjlO1KDSIRc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:From;
	b=Tog2cbwOyx9PYlyI/i8iz8fRcFlvOCgPSs5yPHSxXUEze8M3zqrN3y48nhBzKyTrE
	 OiRu+6QoNOLgDBPB4V83n4RQUqCDtbG7TqTgYmSzV2bdoZBXSBI3gKsNNKaAuj5Bzw
	 x8QBfnyJTYlOwGlF4NONAviSDcpz3+LJggB/M5/5uzzR2QbTIHqZVlHr75nnGxsZEV
	 vS0Z8MFESAE+/SxavWuZAe3lNsZ0c8OK8nV7SkX6B5xbKjRoZlPVrGzMVGoKMPGjNd
	 PHOQqGv5hi9O2BvaxsugwdJ9ndr2oi43sZM93AJWALlpoJN56uLVn/Ydac1m4uL2+J
	 DcEeYgi2vgjlg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 25 Sep 2024 17:53:39 +0300 (MSK)
From: Igor Prusov <ivprusov@salutedevices.com>
Date: Wed, 25 Sep 2024 17:52:39 +0300
Subject: [PATCH v3 1/6] dt-bindings: vendor-prefixes: Add NeoFidelity, Inc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240925-ntp-amps-8918-8835-v3-1-e2459a8191a6@salutedevices.com>
References: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
In-Reply-To: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	"Mark Brown" <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Igor Prusov <ivprusov@salutedevices.com>, Philipp
 Zabel <p.zabel@pengutronix.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, <kernel@salutedevices.com>,
	<prusovigor@gmail.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187980 [Sep 25 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/25 13:22:00 #26670925
X-KSMG-AntiVirus-Status: Clean, skipped

Add vendor prefix for NeoFidelity, Inc

Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a70ce43b3dc032027172b1ed3611b5ff08d16af8..b18f6ee6d6de4848cabeb3cbfa3535dc392436f2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1009,6 +1009,8 @@ patternProperties:
     description: Shanghai Neardi Technology Co., Ltd.
   "^nec,.*":
     description: NEC LCD Technologies, Ltd.
+  "^neofidelity,.*":
+    description: Neofidelity Inc.
   "^neonode,.*":
     description: Neonode Inc.
   "^netgear,.*":

-- 
2.34.1


