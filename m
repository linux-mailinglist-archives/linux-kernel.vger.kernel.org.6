Return-Path: <linux-kernel+bounces-341699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A29883E0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149EF1F20EEE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF62C18A6DC;
	Fri, 27 Sep 2024 12:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOHEfXpB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4C5188CBE;
	Fri, 27 Sep 2024 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727438729; cv=none; b=qypphoh2Z+Y1C6mSkk8PoRZDFN9l/K/hJ4DZa2I5XPkaK8FOmrOBeSkn1RVzcm1N8G+DTKYG/I+WhfMJ1hJsW32THe7k4ze/Rhn1wUO/j0B6k+BNO7YpyTStKKCf2NitzupxGw59JQ+VSpjmE31Vstu+DkuYXjuLY8fVzun6r0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727438729; c=relaxed/simple;
	bh=TE0LKX2c8E2TfT9Hkddc6qnG6wPmZG77HUmFBLIjakI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDAz5Oc9pjuS1G3S5LsNtNTuQORO8TMXSiR4xtd7B8MOON4rjB2fif1b5QwnOWLhxCW9FNDPePubEEcrlS/69+8WtOBOBgTJNoqQ9Cne7CiIE5vtc2SBN0Xbi621OfZGuCt3QHY2W/8afQwN6bPbmSSOKeduwdTzuHZ5u12wJsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOHEfXpB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7EFC4CEC4;
	Fri, 27 Sep 2024 12:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727438728;
	bh=TE0LKX2c8E2TfT9Hkddc6qnG6wPmZG77HUmFBLIjakI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kOHEfXpB9+ydIEuC+pfZodkQQ8eyy4bD6HLDQewhrZ1cGBkrjVoMuF2QlsvbSpmgU
	 x188wYvJMfJlIc0TS3IpcjbB5yhVUJG6d9GYuohuAzUewGFenBsdIj9XMfv7urLtnW
	 RoFZrUE8i3iPKE0i6/0gCryi3iHXuVHtbfZNy6LLy+C37UiuDLAcY61vGIhCJkrove
	 wI2KJpE5v8TyFvVDZ9MPenfMBUqjcFB1bIwFWotXTyr+TK+zuJeq+qd5we04BNNWiI
	 gth/iJcUxfbLFJMX//xNB3T3ms3oah33OmsbXjiJBwjtPWeZUAnJ51AoZds+kQODYj
	 H5YrKft7fmp9A==
Message-ID: <417fa0ae-fe9c-4407-acbe-09173a0a2a47@kernel.org>
Date: Fri, 27 Sep 2024 14:05:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
To: Frank Wang <frawang.cn@gmail.com>, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, william.wu@rock-chips.com,
 tim.chen@rock-chips.com, frank.wang@rock-chips.com
References: <20240926103223.29538-1-frawang.cn@gmail.com>
 <ed829240-d4f7-471f-84f6-3509f87f11a1@kernel.org>
 <7944f4dd-96f0-40df-8c91-523409e3cb20@gmail.com>
 <4b98196a-c898-4d08-9101-31feb4e59b5c@kernel.org>
 <a06af01a-656b-4ef6-84a6-bc1c35d5bafa@gmail.com>
 <2815219e-3a20-4a5b-8573-d8a4ad2df1c9@kernel.org>
 <f5e547ac-cb5b-492d-8cfd-d77d3e9bbf9d@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <f5e547ac-cb5b-492d-8cfd-d77d3e9bbf9d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 27/09/2024 12:59, Frank Wang wrote:
> Hi Krzysztof,
> 
> On 2024/9/27 17:52, Krzysztof Kozlowski wrote:
>> On 27/09/2024 09:59, Frank Wang wrote:
>>>>> -  clocks:
>>>>> -    maxItems: 1
>>>>> +  clocks: true
>>>>>
>>>>> -  clock-names:
>>>>> -    const: phyclk
>>>>> +  clock-names: true
>>>> For the third time, read the code I gave you. Do you see something like
>>>> this there? Why doing all the time something different than existing code?
>>> Refer to the link you sent me that I must add minItems property for
>>> clocks, just like the below codes:
>>>
>>> @@ -35,7 +35,8 @@ properties:
>>>        const: 0
>>>
>>>      clocks:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 3
>> Yes, for all variable properties, so also names.
>>
>>> That can pass dt_binding and dtb checking, however, "clocks" is the
>>> optional property for some old Rockchip PHYs,  I am not sure is it right
>>> to force set  minItems as 1 .
>>> If just keep maxItems, the dt_binding checking is failure.
>> Please specify the question you want to ask.
>>
> 
> Please ignore my last garbled email as mailbox client issue.
> 
> Q1: The "clocks" is an optional property for some old Rockchip PHYs, so 
> set "minItems: 1" likes the below, is this a suitable setting?
> 
>      clocks:
> -    maxItems: 1
> +    minItems: 1
> +    maxItems: 3
> 
> Q2: Do you want me to amend the code to like this?
> 
>     clocks:
>      minItems: 1
>      maxItems: 3
> 
>     clock-names:
>      minItems: 1
>      maxItems: 3

List should be here with minItems. Then you only define the constraints
in if:then:

Best regards,
Krzysztof


