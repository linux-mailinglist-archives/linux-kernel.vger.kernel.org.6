Return-Path: <linux-kernel+bounces-339576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 181B3986730
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 21:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886FCB2325D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1508146586;
	Wed, 25 Sep 2024 19:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCmS+1ID"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403047483
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 19:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294032; cv=none; b=B+VNsEcC3GjrwAToM7oLDMZo5ztsyyv5j71to2hvAZLOVvoI7h4fIVtdQn0b/6PPg9byWm47tnCNOkJpBLkYYRKeXPB4PU6HUbRHq51TRM4PbfbRd2/yrC0U2pfyAWmRbG3gN6vNT1REQGH5rndg28I89IZreuMVaWjU/7A1f90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294032; c=relaxed/simple;
	bh=Imjm8vD8D4GmpoM12aLoNKugntUq+uwVLFQvisTlxAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P+x2ull0uiYdXIMGtcSATuBXhM2MS9s/IABO33bVp9pv1ftuy20jzBTiljsKcEX4NmbYEdfbSUP1Rnp4qRFKbx7jxtuqlebz2fsH7n8Y2MkyJbO55PVpUI20OauLk49gJWwmmSk1pbLiLa51jUtezWFB8z75wSTfU+oD4kPd0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCmS+1ID; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5A7C4CEC3;
	Wed, 25 Sep 2024 19:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727294031;
	bh=Imjm8vD8D4GmpoM12aLoNKugntUq+uwVLFQvisTlxAE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SCmS+1IDW41H4m3z1J/bP8kD5C/6F+HVoD0a8zAXQAw3+G9QK354/IiZTI/4UiI9r
	 8oeTwA1hmKJuaWTv8RY4UURYu8OcqTB8K3lbucqP+T10PPY/Lo7hSKSAe1MZSMSzF3
	 4/ajAXzsDhPtAOujYiyLrY50TnrOjqjn1gk4YVvvIC++pdoEsPoCivQxjJTREXSFAO
	 ZvsT5wWzsMBqTotH+dsF7mPDjjpY/BpD/bINsx8nPeMq0ervrXyEf+HORCWEePSURq
	 Ogkk8rBNGuuBKw9IYV8VEzDNKyzrBbpWxl7UW8J/mh01CRhiQKofgUgGI8JUMEYke4
	 3FaABasJS3ZwQ==
Message-ID: <73f1a21c-1db1-49ce-951e-a2694567c1c6@kernel.org>
Date: Wed, 25 Sep 2024 21:53:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] HID for 6.12
To: Jiri Kosina <jikos@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
 Charles Wang <charles.goodix@gmail.com>
References: <nycvar.YFH.7.76.2409181132240.31206@cbobk.fhfr.pm>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <nycvar.YFH.7.76.2409181132240.31206@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/09/2024 15:04, Jiri Kosina wrote:
> Linus,
> 
> please pull from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/hid-for-linus-2024091602
> 
> 
> to receive HID subsystem queue for 6.12 merge window, namely:
> 
> =====
> 
> - New HID over SPI driver for Goodix devices that don't follow Microsoft's 
>   HID-over-SPI specification, so a separate driver is needed. Currently 
>   supported device is GT7986U touchscreen (Charles Wang)
> 
> - support for new hardware features in Wacom driver (high-res wheel 
>   scrolling, touchstrings with relative motions, support for two 
>   touchrings) (Jason Gerecke)
> 
> - support for customized vendor firmware loading in intel-ish driver 
>   (Zhang Lixu)
> 
> - fix for theoretical race condition in i2c-hid (Dmitry Torokhov)
> 
> - support for HIDIOCREVOKE -- evdev's EVIOCREVOKE equivalent in hidraw 
>   (Peter Hutterer)
> 
> - initial hidraw selftest implementation (Benjamin Tissoires)
> 
> - constification of device-specific report descriptors (Thomas Weißschuh)
> 
> - other small assorted fixes and device ID / quirk additions
> 
> =====
> 
> Thanks.
> 
> ----------------------------------------------------------------
> Benjamin Tissoires (4):
>       HID: samples: fix the 2 struct_ops definitions
>       selftests/hid: extract the utility part of hid_bpf.c into its own header
>       selftests/hid: Add initial hidraw tests skeleton
>       selftests/hid: Add HIDIOCREVOKE tests
> 
> Charles Wang (2):
>       HID: hid-goodix: Add Goodix HID-over-SPI driver
>       dt-bindings: input: Goodix SPI HID Touchscreen

On September 6, Rob reported that this is broken and should be fixed or
reverted.
https://lore.kernel.org/all/CAL_Jsq+QfTtRj_JCqXzktQ49H8VUnztVuaBjvvkg3fwEHniUHw@mail.gmail.com/

On September 10, Rob reminded that it is still broken.

Author ignored the problem, so the maintainer should revert this.. or at
least not send these further for RC inclusion.

If no one wants to fix this code, no one cares, we are not supposed to
take it into kernel release, right?

I just sent a revert, because this is now an issue in Linus' tree.

Best regards,
Krzysztof


