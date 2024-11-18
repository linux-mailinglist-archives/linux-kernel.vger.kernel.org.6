Return-Path: <linux-kernel+bounces-413028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA92E9D12BE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 122E1B26C44
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BC119D087;
	Mon, 18 Nov 2024 13:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql/x06U4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13231991C6;
	Mon, 18 Nov 2024 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731937927; cv=none; b=PSY1JvRm6pVPaseElGIjD54C4zujNfXAUubChpLdBFdHrCoput9Uro7G8T8ZyeQK+5xd5FYrWBdgf2khxWGd6ADmTFuFPKL6PvnkzAPN2qzGwCGakTIWDbdwoQ3+8+xT++mNTw1Mi6oRI+lR/q8j8Twy9ADVLsMO0v/7eGCfJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731937927; c=relaxed/simple;
	bh=YFX7I8wUNcuEKdhfwHfjShYobpEFUbIfJpwAe9tNUns=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CDrrT0FfnMXb2mAv12eknX5S6cySdIwgVIdP663RHbFUKocGjxY01PQYkp5GreidTgnLzDCx9bdrp78bAYpF+a5XYiaCBI3dJzNyGTzFl6CesCJKrYs6KxT2MrL7ooTLzxTHhQWadNbkdBXxforhCVhjxSQENAMNfbUuoJBGouQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql/x06U4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFF0C4CECC;
	Mon, 18 Nov 2024 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731937926;
	bh=YFX7I8wUNcuEKdhfwHfjShYobpEFUbIfJpwAe9tNUns=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ql/x06U45naLOMC2dU7/ZCckVoQ8GoJI2VkRdkS67FLhGzh48v97p3DBJ0ZmoYH3H
	 rbWSxjJSiVok7TYotbwJTeGY55BL8utVySnrqNvn5uAJenApRRPYgP5pOOWpC7LDTn
	 QAT3s+EShAIYHJMJP+MX7yJ7+gv2bVmCDob+AkgFZhmMLSeNr/ZrHFBXQm9JHV44Jf
	 1cmm51jK9JwiRGHuxFJJtW4rPdE0puJVPt1WeEudxvyEoVgX+Pqv9YF4o/huDO3A33
	 mcaiKZFacpnXQX9FLfAYIkOAL9pbaK9i8AvI2CAqpkc0WPcGSY80L6gkgaslIad51T
	 9p2WYLXao+Bzg==
Message-ID: <6e11c85a-5883-4a28-b5bd-98da28f20425@kernel.org>
Date: Mon, 18 Nov 2024 15:52:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: soc: ti: pruss: Add clocks for ICSSG
From: Roger Quadros <rogerq@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, ssantosh@kernel.org, nm@ti.com,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, s-anna@ti.com, kristo@kernel.org, srk@ti.com
References: <20241113110955.3876045-1-danishanwar@ti.com>
 <20241113110955.3876045-2-danishanwar@ti.com>
 <adcc5aa5-0f51-4c69-b684-a1e0844c5e3f@kernel.org>
Content-Language: en-US
In-Reply-To: <adcc5aa5-0f51-4c69-b684-a1e0844c5e3f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/11/2024 15:33, Roger Quadros wrote:
> Hi,
> 
> On 13/11/2024 13:09, MD Danish Anwar wrote:
>> The ICSSG module has 7 clocks for each instance.
>>
>> These clocks are ICSSG0_CORE_CLK, ICSSG0_IEP_CLK, ICSSG0_ICLK,
>> ICSSG0_UART_CLK, RGMII_MHZ_250_CLK, RGMII_MHZ_50_CLK and RGMII_MHZ_5_CLK
>> These clocks are described in AM64x TRM Section 6.4.3 Table 6-398.
>>
>> Add these clocks to the dt binding of ICSSG.
>>
>> Link: https://www.ti.com/lit/pdf/spruim2 (AM64x TRM)
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> index 3cb1471cc6b6..927b3200e29e 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
>> @@ -92,6 +92,16 @@ properties:
>>      description: |
>>        This property is as per sci-pm-domain.txt.
>>  
>> +  clocks:
>> +    items:
>> +      - description: ICSSG_CORE Clock
>> +      - description: ICSSG_IEP Clock
>> +      - description: ICSSG_RGMII_MHZ_250 Clock
>> +      - description: ICSSG_RGMII_MHZ_50 Clock
>> +      - description: ICSSG_RGMII_MHZ_5 Clock
>> +      - description: ICSSG_UART Clock
>> +      - description: ICSSG_ICLK Clock
>> +
> 
> There are actually many more clocks [1]
> What is the purpose of adding all these clocks in the DT if driver doesn't
> use them?
> 
> Only CORE and IEP clocks parent can be configured via clock muxes.
> Those are already defined in the icssg?_cfg nodes.

Actually those clock muxes are internal to ICSSG.
We still need to be able to set clock parents of CORE and IEP clock.

So pruss block needs at most 2 clocks like you had in v2 of this patch?

> 
> [1] - https://software-dl.ti.com/tisci/esd/22_01_02/5_soc_doc/am64x/clocks.html
> 
>>  patternProperties:
>>  
>>    memories@[a-f0-9]+$:
> 

-- 
cheers,
-roger


