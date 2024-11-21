Return-Path: <linux-kernel+bounces-417209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693409D509F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF2C0B24D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 16:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BEC176AB9;
	Thu, 21 Nov 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1n0trqC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B9455C29;
	Thu, 21 Nov 2024 16:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206115; cv=none; b=IcMFmO5OBJCeHfx2Mu0A15lCisV+8nRKln/jo2AJNWSPLqNkVwFkeTU+rbekk/mnqAdpy0b60ttnHYXIfHHi1VJmnO15r+YURjJqv6KYS959fC3T8oGWpAMtfPHpSQgknVqdI4SEeyn7i5LpheIExWlzoG3Pwb+rT9yzMMhP4RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206115; c=relaxed/simple;
	bh=HUjeARzEFKuZwmjuWN7jX9OgSWrkMg5m1nwX93o1uBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSZPGQQoT6lLuUGSxlDKOtutIzfSXMRl9Z+pffaaPVdgcM78c8C93Qx4HB3p4EDgzSRhAvpDbf7szgw48cMBJ3U/h61/9zZCVuXiva3SiWZcbpR7VkhQO0w+q7/UVou/rEANCjHR6zuLw4ZYkkMDvNHTFVQls2deDnnfuQrJ+qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1n0trqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B58C4CECC;
	Thu, 21 Nov 2024 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732206114;
	bh=HUjeARzEFKuZwmjuWN7jX9OgSWrkMg5m1nwX93o1uBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S1n0trqCdN8V95A3uEbLK5W2AFrXe9GjXzAX37/mCzfn9kD+Wvy5AfBNWJ75VcGGk
	 myWtVsK9KySF+0FOHMW/2FadUAKF2obLfIzz7Y0q6eIBM1v7bFeD+KJ8er1EVp/YAb
	 4O00KtoNFJUoU9mG9yOIO4qmo8V3O8SP66gCsIuy5yzxJF6CheWaw3b7AgZR/X1iQa
	 7SRW3oU2jGT61y8j4vt21XjQSIsEzwsB5wI3yVdgqW7AFttSZXkX+QhoSGythuspxA
	 7iGtiulB9F/XT0YIjzGFP0YTlM8OIJ6UYcG07Kj7UAu2mQK57MxUWLtVUJ1JYU/Ix1
	 5yANdkBNswnCQ==
Message-ID: <d72a7a7d-ec78-4aac-8498-a9164e16615d@kernel.org>
Date: Thu, 21 Nov 2024 17:21:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: w1: ds2482: Add vcc-supply property
To: =?UTF-8?B?S3J5xaF0b2YgxIxlcm7DvQ==?= <cleverline1mc@gmail.com>,
 Conor Dooley <conor@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Ben Gardner <bgardner@wabtec.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20241115-ds2482-add-reg-v1-0-cc84b9aba126@gmail.com>
 <20241115-ds2482-add-reg-v1-3-cc84b9aba126@gmail.com>
 <20241115-happy-garter-2cf65f4b1290@spud>
 <83c8487c-2c50-4315-8244-ff80632165e9@gmail.com>
 <9896a38f-4b68-46a9-83b8-bf76abea47ba@kernel.org>
 <f824fcb5-8c04-4a39-887c-64fed2439cef@gmail.com>
 <48f0b74f-561b-4a5b-8311-e2cfddb92e3b@kernel.org>
 <ee013b8f-5526-4f32-bde3-aaebfb49e4d0@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <ee013b8f-5526-4f32-bde3-aaebfb49e4d0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/11/2024 16:56, Kryštof Černý wrote:
> 
> 
> Dne 21.11.2024 v 8:43 Krzysztof Kozlowski napsal(a):
>> On 20/11/2024 23:53, Kryštof Černý wrote:
>>> Hello,
>>>
>>>> On 20/11/2024 09:34, Kryštof Černý wrote:
>>>>> Hello,
>>>>>
>>>>>> On Fri, Nov 15, 2024 at 03:58:06PM +0100, Kryštof Černý via B4 Relay wrote:
>>>>>>> From: Kryštof Černý <cleverline1mc@gmail.com>
>>>>>>>
>>>>>>> Adds the newly added vcc-supply property to bindings.
>>>>>>
>>>>>> This commit message is a circular argument. You're adding it to the
>>>>>> binding, which of course means it is newly added.
>>>>>
>>>>> You are right, I will replace with "Adds the vcc-supply property to
>>>>> bindings." in the next version.
>>>>
>>>> No, please say why, e.g. because it was missing and device has it
>>>> according to datasheet.
>>>
>>> Right, what about:
>>>
>>> Adds the optional vcc-supply property to bindings, informs if the device
>>> needs a regulator to be turned on for its operation
>>
>> It does not inform at all. All devices needs power, don't they? And what
>> operation?
> 
> This is probably the best I can do:
> 
> 	ds2482 has a VCC pin, accepting 2.9-5.5 V. Allow optionally specifying 
> a voltage regulator to power the chip.

Keep only first sentence. Second is obvious, no need to repeat schema in
free form text (and schema defines it is optional).

Best regards,
Krzysztof

