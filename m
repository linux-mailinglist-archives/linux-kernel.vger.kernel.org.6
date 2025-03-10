Return-Path: <linux-kernel+bounces-553621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A89AA58C94
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 08:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A4A716A455
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 07:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0013A1CB332;
	Mon, 10 Mar 2025 07:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rl4jWlx1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD4A1A841C;
	Mon, 10 Mar 2025 07:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590929; cv=none; b=K242rrgHPJxBYNF69R77YZdEOkz76icphPDLN302CaZAnjAuIzH4qK3OYXUtOiDZtV+cfjsRTTJuNml6iQXcxp8tABYjWxQlQMg1P/7XhGlMAbXF/EVHWVZGu1wOR3ZHSM9TG83vmCyqJKae6+tAgMFlriuyQmMk1xChvI3eC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590929; c=relaxed/simple;
	bh=ukmBN1EwaxLenjYh9LRHAQi25Riq9TJLf4Rh32znRWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DSPlzw/f5tkYkKTi6XTDPA3eYRpfEtvb/t+PSAi52EC8Kcorw8QlcNnRClv9a2ZrnYdwGGPzmeKOLftJKgAI2WfJJrl7/M/GbmG+rZO/YkOV7t7BYrNvaSWuzB1/MXclbDyAhPRDkjXUVXl7n6JOuPsX7jn1Ale+NDXzGafpANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rl4jWlx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E459C4CEE5;
	Mon, 10 Mar 2025 07:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741590928;
	bh=ukmBN1EwaxLenjYh9LRHAQi25Riq9TJLf4Rh32znRWU=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rl4jWlx14Ui4SWBpbVbkusbb+1KD/CyraNvvMNlQlfm4Sj/MOtaBNFQPYaH5dB9md
	 jxIJPpsvvAE/S01SPXxL1y8id2UyEV1ZNhmtM53lREI+QO6YWDq2j64n60VN2ccWxr
	 kbLbBmB/aDtZoOydQBiEWQYPrIYp3mhIER0pjvpVswumtc/RaSMvYJ8bvO1jLVidcY
	 tgw3SAp/96nUKGSwpZg8RSMH2CgDXQVx4rOwWRYk16LsMjd2nfDL8OhUFYe8eXR2Tb
	 b917+Am92yndoTxAjoHULvNcsmbp9uybDjhnEyQAryiXItGPSNG2ZrCcAJcMyC20HV
	 Dcqp7Gb3lM9pA==
Message-ID: <e17cdf9d-ba96-41d2-9656-9e50d0e0795a@kernel.org>
Date: Mon, 10 Mar 2025 08:15:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-binding: aspeed: Add LPC PCC controller
To: Kevin Chen <kevin_chen@aspeedtech.com>, "lee@kernel.org"
 <lee@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
 <joel@jms.id.au>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "derek.kiernan@amd.com"
 <derek.kiernan@amd.com>, "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Mo Elbadry <elbadrym@google.com>
References: <20250304104434.481429-1-kevin_chen@aspeedtech.com>
 <20250304104434.481429-2-kevin_chen@aspeedtech.com>
 <8740eeb8-9467-48bb-a911-e70c3da3c45a@kernel.org>
 <PSAPR06MB494973DC08A8105EA05FBE6D89D62@PSAPR06MB4949.apcprd06.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <PSAPR06MB494973DC08A8105EA05FBE6D89D62@PSAPR06MB4949.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2025 02:50, Kevin Chen wrote:
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +        description: The LPC I/O ports to pcc
>>
>> Description is too vague. Why would we encode I/O ports as some numbers
>> instead of GPIOs for example? If these are ports, why this is not a graph?
> For the port-mmaped I/O in x80 architecture, BMC need to handle specific port I/O in the relative HW module.
> So, I need to add the pcc-ports property as the snoop-ports property in Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> 
>>
>> Missing constraints - min/maxItems, defaults, minimum/maximum etc.
> The port-mmaped I/O is defined from host, BMC as the device would capture the port I/O from the pcc-ports property defined in dts.

Put this information in the description, instead of copying property name.

> 
>>
>>> +
>>> +    required:
>>> +      - compatible
>>> +      - interrupts
>>> +      - pcc-ports
>>> +
>>>    "^uart-routing@[0-9a-f]+$":
>>>      $ref: /schemas/soc/aspeed/uart-routing.yaml#
>>>      description: The UART routing control under LPC register space @@
>>> -176,6 +205,13 @@ examples:
>>>          #size-cells = <1>;
>>>          ranges = <0x0 0x1e789000 0x1000>;
>>>
>>> +        lpc_pcc: lpc-pcc@0 {
>>> +            compatible = "aspeed,ast2600-lpc-pcc";
>>> +            reg = <0x0 0x140>;
>>> +            interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
>>> +            pcc-ports = <0x80>;
>>
>> So what 0x80 stands for?
> Host as x86 architecture would access the 0x80 port, which is mapped to the BMC PCC HW module.
> As a result, x86 can keep the port-mmaped I/O usage and access the BMC device, which is needed to know which port using in the PCC module in BMC.

And on different boards this is not 0x80?

Best regards,
Krzysztof

