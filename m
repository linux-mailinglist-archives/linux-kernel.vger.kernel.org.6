Return-Path: <linux-kernel+bounces-379199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA239ADB57
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 07:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 962961F230BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894CD171E49;
	Thu, 24 Oct 2024 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="spTCXkql"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5116A12CD96;
	Thu, 24 Oct 2024 05:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747102; cv=none; b=aDkFbZ8uf6InL26JI9JuL04bmRnYRKR+HTEJ/77aWvctgyrRJ8sogWl/5F57lc4k1ojpPphewIB+DtPZLLhD/6MI4093QhpKRiXfEURIG2Or6zi1tCYu2s852T9XiufrHc7Jy3OH98ardI5k0hVRoIsVTSr+NAIRg5zQ4xNSP2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747102; c=relaxed/simple;
	bh=i55G3JYFny+ZqFRTcmMjsdlyEmFoA+t/qY7SQM5WKUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L1Std9uOIxMfwAsI5xzI9g5oEW6JdKlrsY7J3vhCjoOwvqISmxMhr8z0UCiSJOmkTUlGtkST/hNft8uCSPP/JLXXCPRw/ZzGwe0TVJzGnoCu8LW2lndOq4iO9tDC39xz1q/v/v72eu/OxAFMq2H3Gv/+dafd2dVNnd3vkByCyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=spTCXkql; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 9212812000A;
	Thu, 24 Oct 2024 08:18:15 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 9212812000A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1729747095;
	bh=tOsQKUwocz9twMccWuwSYpSa4JuUcL4zGkvCf3LMXxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=spTCXkqlI1dP+VeYhCbHR1pIAFEf4Q5SvCc734b1eCQTPSFYZ7HJo4K79NmFqXHtG
	 YVr6vwbJfFnALmC4+CRDqeBgns+R5SP9LAB8nZA5vH0n0YS1M77C/hzg18r8seXfg4
	 4Z3C2G+7zwd3IZfOOBLxJimrj/GfLLFwLlg1J6j0ALbVo2T5XxsWPwErgMrxmlbd1b
	 rFztFPop61N37lzZ5INih4rp/GDEFgSMuPJ7+7Kiyji0P+hrI2XNAy5mM4kTfoZexL
	 LE5czbawnkEYJXib7nj2AissDrxuL6aYwjmAM6JcuCQognkk1XXKoCOHJlJgU/FXH6
	 rLWIndptE2nrA==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 24 Oct 2024 08:18:15 +0300 (MSK)
Message-ID: <a1746933-1d8d-487f-af53-cbf4f850f925@salutedevices.com>
Date: Thu, 24 Oct 2024 08:18:14 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/5] Add A1 Soc audio clock controller driver
To: Jerome Brunet <jbrunet@baylibre.com>
CC: Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, "Kevin
 Hilman" <khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
References: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
 <1jplnsjwir.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1jplnsjwir.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m1.sberdevices.ru (172.24.196.116) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188670 [Oct 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 40 0.3.40 cefee68357d12c80cb9cf2bdcf92256b1d238d22, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;sberdevices.ru:7.1.1,5.0.1;smtp.sberdevices.ru:7.1.1,5.0.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/24 04:49:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/24 04:50:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/24 03:43:00 #26794388
X-KSMG-AntiVirus-Status: Clean, skipped



On 10/22/24 12:51, Jerome Brunet wrote:
> On Fri 13 Sep 2024 at 15:11, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> 
>> This series adds support for audio clock and reset controllers on A1 SoC family.
>>
> 
> Split the reset part out of the series (I'd suggest adding VAD reset
> support while at it). Also remove the DT patch, since it will depends on
> both patchset.
> 
> Drop the RFC tag, at v4 I think that phase is over.
> 

Jerome, thank you for review.

>> Dependency: [4]
>>
>> Changes v3 [3] -> v4
>>  - Use auxiliary reset device implemented in [4]
>>  - Split the driver into files
>>  - Use common with axg-audio yaml schema
>>  - Unify clock-names with axg-audio
>>
>> Changes v2 [2] -> v3
>>  - reset:
>>    * added auxiliary device
>>  - yaml:
>>    * added declaration of optional clocks
>>    * fixed names in example and another cosmetics
>>  - clocks:
>>    * reworked naming
>>    * stop using of "core" clock name
>>    * fixed wrong parenting
>>
>> Changes v1 [1] -> v2:
>>  - Detached from v1's series (patch 2, 3, 4, 25).
>>  - Reuse some of defines from axg-audio;
>>  - Split the controller into two memory regions.
>>
>> Links:
>>  [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/
>>  [2] https://lore.kernel.org/lkml/20240328010831.884487-1-jan.dakinevich@salutedevices.com/
>>  [3] https://lore.kernel.org/lkml/20240419125812.983409-1-jan.dakinevich@salutedevices.com/
>>  [4] https://lore.kernel.org/lkml/9a4377fe27d8eb940399e452b68fb5a6d678929f.camel@pengutronix.de/
>>
>> Jan Dakinevich (5):
>>   reset: amlogic: add support for A1 SoC in auxiliary reset driver
>>   clk: meson: axg: share the set of audio helper macro
>>   dt-bindings: clock: axg-audio: document A1 SoC audio clock controller
>>     driver
>>   clk: meson: a1: add the audio clock controller driver
>>   arm64: dts: meson: a1: add the audio clock controller
>>
>>  .../clock/amlogic,axg-audio-clkc.yaml         |   3 +
>>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  48 +++
>>  drivers/clk/meson/Kconfig                     |  14 +
>>  drivers/clk/meson/Makefile                    |   3 +
>>  drivers/clk/meson/a1-audio-clkc.c             | 359 ++++++++++++++++++
>>  drivers/clk/meson/a1-audio-drv.c              | 104 +++++
>>  drivers/clk/meson/a1-audio-vad-clkc.c         |  85 +++++
>>  drivers/clk/meson/a1-audio.h                  | 131 +++++++
>>  drivers/clk/meson/axg-audio.c                 | 138 +------
>>  drivers/clk/meson/meson-audio.h               | 143 +++++++
>>  drivers/reset/amlogic/reset-meson-aux.c       |   9 +
>>  .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++++
>>  .../reset/amlogic,meson-a1-audio-reset.h      |  29 ++
>>  13 files changed, 1051 insertions(+), 137 deletions(-)
>>  create mode 100644 drivers/clk/meson/a1-audio-clkc.c
>>  create mode 100644 drivers/clk/meson/a1-audio-drv.c
>>  create mode 100644 drivers/clk/meson/a1-audio-vad-clkc.c
>>  create mode 100644 drivers/clk/meson/a1-audio.h
>>  create mode 100644 drivers/clk/meson/meson-audio.h
>>  create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>>  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
> 

-- 
Best regards
Jan Dakinevich

