Return-Path: <linux-kernel+bounces-559117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF6A5EFB5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328893A88ED
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEFB264607;
	Thu, 13 Mar 2025 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJsnqep8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C473264FA8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858729; cv=none; b=LAorq75+1QBsdjzIzbgcTeV1osSbWk4vpRv9xr2HjH3u2L+OTaaXzVsWWbGaRdrsszyOAohDxCjaKZXQ585SauENnmyZPnH5YuhAi0K+dCffLlDM6pWUAMzNovOyIuaT156UFWKwH0M/pGYM9dQl0770D5OUVsuKXCdoTXCR6tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858729; c=relaxed/simple;
	bh=XduVv5oWP5XVLUDadTwpUfDqlbjfXc9kb+OmeMBd47E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P6y3mVinH5Zoq4fRhKitAKQnzl0A3+eulAJZZjKa3226hgThE3qkI3nKVKcoFcoeycaYto809w/Bw47XkF5lwFPyVDGm+NnoUtNC2yJ5cidX2gKTfXx3/2KYXLA0JVJlUSemBoTgt7rNut2twWznrXitfvvlYNPJ4ctErawxjsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJsnqep8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39340C4CEE3;
	Thu, 13 Mar 2025 09:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741858728;
	bh=XduVv5oWP5XVLUDadTwpUfDqlbjfXc9kb+OmeMBd47E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oJsnqep8qoQtltsZ/P/mRMfuyLIVgPWJvJ96dFaI743K7A26Mt4Bn2l4reKhD4rJL
	 3Re/al7IX35asDsCZnCbvBIuqxZrIVFl6GNsw61JRTl3Cbet+ev4tpT+YCRK9dl0Wk
	 VK4dlpvncb6NdP42b9uYFAqmUSoZfVxhVIb5LEbgYumXdRbg4S4nY5klkFpB3+HjUK
	 ynxh5Er6qVNEWTEun0WR9srYLTP+BmG4YQr5jiRcHlpwMRFTpcZK+5VOtpnIqAF1Fp
	 Pwlc+MV3jDNGkgZXVcJHPnzD7h1WSA2gHHXMuPNfd9zpzOnH36SCjPYB1gU25R3COX
	 K554Voa4h2cow==
Message-ID: <f019144d-3ecd-4d90-9c57-790a93966176@kernel.org>
Date: Thu, 13 Mar 2025 10:38:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/2] dt-bindings: add device tree binding for silex
 multipk
To: "Gupta, Nipun" <nipun.gupta@amd.com>, linux-kernel@vger.kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 derek.kiernan@amd.com, dragan.cvetic@amd.com, arnd@arndb.de,
 gregkh@linuxfoundation.org
Cc: praveen.jain@amd.com, harpreet.anand@amd.com, nikhil.agarwal@amd.com,
 srivatsa@csail.mit.edu, code@tyhicks.com, ptsm@linux.microsoft.com
References: <20250312095421.1839220-1-nipun.gupta@amd.com>
 <20250312095421.1839220-2-nipun.gupta@amd.com>
 <37707900-9162-43f2-b89b-3e1fec514daf@kernel.org>
 <270daefd-22a6-9359-edcb-c514644cfe4f@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <270daefd-22a6-9359-edcb-c514644cfe4f@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2025 10:25, Gupta, Nipun wrote:
>>> +
>>> +maintainers:
>>> +  - Nipun Gupta <nipun.gupta@amd.com>
>>> +  - Praveen Jain <praveen.jain@amd.com>
>>> +
>>> +description: |
>>> +  Silex Multipk device handles the Asymmetric crypto operations. The
>>> +  driver provides interface to user-space to directly interact with the
>>> +  Silex MultiPK device.
>>
>> Why this isn't in crypto?
> 
> It is mentioned in patch RFC 1/2 - because Crypto AF_ALG does not 
> support offloading asymmetric operations from user-space (which was 
> attempted to be added earlier in Linux at: 
> https://lore.kernel.org/all/146672253157.23101.15291203749122389409.stgit@tstruk-mobl1.ra.intel.com/)

And if crypto framework starts supporting it, would it mean that
hardware should be relocated? No, place it in directory matching the
class of the device.

> 
>>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: silex,mutlipk
>>
>> Unknown vendor prefix
>>
>> Device name part is weirdly generic. How is this device exactly called?
>> Where is it used? Where is datasheet?
> 
> The device is on AMD versal series and is named "Multi PKI" device. I
> will update to use compatible as xlnx,multipk (AMD versal series link: 

Then a SoC? So no, you are supposed to use SoC specific compatibles.

But this does not really answer about undocumented prefix, although
maybe you want to say that it is too generic?

> https://www.amd.com/en/products/adaptive-socs-and-fpgas/versal/premium-series.html). 
> Seems also renaming files to xlnx_multipk.c etc would be better. Will 

We talk about binding here.

> update.
> 
> The device is used for PKI offload for OpenSSL based applications.
> Unfortunately data sheet is not available in public domain.
> 
>>
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: PKI Queues memory region
>>> +      - description: PKI TRNG memory region
>>> +      - description: PKI reset memory region
>>
>> reset? Like reset controller? Why is this here instead of using existing
>> reset framework?
> 
> Not exactly, there is a clock reset which is separate from the device. I 
> explored and there is a soft reset as well which will do the 
> functionality and we do not need this memory region. Will remove it.

So that's a separate device and you need to use here resets property.

> 
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - iommus
>>
>> You did not test your patches.
> 
> We have tested the driver code, but device tree yaml needs some changes 
> you mentioned (and so the dts)

Bouncing back such argument is just making me disappointed in this work.

You did not test it. Period. Send patches only after testing. See
documentation in the DT directory (or talks or online resources).

Best regards,
Krzysztof

