Return-Path: <linux-kernel+bounces-254064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9884932D8E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 18:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 463DBB246D0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 16:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DDD19E7E2;
	Tue, 16 Jul 2024 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N4CqeFe8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597919AD51;
	Tue, 16 Jul 2024 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145995; cv=none; b=obCBbTzdNCZ5hjAVctCrWj6ZL0EatQ3FkjVHt+K4piDit3uLrs6Is+2TASJOZ0PBt2PCkrF8OBXvQrmQcs66+ELFa5sd/m5GNdiMj25RSY17/04zbzK9DkTfvTQLLe67QjuG+C/tlS19kjRDianYdrrH23aabX27Kk/8P5q4mxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145995; c=relaxed/simple;
	bh=gI21/Txq0/V8Mood/7WNX4+a8nWK19FWuXo1RHgcBlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glRjUtpvOTL/dC6h9nHk9f+9AbpKpiloikvLgTxS4HEVefkt0BFjsINtRWuKAxGLsrkp7fFbaK9OTYuePyr0gQOjqALuW7Zz3cSqYMc5zAw8l15gCcF1V3IZJqJ89sU3OWTXnjrJN2748enQDn3Zwgtxa5JhoXK2xXTNtQl6vT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N4CqeFe8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721145991;
	bh=gI21/Txq0/V8Mood/7WNX4+a8nWK19FWuXo1RHgcBlQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N4CqeFe8PNc3O+xfgpqGJQFUDEW+QKrrwmE1npMejRElOw2F71TZo63D/Z4iJ7Caj
	 qklrx7vdRHrdCwPtgmHeqiEYtDApNOGRZooDnolD1wrfNTnui/d68Q8am6HMse0SDb
	 J1+TMDsGtPuvLq4LL5fkNV9sZRduAwbYKqjI7GEGecd1FDvOuAL5+p2hMNdzTi0eNb
	 VxBpM1dipIovxmrsn8NK5nscLTmFHq7r+Ut8eiCN5wt9JbNKx+0IUO4A8xWgAvzvQ/
	 S9RAQ7XQPJRu7K/GyhgJKhS8axETw3pI5vgDaJl68aEFDxQVUIn+h/om7qBbXKAglg
	 obIuxqnflsjmA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 18C8237821CD;
	Tue, 16 Jul 2024 16:06:31 +0000 (UTC)
Message-ID: <a4fb5ab2-c11c-4761-82c0-76c01bcf65d6@collabora.com>
Date: Tue, 16 Jul 2024 18:06:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] arm64: dts: mediatek: mt8195-cherry: Remove
 keyboard-backlight node
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Tzung-Bi Shih <tzungbi@kernel.org>,
 kernel@collabora.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240715-cros-backlight-dt-probe-v1-1-0b5afe64c94b@collabora.com>
 <3dd2dcc9-5fbb-4384-985f-a61e26cc8a5f@collabora.com>
 <96f91c0a-e693-45db-a664-1c396b14999e@notapiano>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <96f91c0a-e693-45db-a664-1c396b14999e@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 16/07/24 14:16, Nícolas F. R. A. Prado ha scritto:
> On Tue, Jul 16, 2024 at 11:24:44AM +0200, AngeloGioacchino Del Regno wrote:
>> Il 15/07/24 18:09, Nícolas F. R. A. Prado ha scritto:
>>> Commit 970c3a6b7aa3 ("mfd: cros_ec: Register keyboard backlight
>>> subdevice") introduced support for detecting keyboard backlight
>>> fuctionality through communication with the ChromeOS EC. This means that
>>> the DT node is no longer used. Remove the unneeded node.
>>>
>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>> ---
>>> Different CrosEC FW versions could potentially not support discovering
>>> the keyboard backlight functionality, but I've tested both a recent
>>>
>>>     tomato_v2.0.23149-099cd3e539 tomato_15699.72.0 2024-01-03
>>>
>>> and an old
>>>
>>>     tomato_v2.0.10686-234e646fd8 tomato_14268.0.0 2021-10-07
>>>
>>> version on mt8195-cherry-tomato and on both relying only on the
>>> discoverability works. I've tested on both tomato-r2 and tomato-r3. I
>>> have not tested on dojo, however, as I don't have access to it.
>>>
>>
>> Dojo will work anyway because those machines do share the same base FW... but
>> anyway, I'm not sure that this is the right thing to do.
>>
>> The commit that you mentioned says that it is meant to make that "work on machines
>> without specific ACPI or OF support for the keyboard backlight", but not that the
>> intention is to stop using either ACPI nor DT nodes for that.
> 
> Yes, because as I understand it not every EC might support this protocol. So
> that commit just added an additional way to probe the keyboard backlight.
> 
> So we don't need to stop using the DT to probe it. But in practice we have
> already stopped, as long as the EC supports the protocol (which from my testing
> is always for these platforms), since that is tried first. Meaning the DT node
> is now useless.
> 
> The only point in keeping the DT node would be to use it as a fallback in case
> the discovery with the EC fails or breaks. But I have never seen a DT node be
> there just as fallback, so it doesn't feel right to me either.
> 
>>
>> The DT kselftest is relatively young, and I suspect that anyway this is not the
>> only affected device, so the justification is only barely valid.
> 
> I didn't include the failing test as part of the commit message proper as I
> don't think it should justify this change. I added it just to clarify my
> motivation. The test showed me that something unexpected was happening. After
> looking into it I thought that a DT node that is no longer used to probe has no
> point in staying around, so that's the justification that I added to the commit
> message.
> 
>>
>> Don't misunderstand me, I'm not saying that I'm not okay with this, but I'd like to
>> have more opinions about this.
>>
>> If we choose to go this way, ideally we should remove this from all of the upstream
>> Chromebook devicetrees (not only MediaTek, clearly!) so that would require a bit
>> more effort to test here and there.
> 
> Note that the cherry DT is the only DT upstream with the
> google,cros-kbd-led-backlight compatible. So it's really only tomato and dojo
> that need to be tested.
> 
Perfect. Let's remove it then, possibly with fire ;-)
Can you please send the patch without the RFC tag?

Also add my R-b, so that I'll remember that I've already checked that patch for
when I'll be able to pick it.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Cheers!

