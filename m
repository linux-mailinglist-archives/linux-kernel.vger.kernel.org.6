Return-Path: <linux-kernel+bounces-567497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32197A686F8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 09:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6729B19C673A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 08:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37652512F2;
	Wed, 19 Mar 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLBO0EVH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0350B1EB5F0;
	Wed, 19 Mar 2025 08:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373398; cv=none; b=mwLZrn1FpgGb0btByghji0YisdSnw1yv4WhNASt99GiCl+yDmfKcv7SPFw0Ep+sbpUYXid1bkBwjN4Maydmrj65NXbRR8dQwtG+uhd3Er/94M9AVFVbDXKA4RzBTQs/Zz3v4pqLyLKbZj6Wr9gATHJ7eJL6WEVFLrxtzbR04Irc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373398; c=relaxed/simple;
	bh=BdDVPT4azJbf932WZ7rfPtehzkFEwo7z+OMpncLjMh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDmaSEWFINK96rbu9rIGqkBkAO94qcmORxwCH1tFmu2wx2l4/hBG1YTtWq2HoSIXJUbAyq9j3Wjw0tDRv8u8/KQ/4B8Io7Nz+J2ReDONzw6DmhI+/2uYNFbJABajIYzBlY4tUy8jHcdwtfPyHcxrpRj969tC1te3igF63OQawo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLBO0EVH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BD7C4CEE9;
	Wed, 19 Mar 2025 08:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742373397;
	bh=BdDVPT4azJbf932WZ7rfPtehzkFEwo7z+OMpncLjMh0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iLBO0EVHsVkxgByDnLynd4n5DIXZumxYDhnkWn+ofIgM1QzAqQBPxzm4/dqNmOf/n
	 OHGCaP92JbyeUefi1rgyqJ00+2E3GLcRVWcnMAvQFuIzaKRUapOpqJRQcptaXw2E7m
	 wqQsnQpNhZh5bfo4jURJUI7VG3RypXPbQANJtv7ytKLUkXQLKlx1O251UBDj8jncl2
	 huUstqyGgREHjglmF4gTaMNiDge75FuTgcZ7fmW3xVy+JrjoH3sI4cKYW/K9xk5HCj
	 z/oP/w8w707gSukddE8Iqlj3tVk11iZqyxI6XDUoXuvllLplkdMBeGcpVHMZFE5aFL
	 oTvEdALTtwBTQ==
Message-ID: <ad9eecf5-5030-4446-8292-e90a9cabb5ae@kernel.org>
Date: Wed, 19 Mar 2025 09:36:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: dt-bindings: maxim,max98357a: Add compatible with
 richtek,rt9123
To: ChiYuan Huang <cy_huang@richtek.com>
Cc: Mark Brown <broonie@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Otto Lin <otto_lin@richtek.com>, Allen Lin <allen_lin@richtek.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1884c3ce2d901ead5d742958889f5a742e168376.1742259040.git.cy_huang@richtek.com>
 <20250318-mature-dogfish-of-ecstasy-3dcea5@krzk-bin>
 <Z9lYVram80dbWWl0@git-send.richtek.com>
 <68e4ce8b-68a9-47a4-88c6-a4a401f5196d@kernel.org>
 <Z9p+dQaMh4EKqss2@git-send.richtek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Z9p+dQaMh4EKqss2@git-send.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2025 09:21, ChiYuan Huang wrote:
> On Wed, Mar 19, 2025 at 08:42:11AM +0100, Krzysztof Kozlowski wrote:
>> On 18/03/2025 12:26, ChiYuan Huang wrote:
>>> On Tue, Mar 18, 2025 at 09:55:48AM +0100, Krzysztof Kozlowski wrote:
>>>> On Tue, Mar 18, 2025 at 08:57:51AM +0800, cy_huang@richtek.com wrote:
>>>>> From: ChiYuan Huang <cy_huang@richtek.com>
>>>>>
>>>>> The hardware control and specification of 'richtek,rt9123' are similar
>>>>> with max98357 or max98360. It's no need to add the new source code. So
>>>>
>>>> Are you sure? I looked at datasheet and do not see anything about
>>>> SD_MODE in RT9123. Also you have two supplies, while max98360a has only
>>>> one. You have I2C but max98360a has no.
>>>>
>>> Sure, consider the I2C mode. Then it seems different. For the power
>>> supply, yes, we have one more supply and it's used for digital input
>>> output reference. It will always tiled to SoC digital power domain.
>>> It's no need to control, so I think DVDD can be ignored.
>>>
>>> If not considering the I2C, and the DVDD power supply, for HW control
>>> mode, then it looks the same including sample rate. One pin to turn on
>>> the amplifier.
>>>
>>> This IC is designed for 'easy to use'. For the normal condition, HW mode
>>> will always be suggested to the customer.
>>>
>>> May I have your suggestion? If it can not be compatible, should I write
>>> two drivers, one platform driver for HW control mode, and another I2C driver
>>> for I2C SW control mode?
>>
>>
>> We don't talk about drivers here. I only commented that they are not
>> compatible based on datasheets, so compatibility should not be expressed
>> in the DT. Considering I2C, this should be in its own binding with full
>> device description (so for both HW mode and I2C).
>>
> Actually, These two mode cannot be coexixted. 

I did not claim that.

> The HW or SW I2C mode is
> detected on POR by different external resistor.

Not related to binding. Binding describes hardware and the chip does not
magically change its transistors based on external resistor, right?

> 
> Just for the HW mode, all the controls, even sampling rate, supported
> bitrate are all similiar with max98357 driver.
> 
> That's why I'm trying to treat it to be compatible.
> 
> For SW I2C, sure, I can write one for the dedicated usage. Under this
> mode, all onoff sequences need to be controlled by RG.

Did you read my first sentence? We do not talk about drivers. What do
you want to write? Driver?


Best regards,
Krzysztof

