Return-Path: <linux-kernel+bounces-339278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF44986202
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CCD1F28AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43CF186295;
	Wed, 25 Sep 2024 14:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="htMXbQXi"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B24183CDC;
	Wed, 25 Sep 2024 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727276033; cv=none; b=GnX3a9lUhg735fLR1Afd4f79WElKB/DreLz5az5JkkMMp5LX/7MaKfteWllc103uBhNypkJACB5Q4hUT980j+ejrNm8k7rHAJZXZt+vbBy0ySBrvJ3arOu3Ay7fQGYRmH+/dp9cn/s1LiCd5wHNtUeW6i+YcPd63zabvrTcwPUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727276033; c=relaxed/simple;
	bh=590hygyiLMYVFkOXyPvAptr2TCCb54A0de4IU1LwJMw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=QCh0D0CVf+F1ycgGN9avMfhl4SjKohGJB+8xyLPDiPoRpdCHsmMRBe8qgZfJnq3WbvFLX7nBwoUAZL8vpwAf62D53mBY4gLzlCCPEe82WuMewl56zRfvUmApVnG5csxylmPLF8QYJSMzsc23ZIqfvSEUCV3t8aKdUnhiEoV0ZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=htMXbQXi; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id A5A0B10004A;
	Wed, 25 Sep 2024 17:53:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru A5A0B10004A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1727276019;
	bh=g1PjG9DV0EBFJRv/c4dhxLqwvunDFGW1tjW9JtSv0VE=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:From;
	b=htMXbQXiNBbu1EcPQ9sLYiEQGdUz0TsfoYhm7Eov3zS0P8+xWl1vZc0ylaqY3skY6
	 0Lb4oP1LK93PyhZBef7lsMgKyz58nkl0w6WXP/+49FFFM1NGBV9EEJzAl3ZF3TAR08
	 DkmmIBjQcdH0rIk1lOz4hwWETPmyozzL4+kCVU5FMM0tV+VFm9tEi+jIpS5W4J3HIw
	 PxfRpHvXw4N7YmN8JCwC0f7BKlXeT8lPE3TUJjTTvI1UpbBgKbsjc76KefV+Irgy62
	 63Da/xkrJQ7fNMYeRxHgoC06Syse3L9J58DPSWNSzp8YwOU3oNnS440DbQauURlYKM
	 HHVgPrEjTRj4g==
Received: from smtp.sberdevices.ru (unknown [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Wed, 25 Sep 2024 17:53:39 +0300 (MSK)
From: Igor Prusov <ivprusov@salutedevices.com>
Subject: [PATCH v3 0/6] ASoC: Add NTP8918 and NTP8835 codecs support
Date: Wed, 25 Sep 2024 17:52:38 +0300
Message-ID: <20240925-ntp-amps-8918-8835-v3-0-e2459a8191a6@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALYj9GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSyMT3bySAt3E3IJiXQtLQwtdCwtjU13DtCRDIzMLA8u0RGMloMaCotS
 0zAqwodGxtbUAnbwY6GQAAAA=
X-Change-ID: 20240924-ntp-amps-8918-8835-1fb126809fa3
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
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;lore.kernel.org:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/25 12:44:00
X-KSMG-LinksScanning: Clean, bases: 2024/09/25 12:44:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/09/25 13:22:00 #26670925
X-KSMG-AntiVirus-Status: Clean, skipped

This series adds support for two NeoFidelity amplifiers. For both
amplifiers vendor provides software for equalizer and filters
configuration, which generates firmware files with registers values.
Since in both cases those files have same encoding, a common helper
module is added to get firmware via request_firmware() API and set
registers values.

Changes in V3:
- Added clocks to bindings and drivers
- removed unused includes
- ntp8835_reset_gpio() now only implements reset sequence and does not
  leave device in reset state
- make data const where possible
- Link to V2: https://lore.kernel.org/lkml/20240709221203.92167-5-ivprusov@salutedevices.com/

Changes in V2:
- Fix dt_binding_check errors
- Link to V1: https://lore.kernel.org/all/20240709172834.9785-1-ivprusov@salutedevices.com/

---
Igor Prusov (6):
      dt-bindings: vendor-prefixes: Add NeoFidelity, Inc
      ASoC: codecs: Add NeoFidelity Firmware helpers
      ASoC: dt-bindings: Add NeoFidelity NTP8918
      ASoC: codecs: Add NeoFidelity NTP8918 codec
      ASoC: dt-bindings: Add NeoFidelity NTP8835
      ASoC: codecs: Add NeoFidelity NTP8835 codec

 .../bindings/sound/neofidelity,ntp8835.yaml        |  73 ++++
 .../bindings/sound/neofidelity,ntp8918.yaml        |  70 +++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 sound/soc/codecs/Kconfig                           |  13 +
 sound/soc/codecs/Makefile                          |   6 +
 sound/soc/codecs/ntp8835.c                         | 480 +++++++++++++++++++++
 sound/soc/codecs/ntp8918.c                         | 397 +++++++++++++++++
 sound/soc/codecs/ntpfw.c                           | 137 ++++++
 sound/soc/codecs/ntpfw.h                           |  23 +
 9 files changed, 1201 insertions(+)
---
base-commit: c7fbbb45ef78ff349d16923b516bc8667367d1a6
change-id: 20240924-ntp-amps-8918-8835-1fb126809fa3

Best regards,
-- 
Igor Prusov <ivprusov@salutedevices.com>


