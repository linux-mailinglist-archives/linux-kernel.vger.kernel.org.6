Return-Path: <linux-kernel+bounces-379181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B08D9ADB25
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCF061F225FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5BF170A1A;
	Thu, 24 Oct 2024 04:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="fxzUW5Dg"
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE689474;
	Thu, 24 Oct 2024 04:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729745430; cv=none; b=ftZAFaG0dUyTaPgIeAX3eNMgBCd6y6/jVbFhl5uI4RBbGHGnoMNJdKwQL6V3YHqhXP9BlyeffKCXb7RM7R5X7RrTvQ6/AHuXE1Ki0Dq9kfDbMEFTfkZUIw6TuOhjq4NXnjslPy32Vi4JgO42XE2xwv98vMPzg04lRnsKLLpkuZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729745430; c=relaxed/simple;
	bh=ggYBo9a6Xr2Cd1mbxAypXRlHCtkkPpwPsGeJS74PmUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kto+PJxzaE2eVQzUvCgyg4IR5XjbEFfY7lOBKjqH12PGJPsV3bm9EHB0VuQt9GeYd/qeHfVRd1EV/vMnhDrfTOSDQ+CJ5xLV/Qn5uIIlGRGy1nAosoADQchL2IRdptjnbXk5SClA3BvonMfmu93xXr8SI5ON9pEA4G20uoHBvYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=sberdevices.ru; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=fxzUW5Dg; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sberdevices.ru
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 068E8100014;
	Thu, 24 Oct 2024 07:50:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 068E8100014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1729745410;
	bh=1dVz0n0M53P6FLPKjEVf7rhvbxbXqDGeBKo9CBC6d0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
	b=fxzUW5DgAiPgc7Y5utjRgV7oW76Q+zDwKmZ4DdIebA5qjDC83JhHS1ThmGkMGgre7
	 aUSVFWpXNx7uxfSyvDgrTCKz0hYeCcOAv4BxYXAyXCofZna8brv1kEJJdRoTmgsUK/
	 rspbBsfoZBGTISK6iigX7bQ+bOwl4EyPcCVQ+8lp/HpgEcmkq4dAoGH8KRFNMsC3yo
	 SXJPcPC5Cabwf2LxGHXHxYGZZFvfgFZ8lISqeX7SNhD18s7p9JmaSdoW7w7zngTdfk
	 7w/YkQ34PU9oUo7s1s4IQyvW4AD3ZBp/eTJwaRgZnf5qwlafSXI8lli3LPO41YKWO7
	 4u2QGo0FSvBQA==
Received: from smtp.sberdevices.ru (unknown [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 24 Oct 2024 07:50:09 +0300 (MSK)
Message-ID: <4619649c-efbd-4370-9166-bf44d97f7732@salutedevices.com>
Date: Thu, 24 Oct 2024 07:48:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 3/5] dt-bindings: clock: axg-audio: document A1 SoC
 audio clock controller driver
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
 <20240913121152.817575-4-jan.dakinevich@salutedevices.com>
 <1j7ca0le5f.fsf@starbuckisacylon.baylibre.com>
Content-Language: en-US
From: Jan Dakinevich <jan.dakinevich@salutedevices.com>
In-Reply-To: <1j7ca0le5f.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
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
X-KSMG-AntiSpam-Info: LuaCore: 40 0.3.40 cefee68357d12c80cb9cf2bdcf92256b1d238d22, {Tracking_smtp_not_equal_from}, {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, {Tracking_smtp_domain_mismatch}, {Tracking_smtp_domain_2level_mismatch}, {Tracking_white_helo}, FromAlignment: n
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/24 03:43:00 #26794388
X-KSMG-AntiVirus-Status: Clean, skipped



On 10/22/24 11:45, Jerome Brunet wrote:
> On Fri 13 Sep 2024 at 15:11, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
> 
>> Add device tree bindings for A1 SoC audio clock and reset controllers.
>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> 
> Reset and clock are now independent.
> 
> Please split the patch and send the changes in the related series,
> bindings before the driver change.
> 

I can cut "include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h"
header and send it at the same series with modifications to reset aux
device. Is it correct?

>> ---
>>  .../clock/amlogic,axg-audio-clkc.yaml         |   3 +
>>  .../dt-bindings/clock/amlogic,a1-audio-clkc.h | 122 ++++++++++++++++++
>>  .../reset/amlogic,meson-a1-audio-reset.h      |  29 +++++
>>  3 files changed, 154 insertions(+)
>>  create mode 100644 include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>>  create mode 100644 include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
>> index fd7982dd4cea..df9eb8ce28dc 100644
>> --- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
>> +++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.yaml
>> @@ -18,6 +18,8 @@ description:
>>  properties:
>>    compatible:
>>      enum:
>> +      - amlogic,a1-audio-clkc
>> +      - amlogic,a1-audio-vad-clkc
>>        - amlogic,axg-audio-clkc
>>        - amlogic,g12a-audio-clkc
>>        - amlogic,sm1-audio-clkc
>> @@ -114,6 +116,7 @@ allOf:
>>          compatible:
>>            contains:
>>              enum:
>> +              - amlogic,a1-audio-clkc
>>                - amlogic,g12a-audio-clkc
>>                - amlogic,sm1-audio-clkc
>>      then:
>> diff --git a/include/dt-bindings/clock/amlogic,a1-audio-clkc.h b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>> new file mode 100644
>> index 000000000000..6534d1878816
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/amlogic,a1-audio-clkc.h
>> @@ -0,0 +1,122 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +/*
>> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
>> + *
>> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> + */
>> +
>> +#ifndef __A1_AUDIO_CLKC_BINDINGS_H
>> +#define __A1_AUDIO_CLKC_BINDINGS_H
>> +
>> +#define AUD_CLKID_DDR_ARB		1
>> +#define AUD_CLKID_TDMIN_A		2
>> +#define AUD_CLKID_TDMIN_B		3
>> +#define AUD_CLKID_TDMIN_LB		4
>> +#define AUD_CLKID_LOOPBACK		5
>> +#define AUD_CLKID_TDMOUT_A		6
>> +#define AUD_CLKID_TDMOUT_B		7
>> +#define AUD_CLKID_FRDDR_A		8
>> +#define AUD_CLKID_FRDDR_B		9
>> +#define AUD_CLKID_TODDR_A		10
>> +#define AUD_CLKID_TODDR_B		11
>> +#define AUD_CLKID_SPDIFIN		12
>> +#define AUD_CLKID_RESAMPLE		13
>> +#define AUD_CLKID_EQDRC			14
>> +#define AUD_CLKID_LOCKER		15
>> +#define AUD_CLKID_MST_A_MCLK_SEL	16
>> +#define AUD_CLKID_MST_A_MCLK_DIV	17
>> +#define AUD_CLKID_MST_A_MCLK		18
>> +#define AUD_CLKID_MST_B_MCLK_SEL	19
>> +#define AUD_CLKID_MST_B_MCLK_DIV	20
>> +#define AUD_CLKID_MST_B_MCLK		21
>> +#define AUD_CLKID_MST_C_MCLK_SEL	22
>> +#define AUD_CLKID_MST_C_MCLK_DIV	23
>> +#define AUD_CLKID_MST_C_MCLK		24
>> +#define AUD_CLKID_MST_D_MCLK_SEL	25
>> +#define AUD_CLKID_MST_D_MCLK_DIV	26
>> +#define AUD_CLKID_MST_D_MCLK		27
>> +#define AUD_CLKID_SPDIFIN_CLK_SEL	28
>> +#define AUD_CLKID_SPDIFIN_CLK_DIV	29
>> +#define AUD_CLKID_SPDIFIN_CLK		30
>> +#define AUD_CLKID_RESAMPLE_CLK_SEL	31
>> +#define AUD_CLKID_RESAMPLE_CLK_DIV	32
>> +#define AUD_CLKID_RESAMPLE_CLK		33
>> +#define AUD_CLKID_LOCKER_IN_CLK_SEL	34
>> +#define AUD_CLKID_LOCKER_IN_CLK_DIV	35
>> +#define AUD_CLKID_LOCKER_IN_CLK		36
>> +#define AUD_CLKID_LOCKER_OUT_CLK_SEL	37
>> +#define AUD_CLKID_LOCKER_OUT_CLK_DIV	38
>> +#define AUD_CLKID_LOCKER_OUT_CLK	39
>> +#define AUD_CLKID_EQDRC_CLK_SEL		40
>> +#define AUD_CLKID_EQDRC_CLK_DIV		41
>> +#define AUD_CLKID_EQDRC_CLK		42
>> +#define AUD_CLKID_MST_A_SCLK_PRE_EN	43
>> +#define AUD_CLKID_MST_A_SCLK_DIV	44
>> +#define AUD_CLKID_MST_A_SCLK_POST_EN	45
>> +#define AUD_CLKID_MST_A_SCLK		46
>> +#define AUD_CLKID_MST_B_SCLK_PRE_EN	47
>> +#define AUD_CLKID_MST_B_SCLK_DIV	48
>> +#define AUD_CLKID_MST_B_SCLK_POST_EN	49
>> +#define AUD_CLKID_MST_B_SCLK		50
>> +#define AUD_CLKID_MST_C_SCLK_PRE_EN	51
>> +#define AUD_CLKID_MST_C_SCLK_DIV	52
>> +#define AUD_CLKID_MST_C_SCLK_POST_EN	53
>> +#define AUD_CLKID_MST_C_SCLK		54
>> +#define AUD_CLKID_MST_D_SCLK_PRE_EN	55
>> +#define AUD_CLKID_MST_D_SCLK_DIV	56
>> +#define AUD_CLKID_MST_D_SCLK_POST_EN	57
>> +#define AUD_CLKID_MST_D_SCLK		58
>> +#define AUD_CLKID_MST_A_LRCLK_DIV	59
>> +#define AUD_CLKID_MST_A_LRCLK		60
>> +#define AUD_CLKID_MST_B_LRCLK_DIV	61
>> +#define AUD_CLKID_MST_B_LRCLK		62
>> +#define AUD_CLKID_MST_C_LRCLK_DIV	63
>> +#define AUD_CLKID_MST_C_LRCLK		64
>> +#define AUD_CLKID_MST_D_LRCLK_DIV	65
>> +#define AUD_CLKID_MST_D_LRCLK		66
>> +#define AUD_CLKID_TDMIN_A_SCLK_SEL	67
>> +#define AUD_CLKID_TDMIN_A_SCLK_PRE_EN	68
>> +#define AUD_CLKID_TDMIN_A_SCLK_POST_EN	69
>> +#define AUD_CLKID_TDMIN_A_SCLK		70
>> +#define AUD_CLKID_TDMIN_A_LRCLK		71
>> +#define AUD_CLKID_TDMIN_B_SCLK_SEL	72
>> +#define AUD_CLKID_TDMIN_B_SCLK_PRE_EN	73
>> +#define AUD_CLKID_TDMIN_B_SCLK_POST_EN	74
>> +#define AUD_CLKID_TDMIN_B_SCLK		75
>> +#define AUD_CLKID_TDMIN_B_LRCLK		76
>> +#define AUD_CLKID_TDMIN_LB_SCLK_SEL	77
>> +#define AUD_CLKID_TDMIN_LB_SCLK_PRE_EN	78
>> +#define AUD_CLKID_TDMIN_LB_SCLK_POST_EN	79
>> +#define AUD_CLKID_TDMIN_LB_SCLK		80
>> +#define AUD_CLKID_TDMIN_LB_LRCLK	81
>> +#define AUD_CLKID_TDMOUT_A_SCLK_SEL	82
>> +#define AUD_CLKID_TDMOUT_A_SCLK_PRE_EN	83
>> +#define AUD_CLKID_TDMOUT_A_SCLK_POST_EN	84
>> +#define AUD_CLKID_TDMOUT_A_SCLK		85
>> +#define AUD_CLKID_TDMOUT_A_LRCLK	86
>> +#define AUD_CLKID_TDMOUT_B_SCLK_SEL	87
>> +#define AUD_CLKID_TDMOUT_B_SCLK_PRE_EN	88
>> +#define AUD_CLKID_TDMOUT_B_SCLK_POST_EN	89
>> +#define AUD_CLKID_TDMOUT_B_SCLK		90
>> +#define AUD_CLKID_TDMOUT_B_LRCLK	91
>> +
>> +#define AUD_CLKID_VAD_DDR_ARB		1
>> +#define AUD_CLKID_VAD_PDM		2
>> +#define AUD_CLKID_VAD_TDMIN		3
>> +#define AUD_CLKID_VAD_TODDR		4
>> +#define AUD_CLKID_VAD			5
>> +#define AUD_CLKID_VAD_AUDIOTOP		6
>> +#define AUD_CLKID_VAD_MCLK_SEL		7
>> +#define AUD_CLKID_VAD_MCLK_DIV		8
>> +#define AUD_CLKID_VAD_MCLK		9
>> +#define AUD_CLKID_VAD_CLK_SEL		10
>> +#define AUD_CLKID_VAD_CLK_DIV		11
>> +#define AUD_CLKID_VAD_CLK		12
>> +#define AUD_CLKID_VAD_PDM_DCLK_SEL	13
>> +#define AUD_CLKID_VAD_PDM_DCLK_DIV	14
>> +#define AUD_CLKID_VAD_PDM_DCLK		15
>> +#define AUD_CLKID_VAD_PDM_SYSCLK_SEL	16
>> +#define AUD_CLKID_VAD_PDM_SYSCLK_DIV	17
>> +#define AUD_CLKID_VAD_PDM_SYSCLK	18
>> +
>> +#endif /* __A1_AUDIO_CLKC_BINDINGS_H */
>> diff --git a/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h b/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
>> new file mode 100644
>> index 000000000000..653fddba1d8f
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/amlogic,meson-a1-audio-reset.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>> +/*
>> + * Copyright (c) 2024, SaluteDevices. All Rights Reserved.
>> + *
>> + * Author: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H
>> +#define _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H
>> +
>> +#define AUD_RESET_DDRARB	0
>> +#define AUD_RESET_TDMIN_A	1
>> +#define AUD_RESET_TDMIN_B	2
>> +#define AUD_RESET_TDMIN_LB	3
>> +#define AUD_RESET_LOOPBACK	4
>> +#define AUD_RESET_TDMOUT_A	5
>> +#define AUD_RESET_TDMOUT_B	6
>> +#define AUD_RESET_FRDDR_A	7
>> +#define AUD_RESET_FRDDR_B	8
>> +#define AUD_RESET_TODDR_A	9
>> +#define AUD_RESET_TODDR_B	10
>> +#define AUD_RESET_SPDIFIN	11
>> +#define AUD_RESET_RESAMPLE	12
>> +#define AUD_RESET_EQDRC		13
>> +#define AUD_RESET_LOCKER	14
>> +#define AUD_RESET_TOACODEC	30
>> +#define AUD_RESET_CLKTREE	31
>> +
>> +#endif /* _DT_BINDINGS_AMLOGIC_MESON_A1_AUDIO_RESET_H */
> 

-- 
Best regards
Jan Dakinevich

