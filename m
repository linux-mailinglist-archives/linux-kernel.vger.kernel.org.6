Return-Path: <linux-kernel+bounces-518688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9900DA3934C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 07:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61C47170757
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD11B21B4;
	Tue, 18 Feb 2025 06:01:05 +0000 (UTC)
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164828FD;
	Tue, 18 Feb 2025 06:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739858465; cv=none; b=O4lNBBvhnKzTi+BBp0Z+hxFItrT4KAYocgSPNCXOHu0MA94BUhxcnyxqKAgL3uk9j5zLGLSYAJNjC5VkQhOD/jkXY66lrVh19EheZHuf1DCqXFNMRqiauL+q31iaK3DWG5jN1HlN/Zpqh1/KD5Slt7nKCU1UoovvSK1h+tX6jR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739858465; c=relaxed/simple;
	bh=XFQvD+vl23T+PN6KyPSaRN3+98jrxgHY32YNiiwrUKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSx8Z8yeYLYoaHBLbbvc9BuFuszRXMR4NMKFVVEwIQ/N3YCCAfh/qxV2Upd9QzTTuxqNXufc18tju98tJIh9rh/5kY/vICX9wYbOHDJ2uLlOIu378iETem30JA4I9H8m+6G1x1PWvtAjJ76F/6i92nY4y5sTfjGE7GE6i2Xv5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
Received: from [89.212.21.243] (port=44296 helo=[192.168.69.52])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <andrej.picej@norik.com>)
	id 1tkFyU-00FfS4-0X;
	Tue, 18 Feb 2025 06:16:49 +0100
Message-ID: <1804102d-22ed-40f2-ad0c-8949f205461f@norik.com>
Date: Tue, 18 Feb 2025 06:16:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] arm64: dts: imx8mm-phycore-som: Add overlay for
 rproc
To: Shawn Guo <shawnguo2@yeah.net>
Cc: shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@lists.phytec.de
References: <20241202072052.2195283-1-andrej.picej@norik.com>
 <20241202072052.2195283-14-andrej.picej@norik.com> <Z3Ie8GO/GtoSkIr3@dragon>
 <221c8216-ce71-4ba2-9981-8612ff33ec2a@norik.com> <Z7MLXJkmcTuq3ZHn@dragon>
Content-Language: en-US
From: Andrej Picej <andrej.picej@norik.com>
Autocrypt: addr=andrej.picej@norik.com; keydata=
 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
 xtT/8OxBOVSHvA==
In-Reply-To: <Z7MLXJkmcTuq3ZHn@dragon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 



On 17. 02. 25 11:11, Shawn Guo wrote:
> On Tue, Dec 31, 2024 at 08:34:32AM +0100, Andrej Picej wrote:
>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso b/arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso
>>>> new file mode 100644
>>>> index 000000000000..0c61946f0cf8
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso
>>>> @@ -0,0 +1,55 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Copyright (C) 2024 PHYTEC Messtechnik GmbH
>>>> + * Author: Dominik Haller <d.haller@phytec.de>
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +/plugin/;
>>>> +
>>>> +#include <dt-bindings/clock/imx8mm-clock.h>
>>>> +
>>>> +&{/} {
>>>> +	reserved-memory {
>>>> +		#address-cells = <2>;
>>>> +		#size-cells = <2>;
>>>> +		ranges;
>>>
>>> I'm getting this:
>>>
>>> arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso:16.3-10: Warning (ranges_format): /fragment@0/__overlay__/reserved-memory:ranges: empty "ranges" property but its #size-cells (2) differs from /fragment@0/__overlay__ (1)
>>> arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso:13.18-43.4: Warning (avoid_default_addr_size): /fragment@0/__overlay__/reserved-memory: Relying on default #address-cells value
>>> arch/arm64/boot/dts/freescale/imx8mm-phycore-rpmsg.dtso:13.18-43.4: Warning (avoid_default_addr_size): /fragment@0/__overlay__/reserved-memory: Relying on default #size-cells value
>>>
>>
>> I see, missed this before, sorry. But I have some problems fixing it.
>> I think the problem is that this is overlay, the same node put in the
>> imx8mm-phycore-som.dtsi doesn't trigger a warning.
>> The only solution that I found is that I specify the default address-cells
>> and size-cells in root node:
>>
>>
>> &{/} {
>> 	#address-cells = <2>;
>> 	#size-cells = <2>;
>>
>> 	reserved-memory {
>> 		#address-cells = <2>;
>> 		#size-cells = <2>;
>> 		ranges;
>> 	...
>> 	};
>> };
>>
>> The same values are used in imx8mm.dtsi, but the checker fails to find these
>> default values.
>> Not sure if this is the right solution, though. Your input would be helpful,
>> thanks.
> 
> Unless DT folks have better suggestion, I'm fine with this.

Ok, I'll send a v2. Thanks.

Best regards,
Andrej

> 
> Shawn
> 

