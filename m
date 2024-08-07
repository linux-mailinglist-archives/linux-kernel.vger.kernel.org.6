Return-Path: <linux-kernel+bounces-278585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D567094B22F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 23:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB091C21341
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEA21494DC;
	Wed,  7 Aug 2024 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TWJcjB4H"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412E812C53B;
	Wed,  7 Aug 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066247; cv=none; b=IQPB/RH1JhYADqoCgEr6oQNzw0CW4TPQu6VbjYA2RqVrObTRID07qEn0BYvP1WREG69ayshQbh9JZin6SY42EGWcH1HXUdtRQoqiGcOtWyhrsRtvOc5/4nC6QCmWaBtDtLepN/Wn4xOoV9SWYHdSo0qA9abOgViyDEEAiTYNE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066247; c=relaxed/simple;
	bh=P0SbEBIZMjEgzWsPOhUAMMejF8jSFg0ZXrXkSfgsVe0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Lhcckf2sMBNXEElOyZ7cGap+aa8viNC4q9Tq4wH/XHECUT1+ezRt/YJ3iJgKd4h74ormK6nyXbV7qXKj4TvCjgfiY8hslh2O/flXxV3t26NKoGo9x0/ZDkUmDISOQ9LGxa5YfxqlRI0LrA3aiGggwugCrG5A+tjNVJSloNK81EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=TWJcjB4H; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1723066241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=clM14XZnCkKlnQEqf0XCli4TSu2XTFrkaDKcxnbToic=;
	b=TWJcjB4HIYS5OdulQ4drZ+lzlqOnbRJxLXKcRvgYDUfl7Oo4+SVaOAJ37y12rQv1PuizBj
	xkVpaoIubMZwlyVLqKiinxU7wgmaDbmwmqWNQCKNsBd+iJm65nie5Pl98C3a4Xcj3RBpvn
	flURP7yCQdIyAC9VwCtr4pOfA898ShYn6uvnNSU05UY+S5UaQtHiAwwgJGIihKHP1ANd83
	//vRPj1oPu81lYeZPTCtpcW60rPd5E5PT4Nlbr2vsbjIHZufHoIKzU+JajeiOGc5l50PWz
	GORbm6cCJY1dcp64sHX5tny8bY8W4GCHkYGtL2T8hG1CsJg+P08dURHXVxAiMg==
Date: Wed, 07 Aug 2024 23:30:40 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Florian Klink <flokli@flokli.de>, linux-rockchip@lists.infradead.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, Kever Yang
 <kever.yang@rock-chips.com>, Muhammed Efe Cetin <efectn@protonmail.com>,
 FUKAUMI Naoki <naoki@radxa.com>, =?UTF-8?Q?Tam=C3=A1s_Sz=C5=B1cs?=
 <tszucs@protonmail.ch>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: rockchip: add rfkill node for M.2 E wifi
 on orangepi-5-plus
In-Reply-To: <4888470.OV4Wx5bFTl@latitude-fedora>
References: <20240807162001.1737829-1-flokli@flokli.de>
 <krvprzy3iz5b7n37eo2mb6sol6pcjkxsjdbdi6sxeebwveqtnr@e52cvrlkdjsa>
 <1b2e1b1b321f84f5cbff2ae18c3eba2e@manjaro.org>
 <4888470.OV4Wx5bFTl@latitude-fedora>
Message-ID: <f524a2e5ddbec28dbbc0be4ef47a120b@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alexey,

On 2024-08-07 23:12, Alexey Charkov wrote:
> On Wednesday, August 7, 2024 9:32:51 PM GMT+3 Dragan Simic wrote:
>> On 2024-08-07 20:14, Florian Klink wrote:
>> > On Wed, Aug 07, 2024 at 07:24:27PM GMT, Dragan Simic wrote:
>> >> On 2024-08-07 19:00, Florian Klink wrote:
>> >>> This follows the same logic as 82d40b141a4c ("arm64: dts: rockchip:
>> >>> add
>> >>> rfkill node for M.2 Key E WiFi on rock-5b").
>> >>>
>> >>> On the orangepi-5-plus, there's also a GPIO pin connecting the WiFi
>> >>> enable signal inside the M.2 Key E slot.
>> >>>
>> >>> The exact GPIO PIN can be validated in the Armbian rk-5.10-rkr4
>> >>> kernel
>> >>> rk3588-orangepi-5-plus.dtsi file [1], which contains a `wifi_disable`
>> >>> node referencing RK_PC4 on &gpio0.
>> >>>
>> >>> Signed-off-by: Florian Klink <flokli@flokli.de>
>> >>> Tested-by: Florian Klink <flokli@flokli.de>
>> >>
>> >> I forgot to mention that providing a Tested-by tag is redundant when
>> >> there's already a Signed-off-by tag, because the latter already
>> >> implies
>> >> the former.
>> >
>> > This came after I sent the v3. Generally I wish people would test
>> > things
>> > - though too often it's not. I explicitly tested this to work (with a
>> > wifi module added to that slot being unblock-able afterwards), and
>> > wanted to point that out, thus adding the Tested-by.
>> 
>> In general, some time should be allowed between sending consecutive
>> versions of the same patch, so people can provide their feedback.
>> 
>> When it comes to testing the submitted patches, please note that 
>> signing
>> off a patch implies that the signer has already, to the best of their
>> abilities, made sure that the patch works as described and expected.
>> 
>> With all that in mind, please allow me to repeat that a Tested-by tag
>> should not be provided from the same person that the Signed-off-by tag
>> is already coming from.  It's simply redundant.
> 
> Just two cents: perhaps dropping the tag and expanding the commit 
> message a
> bit could be the best of both worlds. Just state that you tested it 
> with such
> and such module, observing such and such results. That would also help 
> if for
> example another user tries a different module and that fails due to 
> some
> quirks: it's easier to debug a potential issue when one knows a working
> configuration to compare a non-working one against.

Totally agreed.  Providing as much detail of the performed testing
as possible in the patch description is always a good thing.

