Return-Path: <linux-kernel+bounces-246742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7295B92C61A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9C1282144
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 22:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A651B192490;
	Tue,  9 Jul 2024 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="EuXZ4NNN"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7C18D4D6;
	Tue,  9 Jul 2024 22:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720563151; cv=none; b=u0O4nGjJEfJfB2tX+v/ViTjJtzyVpSpey1NYxaxA1QESueKLQzsVa80JFCI72qeFn88DsKbLtjqLErh/p24ufefYHqEuyX5rwj6nsNYd0SdPvOFKVFXGJvQ4G9f13qoFLoCEUAOzI7ROlCNrgGGNKkJa2D8Ct0Y3Df07EvOxi1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720563151; c=relaxed/simple;
	bh=RYs9z4EYOWfXcSCeORsbSLAQJd893NEHRsyHxd8m0ZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ly7e2VB2Bh56/qhYqGqE/6Hm7bB7VTqMGopb/QevJ7hHPGpu9K53G0J0bzYDiMCbUxH/ZouJXwMbriJSkZS1PlQ+CtggYelZsngzMJEaRhhAJLKOyW2HFm8cQJf75GbFeYW/2e4RsTFuggIVxi5aaa2tIj3n+uUPDC/VPYw4NQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=EuXZ4NNN; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 62030120007;
	Wed, 10 Jul 2024 01:12:25 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 62030120007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1720563145;
	bh=YE1nJN+5xpm97FqeKyLuzXsKRg9SQRHYOLWSBnE7/OI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=EuXZ4NNNwVVyXkGrX3KExJxj7uMM/WEgqwwdfUG9EOGMF+YCyxcbIBzl6pRow76tT
	 N5TZN8UbhRRWfXWBCFp/xMqb60Rr/uq+3UwySKhqdYDoB1GyiQVewxQJpUPp4QGvkV
	 NC2A012xwtImyKyqMZzhNWF4tlqMqjOFLxBPMOJ2LhRN+qRZX/6268p+4/PalkFrzi
	 0Vgb4Bks8b0KKT0+yKmFYGIlsQeToKZN/ACIL+WoS2L/aXG874BRqwUmr+aL2jqvJW
	 ASkLwFI5poHuXZIjTLqCeyPmBQwOU2xhh0oUfuzcTccp5wTafw8MyLXKn+aABa/UNC
	 KcObt/tWw23Mg==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 10 Jul 2024 01:12:24 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jul 2024 01:12:24 +0300
From: Igor Prusov <ivprusov@salutedevices.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Philipp Zabel <p.zabel@pengutronix.de>, Igor Prusov
	<ivprusov@salutedevices.com>
CC: <prusovigor@gmail.com>, <kernel@salutedevices.com>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] ASoC: Add NTP8918 and NTP8835 codecs support
Date: Wed, 10 Jul 2024 01:11:57 +0300
Message-ID: <20240709221203.92167-1-ivprusov@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186406 [Jul 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: ivprusov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 24 0.3.24 186c4d603b899ccfd4883d230c53f273b80e467f, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/09 21:28:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/09 21:28:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/09 21:28:00 #25931284
X-KSMG-AntiVirus-Status: Clean, skipped

This series adds support for two NeoFidelity amplifiers. For both
amplifiers vendor provides software for equalizer and filters
configuration, which generates firmware files with registers values.
Since in both cases those files have same encoding, a common helper
module is added to get firmware via request_firmware() API and set
registers values.

V1: https://lore.kernel.org/all/20240709172834.9785-1-ivprusov@salutedevices.com/

V1 -> V2:
 - Fix dt_binding_check errors

Igor Prusov (6):
  dt-bindings: vendor-prefixes: Add NeoFidelity, Inc
  ASoC: codecs: Add NeoFidelity Firmware helpers
  ASoC: dt-bindings: Add bindings for NeoFidelity NTP8918
  ASoC: codecs: Add NeoFidelity NTP8918 codec
  ASoC: dt-bindings: Add bindings for NeoFidelity NTP8835
  ASoC: codecs: Add NeoFidelity NTP8835 codec

 .../bindings/sound/neofidelity,ntp8835.yaml   |  64 +++
 .../bindings/sound/neofidelity,ntp8918.yaml   |  62 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 sound/soc/codecs/Kconfig                      |  13 +
 sound/soc/codecs/Makefile                     |   6 +
 sound/soc/codecs/ntp8835.c                    | 432 ++++++++++++++++++
 sound/soc/codecs/ntp8918.c                    | 356 +++++++++++++++
 sound/soc/codecs/ntpfw.c                      | 137 ++++++
 sound/soc/codecs/ntpfw.h                      |  23 +
 9 files changed, 1095 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/neofidelity,ntp8835.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/neofidelity,ntp8918.yaml
 create mode 100644 sound/soc/codecs/ntp8835.c
 create mode 100644 sound/soc/codecs/ntp8918.c
 create mode 100644 sound/soc/codecs/ntpfw.c
 create mode 100644 sound/soc/codecs/ntpfw.h

-- 
2.34.1


