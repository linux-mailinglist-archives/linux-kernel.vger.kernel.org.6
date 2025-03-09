Return-Path: <linux-kernel+bounces-553294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C612A5870C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFF68169BDE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AE720296D;
	Sun,  9 Mar 2025 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="G8MpFoxN"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A89171DDA2F;
	Sun,  9 Mar 2025 18:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544200; cv=none; b=ZHPat23GwUNHLQyNTqCFPrXA7HUzPuKCrzCdAzbeN/NmkjmQVAf4zfQPe8i+zXIquql8cK9zIDN4KoCtIrWIvb5O9aUFzewLSRjPnAmdkov4Nx3v65Wbx9okiwgx35SPeLLrqo8U0q20xavBbMMF1VKqMD8Bmu6041IsADTk3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544200; c=relaxed/simple;
	bh=nUtC4VZXpxgYv3Q05HRBYDc7Mm64AekXQUDZBh8nWL4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ovEWhwM5SZI8IKr08Ts/PzUFNcKoykvN5ja0YXsKkRL9s44zSCROMS6m3ftuqZPxKCx+0iYWWnW7RTfr8VoILC+TEptCEdCPAcWGXrAFJClqpbOwdxnr7qIoxhUubHckUJM85R2i+jsU4Ni2mri0DsftLBOrn7Zto/L4dtrjEUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=G8MpFoxN; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7D410120004;
	Sun,  9 Mar 2025 21:16:36 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7D410120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544196;
	bh=LvnTlhZLgvZ9jdZKRD2KGHnNWbB6ALogZvDb15fdpew=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=G8MpFoxNn2tu2bF9G5jlfv5/E+qaUFFNGkIOrGbVRo51FWCNLY5hyc6emtYprjkFx
	 1Os7qTurvyvhB7lLm4tjWr+fphIXmDjyGIL6coYY9rKiaeJPWzNPB4zN/3XnXnQK/A
	 OAoWm2Ei11xxlDQ5RqNokmUHNdyo0JCUDeG8KOppj5hkhWmj3azZJu7hhpsSn1ZU6S
	 TOpMsZP/26nJJ+Sw+gNGG1kxDloS2XzcZaNaTSidCSdrdroM0/beozQpFP83OAGeob
	 XRw+OCo1A3QYus768Vum+LPX+pP45/YafDHlX8JEoO8Q3yGdARraD8Igbak6qqlmIe
	 2lmpSb0qR2UKg==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:16:36 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman
	<khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-sound@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, Takashi Iwai
	<tiwai@suse.com>
Subject: [PATCH v2 0/3] ASoC: meson: t9015: add support for A1 SoC family
Date: Sun, 9 Mar 2025 21:16:27 +0300
Message-ID: <20250309181630.1322745-1-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-exch-cas-a-m1.sberdevices.ru (172.24.201.216)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 191599 [Mar 09 2025]
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_sender_alignment_int}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/03/09 17:18:00
X-KSMG-LinksScanning: Clean, bases: 2025/03/09 17:18:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

This series adds support for internal audio codec found on A1 SoC family
extending existing t9015 driver.

Changes v1 [1] -> v2
 - detached from v1's series (patches 10, 11, 12)
 - configuration of linein/lineout/micbias is moved to device tree

Links:
 [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/

Jan Dakinevich (3):
  ASoC: meson: t9015: prepare to adding new platforms
  ASoC: dt-bindings: meson: t9015: add support for A1 SoC family
  ASoC: meson: t9015: add support for A1 SoC family

 .../bindings/sound/amlogic,t9015.yaml         |  69 +++-
 sound/soc/meson/t9015.c                       | 379 +++++++++++++++++-
 2 files changed, 423 insertions(+), 25 deletions(-)

-- 
2.34.1


