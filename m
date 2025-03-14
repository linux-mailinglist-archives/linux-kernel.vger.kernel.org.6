Return-Path: <linux-kernel+bounces-560916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AC5A60AF3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6FB3BF07B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDF8199249;
	Fri, 14 Mar 2025 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxM5DLHL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36DF194137
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 08:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940038; cv=none; b=G376hKwxN3jDBKP8x1RG0wkXzSffbZmpTiL0jDvZjbACQ4dywDDt63Mg4uM477mmOEBD9kT4LAXiD0iUoMxsNEtvCx8HDoBC6hXDh6hZ8kJVkE2JAjFWIi6J7YBxX/04rUyfVNmSFd3HiOIl52777yQaaIcBNHsq29K5JtP0I+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940038; c=relaxed/simple;
	bh=seuKXhHZYUd/bOYJs3Ge/7ExXVxxWS0G9fYTItKU0us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhLl22wiqafzAgz7b8+RAf4ThdJvbWstk2zrDaipFMI+IVLgQLiSUSfJGfTTwiZsSYCjV+4trnmnKzrEI3bHvhHrq0TCVvyGRVk6t3f0CXtKSFZg2pH1rXnUb5PXoAf33xyClIMqFNYisVZxmCtBK1Aydxl0N0HafnlKu6czowg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxM5DLHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC9CC4CEE3;
	Fri, 14 Mar 2025 08:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741940038;
	bh=seuKXhHZYUd/bOYJs3Ge/7ExXVxxWS0G9fYTItKU0us=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RxM5DLHLPAU3fzVvKAULE492oYzs1GB4NvP+zUr0ofQ28hs4KyL9mUWwpY+h2xK4g
	 N30ejhrcJ4/0iC5ZOn55QvGqdwKea33Tsqpf+LN2eklZDHjS1GhVJl5g1qYmPDLxeC
	 h3ru4Q/ayhb42EaAov+BiPwJihivgjptYbUJcCxA2fpnBog2llP+IelP7RavxDMex1
	 hVWwKvxaiaubSaXTKoJe5DmiqACik2eP86+lZHMQG535e9i7HC/NdHdQeSORhjF0OT
	 36/EmD2z1nyqbNZ2Ymt4vK2/aUM39DfnQkfQaOB88ftPy80G7NRIKtP7L3uk2eRJM9
	 jTwm4RZojS/QA==
Message-ID: <d0d82010-e311-4a41-a6c4-027626e408ba@kernel.org>
Date: Fri, 14 Mar 2025 09:13:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mailbox: cix: add device tree binding
 documentation.
To: Guomin chen <guomin.chen@cixtech.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 Peter Chen <peter.chen@cixtech.com>, Lihua Liu <Lihua.Liu@cixtech.com>
References: <20250313132405.742360-1-guomin.chen@cixtech.com>
 <27cf6dab-da29-458a-b376-4013c05434ab@kernel.org> <Z9PkUxlQ1t5zZxuf@gchen>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z9PkUxlQ1t5zZxuf@gchen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14/03/2025 09:09, Guomin chen wrote:
>>
>>> +
>>> +      This controller supports three types of unidirectional channels, they are
>>> +      1 register based channel, 1 fifo based channel and 8 fast channels.
>>> +      A total of 10 channels for each controller. Following types are
>>> +      supported:
>>> +      channel 0_7 - Fast channel with 32bit transmit register and IRQ support.
>>> +      channel 8   - Reg based channel with 32*32bit transsmit register and
>>> +                    Doorbell+transmit acknowledgment IRQ support
>>> +      channel 9   - Fifo based channel with 32*32bit depth fifo and IRQ support.
>>> +    const: 1
>>> +
>>> +  cix,mbox-dir:
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    description: Direction of the mailbox (0:TX or 1:RX)
>>> +    enum: [0, 1]
>>
>> I don't understand why do you need it. By not sending us driver patch,
>> you are not making it easier. Why would provider care how consumers use
>> the mbox channel? Maybe consumer should choose the direction?
>>
> 
> As for the mbox-dir property, my driver code has already been submitted. 

There is no thing in this thread, so next time be sure you use standard
submitting process, so your work will be threaded.

> On the Cixtech Soc platform, although each mbox is unidirectional, 
> there are multiple mboxes—some for reading and some for writing. 

So all mboxes in a controller have the same direction or not? Do you
configure it or is it defined by hardware?

> Therefore, the mbox controller has added the mbox-dir property. 
> 
> Consumers only need to reference the corresponding mbox controller node, 
> and whether it is for reading or writing is already determined by the mbox controller, 
> without needing to further understand the mbox-dir property.

Don't explain how DT works, I know. Why this property is needed in DT in
the first place?


Best regards,
Krzysztof

