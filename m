Return-Path: <linux-kernel+bounces-339687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A55398691F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 00:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F15DD1F25847
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 22:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE6B157A48;
	Wed, 25 Sep 2024 22:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="URjnbZ1y"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BC4148838
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 22:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727302825; cv=none; b=PPWmpYE3LNx2GtWqqABeKa0qXe0ER93LdkDMrLD3TtezPn9vhaYxVZ5IKa99dk2yR2NbW6Y464ktjr6oG0nLIl8RTN5jIVCD7p7yA8HiAqFqqKs2I8gHkXb2S2tFNzBxen1BNp0JiOv4JZTBqiEBMW3E9P72DarK+QVTpC/Kr6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727302825; c=relaxed/simple;
	bh=3e0aMTeuB5QfQphV1m+a3HqlDa31wwh6gOLS8RoJ1F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnYHQ40gj2csUBYu1x9qaNNq3fReDDGN/LjHNY4symFpVxlc3Nb+rGa+L57f/VljHQOuGRO+OAHgBrCkq+Z7CR9HnM8bfgEMxG2KFPkQcJeWkN1evz+UF0wdfuAhp89Rq/YLFyXHdO8DDXD1LFzkfkesh/Cvsmp3rOJ48uqVdPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=URjnbZ1y; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id F3B9B88BCD;
	Thu, 26 Sep 2024 00:20:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727302822;
	bh=QX3Gljzsal7tP8N3o9z+87VvmHxhndmbIYcHAm6zQ6s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=URjnbZ1yhHO1M+woKnP2IgyA5XkVdInr53KlJKA96CU3QNLRnF0Y1ThmarkISSa8q
	 VzZrzVDMbhGZuR1lbmBwQc7jUg5Sx0KkuPVkE2SSutEOzl3lCaZDZto9X6MAOy+U4t
	 ZqIOADIHcbLPeW+690kCk1FzmEk8EJllbZ5ExdChdZi4z8ublrPDbPSucOm4VvACZF
	 P4LIaQOAOkmDwuUkDsjJP2KvjaZ0kQZpEUOmDpqKIbL1lZRV4+K8jeamfowiuEnBlB
	 cA2pRlyH5yWN49UghsICc1f0U3NhAqNG1uh9wO2IhniuZJm1LkEvxXiLS0w+cUutyC
	 tZOJ/nsNNnOdQ==
Message-ID: <7383cd9f-6e70-4b3a-96a4-98170e584a7b@denx.de>
Date: Thu, 26 Sep 2024 00:11:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: imx8m: Probe the SoC driver late
To: Saravana Kannan <saravanak@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
 kernel@dh-electronics.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Fabio Estevam <festevam@gmail.com>, Jeff Johnson
 <quic_jjohnson@quicinc.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240925160026.84091-1-marex@denx.de>
 <486054ad-20c2-45f4-a457-c9334afb53ed@app.fastmail.com>
 <03b05be4-2276-4e70-9480-2b1467df4ef6@denx.de>
 <4897ec78-b82c-415d-88dd-5092fa009f77@app.fastmail.com>
 <51c340c5-b104-4872-bfdc-8c6d52f6a35a@denx.de>
 <CAGETcx_ODj-FqhH7stxu27PpGNg2LiFwgC=1piLaBjDV4OagLA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAGETcx_ODj-FqhH7stxu27PpGNg2LiFwgC=1piLaBjDV4OagLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/25/24 8:48 PM, Saravana Kannan wrote:

Hi,

>>> On the other hand, making it a late_initcall() defeats the
>>> purpose of the driver because then it can't be used by other
>>> drivers with soc_device_match(), resulting in incorrect
>>> behavior when another driver relies on this to enable
>>> a chip revision specific workaround.
> 
> We could have soc_device_match() return -EPROBE_DEFER if no soc device
> has been registered yet.
> 
> For cases where it's already working without any changes, we shouldn't
> see any new -EPROBE_DEFER return values. But for cases like what Marek
> is trying to do, it should work properly. He might have to fix bad
> driver code where they remap the error instead of returning it as is.

I sent out V2.

> On a tangential note, the soc framework seems to be yet another
> framework violating the bus vs class thing. If it's a bus, then you
> need to have a probe. Otherwise, just make it a class. Might be too
> much to fix at this point, but might be good to keep this in mind if
> you plan to write more frameworks or redo soc framework at some point
> :)
> 
> See Slide 20:
> https://lpc.events/event/18/contributions/1734/
> 
>> I know, I am unsure how to proceed with this. Convert this to
>> platform_driver or some such and probe it early maybe ?
> 
> Marek,
> 
> Thanks for trying out drive_async_probe=* and trying to fix boards/drivers.

That was one of the most useful things I picked at LPC this year, thanks.

> The issue you are facing and the proper way to handle it was covered
> in my talk at LPC 2024 in Slide 18:
> https://lpc.events/event/18/contributions/1734/
> 
> All the benefits of fw_devlink are only present for drivers that use a
> device-driver model. And yes, in this case we should convert this
> driver into a platform device/driver if it's possible.
Done in V2, thanks.

