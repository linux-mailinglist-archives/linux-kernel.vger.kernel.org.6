Return-Path: <linux-kernel+bounces-550590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8F2A561A1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1D83B482D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB521A3168;
	Fri,  7 Mar 2025 07:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzmlyN/6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E91A3146;
	Fri,  7 Mar 2025 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741331702; cv=none; b=IGI7KTMn+U0HkigF5Se3TG7VxFc3YFefJaCFvIi03PXvRez9poEvetKdgdQZ7+GK2WTqpWnb1fMVye8sBTwqr/HNSFiJ7P4JBLNpmPKTQFrsxHCGjXmgqGS9IY4mLgnWQM1G115iAT8FK+LWwSOGPMhD3+tLrHgHGiS69gHyW3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741331702; c=relaxed/simple;
	bh=swX1ojfqJP+t8PPowX7A5i1hWupkReVVGGz1hOuqLTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0FVxm/SEtvi0dFLfb8kcWYmSYT8p5B9JUf7/Wk6V9X16/8dZrCCjtpTbDGhYuxfvd+gda9RJwhC4GmCYkVmafX6foEHNfUup+Bs+RK8w5FlDxC5fkyHuyXxp87GNWXXD6jiwk9HikLvnTwi77WDVP4j5O/bknYt5HTkTlo24/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzmlyN/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075B4C4CED1;
	Fri,  7 Mar 2025 07:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741331701;
	bh=swX1ojfqJP+t8PPowX7A5i1hWupkReVVGGz1hOuqLTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OzmlyN/6EywgDm/4s9UwE1IiGfAbnTjxarKdhvdrbHlW2GibWkTSIgl+S1BaNvncw
	 sCgW7na6PcB5NvfIP4Pe0ka9GgkzannSLySein2EyQhDEwB3c5A6bg/AViFbHFmmNP
	 g9FhCrEkwZNe4sYaZof4wcLyVBCOcilCXF+6VGr0EQm+9ETD+BgAZ6LPZczDwSxVDV
	 mZcktnPLIKap4m1KK9Ez+360Mhz6nHv3zdGmluOkO8PmDxuOo+v49JSUEI5yix5/L2
	 WuvFg653Bytuj7YmT9lphs451MQYudhJFpI9CIU8ImTmgqLdUaIlJbHP544qIhKH7v
	 YpyXrKwPinvoA==
Message-ID: <c965f9dc-518d-4878-810d-420b0ee6c87e@kernel.org>
Date: Fri, 7 Mar 2025 08:14:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs: dt-bindings: Specify ordering for properties
 within groups
To: Dragan Simic <dsimic@manjaro.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <47c51c10098f089e52fb14c5c5527611dc8daf32.1741164239.git.dsimic@manjaro.org>
 <166a7b77-74e3-40b7-a536-ee56850d9318@kernel.org>
 <f05919742c34f5d4489d2cd711c7736f@manjaro.org>
 <20250306-dexterous-goshawk-of-aptitude-e4f1f6@krzk-bin>
 <c166178a01b7e83e9d3c488f4871bad3@manjaro.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <c166178a01b7e83e9d3c488f4871bad3@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/03/2025 09:57, Dragan Simic wrote:
> Hello Krzysztof,
> 
> On 2025-03-06 09:38, Krzysztof Kozlowski wrote:
>> On Wed, Mar 05, 2025 at 10:53:48AM +0100, Dragan Simic wrote:
>>> On 2025-03-05 10:36, Krzysztof Kozlowski wrote:
>>>> On 05/03/2025 09:45, Dragan Simic wrote:
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/dts-coding-style.rst
>>>>> b/Documentation/devicetree/bindings/dts-coding-style.rst
>>>>> index 8a68331075a0..15de3ede2d9c 100644
>>>>> --- a/Documentation/devicetree/bindings/dts-coding-style.rst
>>>>> +++ b/Documentation/devicetree/bindings/dts-coding-style.rst
>>>>> @@ -133,6 +133,12 @@ The above-described ordering follows this
>>>>> approach:
>>>>>  3. Status is the last information to annotate that device node is
>>>>> or is not
>>>>>     finished (board resources are needed).
>>>>>
>>>>> +The above-described ordering specifies the preferred ordering of
>>>>> property
>>>>> +groups, while the individual properties inside each group shall use
>>>>> natural
>>>>> +sort order by the property name.  More specifically, natural sort
>>>>> order shall
>>>>> +apply to multi-digit numbers found inside the property names, while
>>>>> alpha-
>>>>> +numerical ordering shall apply otherwise.
>>>>
>>>> The last sentence was not here and I don't get the point. Natural sort
>>>> order should be always preferred over alpha-numerical for properties.
>>>> About which other case ("...apply otherwise.") are you thinking?
>>>
>>> Yes, I added that sentence in the v2 to, hopefully, clarify the 
>>> natural
>>> sort order itself a bit.  I've researched the natural sort order a bit
>>> further, and it technically applies only to the multi-digit numbers 
>>> found
>>> inside the sorted strings.  That's what I wanted to explain, and 
>>> "shall
>>
>> Natural sort applies to everywhere. It's just the same as
>> alpha-numerical sort for single digits.
> 
> Technically, it depends on how one describes the natural sort order.
> I'll get back to this below.
> 
>>> apply otherwise" refers to applying the alpha-numerical sort order to 
>>> the
>>> remainders of the sorted strings, i.e. to everything but the 
>>> multi-digit
>>> numbers found in the property names.
>>
>> Sorry, still don't get. What would be the difference if for remainders
>> of properties you would also apply natural sort instead of
>> alphanumerical sort?
> 
> Oh, there are no differences in the results of the ordering, it's just
> about the formal definition of the natural sort order.  In some places,
> the natural sort order is described to apply to the multi-digit numbers


I am no language expert, so I rely on Wikipedia:

https://en.wikipedia.org/wiki/Natural_sort_order
"except that single- and multi-digit numbers are treated atomically,"

and anyway I don't really know how natural sort order would work for
single digits if it was applying to them differently.

> found in the sorted strings only.  Thus, the wording I proposed tries
> to explain that further, but I do agree that it's somewhat confusing.
> 
> In other words, the way natural sort order is defined in some places,
> it applies to the multi-digit parts of the sorted strings only, while
> the remainders of the strings are sorted alpha-numerically.  I'll 
> consult
> some more sources and get back with some better wording in the v3, to
> make it less confusing, while still describing the natural sort order
> a bit, because the people who will be reading the DTS coding style may
> not already be familiar with it.


Please drop the second sentence. The point is to be concise. If text
grows too long, people won't read it (just like they don't read
submitting-patches).


Best regards,
Krzysztof

