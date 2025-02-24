Return-Path: <linux-kernel+bounces-528455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1B1A417D9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D91A3B0797
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FED24292C;
	Mon, 24 Feb 2025 08:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PpTe76hO"
Received: from mail-m32102.qiye.163.com (mail-m32102.qiye.163.com [220.197.32.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD0824291B;
	Mon, 24 Feb 2025 08:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387141; cv=none; b=K0s5KW/ykXzXU1yglh1Y5eIcFEFyD67rueOV4IhM52/f0cIK4Q4w64ajhST8dKw/gOInH27w8CAoMbfjQK6t5nQ6YAb077NxcWUsDrN4LHfrQp479rAEJAViNGPbr553y6Hx8nozyOpqtb4Neww/pVklarwHs/0R6PEae6wYldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387141; c=relaxed/simple;
	bh=XUbjs4D7fQffAexiFbZyi3CRHGqUr80ymObuMcPyshU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GNusO4MopIzhJmWue6YAkrgR5+J1Kh/+aCsTWkqXysTazE0uXGyp5hgH+POjxaXv5AoIgPCUzpjsSXFQRq3ogXYhB3eRSa+jvhg4I7acmuFmxaGn4o5LbEU+ZJFFc6kxCx9CqnApQCIjwIV6aBAIsSP0T5EdFxMfvezeXGyf/8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PpTe76hO; arc=none smtp.client-ip=220.197.32.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [192.168.60.65] (unknown [103.29.142.67])
	by smtp.qiye.163.com (Hmail) with ESMTP id bfe919b3;
	Mon, 24 Feb 2025 16:52:13 +0800 (GMT+08:00)
Message-ID: <23c84fd5-83f4-46b3-a247-56e4a2c06d1d@rock-chips.com>
Date: Mon, 24 Feb 2025 16:52:12 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: clock: add rk3562 cru bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Elaine Zhang <zhangqing@rock-chips.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20241224092310.3814460-1-kever.yang@rock-chips.com>
 <krrqtjllx6akrurefbtuhgxw6bwmkiro5rtvdexoevjyufm2uz@r5biw7kbttyr>
Content-Language: en-US
From: Kever Yang <kever.yang@rock-chips.com>
In-Reply-To: <krrqtjllx6akrurefbtuhgxw6bwmkiro5rtvdexoevjyufm2uz@r5biw7kbttyr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaThgeVh9OGktDHh9NSh9LSlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKS0hVSUJVSk9JVU1MWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1
	VLWQY+
X-HM-Tid: 0a95372829e503afkunmbfe919b3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NSo6KQw5NjIUGRMeHQ5CCBEP
	EiMKCgxVSlVKTE9LSENMSkhOTEJJVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlKS0hVSUJVSk9JVU1MWVdZCAFZQUpNT0s3Bg++
DKIM-Signature:a=rsa-sha256;
	b=PpTe76hOHpGk0srvgTU0V496WB4QNRT16SyUTn3RovpGoBOgTamAQyJdyZ9toeKiU54XiNCMokCsB49WToThltFD51fK/JpVz+l7gvApnkmIk9Sa+5mI5YZHT4Ia9oRoVVDjyPoqbW/xiMS5xWNsf9kUucbzusnm/W+YIBC1iDc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=wkj5uNlX0tJSQD/Cdm3vu3AtdbrZyweYKQfMb+Q0YnQ=;
	h=date:mime-version:subject:message-id:from;

Hi Krzysztof,

On 2024/12/27 16:25, Krzysztof Kozlowski wrote:
> On Tue, Dec 24, 2024 at 05:23:08PM +0800, Kever Yang wrote:
>> Document the device tree bindings of the rockchip rk3562 SoC
>> clock and reset unit.
>>
>> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>> ---
> A nit, subject: drop second/last, redundant "bindings". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
>
>
> s/rk3562/Rocchip RK3562/
> or whatever your proper name is (and use proper capitalized parts of
> products)
Will update.
>
>> +properties:
>> +  compatible:
>> +    const: rockchip,rk3562-cru
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  "#reset-cells":
>> +    const: 1
>> +
>> +  clocks:
>> +    maxItems: 2
>
> Why clocks are not required?
The cru is the clock-controller, which is always on module in SoC,
so we don't need to enable "clock" for this clock-controller.

Thanks,
- Kever
>
>> +
>> +  clock-names:
>> +    items:
>> +      - const: xin24m
>> +      - const: xin32k
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#clock-cells"
>> +  - "#reset-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    clock-controller@ff100000 {
>> +      compatible = "rockchip,rk3562-cru";
>> +      reg = <0xff100000 0x40000>;
>> +      #clock-cells = <1>;
>> +      #reset-cells = <1>;
> Why clocks are not here?
>
> Best regards,
> Krzysztof
>
>

