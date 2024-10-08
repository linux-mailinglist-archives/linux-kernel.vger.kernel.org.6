Return-Path: <linux-kernel+bounces-355231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EE994CF6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 15:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C2A1C2514A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFC01DF740;
	Tue,  8 Oct 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGQvqiYn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8534189910;
	Tue,  8 Oct 2024 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392374; cv=none; b=lFn7MAxtoG5LTgdRuSbMRoYo/yqGXJlT1h38YOXsZqxB5vPOq4ebVG9wuYN7g6+Bs2x4Yx5nIrFVR/DRcL2uA3uuNWuahEzaCgumZxNjaLQDMgS0sMg5a/EduyLPQDS0SupRADZmURJL+ApoGk1tycBIl6wl1ST/unHvBOMxYAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392374; c=relaxed/simple;
	bh=S56vPNMgcKpiszKMqZFy08jLIhyiOgKXegYXxUqdUv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LE7vHxarIB4xGov06Wkn45nOD02gkLd9pZAwL94PKjFgU4trgVnOz38HKYm9JJ0ClCWswx9wJbr6NEStBSOj/o/nLfg/HrnqoOaJOYgK59m4DTCVIbmhc2ZtoXhfu4GYBpxe3aOU7FS+IcQ6x6BQ0Tf0CiMMiiVEujDdI3zgP5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGQvqiYn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36146C4CECC;
	Tue,  8 Oct 2024 12:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728392374;
	bh=S56vPNMgcKpiszKMqZFy08jLIhyiOgKXegYXxUqdUv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DGQvqiYnUQqm1++vTmmeOYOgYX4yh8/Yd9XnPeelfDlbep6b6ttPpzowX8PPnjQU0
	 1eJDis+2dieb2WfhD9oxtXjlPnTYPsyiWfO4k1k0aHQwO3E4WqcXcYyjUKrJ4L5tb3
	 ezA1fOIwLMq8wP1ACqq8sdSpEonhOeZiqco1yY7p/zWOhnS+COCAE5KmXwp7n8l+ty
	 esBIr+RP8TFK8AL0XUJzmsEFu2FYslCKpkliYQw15Zct0H7CpTSbuGiKzqXPBCYlNb
	 wMtR4q08yzk8VprrJz/XGVNs4b04HLtTaFFD4kmKP3c5kJ/osRfDgN+9jaRM+YESmh
	 IEXkhxhUOw8nA==
Message-ID: <19bdc074-7f48-4df4-87c0-117f4cff54f0@kernel.org>
Date: Tue, 8 Oct 2024 14:59:28 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Add binding for USB Gen2
 de-emphasis
To: Joy Chakraborty <joychakr@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Thinh Nguyen
 <Thinh.Nguyen@synopsys.com>, Felipe Balbi <balbi@kernel.org>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241007135508.3143756-1-joychakr@google.com>
 <20241007135508.3143756-2-joychakr@google.com>
 <c98ece5f-c105-41ca-af1a-bddc61893071@kernel.org>
 <CAOSNQF148N5meoFZkbGKoMXMZ62kf=JOV+1r0GCsep3DPP_Lrw@mail.gmail.com>
 <1bc2c476-9d7b-4c87-924b-ecaed0f721de@kernel.org>
 <CAOSNQF0b--3o5bseU05Eu3a2zDiTTYfbnQNONFo3imw3HnaONA@mail.gmail.com>
 <502d7a1f-0bac-496f-8fbe-b8924cd0ce31@kernel.org>
 <CAOSNQF1A_gsXeRuuR4qeZQi9FicrsPxYfjvLpmgxkaGq0-mZmA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAOSNQF1A_gsXeRuuR4qeZQi9FicrsPxYfjvLpmgxkaGq0-mZmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/10/2024 14:40, Joy Chakraborty wrote:
> On Tue, Oct 8, 2024 at 5:40 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 08/10/2024 13:59, Joy Chakraborty wrote:
>>>>>
>>>>>>
>>>>>>> +    description: When set core will set Tx de-emphasis for USB Gen2
>>>>>>
>>>>>> And why it cannot be implied by compatible?
>>>>>
>>>>> As per my understanding these are tuning coefficients for de-emphasis
>>>>> particular to a platform and not the dwc3 controller, hence should not
>>>>> be a controller compatible.
>>>>
>>>> Platforms must have specific compatible, so this should be implied by
>>>> compatible.
>>>
>>> Maybe I am using the word "platform" incorrectly here, what I
>>> understand is that the same controller(in a chip) when used on 2
>>> different physical form factors might need different deemphasis
>>
>> You mean boards? This is board-level property?
> 
> Yes, the USB controller can be paired with different phys in a SoC and

That's not board specific, but SoC.

> used on different board layouts where we should be able to drive
> different de-emphasis coefficients to the phy as per the link
> equalization requirements is my understanding.

You keep mixing different stories, so I am not convinced.

> 
>>
>>> coefficient values to be passed to its Phy. Someone could correct me
>>> from the USB link stand point if I am mistaken here.
>>>
>>
>> Then please point me to the upstream DTS boards using these properties.
>> Lore link is enough, if board or DTS change is being upstreamed.
>>
> 
> The DTS change is not being upstreamed currently.

Why do we want code without any user?

> But this change would help bring up a new or development board where
> USB compliance is being run and this parameter needs tuning,  hence
> being able to upstream this would help.

To me whatever Google or any other vendor is doing downstream does not
matter, just "does not exist".

Upstream the DTS so we can verify how this is exactly used.

To me it looks so far as SoC specific and your earlier comment about
pairing USB controller with phy is confirming this.

That's a common practice from Google (but not Chromium folks, they are
awesome!) and few other vendors to upstream whatever they have in their
GKI downstream, regardless whether it is right or not, whether it
follows rules or not, whether there is any user or not (and again: users
are upstream). Rationale for all this is the same - "we have downstream
some crap thus we want it".

Nah, upstream your stuff to be considered as a user.

That's a NAK, sorry.

Best regards,
Krzysztof


