Return-Path: <linux-kernel+bounces-236799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E8B91E740
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6336FB22890
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F016CD1E;
	Mon,  1 Jul 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="ViFKjOnO"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3618BBA34
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857717; cv=none; b=NUfrg9iin743i6NwDNmw6Zdjzi1ZAemi6h5ZD+jZu0iP+Xgj+05HSQHqA9UbVmy2GcCOczPbT1RoKqAPqglxLh+2KnMmytkFCgJ63LlavUZUlddq0xbC/6E+4585vd+MeM5kj5JRrhRAEllqhklLeJDcjeEV0ZKWjzxWrpoIFwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857717; c=relaxed/simple;
	bh=QseJPPx4W8bBEr4BuyPO9KS4jwHMWSvIQx0Jjb5czes=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PYwcK24ZwlemralPhkjGCMJvoI4GFYjnRLo1RtqGSAmAVTTzucp2JYMTkPoUr1pmP7FfoR80/mbzUDi8wQZyOY0ewBC1cHIJPWyp3j4PT0dhznGzJ6ZRD56AzNuqGhf2/EuxrDH7fNxJHt38PV0l1AtidmCM7OX/QW1HDIh4ZVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=ViFKjOnO; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4WCZ2p6TY9zDql0;
	Mon,  1 Jul 2024 18:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1719857715; bh=QseJPPx4W8bBEr4BuyPO9KS4jwHMWSvIQx0Jjb5czes=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ViFKjOnO1J7b4+dF7tTtyUkBPGc4Tk973LbW2yQExKo+DpzjGs+4QcpDRsOg06F3p
	 o9Lan3T4ShOXKGZCEvMRxqnlY3ZaaPjqVPcunhPdbhS0/XncmV05Y85BlZrxPqgre8
	 XXD8u/qTXDyTwCZX9HaVFUM4zn2xY3/MfqpeCGUg=
X-Riseup-User-ID: B88A74BDAAC8086B44F20CFA023858B79A3E2131DF8C1106D6E7EEC07A09B213
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4WCZ2f6YYFzFtKB;
	Mon,  1 Jul 2024 18:15:06 +0000 (UTC)
Message-ID: <2969cd21-5915-46fb-b4f0-c584100c15b1@riseup.net>
Date: Mon, 1 Jul 2024 15:15:04 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 00/17] drm/vkms: Reimplement line-per-line pixel
 conversion for plane reading
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, rdunlap@infradead.org,
 arthurgrillo@riseup.net, Jonathan Corbet <corbet@lwn.net>,
 pekka.paalanen@haloniitty.fi, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
References: <20240516-yuv-v8-0-cf8d6f86430e@bootlin.com>
 <ZoKpwWaX4LGqLC04@louis-chauvet-laptop>
Content-Language: en-US
From: Maira Canal <mairacanal@riseup.net>
In-Reply-To: <ZoKpwWaX4LGqLC04@louis-chauvet-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 7/1/24 10:06, Louis Chauvet wrote:
> Hi everyone,
> 
> I sent this iteration over a month ago, and I haven't received any
> feedback since then. The same goes for the two other series [1] and [2],
> which I sent after discussing with Melissa.

As you may know, Melissa is stepping down on her maintainership duties
for VKMS [1].

> 
> I'm a bit surprised that nothing has been reviewed or merged, as Maíra
> mentioned in [3] that she wanted to merge at least the first 11 patches. I
> just checked, and this series applies to drm-misc-next. However, if you
> encounter any issues, I can send a rebased version.

I want to get the series merged, but, as me and Melissa pointed out last
XDC, we are volunteers. AFAIK VKMS has been maintained by volunteers
since its beginning. We are doing our best to maintain VKMS, but we do
it in our free time.

I need to take some time to review and test this series properly. Then,
I can push it to drm-misc-next.

> 
> As you can see, I have more series ready ([2], [3]), and I am working on
> additional features (configfs [4], variable refresh rate, mst...).
> However, I am currently waiting for feedback on this series before
> proceeding further with the next topics.
> 
> What should I do to move those series forward?

I appreciate the work you are doing for VKMS. But, apart from adding new
features, we first need to ensure that VKMS is stable. Also, when
reviewing new features, I need to make even more tests to make sure that 
everything is still stable. Therefore, it is a slow process, but I hope
we can start to move forward.

[1] 
https://lore.kernel.org/dri-devel/20240525142637.82586-1-melissa.srw@gmail.com/

Best Regards,
- Maíra

> 
> Best regards,
> Louis Chauvet
> 
> [1]: https://lore.kernel.org/all/20240516-b4-new-color-formats-v1-0-74cf9fe07317@bootlin.com/
> [2]: https://lore.kernel.org/all/20240516-writeback_line_by_line-v1-0-7b2e3bf9f1c9@bootlin.com/
> [3]: https://lore.kernel.org/all/c83255f4-745e-43e6-98e0-2e89c31d569a@igalia.com/
> [4]: https://github.com/Fomys/linux/tree/b4/new-configfs
> 

