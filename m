Return-Path: <linux-kernel+bounces-192447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339588D1D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E60372829C8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E82B16C879;
	Tue, 28 May 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJGitwkN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29071DFEB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904082; cv=none; b=ck56aeank6TUPKm1PnXUqm6kjYa9Xi6zrYt5rbUbaZqiyt2ncvyHvZS94sBajK9hjbl6KodKh367H7Ur6Gz6Yv78p7wqA397WSakq/cMspseAQvE2c9a7kPqT2QZMVcnO5jpjwZBcQdY0q4MAAmfvjwTQSKIwOHG6iu3w10TuJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904082; c=relaxed/simple;
	bh=I5QCYdEFcv7RlobsjH6ZfbNpvtHXvU/zeLRLW9dDO5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfgWeoRLY9MCNgSpWOfzedqx/17uFWQAl0iOpQWyqty0jElcrpKTTIjC0dkftNqrpyuTRNJfZZcH5BTbMUDzUEKnNp73+E4fgRvAFVx/dv2SBuEjm4JvQjwjx0UQGCpzLeqB6eo7s2t0Mtop3XfvsLhHn2+YKHeq3Qm+dfMmn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJGitwkN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713EDC3277B;
	Tue, 28 May 2024 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716904082;
	bh=I5QCYdEFcv7RlobsjH6ZfbNpvtHXvU/zeLRLW9dDO5A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NJGitwkNCge4f1+ZFigpQ95yS9L2Yyej7/EyDxHQBs+CD0edLzFzsyk0mwjsXjlaX
	 RIcWcOofAuxtfQOQuYLBw+jKMKaxH36OlTatoIHjwbHxCxcTT8dLEpbjcQP/+nIL3U
	 0+sT60WNH5QR0MehfSnWhi2ULHXgJlOhsS3w7id0kkQmlizYu+r27kSgvkpJcdM1Hz
	 IQOHd1hAXdoPDRC+V7fYbsG30RXA+3Z+fv7HpW1t5Ao90Vx/a6RhlP29G3eeDFeK/t
	 kaP8hfXD/8PpTflZ1+4biyo1orcW4E6EQrlOCwPoNOErgkMRot99ksIBYMC/FpUA+G
	 k6pDenvEKrAhw==
Message-ID: <b21fa5e9-f8a7-4963-88e5-16204dc2c997@kernel.org>
Date: Tue, 28 May 2024 15:47:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] powerpc/configs: Update defconfig with now
 user-visible CONFIG_FSL_IFC
To: Esben Haabendal <esben@geanix.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
References: <20240528-fsl-ifc-config-v2-0-5fd7be76650d@geanix.com>
 <20240528-fsl-ifc-config-v2-2-5fd7be76650d@geanix.com>
 <096662e8-03cf-4c13-baa0-11918cab7511@kernel.org> <87le3ukqnj.fsf@geanix.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <87le3ukqnj.fsf@geanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/05/2024 15:33, Esben Haabendal wrote:
> Krzysztof Kozlowski <krzk@kernel.org> writes:
> 
>> On 28/05/2024 14:28, Esben Haabendal wrote:
>>> With CONFIG_FSL_IFC now being user-visible, and thus changed from a select
>>> to depends in CONFIG_MTD_NAND_FSL_IFC, the dependencies needs to be
>>> selected in config snippets.
>>>
>>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>>> ---
>>>  arch/powerpc/configs/85xx-hw.config | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
>>> index 524db76f47b7..8aff83217397 100644
>>> --- a/arch/powerpc/configs/85xx-hw.config
>>> +++ b/arch/powerpc/configs/85xx-hw.config
>>> @@ -24,6 +24,7 @@ CONFIG_FS_ENET=y
>>>  CONFIG_FSL_CORENET_CF=y
>>>  CONFIG_FSL_DMA=y
>>>  CONFIG_FSL_HV_MANAGER=y
>>> +CONFIG_FSL_IFC=y
>>
>> Does not look like placed according to config order.
> 
> Correct.
> 
>> This is not alphabetically sorted, but as Kconfig creates it (make
>> savedefconfig).
> 
> Are you sure about this?
> 
> It looks very much alphabetically sorted, with only two "errors"

Uh, ok, in general this is savedefconfig-sorted, but of course some
platforms can choose other way. At least all arm and arm64 are
savedefconfig-sorted.

Follow whatever is there already, so in this case alphabetical.

..

> 
>>>  CONFIG_FSL_PQ_MDIO=y
>>>  CONFIG_FSL_RIO=y
>>
>> You also missed to update second defconfig - arm64.
> 
> Argh. I thought I checked, and it did not need any changes. But it needs
> to have CONFIG_FSL_IFC=y added.
> 
> I will add that for v3.
> 
> /Esben

Best regards,
Krzysztof


