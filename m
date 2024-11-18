Return-Path: <linux-kernel+bounces-412892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BF39D10C0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A87DB25A07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 12:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331C19E998;
	Mon, 18 Nov 2024 12:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/TinJ3O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597719AD90;
	Mon, 18 Nov 2024 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731933636; cv=none; b=ufm6nSsvCvUMF6kb7CKc1HPlZLEjEHwSpYbVwYoAB3ihGsCARu+x+g/Fn0qRQoKlzFMcx7brU9Guwwenb7pCRWYEIfTQ1eEnudCFcAwLuw0Dl5UBvLdO74Qop3UU61LSeDdOErzljltVkAMiKYl9GUocSEvLIwPBQctyfOHoRGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731933636; c=relaxed/simple;
	bh=6hnk+UavMbVpLRMCmpKV6jDM2g44tWyAvdtguE2AvBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cy2RD6q3TaDOiteGMtMct1YgkwLK9U+AT4BNIrd9FxxEb4I20yrhh0ljc/T9oG7VyFQkFmgQGaIRu9ajf85Zn4q9voDk3WsLj6OJOPlYnRILbXBu1wySSHdQ/inkaGXxXlJGxRGlMm0SVWT+fdZF+eQhx0VQCcI7Z6/w07o7NlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/TinJ3O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C453DC4CECC;
	Mon, 18 Nov 2024 12:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731933635;
	bh=6hnk+UavMbVpLRMCmpKV6jDM2g44tWyAvdtguE2AvBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=O/TinJ3OUWJrfC/ZTqXSelM38Y+EqedZ2cfgM+PJMQyUCUE2Svea1KxwCGFxatikU
	 5SYCidWhyEDryDFGSEBq5q9wATVqOyz50Nuo0HgktmIl8AO3GxcBR2liQw+Lz/uVbA
	 oEQkJXtZMnfD2RO/NbJotqTYpuYu3XZ69dA0NPRWW4i7YEosIRWLvPdycullcd2ZQk
	 Hni0MXeC+5mjgVE0qzkJcaE5lWsldiNE6hzQg0IBz5ore4IQ09ZzIf7uvMZkGdtW+x
	 TFtFkAQ++J9NZiPWEkD8u4vGAJ5380uJZ4MDWH2zwM3xAFpoL5Du/msQ6AJv8N1ahE
	 J4JO0lnoSQyHg==
Message-ID: <8c2f77e1-6552-47ad-a966-b137ce99852b@kernel.org>
Date: Mon, 18 Nov 2024 14:40:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: omap-usb-tll: convert to YAML
To: Andreas Kemnade <andreas@kemnade.info>,
 Karol Przybylski <karprzy7@gmail.com>
Cc: lee@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org
References: <20241114185830.10025-1-karprzy7@gmail.com>
 <20241115210543.7cfcd7ba@akair>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241115210543.7cfcd7ba@akair>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/11/2024 22:05, Andreas Kemnade wrote:
> Am Thu, 14 Nov 2024 19:58:30 +0100
> schrieb Karol Przybylski <karprzy7@gmail.com>:
> 
>> Conversion of omap-usb-tll.txt into yaml format, inspired by discussion in [1]
>>
>> All feedback greatly appreciated, especially about what to put in 'maintainer'
>>
>> 1 - https://lore.kernel.org/all/cd915c18-7230-4c38-a860-d2a777223147@kernel.org/
>>
>> Signed-off-by: Karol Przybylski <karprzy7@gmail.com>
>> ---
>>  .../devicetree/bindings/mfd/omap-usb-tll.txt  | 27 ----------
>>  .../devicetree/bindings/mfd/omap-usb-tll.yaml | 51 +++++++++++++++++++
>>  2 files changed, 51 insertions(+), 27 deletions(-)
>>  delete mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
>>  create mode 100644 Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt b/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
>> deleted file mode 100644
>> index c58d70437fce..000000000000
>> --- a/Documentation/devicetree/bindings/mfd/omap-usb-tll.txt
>> +++ /dev/null
>> @@ -1,27 +0,0 @@
>> -OMAP HS USB Host TLL (Transceiver-Less Interface)
>> -
>> -Required properties:
>> -
>> -- compatible : should be "ti,usbhs-tll"
>> -- reg : should contain one register range i.e. start and length
>> -- interrupts : should contain the TLL module's interrupt
>> -- ti,hwmod : must contain "usb_tll_hs"
>> -
>> -Optional properties:
>> -
>> -- clocks: a list of phandles and clock-specifier pairs, one for each entry in
>> -  clock-names.
>> -
>> -- clock-names: should include:
>> -  * "usb_tll_hs_usb_ch0_clk" - USB TLL channel 0 clock
>> -  * "usb_tll_hs_usb_ch1_clk" - USB TLL channel 1 clock
>> -  * "usb_tll_hs_usb_ch2_clk" - USB TLL channel 2 clock
>> -
>> -Example:
>> -
>> -	usbhstll: usbhstll@4a062000 {
>> -		compatible = "ti,usbhs-tll";
>> -		reg = <0x4a062000 0x1000>;
>> -		interrupts = <78>;
>> -		ti,hwmods = "usb_tll_hs";
>> -	  };
>> diff --git a/Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml b/Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml
>> new file mode 100644
>> index 000000000000..f49417d1faf7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/omap-usb-tll.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mfd/omap-usb-tll.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: OMAP HS USB Host TLL (Transceiver-Less Interface)
>> +
>> +maintainers:
>> +  - <maintainer@kernel.org>
>> +
> Roger? 

Sure, but I do not have any board to test this.

> 
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - ti,usbhs-tll
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  ti,hwmod:
>> +    const: usb_tll_hs
>> +
>> +  clocks:
>> +    minItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: usb_tll_hs_usb_ch0_clk
>> +      - const: usb_tll_hs_usb_ch1_clk
>> +      - const: usb_tll_hs_usb_ch2_clk
>> +    minItems: 2
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - ti,hwmod
> 
> keeping the binding in pace with reality... ti,hwmod should
> be deprecated. 
> 
> Regards,
> Andreas

-- 
cheers,
-roger


