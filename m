Return-Path: <linux-kernel+bounces-228388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F1F915F2C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:58:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9784F1F22CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 06:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2321465A4;
	Tue, 25 Jun 2024 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="IF+kpJjP"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB11459E5;
	Tue, 25 Jun 2024 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298662; cv=none; b=pwQjSlDNJFsvb6oVZjUm6WN9ep9HRLNk2OZa507IL2nQjlxLocVjAzw/zCXQRVxDMRtaS0A2ofdnjbf8mExs5nMu1mMABuvUMqI6BjntWJhi84WEM1WaBlLbT34StP83uK1d+WCiPah5hwZcJvw27IKknnf6ARBaYACYooOrzFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298662; c=relaxed/simple;
	bh=bKPQsRHcbrOe9VWJG0E8XcG0bXIKSNlO9mTQ1r8Yml0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVpgJy5KPlsZuBOos+Oa7EKnmC3IBzeX5Cj2f8x4speg2H0JOVUGI3IDpdhEEtcOgXOM/ghs6ePpuRYe2YIcuMgzMd3bEHx0N53P2OZ6Q5J7eSOuTH4Nk1jalw4gW8mwLAD0wWvx+cEP/wCa/VFAnBgz9BdHUBI2zxo7ZM8M10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=IF+kpJjP; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=kUl7QT2T3KPC925+9jNg+6Y6AiMpD0H7o74v93B+d+4=;
	t=1719298660; x=1719730660; b=IF+kpJjPXpN4ufRistGLzEEwebkTy1G1d2poZ+2XjbJuBvM
	QVZd7trglkJIq4Dt42/6mVdAvOCWx3yfo9bKVDcV0HOzss8YpZDzH3RLQj1NeHhzwOt5tXe7i+9Wk
	9RBRMeZyL0oPURpUTHo3/GwBADqYar1PlcmjceegPBIVRxweyjKpmgMhZrZnEeWgQ1rfQNbuvXRwJ
	E9KG1bbW8LbrOrf9KQoakYxMyhRxu7PYsxsPMlblGuv1GB0JFpfU8hOwm3VN9IozRxd3SWGTZt3IP
	9/NW8l0H5vxW1WZX0txyGew6fZNLK3R4bu/osww4/zwhnwHVKQlFPpVa8INUhlDw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sM07Q-0005O4-C2; Tue, 25 Jun 2024 08:57:32 +0200
Message-ID: <40035548-c76b-4b0d-915f-c513eaadbc5d@leemhuis.info>
Date: Tue, 25 Jun 2024 08:57:31 +0200
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
 Paolo Abeni <pabeni@redhat.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20240516204847.171029-1-linux@fw-web.de>
 <a29dd7d1-40a8-4c88-99aa-651a3305b640@arinc9.com>
 <5AEE5668-0C8E-4EE4-A398-66CB99DF5650@public-files.de>
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
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <7a2ea06b-ae4e-4374-82c2-4de4184e06c3@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719298660;454567c6;
X-HE-SMSGID: 1sM07Q-0005O4-C2

On 25.06.24 08:17, Arınç ÜNAL wrote:
> On 25/06/2024 08.56, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 17.06.24 13:08, Arınç ÜNAL wrote:
>>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis)
>>> wrote:
>>> [...]
>>> I've submitted a patch series that fixes the regression. Angelo argued
>>> against the way the regression is fixed. I've very clearly argued
>>> back why
>>> I find Angelo's approach wrong. There's been no response back. I don't
>>> understand why reverting the patch is the likely outcome
>>
>> Long story short: because that how things like that are handled in the
>> Linux kernel project, as Linus wants it like that. See some of the
>> quotes from https://docs.kernel.org/process/handling-regressions.html
>> for details.
>>
>>> whilst the
>>> standing argument points towards applying the said patch series. If a
>>> revert happens before this discussion with Angelo finalises, this
>>> will set
>>> a precedent that will tell maintainers that they can have their way
>>> by just
>>> not replying to the ongoing discussions.
>>>
>>> That said, the decision of resolving the regression by either
>>> reverting the
>>> patch or applying the patch series shall not depend on whether or not
>>> Angelo is pleased but rather there're no counter-arguments left on the
>>> points brought, meaning the decision shall be made depending on the
>>> argument that stands.
>>>
>>> Therefore, I suggest that unless Angelo responds back with a
>>> counter-argument in the window of a week or two, as you've described, my
>>> patch series shall be applied.
>>
>> It looks more and more like we are stuck here (or was there progress and
>> I just missed it?) while the 6.10 final is slowly getting closer. Hence:
> 
> There hasn't been progress at all. I believe I have clearly described the
> way out of this issue.
> 
>> AngeloGioacchino, should we ask the net maintainers to revert
>> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
>> device tree") for now to resolve this regression? Reminder, there is
>> nothing wrong with that commit per se afaik, it just exposes a problem
>> that needs to be fixed first before it can be reapplied.
> 
> Are you suggesting the patch shall be reverted first, then the DT patch
> applied, then the reverted patch applied back?

Yeah.

> If only one of the first two
> steps were done, it would fix the regression so I don't understand why go
> through this tedious process when we can quite simply apply the DT patch to
> resolve the regression.

Which DT patch do you mean here? Your series or the one from Frank at
the start of the thread (the one you seems to be unhappy about iirc, but
I might be wrong there)?

Anyway, to answer the statement: because the maintainers that would have
to accept the DT patch to resolve the problem apparently are not happy
with it -- and nobody seems to be working on providing patches that make
them happy which are also acceptable at this point of the devel cycle;
so as it looks like currently to prevent the regression from entering
6.10 reverting the net change is the only option left.

> Keep in mind that I maintain the MT7530 DSA subdriver and the company I
> work with has got boards that uses the functionality the commit
> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
> device tree") brings.

Don't see a revert as setback at all, that's just normal for the kernel.
I'm not the one that will decide about this anyway. And everyone
involved afaics would like to prevent a revert. But it seems more and
more likely that we are not getting there in time for the 6.10 release
(or ideally -rc6 or -rc7 to allow some testing, as last-minute reverts
can cause new problems).

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

