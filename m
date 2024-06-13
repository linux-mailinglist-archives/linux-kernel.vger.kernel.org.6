Return-Path: <linux-kernel+bounces-213396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DA190748D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7931F220F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 14:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1C0144D22;
	Thu, 13 Jun 2024 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8D84jqD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D199476;
	Thu, 13 Jun 2024 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287440; cv=none; b=ULV9J5qslhr8FZA8bPSwgRb+k68v7l1E32OUOhSRMMbmoEwqEKG0M0aU2+WUwqqDgH1zLzLChS1ZYviNnPl3uhpKjw8cnLDBZPcbHxwvjtYs9coZ5+j8GNFY/YH+OwpgA2wV4JduWIurh8TZjwRjB/6x/YvhjhIvnHW7H4tQ4mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287440; c=relaxed/simple;
	bh=tA+ZFQAqpvg+G+t2qduevu+kebIw5Dh4TdqA0ZnOYfI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejZ5Ny8NrosG/FJ/uZBubJeasL7pBASO80w7mqP9E8P3+CVxvIjjjF0fEcAw8PA69OghmRTEuHTNBKYEw0ITERLOC5Ex8UttJgwWIgqfQvF+j+0qDW5ok2YHi+UGy5/iDgv8vHFMIIdPcBJ07LGeSR5Q98fXjViZRvkD+GAKUXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8D84jqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7741C2BBFC;
	Thu, 13 Jun 2024 14:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718287439;
	bh=tA+ZFQAqpvg+G+t2qduevu+kebIw5Dh4TdqA0ZnOYfI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d8D84jqDn1VqJ6IDMYy/UYaGCkftPCPWErfo7X6iFrw4IXqZQkVFwkyLaWEL1vk6A
	 sIO6xAACuSNLtotedW0ZcqQqylA6gGZH0+HkvDDunK58ixQxEm9FvyAys3DiCHRftf
	 DpUuHaMGGOGKZ9FZag/bXZPLt15PmT/nL2mV1gZ42y0Q7oe3LPLEmMRiSAUhJ7jFuf
	 9w2ofJmwB/p7ld+ph0bo9G+TLCWF984gEvEwlc3XGtaCdnWYMCRtfFV8H3nppSehXV
	 Gn7Dx7OkRLGfZAGo9/m6cezAIp8PC+wkAoMiAFmSsiqy4xrZUqjs6Nbd/FeF6IXlpI
	 sdmjtt6kbfjbQ==
Message-ID: <07e242d9-86d5-487d-9d23-8f765219fa59@kernel.org>
Date: Thu, 13 Jun 2024 16:03:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4, 1/3] dt-bindings: usb: dwc3: Add snps,p2p3tranok quirk
To: joswang <joswang1221@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, balbi@kernel.org,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jos Wang <joswang@lenovo.com>
References: <20240601092646.52139-1-joswang1221@gmail.com>
 <20240612152347.3192-1-joswang1221@gmail.com>
 <21cfeb4c-4ce2-487a-bdd5-45c3ed71bf6f@kernel.org>
 <CAMtoTm1ORiZHhMZRZ9NCq4qD7RB-ZCzAnusdN3PvRUff5zSh3A@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAMtoTm1ORiZHhMZRZ9NCq4qD7RB-ZCzAnusdN3PvRUff5zSh3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/06/2024 15:19, joswang wrote:
> On Thu, Jun 13, 2024 at 2:17 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 12/06/2024 17:23, joswang wrote:
>>>
>>> +  snps,p2p3tranok-quirk:
>>> +    description:
>>> +      When set, the controller transitions directly from phy power state
>>> +      P2 to P3 or from state P3 to P2. Note that this can only be set
>>> +      if the USB3 PHY supports direct p3 to p2 or p2 to p3 conversion.
>>> +    type: boolean
>>
>> Hm? You respond to feedback and, without waiting for my answer,
>> immediately send new version?
>>
>> No. Read feedback on your previous version. Drop the quirk.
>>
>> Best regards,
>> Krzysztof
>>
> 
> Thank you for your help in reviewing the code.
> Sorry, I submitted three patches in total. Patch1 (the current patch)
> and patch2 solve one case, and patch3 solves another case. Because
> patch3 needs to submit a new version, I resubmitted v3 and v4
> versions.
> Patch2 is under review, and there is no clear conclusion. For now,
> patch1 does not need to be paid attention to. I will notify you when
> patch2 has a clear conclusion.

This does no work like this.

Implement feedback and send new version of entire patchset *ONCE* there
is conclusion. Sending new version of some parts ignoring feedback or
skipping conclusion is not the way.

Sorry.

Still drop.

Or in case we still have here misunderstanding - so far it looks like: NAK

Best regards,
Krzysztof


