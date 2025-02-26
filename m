Return-Path: <linux-kernel+bounces-533535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02EEA45BCE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2D253A7E50
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CC6238179;
	Wed, 26 Feb 2025 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRN+CDHp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD2F258CDD;
	Wed, 26 Feb 2025 10:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740565845; cv=none; b=ONnHjkn5yqZ6a1d2g7wibFfzqtQzcETkG7at0T8B7Q3SQ7NGkp+mN9Ee2acsqQD3V2nTz8TEC7K2SwiZoIS80k7r4RTmz4cEFkZ9BIC84IQhnkkatejnTDhOPov3ske2Yxl5373JAF1fhiSt9PhooW7xhrqfJAzSNtXVW2y7kM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740565845; c=relaxed/simple;
	bh=12xjjcbr8wkE+v+6ct+nnGb1YzfZrIoiphJhPdLep14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u60vgcxTdz9KjVFqagqNt8qWIz81WbemhKzyPKw/xUU/skAYk8MjZEOUc8tehztKwdWVeZFFbUA7/YbXErjEL6iJrgGMkq+amM2SX6GmKLTzz0XRwGJLK7YtwoEPK3JLuJ7lueEKhrRBgK/HGuFeroD7aNHXjvAzss+3lfHWZAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRN+CDHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CC6C4CED6;
	Wed, 26 Feb 2025 10:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740565844;
	bh=12xjjcbr8wkE+v+6ct+nnGb1YzfZrIoiphJhPdLep14=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MRN+CDHpwO2M7lvH3rhzw21FdnD7DuEQkTv16oMjzRm34SSeksf4wAXixCkvEBqeZ
	 IhourRNnR4/58me31Ao02UiTaE9kWstfdh78ZS8v7UNiH/dRS5OJPflL8+R/2PakIY
	 zc02Dbr9lHAyHSZQXxZSZmMRMcHAn+JjnYh+IZERM7jL2eSki1W1UaKIFc9AAWI4cQ
	 ssoTbKAOIbAm/nD/JGsxXSaNbkthgHjZqx/uy8Ug88vXPZlsJs3m0IQT7ABl5b1xnG
	 wwYlqFMHejz4t1juJju0SAcmTJnkhxYNjwnQBVuA5fJuibWS2mCk3jkTiDdOYIovs1
	 2/TrHMJdqY4vw==
Message-ID: <816a3601-4ce1-47ef-8ef9-befc39c479c5@kernel.org>
Date: Wed, 26 Feb 2025 11:30:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: arm: add CIX P1 (SKY1) SoC
To: Peter Chen <peter.chen@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, cix-kernel-upstream@cixtech.com,
 marcin@juszkiewicz.com.pl, Fugang Duan <fugang.duan@cixtech.com>
References: <20250226012136.854614-1-peter.chen@cixtech.com>
 <20250226012136.854614-3-peter.chen@cixtech.com>
 <f89817fe-22af-460e-9f5c-a3347eba1892@kernel.org>
 <Z77MHGhUF6pPwLww@nchen-desktop>
 <d9556611-cfe7-44fa-8965-bc2b0f870845@kernel.org>
 <Z77sSg_3YC30oYoP@nchen-desktop>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z77sSg_3YC30oYoP@nchen-desktop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/02/2025 11:26, Peter Chen wrote:
> On 25-02-26 09:40:06, Krzysztof Kozlowski wrote:
>>>>
>>>> On 26/02/2025 02:21, Peter Chen wrote:
>>>>> Add device tree bindings for CIX P1 (Internal name sky1) Arm SoC,
>>>>> it consists several SoC models like CP8180, CD8180, etc.
>>>>>
>>>>> Acked-by: Fugang Duan <fugang.duan@cixtech.com>
>>>>> Signed-off-by: Peter Chen <peter.chen@cixtech.com>
>>>>> ---
>>>>
>>>> <form letter>
>>>> This is a friendly reminder during the review process.
>>>>
>>>> It looks like you received a tag and forgot to add it.
>>>>
>>>> If you do not know the process, here is a short explanation:
>>>> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions
>>>> of patchset, under or above your Signed-off-by tag, unless patch changed
>>>> significantly (e.g. new properties added to the DT bindings). Tag is
>>>> "received", when provided in a message replied to you on the mailing
>>>> list. Tools like b4 can help here. However, there's no need to repost
>>>> patches *only* to add the tags. The upstream maintainer will do that for
>>>> tags received on the version they apply.
>>>>
>>>> Please read:
>>>> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
>>>>
>>>> If a tag was not added on purpose, please state why and what changed.
>>>> </form letter>
>>>>
>>>
>>> I have checked the review-process again at:
>>> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=935897
>>
>> This does not matter - that's not a patchwork anyone uses...
>>
>>> It seems no one gives any Reviewed-by or Acked-by Tag.
>>
>> You were directly addressed! So you got email and what did you do with it?
>>
>> And lists received it:
>> https://lore.kernel.org/all/ac6c4a8b-a6bd-44a9-993b-3b743a172dcc@kernel.org/
>>
> 
> I am sorry about that. I checked this email with our IT engineers at
> office365 administration page, it was not received by Microsoft office365
> server, we don't know what's the reason.


That's the only email which did not reach you, I think. 4 or 5 others
did, so this could mean your system will spam/reject silently anything
with review tag (or email address).

If so, your corporate mail system is not suitable for upstream work
(Microsoft outlook is known of poor quality in that matter and that's
not the first case people have trouble with Outlook servers) and maybe
you should switch to b4-relay and other mail boxes.

> 
> I will put your Reviewed-by tag when sending v3 patch, may I get your
> Ack for the 1st patch:
> https://lore.kernel.org/linux-arm-kernel/330a01b7-7285-47fe-abb1-8d5fa71dd240@kernel.org/T/#u


I'll send it, but I still have doubts Microsoft won't put me in spam :/


Best regards,
Krzysztof

