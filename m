Return-Path: <linux-kernel+bounces-528445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B2FA417BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F4416F4E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD8323C8C5;
	Mon, 24 Feb 2025 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="WA3pmr7Q"
Received: from mail-m49236.qiye.163.com (mail-m49236.qiye.163.com [45.254.49.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE58724168A;
	Mon, 24 Feb 2025 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740386873; cv=none; b=XXXadGOu7cCv7YWB5p2XLMBsc/m97rixkldWe3fWG8r8Onxgj0LT/T6BONp/rRHchbGP3yBeSoId9Gexun2nuC9UDP+k60CWHUq60s5coZWXigOzSE/BNPfiggksBwBuEpHdguubtLebF5sd0HWNqliNhNAzJHQ1uWgUnuhXZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740386873; c=relaxed/simple;
	bh=HYPzYTRdGvlsjbHeaX9TM/gXHq6UxnWgvSlWzFt18KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBbQvhTFxuP+nNCiEBXQCa2cWCls0n4PH9jhlBeyFVylVYBuvWzXZEaFApmmSgBpbzP0fFOkqgcFR0yWJ2lBqvAiHzTtEMS5qJOgM7Ji/ZvPDTOxT4PW8+Yt/CgMEM0gxBLsn6rsN80euLjl8xMaM/mR9dGMgZV8UFubcX85GJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=WA3pmr7Q; arc=none smtp.client-ip=45.254.49.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTP id bfe5cb08;
	Mon, 24 Feb 2025 16:47:42 +0800 (GMT+08:00)
Message-ID: <28dcac28-9060-4f65-8167-64f6a0e4532d@rock-chips.com>
Date: Mon, 24 Feb 2025 16:47:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] dt-bindings: clock, reset: rockchip: Add support
 for rk3562
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
 Finley Xiao <finley.xiao@rock-chips.com>, Liang Chen <cl@rock-chips.com>,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241224092310.3814460-1-kever.yang@rock-chips.com>
 <20241224092310.3814460-2-kever.yang@rock-chips.com>
 <z7jb32foci6bamqqddkkp34hazi2itp6uclarsoi5pkrgso2go@bxflagkaciq6>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <z7jb32foci6bamqqddkkp34hazi2itp6uclarsoi5pkrgso2go@bxflagkaciq6>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSk4fVhgaTE1NSRgeSx4fT1YVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1
	VLWQY+
X-HM-Tid: 0a953724079603afkunmbfe5cb08
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mhg6USo6KDITPxMsKzQMHgxR
	Kx1PC09VSlVKTE9LSENNQ01NQ05NVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUlPTEg3Bg++
DKIM-Signature:a=rsa-sha256;
	b=WA3pmr7QT5Hkf9NM5J4r4h5VyGiCXSrAlc66OXg1bmLMCGq8+B/MxJUJuUTBwUobsDxt5vimbfthlLTb8yGUl78OUnFzK+4mK+s/50Qw5ldgbqV+MuwYxHQP3gbV0JmYJr2l6940JfCv8oDALgFpshdtPcSBah52AfMtjoxPQqk=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=dG+gxPUSWpwDoki4eEh/9rwYbhNLk1VbVLvja7f2r94=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

On 2024/12/27 16:28, Krzysztof Kozlowski wrote:
> On Tue, Dec 24, 2024 at 05:23:09PM +0800, Kever Yang wrote:
>> From: Finley Xiao <finley.xiao@rock-chips.com>
>>
>> Add the dt-bindings header for the rk3562, that gets shared between
>> the clock controller and the clock references in the dts.
>> Add softreset ID for rk3562.
>>
>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>> Signed-off-by: Liang Chen <cl@rock-chips.com>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
>>
>> Changes in v2:
>> - rename the file to rockchip,rk3562-cru.h
>> - remove CLK_NR_CLKS
>> - add new file for reset ID
>> - update to use dual license
>>
>>   .../dt-bindings/clock/rockchip,rk3562-cru.h   | 377 ++++++++++++++++++
>>   .../dt-bindings/reset/rockchip,rk3562-cru.h   | 360 +++++++++++++++++
>
> No, that's not a separate patch. Headers *ALWAYS* go with the bindings
> patch.
Will fix.
>>   2 files changed, 737 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/rockchip,rk3562-cru.h
>>   create mode 100644 include/dt-bindings/reset/rockchip,rk3562-cru.h
>>
>> diff --git a/include/dt-bindings/clock/rockchip,rk3562-cru.h b/include/dt-bindings/clock/rockchip,rk3562-cru.h
>> new file mode 100644
>> index 000000000000..ad07ad3a12ad
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/rockchip,rk3562-cru.h
>> @@ -0,0 +1,377 @@
>> +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> Why not using license requested by checkpatch?

The checkpatch does not report error/warning for this license, and this 
is the same as many other SoCs.

Which license is recommend in the header file?

>
>> +/*
>> + * Copyright (c) 2022-2024 Rockchip Electronics Co., Ltd.
>> + * Author: Finley Xiao <finley.xiao@rock-chips.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_ROCKCHIP_RK3562_H
>> +#define _DT_BINDINGS_CLK_ROCKCHIP_RK3562_H
>> +
>> +/* cru-clocks indices */
>> +
>> +/* cru plls */
>> +#define PLL_APLL			1
> Start with 0. Your other binding also starts with 0, so be consistent.
Will fix.
>
>> +#define PLL_GPLL			2
>> +#define PLL_VPLL			3
>> +#define PLL_HPLL			4
>> +#define PLL_CPLL			5
>> +#define PLL_DPLL			6
>> +
>> +/* cru clocks */
> Missing clock for 7. You are not supposed to have any holes here.

Will fix.

Thanks,

- Kever

>> +#define ARMCLK				8
>> +#define CLK_GPU				9
>> +#define ACLK_RKNN			10
> Best regards,
> Krzysztof
>
>

