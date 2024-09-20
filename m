Return-Path: <linux-kernel+bounces-334487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7803F97D7E1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 17:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3794A287331
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59EB17D36A;
	Fri, 20 Sep 2024 15:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="vwIJoaIe"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A9161FCF;
	Fri, 20 Sep 2024 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847458; cv=none; b=EABptPOhI5o0NbW5uNtUUrD/fwacdLl1oUVuo01dso4ZZ8onieCNeJ69OZnk+UxSIXBTdAjo7AtnDuf1GKxQU++pqbd+ZyP3W3ABEbT26nGBsIwXwQ8vGyGAtOTub91Ts6Enqk7bmC9TFU3XMeuotmbu1JJBjd6X/TBrP+Xh2+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847458; c=relaxed/simple;
	bh=bmkuLKPssx4ZG+ZMZ7vGQhCfVwgxg+oPQLdk+5zdSqA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=GwFRYBG/qhegpP0Eoro8NTiRsgaURieljtF5SUGB9AFCLslt5z/wWNQeBHeUpdrIy2XFzEI4Q2fhbaNCVq+0NSDYsz0smk56jC9UeFIWz/skAAN9YpVPS5yvsrBZUl6+vXfxcGDSPjcadwmMQS6hTK74ScxL0RisrAiorT1jXnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=vwIJoaIe; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id AFC6F120009;
	Fri, 20 Sep 2024 18:41:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru AFC6F120009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1726846893;
	bh=kKKoZX10DHxzZppRxtzk+++K95BJQK590YQ7OxuXtd8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:From;
	b=vwIJoaIe1a09gWIuxMwRdpIDT1KPg8HGfB7ZBPXjRc8JMhca4z/LqAs2lSiXCHzbL
	 QfLn2c+fukXOgJhmwAgjj02OY6mhlFnnb9tAg1ULg3yGrY1uUyUMak2ZdUfFDl7+47
	 h+PWFyzV56rmYrknnNq75lrf6E3+iV4wPiie9BMKyrXjimIZnx+pZ/7/vSbQtEzbfB
	 n+/NMpxeRv44+9kqEMdPgoNYvmmoOGMDzqGyJwdcrKrGotcM1ocULmzazZMt7N/jh8
	 e0K2WEsxysklBQ9Dakxl59w6j5lyRurtL+R9L89LWjjhZTuBrMUOdkpuRLtJCYteIi
	 6tEEVJG6BbB7A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri, 20 Sep 2024 18:41:33 +0300 (MSK)
From: Igor Prusov <ivprusov@salutedevices.com>
Subject: [PATCH v2 0/2] Add ES7243E ADC driver
Date: Fri, 20 Sep 2024 18:41:06 +0300
Message-ID: <20240920-es7243e-adc-v2-0-0be019735b81@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJKX7WYC/x3MTQqAIBBA4avErBOGUfq7SrQwHWs2FgoRiHdPW
 n6L9wpkTsIZlq5A4keyXLGB+g7caePBSnwzEJLBmVBxHsloVtY7hazRa2emPQzQijtxkPe/rVu
 tH5tmXsxdAAAA
X-Change-ID: 20240920-es7243e-adc-0e30d3c48bf6
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Igor Prusov <ivprusov@salutedevices.com>
CC: <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <kernel@salutedevices.com>,
	<prusovigor@gmail.com>, David Yang <yangxiaohua@everest-semi.com>, "Martin
 Kurbanov" <mmkurbanov@salutedevices.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187889 [Sep 20 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;github.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/20 12:16:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/20 12:16:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/20 14:03:00 #26646385
X-KSMG-AntiVirus-Status: Clean, skipped

This series adds Everest Semi ES7243E ADC driver and bindings.
Driver is based on David Yang's implementation [1].

[1] https://github.com/BPI-SINOVOIP/BPI-R2PRO-BSP/blob/main/kernel/sound/soc/codecs/es7243e.c

Changes in V2:
- use generic node name in bindings
- remove unused include statements
- add sclk and lrck clocks
- add const where possible
- Link to V1: https://lore.kernel.org/lkml/20240709104117.33431-1-ivprusov@salutedevices.com

---
Igor Prusov (2):
      ASoC: dt-bindings: Add Everest ES7243E
      ASoC: codecs: add ES7243E ADC driver

 .../devicetree/bindings/sound/everest,es7243e.yaml |  56 ++
 sound/soc/codecs/Kconfig                           |   4 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/es7243e.c                         | 693 +++++++++++++++++++++
 4 files changed, 755 insertions(+)
---
base-commit: baeb9a7d8b60b021d907127509c44507539c15e5
change-id: 20240920-es7243e-adc-0e30d3c48bf6

Best regards,
-- 
Igor Prusov <ivprusov@salutedevices.com>


