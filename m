Return-Path: <linux-kernel+bounces-448519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ECB9F4135
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DD016D059
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 03:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BC21494A5;
	Tue, 17 Dec 2024 03:26:15 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9261A1487E9;
	Tue, 17 Dec 2024 03:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734405975; cv=none; b=XGQuFFoY7nDBOm+dy6tRsNWx+QWWjVf3XukhppLsMWfmyBd22hGKRJi9bdtr6A+VoUYVRZv1BueH1XbZ3i7NdodrAc03ym+JqHMbVgkSznskki9356fyU+emliJZ2jnjcTa2AA9bMGXqTgu83OZzlKqtMvS3E9oB6sR8hKWVxJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734405975; c=relaxed/simple;
	bh=sZOvuW1HEcRirxjW0tMfjBhBibKySg+ZlHH/e1Gv2yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pL/JhdO2tKW1zz9lRoJnPDvtArYUho1CE/QscqONUUWjKKqxA0CsNAuVhbA1vLoy0OdPY/3iIdvCi9BS/uqSg3Gx9w+5vWHJyrMQEU1iON4dReqiFK2BCaThWPiu4GBNobFSdLwiUsfCeH/g9RGfRQhfPGmwbLEby8IDXdb46JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from [IPV6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46] (unknown [IPv6:2605:59c8:31de:bf00:37c2:fe62:c21b:ab46])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 745A8B4B2470;
	Tue, 17 Dec 2024 04:26:01 +0100 (CET)
Message-ID: <bd4df536-0a5d-4ba9-ad0c-51a7828acd9c@freeshell.de>
Date: Mon, 16 Dec 2024 19:25:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: starfive: jh7110-common: Use named definition
 for mmc1 card detect
To: Hal Feng <hal.feng@starfivetech.com>, Conor Dooley <conor@kernel.org>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Jisheng Zhang <jszhang@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20241210040652.164030-1-e@freeshell.de>
 <20241216-elixir-cupped-f7a83bce4e12@spud>
 <ZQ2PR01MB1307F1FC7EEB8701525AC9DEE604A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <ZQ2PR01MB1307F1FC7EEB8701525AC9DEE604A@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, Hal

On 12/16/24 18:02, Hal Feng wrote:
>> On 17.12.24 04:13, Conor Dooley wrote:
>> On Mon, 09 Dec 2024 20:06:46 -0800, E Shattow wrote:
>>> Use named definition for mmc1 card detect GPIO instead of numeric literal.
>>>
>>>
>>
>> Applied to riscv-dt-for-next, thanks!
>>
>> [1/1] riscv: dts: starfive: jh7110-common: Use named definition for mmc1
>> card detect
>>        https://git.kernel.org/conor/c/c96f15d79172
> 
> No, here "41" means the GPIO number, but GPI_SYS_SDIO1_CD means the
> multiplexed function and should be used by pinctrl pinmux not gpio subsystem.
> Although GPI-SYS_SDIO1_CD is numerically the same as 41.
> 
> Best regards,
> Hal

You're right, Hal. I'm confused trying to make sense of this.

 From dts/upstream/src/riscv/starfive/jh7110-pinfunc.h:

"gpio nr:  gpio number, 0 - 63"

And yet in dts/upstream/src/riscv/starfive/jh7110-common.dtsi there's:

 >                        pinmux = <PINMUX(64, 0)>,
 >                                 <PINMUX(65, 0)>,
 >                                 <PINMUX(66, 0)>,
 >                                 <PINMUX(67, 0)>,
 >                                 <PINMUX(68, 0)>,
 >                                 <PINMUX(69, 0)>,
 >                                 <PINMUX(70, 0)>,
 >                                 <PINMUX(71, 0)>,
 >                                 <PINMUX(72, 0)>,
 >                                 <PINMUX(73, 0)>;


Loosely on the subject of MMC interface and GPIO numbering, what is the 
above code doing? These are not GPIO numbers 0-63 so what is this?

I'm trying to understand this so I can write the Mars CM (-Lite) dts.

Conor, and Hal: sorry for the mistake there.

-E

