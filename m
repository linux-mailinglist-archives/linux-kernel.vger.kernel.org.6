Return-Path: <linux-kernel+bounces-267185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91128940E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 11:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA1E5B2A39E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE8F196D8D;
	Tue, 30 Jul 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Uor3g7kK"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C31922C1;
	Tue, 30 Jul 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332505; cv=none; b=pH2t5Q9VnwiKspwgSFIyzhhnul5AMj+Z9ptDEgU1Oq6DhxdNi7BGEyJWduXvwtBmdTCfR023ikPFXpQG9ryllMrqzxkQf5Xq9Pd1NtHQZW8osT6jSos4OEutt2Hk94RaITb2hDAVt0HmRFv8PqadIMmjclVwOREF018WP49CwEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332505; c=relaxed/simple;
	bh=hgNqnU4Er33p+LqqcZgo595E37aXhaKnOBZSc3IoLZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZYgNdIDriPEbcGC3gBA5yzuQoeKFUmbZIN/paRyJM/CBcteJyFj/osPRKPOFr42rdgswe8S7zD2+nvsjIdPhA3jqGcE6o8744JJdz8kXFLdgr3zeRYQWQ0Z+t3qdS9PFAt8eoBh6aK2pdhDxXGAwFbK+aExhiBgAX3sr/FB8Iqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Uor3g7kK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722332502;
	bh=hgNqnU4Er33p+LqqcZgo595E37aXhaKnOBZSc3IoLZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Uor3g7kK6v9AlBioKHDcqkhdlnieTcyYn3qckI4rk6+5sXc81Gz2+lksR4tytnMY2
	 uXWTq4OLNv6r46AZt7vDdXrhM33klHA7KuauybDtyJIs5UwM1RpUn8q+tfDf01L+D/
	 TSlIl7gUmyZOej7bei8TpGrCWTUxAxkpFLxjrBh4Asr8v5On4cesJaIIX8d6d5/kvq
	 Gvo18xarfxaF53LYuv5+HcOkCsMpHt8qYmPLw8MhYAZY3DI0BJPu50QMdLzzHwWQKm
	 6M0GHl/uCrZ5vUjw2w0Jv8ZgEtbfluOpr01A9sItS5rn5+UZ3k5uM9Ik+Zz41gTUi4
	 Wh3nS5xL7dsdA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 13D4E37821ED;
	Tue, 30 Jul 2024 09:41:41 +0000 (UTC)
Message-ID: <b3fa66cc-516b-4d78-aee5-62a47b52a3b1@collabora.com>
Date: Tue, 30 Jul 2024 11:41:40 +0200
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
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20240516204847.171029-1-linux@fw-web.de>
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
 <9c498e37-df8b-469e-818a-9b1c9f2b1a3c@collabora.com>
 <cebb10b8-b0bf-4cb7-bba4-c3f941ba2b82@leemhuis.info>
 <1aedb1d4-8dc3-4e17-aff1-7cc417465967@arinc9.com>
 <130518e2-d6dd-49ed-9cc2-ca9cdec93b98@leemhuis.info>
 <aeb255ff-3755-4f76-a8f8-cda27a67f818@arinc9.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <aeb255ff-3755-4f76-a8f8-cda27a67f818@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/07/24 10:15, Arınç ÜNAL ha scritto:
> On 01/07/2024 11:04, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 01.07.24 09:44, Arınç ÜNAL wrote:
>>> On 01/07/2024 09:16, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> [CCing the other net maintainers]
>>>>
>>>> On 25.06.24 10:51, AngeloGioacchino Del Regno wrote:
>>>>> Il 25/06/24 07:56, Linux regression tracking (Thorsten Leemhuis) ha
>>>>> scritto:
>>>>>> On 17.06.24 13:08, Arınç ÜNAL wrote:
>>>>>>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis)
>>>>>>> wrote:
>>>>>>> [...]
>>>>>> It looks more and more like we are stuck here (or was there progress
>>>>>> and
>>>>>> I just missed it?) while the 6.10 final is slowly getting closer.
>>>>>> Hence:
>>>>>>
>>>>>> AngeloGioacchino, should we ask the net maintainers to revert
>>>>>> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
>>>>>> device tree") for now to resolve this regression? Reminder, there is
>>>>>> nothing wrong with that commit per se afaik, it just exposes a problem
>>>>>> that needs to be fixed first before it can be reapplied.
>>>>>
>>>>> To be clear on this: I asked for the commit to be fixed such that it
>>>>> guarantees
>>>>> backwards compatibility with older device trees.
>>>>>
>>>>> If no fix comes,
>>>>
>>>> I haven't see any since that mail, did you? If not, I think...
>>>>
>>>>> then I guess that we should ask them to revert this commit
>>>>> until a fix is available.
>>>>
>>>> ...it's time to ask them for the revert to resolve this for -rc7 (and
>>>> avoid a last minute revert), or what do you think?
>>>
>>> This is quite frustrating. I absolutely won't consent to a revert. [...]
>>
>> Reminder: try to not see a revert as a bad thing. It's just means "not
>> ready yet, revert and we'll try again later" -- that's actually
>> something Linus wrote just a few hours ago:
>> https://lore.kernel.org/lkml/CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com/
> 
> Except it is ready and trying again is my responsibility, which means
> unnecessary work for me to do. I've already got a ton of things to do.
> Applying the device tree patch resolves this regression; no reverts needed.
> And then there's the patch in the works by Daniel that will address all the
> remaining cases outside of the reported regression.
> 

The commit that fixes your breakage in a way that does *not* please me
(because of older devicetrees being still broken with the new driver) was
picked and it is in v6.11-rc1.

I had to do this because I value the community (in this case, the users) much
more than trying to make an arrogant developer to act in a community-friendly
manner while leaving things completely broken.

That said, remembering that we're humans and, as such, it's normal to get something
wrong during the development process, I want to remind you that:

  1. A series that creates regressions is *not* good and *not* ready to be
     upstreamed; and
  2. As a maintainer, you have the responsibility of not breaking the kernel,
     not breaking devices and not breaking currently working functionality; and
  3. Devicetrees being wrong (but working) since day 0 is not an excuse to break
     functionality; and
  4. Blaming the one who introduced the devicetree (you're doing that, since you
     are blaming the devicetree being wrong) isn't solving anything and will not
     magically make your code acceptable or good; and
  5. If you push a wrong commit, there's nothing to be ashamed of; and
  6. If you make a mistake, you should recognize that and find a way to
     make things right, that should be done for the community, not for
     yourself; and
  7. You shall respect the community: in this case, with your arrogant behavior
     you did *not* respect the users.

P.S.: The right way of making such change is to:
       1. Avoid breaking currently working devices by making sure that their DT
          still works with the new driver; and
       2. If breakage is unavoidable, make it so one kernel version has a fix that
          works with both old and new driver, and the next version introduces the
          breakage. N.2 should ideally never happen, anyway.

Let's wrap up this matter now - I don't want to spend any more word, nor time,
on this, as I really have nothing else to say.

Best regards,
Angelo

