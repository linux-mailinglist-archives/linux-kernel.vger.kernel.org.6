Return-Path: <linux-kernel+bounces-279262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC5E94BB0E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 12:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F2E71C21DA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 10:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D3A18A6DB;
	Thu,  8 Aug 2024 10:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b="i205RKxT"
Received: from mail.flokli.de (mail.flokli.de [116.203.226.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15646146584;
	Thu,  8 Aug 2024 10:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.226.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723113104; cv=none; b=iZwUgmHc48n0WdrX7BL74vygrTGljZRGx3nN4e1M7ltJE2SQD6EiqdOEFgs/W4KC/8KmyqWCRbob1+adG58pHWIgfV8hGi7OdCr4fFv+jl3YdK9iUsSpN8R9Jd73/rscY1f3ThOXjnvh/zrAKVohI6sxrBkMPTBQZwl3db3kZQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723113104; c=relaxed/simple;
	bh=1diQP0QbSi5Jld7PuoM6ZJFf+WRHuMBZZY/mv3hPKqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttTsilm7cXpmN3mqryLp4CgxQttoKtTvfNNhJM7KEuLjCvE74Yx7B4E3BiF3ZAQWiJGOkxFdawjtlFJR7OsOTYtGie1tNrmgO4f7WR4I5Q8AWh5oiwPvR5QwkWdaaajETgP1VhU+jMI3aAVYRd8bbaCc0pYjaoYUXrAessrDhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de; spf=pass smtp.mailfrom=flokli.de; dkim=pass (1024-bit key) header.d=flokli.de header.i=@flokli.de header.b=i205RKxT; arc=none smtp.client-ip=116.203.226.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flokli.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flokli.de
Date: Thu, 8 Aug 2024 13:31:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flokli.de; s=mail;
	t=1723113099; bh=D0j9fkFtDjrlhyFzMZPQzhRxftT0Q3FnZnmN7j+B9Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i205RKxTpP4tv6wMWD1Jce9K8qen8yv4IabytzUKijFGBTO9F4k2Tjml8t7dzcONp
	 FPMZUMT1bqE6TDHhhZk2ALFF496eLBe+iPtHbZoU9a759l4970l+ioxFknBUZW/QS9
	 9wfExnwsENjBYTtF0Y+iZkaDd6VchA89rFF6rpKU=
From: Florian Klink <flokli@flokli.de>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Alexey Charkov <alchark@gmail.com>, linux-rockchip@lists.infradead.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Sebastian Reichel <sebastian.reichel@collabora.com>, Kever Yang <kever.yang@rock-chips.com>, 
	Muhammed Efe Cetin <efectn@protonmail.com>, FUKAUMI Naoki <naoki@radxa.com>, 
	=?utf-8?B?VGFtw6FzIFN6xbFjcw==?= <tszucs@protonmail.ch>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rfkill node for M.2 E wifi
 on orangepi-5-plus
Message-ID: <bukq6244owje5ih3uo6gg2d2nkg4xwipsgbn4r5abos36g46xz@uauybbkf7y4z>
References: <20240807162001.1737829-1-flokli@flokli.de>
 <krvprzy3iz5b7n37eo2mb6sol6pcjkxsjdbdi6sxeebwveqtnr@e52cvrlkdjsa>
 <1b2e1b1b321f84f5cbff2ae18c3eba2e@manjaro.org>
 <4888470.OV4Wx5bFTl@latitude-fedora>
 <f524a2e5ddbec28dbbc0be4ef47a120b@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f524a2e5ddbec28dbbc0be4ef47a120b@manjaro.org>

On Wed, Aug 07, 2024 at 11:30:40PM GMT, Dragan Simic wrote:
>Hello Alexey,
>
>On 2024-08-07 23:12, Alexey Charkov wrote:
>>On Wednesday, August 7, 2024 9:32:51 PM GMT+3 Dragan Simic wrote:
>>>On 2024-08-07 20:14, Florian Klink wrote:
>>>> On Wed, Aug 07, 2024 at 07:24:27PM GMT, Dragan Simic wrote:
>>>>> On 2024-08-07 19:00, Florian Klink wrote:
>>>>>> This follows the same logic as 82d40b141a4c ("arm64: dts: rockchip:
>>>>>> add
>>>>>> rfkill node for M.2 Key E WiFi on rock-5b").
>>>>>>
>>>>>> On the orangepi-5-plus, there's also a GPIO pin connecting the WiFi
>>>>>> enable signal inside the M.2 Key E slot.
>>>>>>
>>>>>> The exact GPIO PIN can be validated in the Armbian rk-5.10-rkr4
>>>>>> kernel
>>>>>> rk3588-orangepi-5-plus.dtsi file [1], which contains a `wifi_disable`
>>>>>> node referencing RK_PC4 on &gpio0.
>>>>>>
>>>>>> Signed-off-by: Florian Klink <flokli@flokli.de>
>>>>>> Tested-by: Florian Klink <flokli@flokli.de>
>>>>>
>>>>> I forgot to mention that providing a Tested-by tag is redundant when
>>>>> there's already a Signed-off-by tag, because the latter already
>>>>> implies
>>>>> the former.
>>>>
>>>> This came after I sent the v3. Generally I wish people would test
>>>> things
>>>> - though too often it's not. I explicitly tested this to work (with a
>>>> wifi module added to that slot being unblock-able afterwards), and
>>>> wanted to point that out, thus adding the Tested-by.
>>>
>>>In general, some time should be allowed between sending consecutive
>>>versions of the same patch, so people can provide their feedback.
>>>
>>>When it comes to testing the submitted patches, please note that 
>>>signing
>>>off a patch implies that the signer has already, to the best of their
>>>abilities, made sure that the patch works as described and expected.
>>>
>>>With all that in mind, please allow me to repeat that a Tested-by tag
>>>should not be provided from the same person that the Signed-off-by tag
>>>is already coming from.  It's simply redundant.
>>
>>Just two cents: perhaps dropping the tag and expanding the commit 
>>message a
>>bit could be the best of both worlds. Just state that you tested it 
>>with such
>>and such module, observing such and such results. That would also 
>>help if for
>>example another user tries a different module and that fails due to 
>>some
>>quirks: it's easier to debug a potential issue when one knows a working
>>configuration to compare a non-working one against.
>
>Totally agreed.  Providing as much detail of the performed testing
>as possible in the patch description is always a good thing.

Just sent out a v4 including more information about my testing, and
dropping the explicit Tested-By tag.

Thanks,
Florian

