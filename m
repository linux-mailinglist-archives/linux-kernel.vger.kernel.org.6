Return-Path: <linux-kernel+bounces-553274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1ADA586BA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C6F167342
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3251EF39A;
	Sun,  9 Mar 2025 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="cJZdjf/T"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68505211C;
	Sun,  9 Mar 2025 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543282; cv=none; b=AGo/guHRi2LYTRmEa/iw18MBmozpu73cEPtJvhjvDZIn4fEorzQqmVFdtRK8RYAgndbsnVjYs5+GdIXp3/NUKB3AQrbKdnqOv9KH7p+dvE5J2qppcedXUj8/I17ZFAMBJ6GuOlQdHCZIlI4fBWFHgC9/TkUHpGR7XV4pgE3cVhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543282; c=relaxed/simple;
	bh=QXNO2TFKFCNp/dnChFYm/WWrmTU9bCQ/ukUysCoZQWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f10oE/W9XcfnW12aXjAJzB0nlZ3I+qjy9rTUCC03wLB7eoWbkcBdrxgJ0ORU8P++rVrMLQZIUYXK3NSvFaNJzG0Rys8d2nE2NT6W+6hqNj0Ru/aminPFtLCnCYsOEoATw/p3KHXpSFd5xjE6/0UOiQpSkLHS33buHnsHTXmOQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=cJZdjf/T; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 63FD5100006;
	Sun,  9 Mar 2025 21:01:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 63FD5100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1741543276;
	bh=R889OQZqGkZECGMvlH9uK+1XnElLMmutxFqWQH48G30=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=cJZdjf/Tfda0/fAiPchdTXyM/LCu+kWaDOwozghQfHS9PRXHgR/HI2yCb05Me3RQq
	 ZVoNoZqNXUfY8zdvoxUnR1nYr8pnLjhPWqBBW0uXJBtmRZTT2GcSMivMLCKZ6ojcbN
	 gm2+Xpl9DUGi0sSYaJBYPTJ5lWE+5WBc8TZ36tgy0be+3Z7iCgJ9qZCIZI+HUYWmWe
	 Ql5h8NSUM+Z50PyyingTyljgML7H8y4o+HnXUnHGNUuQ3G+SiQOBNyU4UhRxFuhg6Z
	 CGaWiLcxspFnNZvDEER8KYFHgeOo9IBV29jpWIS/5zH3IO4LGcPy8lebVtzX7OTkZX
	 U1mBQ7tSU0OSA==
Received: from smtp.sberdevices.ru (p-exch-cas-a-m1.sberdevices.ru [172.24.201.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Sun,  9 Mar 2025 21:01:16 +0300 (MSK)
Message-ID: <7dffb0fb-13a0-4c52-8588-647e63761b9e@salutedevices.com>
Date: Sun, 9 Mar 2025 21:01:15 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] Add A1 Soc audio clock controller driver
To: Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>, Jerome
 Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, <linux-amlogic@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-clk@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>, Michael Turquette
	<mturquette@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, Rob
 Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
References: <20250309174322.1321201-1-jan.dakinevich@salutedevices.com>
Content-Language: en-US
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <20250309174322.1321201-1-jan.dakinevich@salutedevices.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
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
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {Tracking_smtp_not_equal_from}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;smtp.sberdevices.ru:7.1.1,5.0.1;lore.kernel.org:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2025/03/09 17:18:00
X-KSMG-LinksScanning: Clean, bases: 2025/03/09 17:18:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2025/03/09 17:28:00 #27692143
X-KSMG-AntiVirus-Status: Clean, skipped

Please, ignore it.

On 3/9/25 20:43, Jan Dakinevich wrote:
> This series adds support for audio clock and reset controllers on A1 SoC family.
> 
> Depends on [7]
> 
> Changes v5 [5] -> v6
>  - use __devm_auxiliary_device_create() helper that is being introduced in [7]
> 
> Changes v4 [4] -> v5
>  - moved changes of aux reset driver to series [6]
>  - added reset controller on top of audio-vad
>  - merged into single file
>  - reworked variables/defines naming
>  - added clk81 clock hierarchy
>  - added TDMIN_VAD-related clocks
>  - excluded DT patch (it will submitted separately)
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
>  - Detached from v1's series (patch 2, 3, 4, 25)
>  - Reuse some of defines from axg-audio
>  - Split the controller into two memory regions
> 
> Links:
>  [1] https://lore.kernel.org/lkml/20240314232201.2102178-1-jan.dakinevich@salutedevices.com/
>  [2] https://lore.kernel.org/lkml/20240328010831.884487-1-jan.dakinevich@salutedevices.com/
>  [3] https://lore.kernel.org/lkml/20240419125812.983409-1-jan.dakinevich@salutedevices.com/
>  [4] https://lore.kernel.org/all/20240913121152.817575-1-jan.dakinevich@salutedevices.com/
>  [5] https://lore.kernel.org/all/20241112230443.1406460-1-jan.dakinevich@salutedevices.com/
>  [6] https://lore.kernel.org/all/20241112230056.1406222-1-jan.dakinevich@salutedevices.com/
>  [7] https://lore.kernel.org/all/20250218-aux-device-create-helper-v4-0-c3d7dfdea2e6@baylibre.com/
> 
> Jan Dakinevich (4):
>   clk: meson: axg: share the set of audio helper macros
>   dt-bindings: clock: axg-audio: document A1 SoC audio clock controller
>     driver
>   clk: meson: a1: add the audio clock controller driver
>   arm64: dts: meson: a1: add the audio clock controller
> 
>  .../clock/amlogic,axg-audio-clkc.yaml         |   4 +
>  arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |  49 +
>  drivers/clk/meson/Kconfig                     |  14 +
>  drivers/clk/meson/Makefile                    |   1 +
>  drivers/clk/meson/a1-audio.c                  | 856 ++++++++++++++++++
>  drivers/clk/meson/axg-audio.c                 | 215 +----
>  drivers/clk/meson/meson-audio.h               | 156 ++++
>  .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 139 +++
>  8 files changed, 1254 insertions(+), 180 deletions(-)
>  create mode 100644 drivers/clk/meson/a1-audio.c
>  create mode 100644 drivers/clk/meson/meson-audio.h
>  create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
> 

-- 
Best regards
Jan Dakinevich

