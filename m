Return-Path: <linux-kernel+bounces-228561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A639161A3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4F4B254FE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCCC148840;
	Tue, 25 Jun 2024 08:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="osA68c02"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8712A148836;
	Tue, 25 Jun 2024 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305363; cv=none; b=nPhLmjngGZHgZKbPURpNzgRqaDld3b6lh4RJ5o45KbupWko70wyMdqDGoPX7m/vgV4K636EF4CjjKgvYCitmQ0iqoD+6yT/3UkAjm2UbYuXrD4Q1mmSz0Th8loFiYr5P+8nnjNsHcvTpmVcoAGrFAyqCFN/wkdalM9qay6F5xy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305363; c=relaxed/simple;
	bh=jaMfjUSzmTt56GaotikfsNUu0t1/tVz87p+MxzGBY50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dVVT6uP8CPgUwYDDWUw/iijk9EOa8c9EJ+Tr4IGU7pZUSAFiLEDXl9iGzCpbyBQyiTpP8o7Iee91LacCZdzMcwCjkCia11CffNOVilAnIMxOCg5FkdYubAx8Y4hL5Z8wzTmRwNtDftuBRMAEuf2fBggH9XohhGPOFH40vie6ta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=osA68c02; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719305357;
	bh=jaMfjUSzmTt56GaotikfsNUu0t1/tVz87p+MxzGBY50=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=osA68c029o1snvbg8uaGgx3SdEFXZleM3P6TejYL0GGc3zJZKZkZfMPNAFfXy+wrW
	 DWf0YvSMU4qykWszIjEO1IZikI7SiLEJtXiViRfRjODGfgjW9L4eNMun33GdbzGMz+
	 Bm6SC4WLna+GEYg3c1QJzcrN5rGcN1JXDX2BVqbE3+VZpfPW76b1mK/fc9AE+Eoypq
	 bHyKLWXE3eQKc1iIi6hLfwCgpk5ujjtcnz9NhiohTf6URXPoRQTNcBSnkwIMcaIB/V
	 gT8eI2NLmEJ06t938s9m2xzYBPYka6FmBy1QaNZn/r8QU2AzTmCifELK3CnKIPMbcG
	 u5vFcIg0uHF3A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BB306378045F;
	Tue, 25 Jun 2024 08:49:16 +0000 (UTC)
Message-ID: <4647181b-e5a0-4f6e-9aba-1bcde763d678@collabora.com>
Date: Tue, 25 Jun 2024 10:49:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Paolo Abeni <pabeni@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20240516204847.171029-1-linux@fw-web.de>
 <43aacd9d-b851-4100-8ccc-878ac6ae10f8@leemhuis.info>
 <698cf562-1ca9-4aa3-be7e-a1474b612c5b@leemhuis.info>
 <0cba095c-3d55-416a-a7ad-b359129731cf@arinc9.com>
 <714da201-654b-4183-8e5e-8ff0b64fe621@leemhuis.info>
 <2cac4cf68304e81abffbd9ff0387ee100323c2b7.camel@redhat.com>
 <b49c801c-6628-40a6-8294-0876d8871ba7@leemhuis.info>
 <e92c3ca0-c9be-44ac-a4fc-57ca5ebedbc5@leemhuis.info>
 <1807a142-1534-4fa4-ad4b-d1c03af014c2@arinc9.com>
 <58d8ddea-71cc-427a-94cc-a95f6bce61d2@collabora.com>
 <16e9c06e-9908-455d-a387-614fefe5bcf8@arinc9.com>
 <5e87d31c-b059-4f9a-93f7-dc87465ed14a@collabora.com>
 <4416ef22-78cc-4ce5-b61d-69ff0903811e@arinc9.com>
 <bd6b6929-d34d-4bd5-9cb0-bc8fe850ee46@leemhuis.info>
 <af561268-9793-4b5d-aa0f-d09698fd6fb0@arinc9.com>
 <750a60a6-4585-4bd2-97be-cf944e51fbdb@leemhuis.info>
 <7a2ea06b-ae4e-4374-82c2-4de4184e06c3@arinc9.com>
 <40035548-c76b-4b0d-915f-c513eaadbc5d@leemhuis.info>
 <bb7e9cae-d627-4f38-9da2-b40fb3c349fe@arinc9.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <bb7e9cae-d627-4f38-9da2-b40fb3c349fe@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/06/24 10:17, Arınç ÜNAL ha scritto:
> On 25/06/2024 09.57, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 25.06.24 08:17, Arınç ÜNAL wrote:
>>> On 25/06/2024 08.56, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 17.06.24 13:08, Arınç ÜNAL wrote:
>>>>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis)
>>>>> wrote:
>>>>> [...]
>>>>> I've submitted a patch series that fixes the regression. Angelo argued
>>>>> against the way the regression is fixed. I've very clearly argued
>>>>> back why
>>>>> I find Angelo's approach wrong. There's been no response back. I don't
>>>>> understand why reverting the patch is the likely outcome
>>>>
>>>> Long story short: because that how things like that are handled in the
>>>> Linux kernel project, as Linus wants it like that. See some of the
>>>> quotes from https://docs.kernel.org/process/handling-regressions.html
>>>> for details.
>>>>
>>>>> whilst the
>>>>> standing argument points towards applying the said patch series. If a
>>>>> revert happens before this discussion with Angelo finalises, this
>>>>> will set
>>>>> a precedent that will tell maintainers that they can have their way
>>>>> by just
>>>>> not replying to the ongoing discussions.
>>>>>
>>>>> That said, the decision of resolving the regression by either
>>>>> reverting the
>>>>> patch or applying the patch series shall not depend on whether or not
>>>>> Angelo is pleased but rather there're no counter-arguments left on the
>>>>> points brought, meaning the decision shall be made depending on the
>>>>> argument that stands.
>>>>>
>>>>> Therefore, I suggest that unless Angelo responds back with a
>>>>> counter-argument in the window of a week or two, as you've described, my
>>>>> patch series shall be applied.
>>>>
>>>> It looks more and more like we are stuck here (or was there progress and
>>>> I just missed it?) while the 6.10 final is slowly getting closer. Hence:
>>>
>>> There hasn't been progress at all. I believe I have clearly described the
>>> way out of this issue.
>>>
>>>> AngeloGioacchino, should we ask the net maintainers to revert
>>>> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
>>>> device tree") for now to resolve this regression? Reminder, there is
>>>> nothing wrong with that commit per se afaik, it just exposes a problem
>>>> that needs to be fixed first before it can be reapplied.
>>>
>>> Are you suggesting the patch shall be reverted first, then the DT patch
>>> applied, then the reverted patch applied back?
>>
>> Yeah.
>>

Sorry, I've lost your reply in the long stack of emails that I get every day.

I'm not suggesting to revert the patch, but to fix it such that it does not
break devices using old devicetrees, as it was the case before.

Even though, in a way, when you update the kernel, you do also update the
devicetrees with it just because it's almost effortless to do so, doing that
is not mandatory.

...and that's why the driver, which was - in a way - faulty before, getting
the switch to work even though the devicetree node was wrong, must still be
compatible.

I do want to apply the devicetree fix, but I also do *not* want to see *driver*
changes that go against the backward compatibility rule of devicetree when this
is not strictly necessary (when it is - it's okay to make an exception)...

...and this is not one of the cases in which it's strictly necessary.

>>> If only one of the first two
>>> steps were done, it would fix the regression so I don't understand why go
>>> through this tedious process when we can quite simply apply the DT patch to
>>> resolve the regression.
>>
>> Which DT patch do you mean here? Your series or the one from Frank at
>> the start of the thread (the one you seems to be unhappy about iirc, but
>> I might be wrong there)?
> 
> My series, as arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts needs to be
> addressed too to resolve the regression.
> 
>>
>> Anyway, to answer the statement: because the maintainers that would have
>> to accept the DT patch to resolve the problem apparently are not happy
>> with it -- and nobody seems to be working on providing patches that make
>> them happy which are also acceptable at this point of the devel cycle;
>> so as it looks like currently to prevent the regression from entering
>> 6.10 reverting the net change is the only option left.
> 
> I've already made my case regarding the situation with the DT patch. I
> can't provide new patches because Angelo did not acknowledge my points yet.
> I maintain the net driver and I too won't be happy with a revert on the
> driver.
> 

And again, I wouldn't be happy to see a revert either; just fix it so that the
old devicetree still works with the driver code.

Regards,
Angelo


