Return-Path: <linux-kernel+bounces-353652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591CC9930D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CAB51C22206
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE291D8DF3;
	Mon,  7 Oct 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="mtxelPCO"
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB1B1D4166;
	Mon,  7 Oct 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313841; cv=none; b=WtAyT2Al4fFkizlye06wMCe96Ldu53wxfhXnxTfs0vUeTX6oPhzRv1seHw1R9zoS7dgDWywNO+mtc8or2DQpM5XUmF5stT8c601YNBnpEGK+Qye/h1bA6jERwQ0OdHOwHU4LR67lrjI+9Cm6RLsX8n/FmMKW3R/uMCoZpzJb4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313841; c=relaxed/simple;
	bh=QODmP8lkkPVyqcqcjsNYQGf3lmTjOZV1uaJ8QJmI5S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=a+GtwlARE7zbhMS4kGeK9DYY0OZkDAcgIFp+M7KXhFar4473jSbDW8AFZthKzQiew/2qvx5+yW00H5nJqPD0h/vASZRSTc9iExJ7OXgLly4NVciCe/Suvy81Lg27RbBBausoHyVAS72culD9MprMGUlIHAf5gEcSzfhAapDMfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=mtxelPCO; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4044A12001B;
	Mon,  7 Oct 2024 18:01:22 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4044A12001B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1728313282;
	bh=tDK2N1D0jqnoD+O3ST573uVP5E5qmpYkCDwEUcRwxAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=mtxelPCOxzDQoEKR8h1OhEZ3fmEu7uKxXDrOB55hrZWVkhqe+AUncNiMorF1A2jh4
	 88KwTu0hgqf3Y9gMweioWko4mPB3hM9uO2yYzFhWdJSWvNfZH6HLEH7BNYMAh0Wh18
	 GFnvS6x1CNtmNTpXlIydhx0p7BC3KvebkfOCSUmUKdEHilp7pci329QnP5mdvco4MR
	 94CGF9dYBpmhyIEhvyw7d4Yn5JPYNCAnEX4q/ggE5X90hpwAcu5zkfVUT/YsbkOh1p
	 cUGdfhXLmuBpfQf4T+SdFq1sVa+u3KNCOQizN1Eqa2aMKTEcaswnQig+2tFtz9BDoZ
	 wmLIRtuZSKWEQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  7 Oct 2024 18:01:22 +0300 (MSK)
Message-ID: <3ec49401-de70-4779-87df-9594d3eb3321@salutedevices.com>
Date: Mon, 7 Oct 2024 17:59:28 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 0/5] Add A1 Soc audio clock controller driver
To: Jerome Brunet <jbrunet@baylibre.com>
References: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
Content-Language: en-US
CC: Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, "Kevin
 Hilman" <khilman@baylibre.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20240913121152.817575-1-jan.dakinevich@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188273 [Oct 07 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: YVDakinevich@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;salutedevices.com:7.1.1;sberdevices.ru:5.0.1,7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;127.0.0.199:7.1.2, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/07 11:09:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/07 11:09:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/07 12:27:00 #26713662
X-KSMG-AntiVirus-Status: Clean, skipped

Hi, Jerome! Could you take a look at this patch series?

On 9/13/24 15:11, Jan Dakinevich wrote:
> This series adds support for audio clock and reset controllers on A1 SoC family.
> 
> Dependency: [4]
> 
> Changes v3 [3] -> v4
>  - Use auxiliary reset device implemented in [4]
>  - Split the driver into files
>  - Use common with axg-audio yaml schema
>  - Unify clock-names with axg-audio
> 
> Changes v2 [2] -> v3
>  - reset:
>    * added auxiliary device
>  - yaml:
>    * added declaration of optional clocks
>    * fixed names in example and another cosmetics
>  - clocks:
>    * reworked naming
>    * stop using of "core" clock name
>    * fixed wrong parenting
> 
> Changes v1 [1] -> v2:
>  - Detached from v1's series (patch 2, 3, 4, 25).
>  - Reuse some of defines from axg-audio;
>  - Split the controller into two memory regions.
> 
> Links:
>  [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/
>  [2] https://lore.kernel.org/lkml/20240328010831.884487-1-jan.dakinevich@salutedevices.com/
>  [3] https://lore.kernel.org/lkml/20240419125812.983409-1-jan.dakinevich@salutedevices.com/
>  [4] https://lore.kernel.org/lkml/9a4377fe27d8eb940399e452b68fb5a6d678929f.camel@pengutronix.de/
> 
> Jan Dakinevich (5):
>   reset: amlogic: add support for A1 SoC in auxiliary reset driver
>   clk: meson: axg: share the set of audio helper macro
>   dt-bindings: clock: axg-audio: document A1 SoC audio clock controller
>     driver
>   clk: meson: a1: add the audio clock controller driver
>   arm64: dts: meson: a1: add the audio clock controller
> 
>  .../clock/amlogic,axg-audio-clkc.yaml         |   3 +
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  48 +++
>  drivers/clk/meson/Kconfig                     |  14 +
>  drivers/clk/meson/Makefile                    |   3 +
>  drivers/clk/meson/a1-audio-clkc.c             | 359 ++++++++++++++++++
>  drivers/clk/meson/a1-audio-drv.c              | 104 +++++
>  drivers/clk/meson/a1-audio-vad-clkc.c         |  85 +++++
>  drivers/clk/meson/a1-audio.h                  | 131 +++++++
>  drivers/clk/meson/axg-audio.c                 | 138 +------
>  drivers/clk/meson/meson-audio.h               | 143 +++++++
>  drivers/reset/amlogic/reset-meson-aux.c       |   9 +
>  .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++++
>  .../reset/amlogic,meson-a1-audio-reset.h      |  29 ++
>  13 files changed, 1051 insertions(+), 137 deletions(-)
>  create mode 100644 drivers/clk/meson/a1-audio-clkc.c
>  create mode 100644 drivers/clk/meson/a1-audio-drv.c
>  create mode 100644 drivers/clk/meson/a1-audio-vad-clkc.c
>  create mode 100644 drivers/clk/meson/a1-audio.h
>  create mode 100644 drivers/clk/meson/meson-audio.h
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
> 

-- 
Best regards
Jan Dakinevich

