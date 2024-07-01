Return-Path: <linux-kernel+bounces-235653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9B091D803
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4BD91C21DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 06:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A1A4D8C0;
	Mon,  1 Jul 2024 06:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PkhUfSK+"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394E59160;
	Mon,  1 Jul 2024 06:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719814606; cv=none; b=LLSpwS8BxY/9cfENZXFJfiVfXpaUdHzXuOSkYchNh1M6tg58xPYr8/ve7Pc946ICFkwu68JqHPyRbSylx42b3EsXEa9+omIgOpEQMlJ+03zxc2yf6rVpY5nnwFk+qJKG2IyEAuX5L9CluMY/n+UGEz7AsnINoWcJ4ac/9LHprik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719814606; c=relaxed/simple;
	bh=5miFg8Cm5ArCbMrcvQJy9y7rYZlHY79Uk7nIu2PM3a0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qCgej/OpxwLEF2AeGu3xz4quzbwtTrsBlIe6nsZCRb5wy6MmB1gQXqfPkjxu4EbBSqULmZQ1t3TLNow1PoMs90vi4qd4TP4KXtNRdqEfLX6o9dP78LvkNp4ItCqeFQM4NrYlPBRuKnA8pILlOevY2GaFYIaZBE1L5yJjDo7Ci0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PkhUfSK+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=fXyGQ5yDjGp7ZJaBVw0haYA/oXbMVh7sNoBQsxpRsYs=;
	t=1719814604; x=1720246604; b=PkhUfSK+IZwLbLNGo6RDxuacZFkQd0uI2rFDLN+9jNBHit8
	yjxfFvk6SXbiuJZCb788PLVMosdpnDgoOiu6daKS+aaMnPgovDFgTvmjIJKkT35WIflgnK7C9f6O0
	M3oPf5iuomyCRhbnouVNd+kGv8sWlqERVCvR/zbTWxQ3t4KPX2R2NEHkaaBOqcrk71E8FTPVnxF01
	TFbwIF9qQrNgidQKitdcFm2UD3RKdBZWOvU8lNt7t8ro9hpn/cMN25NFYlUZiOVz0p3HY6CyKrRcv
	DlkKbuLphtgzSYxnXgym6KFJvFXm4Dn5rQ8Wb5SMhMfPDYPMtE2nWCBulztur49A==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sOAL4-00045O-IX; Mon, 01 Jul 2024 08:16:34 +0200
Message-ID: <cebb10b8-b0bf-4cb7-bba4-c3f941ba2b82@leemhuis.info>
Date: Mon, 1 Jul 2024 08:16:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64
To: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Daniel Golle <daniel@makrotopia.org>, frank-w@public-files.de,
 Frank Wunderlich <linux@fw-web.de>, =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?=
 <arinc.unal@arinc9.com>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
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
 <9c498e37-df8b-469e-818a-9b1c9f2b1a3c@collabora.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <9c498e37-df8b-469e-818a-9b1c9f2b1a3c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1719814604;b653b989;
X-HE-SMSGID: 1sOAL4-00045O-IX

[CCing the other net maintainers]

On 25.06.24 10:51, AngeloGioacchino Del Regno wrote:
> Il 25/06/24 07:56, Linux regression tracking (Thorsten Leemhuis) ha
> scritto:
>> On 17.06.24 13:08, Arınç ÜNAL wrote:
>>> On 17/06/2024 11:33, Linux regression tracking (Thorsten Leemhuis)
>>> wrote:
>>> [...]
>> It looks more and more like we are stuck here (or was there progress and
>> I just missed it?) while the 6.10 final is slowly getting closer. Hence:
>>
>> AngeloGioacchino, should we ask the net maintainers to revert
>> 868ff5f4944aa9 ("net: dsa: mt7530-mdio: read PHY address of switch from
>> device tree") for now to resolve this regression? Reminder, there is
>> nothing wrong with that commit per se afaik, it just exposes a problem
>> that needs to be fixed first before it can be reapplied.
> 
> To be clear on this: I asked for the commit to be fixed such that it
> guarantees
> backwards compatibility with older device trees.
> 
> If no fix comes,

I haven't see any since that mail, did you? If not, I think...

> then I guess that we should ask them to revert this commit
> until a fix is available.

...it's time to ask them for the revert to resolve this for -rc7 (and
avoid a last minute revert), or what do you think?

> I don't like this situation, either, btw.

I guess none of us does. :-/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

