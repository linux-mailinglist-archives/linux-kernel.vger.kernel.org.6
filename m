Return-Path: <linux-kernel+bounces-439503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B479EB028
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 12:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D25A1882458
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633FB19F11F;
	Tue, 10 Dec 2024 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUlgVH/Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA519924F;
	Tue, 10 Dec 2024 11:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733831278; cv=none; b=Az4Q4gF1n4UqpE74M+7qzUNYHwlv464xHPon8weOEMYGL7dq5xThs1oBRdWHB0oGlNTuO3ueBV9HVhnJq44MNOG5Lxr5gwyOSmnwxYk9UQ7nzVSKbOQ1IuB2mUZXYwtI+i6ac/XZPjoi4a6Uh34+D9BQuD0D/I4pObcNruI2gM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733831278; c=relaxed/simple;
	bh=rzjp/TyXIjzKiZW1IwrY6tCvrOTe5liapYdopftQ+4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JM0Uu6ufE3P1jkHPLRLacIqsbJBxYep1MtdRJFpBJMO3su/S77fxDabQnt5IyE9G5It+JqZhcrmPRcJb4/OHaXdIuTJ0gh3cE94E9Bqsv/doPSSExiUY3bX4ebsbO4iqzKjdMDCKXAmWQk31TLOAcySgN/a30nfnYt8OlBcgDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUlgVH/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B388EC4CED6;
	Tue, 10 Dec 2024 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733831278;
	bh=rzjp/TyXIjzKiZW1IwrY6tCvrOTe5liapYdopftQ+4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WUlgVH/Y66Lxis+Z70rcXNgHpmrvqRrAoDbGTY5Vrny52YhDpeV6eHOuNLhHKUmHO
	 f1Eb5l32s+d+B+R1R8ki0fvWgjm7z/E0fWLuzwHW8E+JAV4V/mfFf1+EFIPSOOT0dJ
	 fmMxdwExiXAra/0adHF14oFwZzaJnqZg3cdhs9x9C5y2bXtIgThzttRltOJ43TSojy
	 uqH5eyMDolaaNfrRsvmiDjQ68ZqDt7/9LUcrsA6xLTDq9aSstPXd/Cy98P/vLruB/6
	 ZBtndUS5PTVAu4XHfyvioxDKk6GHGdGfER8i+57yF1D2bzqJJNGCxb3vtFW6ia1/mH
	 q/dEQdY2H7Jnw==
Message-ID: <1cbaa7a3-e26a-4f8e-a7e0-8f148d516b75@kernel.org>
Date: Tue, 10 Dec 2024 12:47:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: snps,dwc3: Add
 snps,filter-se0-fsls-eop quirk
To: Krishna Kurapati <quic_kriskura@quicinc.com>,
 Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 quic_ppratap@quicinc.com, quic_jackp@quicinc.com
References: <20241017114055.13971-1-quic_uaggarwa@quicinc.com>
 <20241017114055.13971-2-quic_uaggarwa@quicinc.com>
 <gclvciv5cmrcut6qvo3kh3ycutqt5sot5k4i2nwics6myhuxvq@cf6ajwflxdlc>
 <1129e0a7-6bd0-416e-8c56-6b8d75600c4e@quicinc.com>
 <f9f66565-6356-4b61-8653-1e9c006b892c@kernel.org>
 <99810132-85b6-45ee-9933-7a00c3672c47@quicinc.com>
 <aa67ea21-b451-4a1d-b4bf-4912b88c0341@quicinc.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <aa67ea21-b451-4a1d-b4bf-4912b88c0341@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/12/2024 11:12, Krishna Kurapati wrote:
> 
> 
> On 11/20/2024 2:53 PM, Krishna Kurapati wrote:
>>
>>
>> On 11/7/2024 3:25 PM, Krzysztof Kozlowski wrote:
>>> On 07/11/2024 07:17, Krishna Kurapati wrote:
>>>>
>>>>
>>>> On 10/18/2024 11:57 AM, Krzysztof Kozlowski wrote:
>>>>> On Thu, Oct 17, 2024 at 05:10:54PM +0530, Uttkarsh Aggarwal wrote:
>>>>>> Adding a new 'snps,filter-se0-fsls-eop quirk' DT quirk to dwc3 core 
>>>>>> to set
>>>>>> GUCTL1 BIT 29. When set, controller will ignore single SE0 glitch 
>>>>>> on the
>>>>>> linestate during transmission. Only two or more SE0 is considered as
>>>>>> valid EOP on FS/LS port. This bit is applicable only in FS in 
>>>>>> device mode
>>>>>> and FS/LS mode of operation in host mode.
>>>>>
>>>>> Why this is not device/compatible specific? Just like all other quirks
>>>>> pushed last one year.
>>>>
>>>> Hi Krzysztof,
>>>>
>>>>    Apologies for a late reply from our end.
>>>>
>>>>    In DWC3 core/dwc3-qcom atleast, there have been no compatible 
>>>> specific
>>>> quirks added.
>>>
>>
>> Sorry again for late reply.
>>
>>> Nothing stops from adding these, I think.
>>>>
>> Agree, we can take that approach of adding soc specific compatibles to 
>> dwc3 driver instead of adding through bindings.
>>
>>>> Also since this is a property of the Synopsys controller
>>>> hardware and not QC specific one, can we add it in bindings itself.
>>>> Because this is a property other vendors might also use and adding it
>>>> via compatible might not be appropriate.
>>>
>>> This does no answer my question. I don't see how this is not related to
>>> one specific piece of SoC.
>>>
>>> If you claim this is board-related, not SoC, give some arguments.
>>> Repeating the same is just no helping.
>>>
>>
>> But my point was that although the issue was found only on some QC 
>> SoC's, the solution still lies in some bits being set in controller 
>> register space and it is part of Synopsys IP. So wouldn't officially we 
>> add that support in bindings and then enable/disable the feature via DT 
>> like we did for other quirks ? If many SoC's need it in future, the 
>> driver needs to add a long list of compatible specific data which 
>> otherwise might be quirks in DT.
>>
> 
> Hi Krzysztof,
> 
>   Gentle ping to provide your feedback on the last comment.
You got clear comments yet you still do not accept them. Nothing
changed, this is implied by compatible. The only reason this is not
compatible implied is that this is board specific. I asked for arguments
for this. Did you provide them? No. Instead we keep discussing same over
and over again.

You bring downstream arguments - one compatible and hundreds of
properties - and it is tiring to discuss over and over. There were
already multiple guidelines written and multiple comments for multiple
patches on the exact same topic.

I don't find nice being pushed over this and pinged for every little
disagreement with standard Devicetree rules and guidelines.


Best regards,
Krzysztof

