Return-Path: <linux-kernel+bounces-170935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5218BDE07
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 235E3285261
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F2014D716;
	Tue,  7 May 2024 09:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asus.com header.i=@asus.com header.b="WqDQWi3u"
Received: from ms.asus.com (ms.asus.com [103.10.4.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BAC14D6F7;
	Tue,  7 May 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.10.4.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715073754; cv=none; b=ttp2zRCHqz7SxYV951TPOYN/njTI+Elg/QIFxynLVXj5GCcQV/cs1JZv20lJpCqUsL/CSEJIR9JGd2bPS4PpxArTSr7F+vcEEasiFrlH/hSMOJpzIm45B+V03I3IyxICnQVfw0WFmDc2+s/XXxACG1/uSg3rioY2QL2LW0G0tf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715073754; c=relaxed/simple;
	bh=soaSKLNiK8yLuSfHu376E6xKacUX7+Q6AvxodFOhgpU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CljoUPEBIVqZR8Dv2qTKfKc93YA9/6ZrjYJCxU71T/Jkq5McBOtoK8i8N+RN1bSCky9AhhhpzY/ZRc/HKgx0OyJ/x9LNcBMe1YLiFRE14IMKah41+L8rUGohOtKGd01wa64/CjQhlXe/wgVcR/SThW1rEUsWizvjnNQHmjxnVg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asus.com; spf=pass smtp.mailfrom=asus.com; dkim=pass (1024-bit key) header.d=asus.com header.i=@asus.com header.b=WqDQWi3u; arc=none smtp.client-ip=103.10.4.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asus.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
  t=1715073752; x=1746609752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=soaSKLNiK8yLuSfHu376E6xKacUX7+Q6AvxodFOhgpU=;
  b=WqDQWi3umHzDGpnbfBfKg5EzpaSfutVzWJUG8XSTyYQA5aMiVbJJP37D
   S7XM2sXT8gm0E5XYR+NZMx8DxrUPtAgG5e5TfLEsPCrsWyoHtmGY1okOs
   jmejrcr7Wrpw0ppESdyftU3OIgzEk0mp0mfSn35uG5/Cj1+4uKLy2AGpL
   o=;
X-IPAS-Result: =?us-ascii?q?A2E3AwBZ8Tlm/xEvFqxagliFIR2WIp4NFIFqDwEBAQEBA?=
 =?us-ascii?q?QEBAQgBRAQBAYUGAogxJzYHDgECBAEBAQEDAgMBAQEBAQEIAQEBBQEBAQEBA?=
 =?us-ascii?q?QYEAQEBAoEZhS9SgmcBg3gGJ1IQOBlWBg4FgwCCZbUGM4EB3jGBawkBgT6IL?=
 =?us-ascii?q?gGEWIRpe4ILRCZvg2iDfBIBEgEJVw6FdwSGDogjO2SBeCdBgVGBDoEdg2mCT?=
 =?us-ascii?q?H+BBVkPiEpKgQccA1kyAVUTDQoLPgkWAhYDGxQEMA8JCyYDKgY2AhIMBgYGW?=
 =?us-ascii?q?SAWCQQjAwgEA0QDIHERAwQaBAsHdYMxBBNEA4E4iXqDPSmBd4QgS4R2gXgOY?=
 =?us-ascii?q?ocjAwcFLB1AAwsYDUgRLDUUGwYiH24HoywTaUAQEAMrFF4SK2URBBePaIM0g?=
 =?us-ascii?q?z+OVKBuhB2BYQyII5ccGjOEBYx+hkGScJhiglSgaYUgAgQCBAUCF4FsA4Ecc?=
 =?us-ascii?q?DMaI4EKDlaBSVIXAg+wRms7AgcLAQEDCYhuBS8sATtgAQE?=
IronPort-PHdr: A9a23:npBHeBbfHzNKTEXPdumGcz3/LTH+14qcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1g6PB9+LoKsew8Pt8IneGkU4oqy9+EgYd5JNUxJXwe43pCcHRPC/NEvgMfTxZDY7F
 skRHHVs/nW8LFQHUJ2mPw6arXK99yMdFQviPgRpOOv1BpTSj8Oq3Oyu5pHfeQpFiCS5bL9oM
 hm6swbcusYLjYd8N6081gbHrnxUdutZwm9lOUidkxHg6Mmu4ZVt6T5Qu/Uv985BVaX1YaE1R
 qFGATolLm44+tTluQHMQgWT6HQcVH4WkgdTDAje8B76RJbxvTDkued7xSKXINf5TbEwWTSl8
 qdrVBrlgzoJOjIl7G3ajNF7gblFqxy9uRNw34/UYJmUNPVgeKPdYcgaTndFUspISiBNHp+wY
 44JAuEcP+hXspP9qkMOoxWgGwSiGe3hxDxPiHD006013OsvHh3H3AE7A9IOqW7ZoMnvOasOT
 ey4yrTDwzXZb/NR3Dfw8I3GfQ4lofGIXbN7bMjfyVQpFwPKk16dronrMC2R1uQJs2mV7fdgV
 eSgi2M8sQ5xuSWvxtw2hobVgYIVz0nJ+CNky4k6OdO2UlR0YcK4EJROrSGaMZN7T8M+T2xou
 Cg0xKMLtYCncCUExpor2RDRZviJfYWW7R/tVOScLDl6iX97eb+yhhe//Eu9x+HgSsW4zEtHo
 zZHn9TKq3sD1ATT59CaRvZ/4EutwyiD2x7J5uxLI004j7fXJpw5zrMxi5Yfq1rPEjL3lUnsj
 aKbdl8o9vWr5unlZLjtu4GRN4tpigHlLqQhhNa/D/k5MgkPQWeW4fiw2bv+9kPjWrpKlOc5k
 qzBvZDfIsQUu7C2DhdO0oYm9xa/FzCm0MkEnXUfLFJKZhaHj4/xNl/QOv70FPCxjVq1nDhk2
 /zKI6ftDYnKLnjZiLfhe6hy61JGxAUp1tBf+olUBqkAIPL1REDxqMTVAgI7PgCq2errFstx2
 pkRVG+NGKOVLaHfvUeN5u01IumMYIEVuCz6K/gg//PgiGE2mVsZfaip35UXdXa4Hvt9LkqDe
 nrsn8wBHX0WsQo5SezmkFuCXiVLaHaoQ608/i07CJ6hDYrbW4yhnaSN3D2nEZ1OemBGFleMH
 G/yd4WDQPgMaCWeLdJ9kjEfVriuVZUh1Rewuw/+0bZnKfDU+iIAuZL5yNd1//HTlQ019TFsD
 MSdyWCMTmFvnmIJWz82265/rVZ+yleE0Kl4h/tYFNJI5/NKUwc2MoPTz/BhBtD2WwLBeM2GS
 EyhQtm8BjExVN0xz8cUY0lhA9WikgzD3y2yDrAJkLyLAps08rjb03fsO8Zw0HXG27c7j1kgX
 MRPMXeqhqll9wjcH4LJiVmWl762daQA2y7A7GWDzW2Qs0FcSwNwU6DFXWsFakvXsNv1/FnNT
 6K2BbQ9LgRB0dKCKrdNatDxl1pGQursOM7AbGO/gGq/GRGIya6SY4X2fGUd2j7dCFQekwAO4
 XmGKRIyCTumo2LbFjBhD0/vMAvQ9rwqsnSxTgw40ymJYldn2r7z/QQa06+yUfQWi5EJvCMw4
 xVpGln1i/HbD96Rhxdnc41Ves4mplxA0DSK5ERGIpW8IvU61RYleANtsharjk0vYrg=
IronPort-Data: A9a23:05G+AqgEbCo3AJ/Xz2agzZ9ZX1613REKZh0ujC45NGQN5FlHY01je
 htvCD2FOP+KZzD1ctAiaN7j9h8B68WHy9Y1GgNl+S1jRngW8JqUDtmwEBz9bniYRiHhZBs8t
 p1BMLEsDyyWolv0/ErF3m3J8CEUOZmgH+a6UqifUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ5hYtWo4qw/PbwP9QlKmq0N8olgRWTexGulbYi04UAPo3TU1mByCgKmX8NrfSq
 9frlNlVzEuAl/seIorNfoLAT6E/auW60T5iKpZhc/PKbhBq/kTe20ugXRYWQR8/Zz6hx7idx
 DjR3HAZpMhA0qDkwYwgvxdk/y5WOK1tqa3WOSGFmu+t1BDkLSq9z9BMExRjVWEY0r4f7WBmy
 cRdDRxIUEjawemx2qq9R/Uqj98+N6EHPqtG5Ssml2ufUalgGM+rr6bivLe02B8Ti8RKDNbDY
 cUxYCFyd1LLZBgn1lI/UsluwLrw3yikG9FegF6KnLVp+WPU9lBWj7LLFuiNX/+AGPwAyy50o
 UqDpQwVGCoyLtuVyXmJ7lqvi/XJkCe9X5gdfJW77Ox7m0+PwWJVCxoEUVykuvq4yUKic9ZeL
 UUO/Wwpt6da3EesSN7nHBGkiH2JpBgRX5xXCeJSwAOKx6784QOCQGkICDdcAPQvssMsSCMC3
 ViFktjuAydzqqCeVTSW8bLSpC7aESQYM24JaDMeQAYt/dbuuscwgwjJQ9IlF7S65vXxGDft0
 3WDti17hLgJi8MP/6G65kzcxTOqqILAQgM86kPQRG3Nxgd4YpO1IoWz8VXW4d5ELZ2FVR+Gr
 nwNkdPY6/oBZbmJlSqQUKAOEauv6vKtLjLRmxhsEoMn+jDr/GSsFahX+Dx4LkJiGsIFYiPyJ
 kjBvQpb/9lUJnTCRaRwZYWrTcgtyqztBPzgV/vOadFOY4A3fwiClByCfmaMxyXonA0yyfh5M
 pCBacChETATErl8pNare9ogPXYQ7nhW7QvuqVrTk3xLDZL2iKapdIo4
IronPort-HdrOrdr: A9a23:r+KDCaBDLH/7eJLlHemE55DYdb4zR+YMi2TC1yhKJSC9Ffbo8/
 xG/c5rsiMc5wx+ZJhNo7q90ey7MBDhHP1OkOws1NWZPTUO0VHAROpfBMnZsl/d8kXFh4hgPM
 xbHJSWZuecMbAs5vyKmDVQa+xB/DDRytHQuQ+bpE0dNj1XVw==
X-Talos-CUID: 9a23:5+VjGG9Ggw1BDcmnr2mVv0sUMZE3Y2WE9lzzHVTlKzg4GbGwa0DFrQ==
X-Talos-MUID: 9a23:2kKaogmXs1epWMYGH8tEdnpuK/53vb6lD3pRtsoMne+2bQlTMWqk2WE=
X-IronPort-Anti-Spam-Filtered: true
Received: from tp-md-v01.corpnet.asus ([172.22.47.17])
  by ms.asus.com with ESMTP; 07 May 2024 17:21:21 +0800
Received: from localhost.localdomain (61.216.65.187) by TP-MD-V01.corpnet.asus
 (172.22.47.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.37; Tue, 7 May
 2024 17:21:19 +0800
From: Kelly Hung <KellyHung@asus.com>
To: <robh+dt@kernel.org>
CC: <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<joel@jms.id.au>, <andrew@codeconstruct.com.au>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<openbmc@lists.ozlabs.org>, <kelly_hung@asus.com>, <Allenyy_Hsu@asus.com>,
	Kelly Hung <KellyHung@asus.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v8 1/2] dt-bindings: arm: aspeed: add ASUS X4TF board
Date: Tue, 7 May 2024 17:21:08 +0800
Message-ID: <20240507092109.6018-2-KellyHung@asus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240507092109.6018-1-KellyHung@asus.com>
References: <20240507092109.6018-1-KellyHung@asus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: APZA002EXB.corpnet.asus (172.22.6.14) To
 TP-MD-V01.corpnet.asus (172.22.47.17)
X-TM-SNTS-SMTP:
	7B5E8808B64D3409BE36DE63A1FC0495CD91438CB54365635DC9BAA38B2E39902000:8

Document the new compatibles used on ASUS X4TF.

Signed-off-by: Kelly Hung <KellyHung@asus.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
v7 -> v8:
- Modify Signed-off-by field with new ASUS smtp account.
- Add back Acked-by tag.
v6 -> v7:
- Remove incorrect tags.
- Modify Signed-off-by field.
v5 -> v6:
- Add Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
- Add Reviewed-by: Rob Herring <robh@kernel.org>
- Add Reviewed-by: Zev Weiss <zweiss@equinix.com>
- Add Acked-by: Conor Dooley <conor.dooley@microchip.com>
V4 -> V5: Update all changelog from v1 to v5.
V3 -> V4: The new compatible is a BMC for a ASUS X4TF server which use
a ast2600-a3 chip, so correct string to asus,x4tf-bmc.
V2 -> V3: Add a label to indicate it is new compatible for bmc.
V1 -> V2: Remove blank in front of the string x4tf.
---
 Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/Doc=
umentation/devicetree/bindings/arm/aspeed/aspeed.yaml
index 749ee54a3..0047eb4ab 100644
--- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
+++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
@@ -74,6 +74,7 @@ properties:
               - ampere,mtmitchell-bmc
               - aspeed,ast2600-evb
               - aspeed,ast2600-evb-a1
+              - asus,x4tf-bmc
               - facebook,bletchley-bmc
               - facebook,cloudripper-bmc
               - facebook,elbert-bmc
--
2.25.1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
This email and any attachments to it contain confidential information and a=
re intended solely for the use of the individual to whom it is addressed. I=
f you are not the intended recipient or receive it accidentally, please imm=
ediately notify the sender by e-mail and delete the message and any attachm=
ents from your computer system, and destroy all hard copies. Please be advi=
sed that any unauthorized disclosure, copying, distribution or any action t=
aken or omitted in reliance on this, is illegal and prohibited. Any views o=
r opinions expressed are solely those of the author and do not represent th=
ose of ASUSTeK.

For pricing information, ASUS is only entitled to set a recommendation resa=
le price. All customers are free to set their own price as they wish.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

