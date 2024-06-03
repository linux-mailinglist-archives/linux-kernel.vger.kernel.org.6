Return-Path: <linux-kernel+bounces-198733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA038D7CAE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 09:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE65F1F22DFB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 07:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7904C62E;
	Mon,  3 Jun 2024 07:45:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923714C61C;
	Mon,  3 Jun 2024 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717400708; cv=none; b=MKULBggTAdf+hNWPP2qoJD7wcnq9efAuEAS3Z2yn5R34iouB13H5g406+6Ncc3nOHuSUrM7HSEhCpE7T9Knzy0Q9hKaXVfqyDciPQmt1mBxtg6eXa5DfdPdxpb0J32Ey7cQVzSSrJQmzFGpvq8+/SbFK4d5xWC8whqudXO6rGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717400708; c=relaxed/simple;
	bh=jG2Qkqno7nw2YxAPdMySz0EFNj7Gm9u4EtZnUecdAN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMBOLY3VoegoXfHQR0RLJT9pifQHD8S+EzPdcqSeprXtKwgOQApJJvRMShyzcVEMMSK/y0aBYJgIWDlbHbifWjnhfwb41jx8zlMrL1V36lmZ3M5pLaBrkE3SXqtzhdNTHL8wf5qx8xlcJeic8Efjd1obNU6OK2O/zWMJIcU6YV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C66D81042;
	Mon,  3 Jun 2024 00:45:28 -0700 (PDT)
Received: from [10.57.39.221] (unknown [10.57.39.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 522F83F762;
	Mon,  3 Jun 2024 00:45:00 -0700 (PDT)
Message-ID: <ebcbc9c6-d858-4774-be48-857b7d446e15@arm.com>
Date: Mon, 3 Jun 2024 08:45:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] drm/imagination: Add compatible string entry for
 Series6XT
To: Chen-Yu Tsai <wenst@chromium.org>, Frank Binns <Frank.Binns@imgtec.com>
Cc: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 Matt Coster <Matt.Coster@imgtec.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "airlied@gmail.com" <airlied@gmail.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>
References: <20240530083513.4135052-1-wenst@chromium.org>
 <20240530083513.4135052-5-wenst@chromium.org>
 <efdacd820d13368816973f57c4a817e039ec4a2d.camel@imgtec.com>
 <CAGXv+5EMMNCbxaBqiBSQwGrQt-0KXWAtJU54K20sUU8PBh8faQ@mail.gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <CAGXv+5EMMNCbxaBqiBSQwGrQt-0KXWAtJU54K20sUU8PBh8faQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03/06/2024 04:29, Chen-Yu Tsai wrote:
> On Fri, May 31, 2024 at 7:18 PM Frank Binns <Frank.Binns@imgtec.com> wrote:
>>
>> On Thu, 2024-05-30 at 16:35 +0800, Chen-Yu Tsai wrote:
>>> The MediaTek MT8173 comes with a PowerVR Rogue GX6250, which is part
>>> of the Series6XT, another variation of the Rogue family of GPUs.
>>>
>>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>>> ---
>>>  drivers/gpu/drm/imagination/pvr_drv.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
>>> index 5c3b2d58d766..3d1a933c8303 100644
>>> --- a/drivers/gpu/drm/imagination/pvr_drv.c
>>> +++ b/drivers/gpu/drm/imagination/pvr_drv.c
>>> @@ -1475,6 +1475,7 @@ pvr_remove(struct platform_device *plat_dev)
>>>
>>>  static const struct of_device_id dt_match[] = {
>>>       { .compatible = "img,img-axe", .data = NULL },
>>> +     { .compatible = "img,powervr-6xt", .data = NULL },
>>
>> I assume that by adding this to the list of supported devices we're essentially
>> freezing the existing uapi. This concerns me, as we've not yet started running
>> Vulkan conformance on any Series6XT GPUs and there's a chance we may need to
>> make some tweaks.
>>
>> I'm not really sure what the accepted approach is to hardware enablement /
>> experimental support. I'm not sure if it's sufficient to hide support behind a
>> Kconfig option and/or module parameter or whether we just have to hold this
>> patch back for the time being.
> 
> I guess this is more of a question for the DRM maintainers.
> Added a couple Panfrost/Panthor folks for ideas.

I'm not sure quite what scale of "tweaks" you are expecting. Obviously
adding new uAPI is possible at any time - the only requirement is "don't
break user space" - i.e. don't remove old uAPI. Although obviously you
want to be careful about adding it because that means supporting it
forever more.

Panfrost has had an "unstable_ioctls" module parameter that we've hidden
performance counters behind. (Performance counters are hard from a uAPI
perspective - Panthor has similar issues).

We've also added support for GPUs in a deliberately "crippled" manner
(e.g. only one core group - see panfrost_get_core_mask()). I think we're
mostly just hoping those 'awkward' GPUs are not interesting enough and
we'll never implement full support for them - but if we did I expect
we'd implement support by providing a new uAPI for enabling the second
core group so old user space can continue working with just the single
core group.

Of course if the support for this platform is actually 'broken' (the
talk of GPU resets makes me think so - on Mali requiring a reset is a
"should never happen" situation, but we do have errata...) then it's
probably best holding off merging this until you've got something which
is minimally functional and then add support as necessary. For Vulkan
you can always have user space require a particular DRM kernel version
if you discover extra uAPI is needed.

Steve


