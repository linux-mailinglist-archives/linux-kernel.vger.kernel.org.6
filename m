Return-Path: <linux-kernel+bounces-228564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7699161AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 091F91C2367D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70058148850;
	Tue, 25 Jun 2024 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="S2JST7Gt"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590591474A0;
	Tue, 25 Jun 2024 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719305495; cv=none; b=R0iVpYtgS0NgqmhhdjExNwTz/Q4pcpsoT3NmyWg2oFiI+pFKVBvo33PDrkp/VfZMmJ6juCp34Lz0hlvUUM/ilQun/buky4RKxFj5v3yqT9Z7LoZn7cmuygpfJOSzgmmPIuNieIX171mMRrZ9OvSmfk7lFstBL65mOoa3vhLdGZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719305495; c=relaxed/simple;
	bh=J7W6jQQOq6oMCiMWpafdMRKX7RlHQIMkt8NcZBcjKOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuESg7BWMno+4rTp7xKkjKkfMdNLASpSduIDNpSEb0a9viV23qk7Z5EpebdgR+RlMDZdTiSuGgQvkCWK9n18OOd0H3bH43cxVLKm/Jv9ZDEKzyoiV+lv3F38csndGt53r5HLN6lHTjZAhFsnqH6iWu2VLz1piWPBa8c0RLkkLb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=S2JST7Gt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719305492;
	bh=J7W6jQQOq6oMCiMWpafdMRKX7RlHQIMkt8NcZBcjKOk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S2JST7Gtm+r4PcCve+QDN4GXwgH8RYiAG870eilIPav2n3x4SlVt+Lm1R+3ADFdTb
	 iSOhePfe6weu4x/WNfuo8HTjZA7EeP9PMNW9IGckoUJRWp+jksOOHjfmxD+raBBPi9
	 MaEhWi5sXVg+XKrtY5rPBKlkPPx43SSP5rx1xBvte8IjgZvBoo+5gk31oQol8rBhyq
	 lgjc6Em6c+7ARiHDEUxwSRtwk/3DFxJgikGbpaj9hb/XHBchFMCKRmZ7E/Orp6Y/y4
	 R94oswSbt3e8dBu7W5ybEe+Eq09WnWs5TRrlKHOFhQ/IUV35i82dPGiPza0aMJkBHr
	 /9pH1mbAdHrzw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A6353378045F;
	Tue, 25 Jun 2024 08:51:31 +0000 (UTC)
Message-ID: <9c498e37-df8b-469e-818a-9b1c9f2b1a3c@collabora.com>
Date: Tue, 25 Jun 2024 10:51:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Paolo Abeni <pabeni@redhat.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 Frank Wunderlich <linux@fw-web.de>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Rob Herring <robh@kernel.org>,
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
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <750a60a6-4585-4bd2-97be-cf944e51fbdb@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 25/06/24 07:56, Linux regression tracking (Thorsten Leemhuis) ha scritto:
> On 17.06.24 13:08, Arınç ÜNAL wrote:
>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [...]
>> I've submitted a patch series that fixes the regression. Angelo argued
>> against the way the regression is fixed. I've very clearly argued back why
>> I find Angelo's approach wrong. There's been no response back. I don't
>> understand why reverting the patch is the likely outcome
> 
> Long story short: because that how things like that are handled in the
> Linux kernel project, as Linus wants it like that. See some of the
> quotes from https://docs.kernel.org/process/handling-regressions.html
> for details.
> 
>> whilst the
>> standing argument points towards applying the said patch series. If a
>> revert happens before this discussion with Angelo finalises, this will set
>> a precedent that will tell maintainers that they can have their way by just
>> not replying to the ongoing discussions.
>>
>> That said, the decision of resolving the regression by either reverting the
>> patch or applying the patch series shall not depend on whether or not
>> Angelo is pleased but rather there're no counter-arguments left on the
>> points brought, meaning the decision shall be made depending on the
>> argument that stands.
>>
>> Therefore, I suggest that unless Angelo responds back with a
>> counter-argument in the window of a week or two, as you've described, my
>> patch series shall be applied.
> 
> It looks more and more like we are stuck here (or was there progress and
> I just missed it?) while the 6.10 final is slowly getting closer. Hence:
> 
> AngeloGioacchino, should we ask the net maintainers to revert
> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
> device tree") for now to resolve this regression? Reminder, there is
> nothing wrong with that commit per se afaik, it just exposes a problem
> that needs to be fixed first before it can be reapplied.
> 

To be clear on this: I asked for the commit to be fixed such that it guarantees
backwards compatibility with older device trees.

If no fix comes, then I guess that we should ask them to revert this commit
until a fix is available.

I don't like this situation, either, btw.

Ciao!
Angelo

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke


