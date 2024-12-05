Return-Path: <linux-kernel+bounces-432932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317E79E5206
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0331A165F23
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073DE1D5CE3;
	Thu,  5 Dec 2024 10:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Behr+Tt3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490B45FEE4;
	Thu,  5 Dec 2024 10:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733394124; cv=none; b=nWhMNq2gulK1PyISMssFd3fqVk/O0nJ0ybQ6Pfh/47iobO/LYC+T5M70w88R1kv5arQrLgASravjATDRLLygx8qDVLo8+WGkWEmkf8nYyFdSgL8HpFOFl2Bu+ComehXqkvbdasFp2Ja+BYjJYVnFa4UXmI6wYFddBE8sL6fONu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733394124; c=relaxed/simple;
	bh=a2ZIc4bdklL+bcmW647CCfd3d+E4Lc6e6OjH4iLjio0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ujrXKkV/+Vzd8u2sP3pjX/fYuqPrCc39jX3ZuTq3CeGHVXsmuhxyz8TPOFPkYHQF5rsX4AArC5ubdV3epi7MiRVoEFdPRcXaPzgpCr5gtZhJ9Z7nvbHWBo7lw4iK7CyGH7qcQZMeEBFg4az2G6g8fsgCXB97zFnTW0546H+tGuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Behr+Tt3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50C2C4CED6;
	Thu,  5 Dec 2024 10:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733394123;
	bh=a2ZIc4bdklL+bcmW647CCfd3d+E4Lc6e6OjH4iLjio0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Behr+Tt37tGOxDtF+fmYHIhH5+rRxUp6rpWIwNldJS2/Acd2nkU17wNIGY5fxnJ6e
	 vPVnHcmdNMkrF6wMM3ZWw42erTG1Xg9au+O+EpKXneWHjm7JBaOv0Uel1B3tUIl/n8
	 V4ldM/DAbVq2iHFqP8g+Zs8jCfnsyXx+X4qTzRcumNwGYdsVWfVyWsEAXS7M0M4OVb
	 YCWA8SZ+kLd5ZLdloQlhH1wi+Qqm+nlNjQGrrm1dCfSfVrehv5Y2xUwt/ZYm6Wgk0t
	 ExEiTI/0ZI57hW0OHrDbzRUV843S7U4UOjYKn7b8Ve1KKE/c5R36bHyLyUYoYbha6d
	 OQ+91kTvpvdKA==
Message-ID: <3b448717-b6ec-498b-bb0d-5f2e2a4fc528@kernel.org>
Date: Thu, 5 Dec 2024 11:21:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: sprd: Remove unused and undocumented
 "constant_charge_voltage_max_microvolt" property
To: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Stanislav Jakubek <stano.jakubek@gmail.com>, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, orsonzhai@gmail.com,
 Cixi Geng <cixi.geng@linux.dev>, Arnd Bergmann <arnd@arndb.de>
References: <Zz3SnIiW_iu10rrs@standask-GA-A55M-S2HP>
 <a31e5b41-d495-4b5e-996d-1cb0a1f6929f@linux.alibaba.com>
 <afffd5e3-19e9-49a6-8854-039be1128922@kernel.org>
 <CAAfSe-uHuoBBKkSU-pDaNVYNCrfgqjh07gX7jS6uvO3AQF7b-g@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAAfSe-uHuoBBKkSU-pDaNVYNCrfgqjh07gX7jS6uvO3AQF7b-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/11/2024 04:04, Chunyan Zhang wrote:
> Hi Krzysztof,
> 
> On Wed, 20 Nov 2024 at 22:25, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 20/11/2024 13:27, Baolin Wang wrote:
>>>
>>>
>>> On 2024/11/20 20:14, Stanislav Jakubek wrote:
>>>> Hi Rob,
>>>>
>>>> constant-charge-voltage-max-microvolt is a valid property, which I assume
>>>> was the original intention here. I've already submitted a patch changing this
>>>> to the documented property:
>>>>
>>>> https://lore.kernel.org/lkml/aa557091d9494fdaa3eda75803f9ea97014c8832.1730918663.git.stano.jakubek@gmail.com/
>>>>
>>>> Baolin also reviewed that patch... make of that what you will.
>>>
>>> Ah, yes. Sorry I forgot your patch. Thanks for reminding.
>>
>> No one picked them up... I kept Stanislav's patches in my incoming/inbox
>> folder for quite long time, because I pick up some random fixes here and
>> there, but then forgot them and did not apply for v6.13-rc1. So they
>> missed v6.13-rc1.
>>
>> I am not the maintainer of that platform, so I don't care about it
>> really, but I care about contributors work not being lost/ignored.
>>
>> What is the plan with these and all other Spreadtrum patches? Are they
>> going to be applied by you or other Spreadtrum maintainers? Do you need
>> any help from us? Or maybe some clarifications of the process?
> 
> Yes we need your help!
> 
> The Spreadtrum DTS patches had been being maintained through my tree.
> I'm not suitable to do this any more due to some changes (I've moved
> myself to the reviewer entry of sprd).
> 
> After discussion with other sprd maintainers, we still want the
> Spreadtrum patches to go through your tree if you agree.

+Cc Arnd,

With few folks we talked briefly on IRC, but that probably missed some
audience. I was indeed taking orphaned fixes, not only for Spreadtrum
but also other trees, but that's different than maintaining. I don't
feel comfortable taking any features or making any maintenance decisions
about Spreadtrum, so I should not be listed in MAINTAINERS file. If I am
not listed there, it is likely I will miss patches, so me picking up
fixes here solves current issue, but does not really solve the problem
long term.

If there is no one willing to handle patches for Spreadtrum, maybe the
platform's status should be changed from Maintained to "Odd Fixes"?

Best regards,
Krzysztof

