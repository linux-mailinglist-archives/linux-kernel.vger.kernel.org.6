Return-Path: <linux-kernel+bounces-281897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A37994DCB8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 14:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7B32821B9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 12:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C8A158546;
	Sat, 10 Aug 2024 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCcNXD2C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FA113E02A;
	Sat, 10 Aug 2024 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723292497; cv=none; b=b9qLIKxagQeXhMiWwPjyk7tE4e/+nNG8lcuiA0+oAroHPz9N0YIbbkgpuslxInUtUTzqZxAOaJeW0BR6kEwO6+PjVaOdpLbroglSotfMK6BZ12k1vPK61AXEc0g1Ub67JTIiAomRarjc107u5SaVFo6QkmYZ3ztW9M0+MIIhs3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723292497; c=relaxed/simple;
	bh=BUO7G27ozlxUWdCf9RP7tbhzzSrPxYy/G08Wuj3qLpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K7np6Pt0PXW2SiIr2DQfvcb8RwjmFP7UHhjF9RnH7pUmWp1hH8PQPbm0EdITVz3FGWNi5/h/7+l1kiaoGLe8Q7haDZ+6usYpae3f0S7+dQXmvLx0yCYqYZsJ3P0l/uTzUacRuLlipZ8l1OppnVSFB4nOjbIpAvoU1c4UR7a08l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCcNXD2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E43C32781;
	Sat, 10 Aug 2024 12:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723292497;
	bh=BUO7G27ozlxUWdCf9RP7tbhzzSrPxYy/G08Wuj3qLpU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OCcNXD2CzuLrZ1X2Mc2SrEexHq31MgvQjnWU8QsftVzNaFkK3AsP9P/MSZ6usZKNW
	 Oh+bQ1sv6Jq6Pj9hITzsbDpOrIq82BaycMfJ5tT3wbvnqZBL5O93ocR/kHo+Irl0GM
	 Tm5pdUGT4JhO4WJvYP52GH4PTKJknNkEnmEvr76qdnmncQ0lg+BIagMTRy7xHT+dgJ
	 jj1WVCqRew5OEgq60RWcZ0YwDyxw+eIV9g2T47BAhkXRQOGwJaxV0Lprbdy3BgOm3w
	 sztzsXbHvzj6xt1ymDINmePmaabS/Wrq0lFi/d4TytRTzRTjPn/NgfK/ENnLeyyg5X
	 RJU2T6ZtGnXyQ==
Message-ID: <ac41ac85-fdf5-4aa8-953d-6b3ab3c23f37@kernel.org>
Date: Sat, 10 Aug 2024 14:21:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm64: dts: lx2160a: Change PCIe compatible string to
 fsl,ls2088a-pcie
To: Frank Li <Frank.li@nxp.com>, Conor Dooley <conor@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 "moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 imx@lists.linux.dev
References: <20240808153120.3305203-1-Frank.Li@nxp.com>
 <20240808-frosted-voicing-883f4f728527@spud>
 <ZrTphsdTZVsbiGo/@lizhi-Precision-Tower-5810>
 <20240808-linoleum-evasion-ad7111a2afc4@spud>
 <ZrTvB/3GGIhEOItT@lizhi-Precision-Tower-5810>
 <20240809-freewill-compactor-4f441a4a60bb@spud>
 <ZrZNzqDKUaOqzl7k@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ZrZNzqDKUaOqzl7k@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/08/2024 19:11, Frank Li wrote:
> On Fri, Aug 09, 2024 at 04:07:25PM +0100, Conor Dooley wrote:
>> On Thu, Aug 08, 2024 at 12:15:03PM -0400, Frank Li wrote:
>>> On Thu, Aug 08, 2024 at 04:55:14PM +0100, Conor Dooley wrote:
>>>> On Thu, Aug 08, 2024 at 11:51:34AM -0400, Frank Li wrote:
>>>>> On Thu, Aug 08, 2024 at 04:34:32PM +0100, Conor Dooley wrote:
>>>>>> On Thu, Aug 08, 2024 at 11:31:20AM -0400, Frank Li wrote:
>>>>>>> The mass production lx2160 rev2 use designware PCIe Controller. Old Rev1
>>>>>>> which use mobivel PCIe controller was not supported. Although uboot
>>>>>>> fixup can change compatible string fsl,lx2160a-pcie to fsl,ls2088a-pcie
>>>>>>> since 2019, it is quite confused and should correctly reflect hardware
>>>>>>> status in fsl-lx2160a.dtsi.
>>>>>>
>>>>>> This does not begin to explain why removing the soc-specific compatible,
>>>>>> and instead putting the compatible for another soc is the right fix.
>>>>>> Come up with a new compatible for this device, that perhaps falls back
>>>>>> to the ls2088a, but this change doesn't seem right to me.
>>>>>
>>>>> It can't fallback to fsl,ls2088a-pcie if fsl,lx2160a-pcie exist, which are
>>>>> totally imcompatible between fsl,ls2088a-pcie and fsl,lx2160a-pcie.
>>>>>
>>>>> Previous dtb can work just because uboot dynamtic change fsl,lx2160a-pcie
>>>>> to fsl,ls2088a-pcie when boot kernel.
>>>>>
>>>>> fsl,lx2160a-pcie should be removed because Rev1 have not mass productioned.
>>>>
>>>> Please re-read what I wrote. I said to come up with a new compatible for
>>>> this device, not fall back from the existing fsl,lx2160a-pcie to
>>>> fsl,ls2088a-pcie.
>>>
>>> According to my understand, It needn't add new compatible string if nothing
>>> difference. for example, it use fsl,vf610-i2c for all i2c without add
>>> new soc-specific fsl,lx2160-i2c.
>>
>> No, you should have soc-specific compatibles regardless. Just because
>> you got away with it once, doesn't mean I'm not going to complain about
>> it here!
> 

Above... and here:
https://lore.kernel.org/all/20220817202538.21493-2-leoyang.li@nxp.com/

Uh, this is so confusing. You have fsl,lx2160a device with PCIe and
fsl,lx2160a-pcie compatible. You claim that these are wrong. Instead of
fixing driver, you use entirely different device's compatible?

Wow, that's confusing.

> Rob:
> 	What's current policy for this? Not only for this one. If new SOC
> appear such as iMX10 (maybe many derived chip i.MX101, i.MX102...), there
> are bunch of IPs, Do we need add fsl,imx10* for everyone, which most part
> is exactly the same as old one and bloat binding doc.


NXP since early days was following this approach of having specific
compatibles, so why changing it now?

In general you need specific front-compatibles, except for different
pinout or fused values.

But that's not the problem here. Earlier confusion is the problem. This
is very weird change.

> 
> 	I remember that I got a feedback that required provide the
> difference during I try to add new compatible string. I am sorry, I can't
> find origial dicussion thread.
> 


Best regards,
Krzysztof


