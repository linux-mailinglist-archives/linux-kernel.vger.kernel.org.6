Return-Path: <linux-kernel+bounces-325494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EBA975A5C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174722881C6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 18:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4761A1B6554;
	Wed, 11 Sep 2024 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="WazDwtuM"
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3D7AE5D
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726079212; cv=none; b=UceIcG79DZZJz0rauvQ1OLD91uORV22SiQqt5gdTErPFg6MdlWvXz5qhBhDTR24YgBKIloejeObMf3TEMTWZT8WBiBpactdmgQJgZ+KMsLdh8Jx/G+ohEF4TBvDy4ZoD7k2Kamf81xRnxfcgQh/I2H8N5H70Ixej7EwtpDBl460=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726079212; c=relaxed/simple;
	bh=HVgjg48h7yQ5aSQh0ZIA4md6dKOF+acuihSkQ39ahRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mhFToeJl86APl6V5D16NBKOfchkCbxOpf/RPs9Y0pzvzqKWtLOeAglS4gcIb2m6Gs/NNMnv+8NS+oE5TZptEgCFK81grHSeirD3GeQ2DSYorbvJkPo4fSNXe6IgrLkTaWlD8acOLd+baSmrn/YrfSUREFnWcTYD8W2cfPNQFjAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=fail smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=WazDwtuM; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 83CD9BFB39;
	Wed, 11 Sep 2024 20:26:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1726079208; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=c7s+a1DXGSnU83uOS1h87JsKv2O/+rk28GPS9hHpHGo=;
	b=WazDwtuMX9Law/jw92lkZ9NWsct2Z1n4yKrMNadHBH2hJI08rpUE67JpGCdhEreGhdWUbQ
	BmGL+6JwEyiHZlxdw4RsEEe7mM9fK5H7ygjjfL3/no2sxIZ7nIfD6Z40ZNp7oKqeRZ+OXw
	lN0FgjGgBl92YbACFdUJyJy0SKt7nYhuTxH96mDnwgLcSCsAqPlZCU5D7Vy4ZNRf3VIfHc
	nGARRFLf8PVeCt+9ydqf0qGc+5JLkAPmzbaMoLlvbsnK+AICcyvZiPz2HJMe/dP7qcmQfO
	QQ5KKZ9n1L3zmTKLbyn/ZCMuMVz3qdgL6nghYo4h0YczWFU/Ir0Nm/eLWz/dCA==
Message-ID: <440cf92a-052f-4a03-91a8-2405c902aa3e@fris.de>
Date: Wed, 11 Sep 2024 20:26:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Extending PLL LUT for i.MX8MP Samsung HDMI PHY
To: Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Adam Ford <aford173@gmail.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>, Marco Felsch
 <m.felsch@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@pengutronix.de>
References: <20240910181544.214797-1-frieder@fris.de>
 <ZuDjAwPxHeJTvXAp@atmark-techno.com>
 <CAHCN7xJD8jsqyZX1JkWxrA84XkZ8YYN19hXW6KVe+jkOFugqrw@mail.gmail.com>
 <ZuDyBQ1I2vcGzAqX@atmark-techno.com>
Content-Language: en-GB, de-DE
From: Frieder Schrempf <frieder@fris.de>
In-Reply-To: <ZuDyBQ1I2vcGzAqX@atmark-techno.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11.09.24 03:27, Dominique Martinet wrote:
> Adam Ford wrote on Tue, Sep 10, 2024 at 08:16:04PM -0500:
>>> That aside, I see no problem with this, just one meta-comment about
>>> adding a link to the script in an external repo: I see some other
>>> drivers have python scripts in their trees e.g.
>>> drivers/comedi/drivers/ni_routing/tools/*py
>>> drivers/gpu/drm/ci/xfails/update-xfails.py
>>> drivers/gpu/drm/msm/registers/gen_header.py
>>>
>>> would it make sense to commit the script here instead of linking to a
>>> repo that might be lost in the future?
>>>
>>> I'm not quite sure what policy the linux repo has here, so leaving that
>>> as an open question.
>>
>> Is there a reason this couldn't be coded in C and used to expand my
>> integer calculator series?  With that, we could drop the lookup table.
> 
> Quoting a previous mail from Frieder:
>> I will clean things up a bit and then share what I have. I hope that this
>> allows anyone to calculate parameters for their non-standard displays if
>> required.
>>
>> If someone feels extra motivated they could try to calculate the fractional
>> parameters at runtime. However I'm not sure that this is feasible. The
>> numerical computation of a large number of parameters is quite heavy and it's
>> probably not easy to strip the algorithm down to something that can be run on
>> the target without too much overhead.
> 
> Trying a random frequency with the algorithm he has implemented it
> easily takes 10 seconds to run on my imx8mp board, so even if we asssume
> C is 3-4 times faster I think the current algorithm is too slow for
> runtime and it makes more sense to extended the LUT to me (as long as
> the values can be & are checked at least once, which we now can)
> 
> The current algorithm brute-forces its way through so there could be a
> better way of computing the fractional part of the divider, but I'm not
> sure it's worth the effort at this point; I guess it's a good
> intellectual challenge though so someone might do it in the future.

Second this. My algorithm is far from optimal and there might be more 
elegant solutions. If anyone feels like creating something that can be 
added to the driver that would be interesting and welcome for sure.

