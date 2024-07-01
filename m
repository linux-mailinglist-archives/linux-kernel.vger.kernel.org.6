Return-Path: <linux-kernel+bounces-235786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D37391D99F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED22A28510D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34E081AB6;
	Mon,  1 Jul 2024 08:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="gjc2k6zc"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6EA61674;
	Mon,  1 Jul 2024 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821072; cv=none; b=UzokREN6i2RkNMq0xFu7MOk11hBJd8FRThKR75dr3WCmUnroRL90KojBS7TwjFbhI5R8C0VRSsdT3hF4lZzCEKVUBvG3KVziM2BKIMrWwljhABi+UtfLkJCU8NI3BUnz+nT+0fR/HQhXr2RkPrAl3SA7rJdUVNQkwpg2jo17rTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821072; c=relaxed/simple;
	bh=Sm87+MqQP6spLgCMYnAlIdJb/hFhBSlOaGQ6P6PPV9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q39CVJst5KD3VfxAm8HrKhPHpR7JEqqGuo66vOThqfiE1rmOcIDSEqA0coSDNWKYSc7TgJ1kygONGnsb0YrizcZILjK+iW66PEIpTXCHILRmn3/6cV9yttpV4+JzVdHpPm70rcO23nN1NM65XeYOECgN8fjF4Wz7CwRT/dxsLRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=gjc2k6zc; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=9/YONfSef0lT8ancw7u9V6qp8JgxuwwsqGvaUVaveMI=;
	t=1719821070; x=1720253070; b=gjc2k6zclXmv8/lNrDLRWp0f6QV+NBUpeVrgYFlz2Ry+DmL
	ktCVEBFUSG+HKFXj/azTX1JVtB9MbEhlvl4iibahxjm55u04OYcxOR0yT2ZU4kelbgiiD9IraMF15
	pfB9oxYjiEMuJNv/lNNZBqTqFtJpOUCEzmq8SaT2ynsBGvanmfiYJm6BD548SSE5hidzKuBMGfFVm
	83LBImVx2c4wi22gPm2WUp1DZHEU8Vx/aNXvwIbcZ4RLnMAqkF7YCEC3+dI+pn/S9yrPFqHYHOfGT
	gZjt1s3rMaVpt2jK7sXyPQQiWcdMnGLYksGisXTRvBc0V3yok8pAxv85Q31wPRhw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sOC1O-0000IS-6b; Mon, 01 Jul 2024 10:04:22 +0200
Message-ID: <130518e2-d6dd-49ed-9cc2-ca9cdec93b98@leemhuis.info>
Date: Mon, 1 Jul 2024 10:04:21 +0200
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
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jakub Kicinski <kuba@kernel.org>
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
 <9c498e37-df8b-469e-818a-9b1c9f2b1a3c@collabora.com>
 <cebb10b8-b0bf-4cb7-bba4-c3f941ba2b82@leemhuis.info>
 <1aedb1d4-8dc3-4e17-aff1-7cc417465967@arinc9.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <1aedb1d4-8dc3-4e17-aff1-7cc417465967@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719821070;5ecf728d;
X-HE-SMSGID: 1sOC1O-0000IS-6b

On 01.07.24 09:44, Arınç ÜNAL wrote:
> On 01/07/2024 09:16, Linux regression tracking (Thorsten Leemhuis) wrote:
>> [CCing the other net maintainers]
>>
>> On 25.06.24 10:51, AngeloGioacchino Del Regno wrote:
>>> Il 25/06/24 07:56, Linux regression tracking (Thorsten Leemhuis) ha
>>> scritto:
>>>> On 17.06.24 13:08, Arınç ÜNAL wrote:
>>>>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis)
>>>>> wrote:
>>>>> [...]
>>>> It looks more and more like we are stuck here (or was there progress
>>>> and
>>>> I just missed it?) while the 6.10 final is slowly getting closer.
>>>> Hence:
>>>>
>>>> AngeloGioacchino, should we ask the net maintainers to revert
>>>> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
>>>> device tree") for now to resolve this regression? Reminder, there is
>>>> nothing wrong with that commit per se afaik, it just exposes a problem
>>>> that needs to be fixed first before it can be reapplied.
>>>
>>> To be clear on this: I asked for the commit to be fixed such that it
>>> guarantees
>>> backwards compatibility with older device trees.
>>>
>>> If no fix comes,
>>
>> I haven't see any since that mail, did you? If not, I think...
>>
>>> then I guess that we should ask them to revert this commit
>>> until a fix is available.
>>
>> ...it's time to ask them for the revert to resolve this for -rc7 (and
>> avoid a last minute revert), or what do you think?
> 
> This is quite frustrating. I absolutely won't consent to a revert. [...]

Reminder: try to not see a revert as a bad thing. It's just means "not
ready yet, revert and we'll try again later" -- that's actually
something Linus wrote just a few hours ago:
https://lore.kernel.org/lkml/CAHk-=wgQMOscLeeA3QXOs97xOz_CTxdqJjpC20tJ-7bUdHWtSA@mail.gmail.com/

Ciao, Thorsten

