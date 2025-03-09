Return-Path: <linux-kernel+bounces-553299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2728A5871A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 285303A4434
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6586D202C44;
	Sun,  9 Mar 2025 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="SOfwJ9na"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBD74683;
	Sun,  9 Mar 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741544497; cv=none; b=AzRFIaSlN2IjOlU27AA1ZfBAkXfHEiYaEqymzre8/BSf17+RL/woBSuP0eRtEQj83irh3GpL1esuDjNX3yRUQGbfkVqAwrQIoB9ofocHfIxaWpLZNMykcfgPv3DI2QtZWbo6R0x5brA1O4RaSUNDbXmNGs6We7l9KXC9XBeAPl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741544497; c=relaxed/simple;
	bh=aFw6S2SgwAE2yUAb8enx5lzgnrsuAjKL8A4+fP3JAZ8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z1kw37zDNHAYmt0s0T62eCL9cSnEwrErbNkPNG1xIyURjPjV81q2iYzJK8wb057p8hN3VnRtmLU48SUm5N4dXYj1NSEMX8iB8NdDsvaeIyn/VZqP1hcXOwMTVsEwFbttYncOC3wdkalctyXPnVIXaJnz3tXeMgeTZHuUidlJ5ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=SOfwJ9na; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 339EF120004;
	Sun,  9 Mar 2025 21:21:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 339EF120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741544493;
	bh=UaZ3IToX9EA+ySS8nZsHr/BQXxlEJ2EpDl6spCpL+vU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=SOfwJ9nab/bugC5lDc9TBWTLoiiPW0Gu9YGQKAe7ayiKy5fq39HtptsEpfF/c8Yy9
	 emtZrG3OpVOAtnRe6sVlC5KAaAfo8TufqmRNCxu9je9Tgr265iU9HsC54aRfP4s3G2
	 9R/+m9qY/gnmu2SL1wGDjEoqCs2sUnNR4hg6KErB96hLl7H4VpSv3Wtz/xgIelY8gT
	 0d4X+gRdDdLfXP+IHxyuujghl3F1qk5XKCFQt9GWgS5+1B5666ZDQwdbP0uazRo0h9
	 ZWzZIZYSE4XbB80hKhxhlqvLyUcGbWzx0emzvofYANhkJqs+M3Dji0a7dxfIMUeyfj
	 K5GCwcXkkE9vQ==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:21:33 +0300 (MSK)
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>, Conor Dooley
	<conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome Brunet
	<jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Neil Armstrong
	<neil.armstrong@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, Rob
 Herring <robh@kernel.org>
Subject: [PATCH v2 0/6] Enable audio on Amlogic A1 SoC family
Date: Sun, 9 Mar 2025 21:21:21 +0300
Message-ID: <20250309182127.1322890-1-jan.dakinevich@salutedevices.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
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

This series brings up the audio on Amlogic A1 SoC family and on Amlogic AD402
reference board.

Depends on [2][3][4]

Changes v1 [1] -> v2
 - detached from v1's series (patches 16, 17, 18, 19, 20, 21, 23, 24, 25)
 - use new names from updated clock controller
 - don't use A1-specific compatibe for pure software components
 - don't use link-name property

Links:
 [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/
 [2] https://lore.kernel.org/all/20250309180940.1322531-1-jan.dakinevich@salutedevices.com/
 [3] https://lore.kernel.org/all/20250309181600.1322701-1-jan.dakinevich@salutedevices.com/
 [4] https://lore.kernel.org/all/20250309181630.1322745-1-jan.dakinevich@salutedevices.com/

Jan Dakinevich (6):
  ASoC: dt-bindings: meson: meson-axg-audio-arb: claim support of A1 SoC
    family
  ASoC: dt-bindings: meson: axg-fifo: claim support of A1 SoC family
  ASoC: dt-bindings: meson: axg-pdm: claim support of A1 SoC family
  ASoC: dt-bindings: meson: axg-tdm-formatters: claim support of A1 SoC
    family
  arm64: dts: meson: a1: add audio devices
  arm64: dts: ad402: enable audio

 .../reset/amlogic,meson-axg-audio-arb.yaml    |  10 +-
 .../bindings/sound/amlogic,axg-fifo.yaml      |   8 +
 .../bindings/sound/amlogic,axg-pdm.yaml       |   1 +
 .../sound/amlogic,axg-tdm-formatters.yaml     |  22 +-
 .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 110 +++++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 443 ++++++++++++++++++
 6 files changed, 583 insertions(+), 11 deletions(-)

-- 
2.34.1


