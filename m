Return-Path: <linux-kernel+bounces-384629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6BE9B2C95
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 11:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2ACB1F2278E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD991D043D;
	Mon, 28 Oct 2024 10:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="rNiWLRqB"
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB739187876;
	Mon, 28 Oct 2024 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730110654; cv=none; b=rh8QKTH6irrgSkbMpWiv1jArsU/ldazD6j2/uhg2qOj8kfy1dv9lA4wpy8ETA/aF6pUxt1udx0rSZHek85anbJnsYo10lRWMdooNfEtbnAFtyy4k6OxX3p1gL2KShalhMEKvv91U0DZA4PCinIzxvejWbEhm/flzYvVhhhT4630=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730110654; c=relaxed/simple;
	bh=g4AQlFUQ9S+MSRIsWNQVarYHFzjSa00wLVilFkIXp0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vr/WUsZwjpOxct/PrEHm+D9lYrDrwxNePJwu57F77KQ/zbPuAnmILpqW2J5AKNnK4zfCJEdiSlShiZStxgYCr7VFa4F+IRpWIBDtBj+Tdg3je9cyFJWnGhPrW/83jvWYmAX+oIjCs2r+AHIST4apuYW9+LCaCmk7ZykBZySq3m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=rNiWLRqB; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XcTpX1szDzDqF9;
	Mon, 28 Oct 2024 10:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1730110644; bh=g4AQlFUQ9S+MSRIsWNQVarYHFzjSa00wLVilFkIXp0g=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=rNiWLRqBSZyVTolSGeS2kHwDMA+LnR9toGy0YIb3j3g+Xq6Y4MCiy6odbHInGenSN
	 tqZCywxtjNK5DkgDleWyeN4fHiovJYeA3pfKy0mDnjhJIgRJSyazNE/wfqeD4+06n4
	 Nir/XAiQxmYbACIc8qEc9dK6shMdDD/2BdB6bzFk=
X-Riseup-User-ID: C24371E5919299DE26FBED04841B5421381C2E6F8F79BC121909B28BCA566AF5
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4XcTpB3gq4zFtfv;
	Mon, 28 Oct 2024 10:17:06 +0000 (UTC)
Message-ID: <6278651d-b61d-49d2-8151-7ab4ca03971c@riseup.net>
Date: Mon, 28 Oct 2024 07:17:04 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v12 09/15] drm/vkms: Remove useless drm_rotation_simplify
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Simona Vetter <simona@ffwll.ch>, rdunlap@infradead.org,
 arthurgrillo@riseup.net, pekka.paalanen@haloniitty.fi,
 Simona Vetter <simona.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 thomas.petazzoni@bootlin.com, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, seanpaul@google.com, marcheu@google.com,
 nicolejadeyee@google.com
References: <ZwzYqihbReaLFn-c@louis-chauvet-laptop>
 <d3e8bb5a-6053-4a2b-a445-0cf4e610f112@riseup.net> <Zx9eazDt3f2meyht@fedora>
Content-Language: en-US
From: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <Zx9eazDt3f2meyht@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Louis,

On 28/10/24 06:50, Louis Chauvet wrote:
> On 26/10/24 - 09:10, Maíra Canal wrote:
>> Hi Louis,
>>
>> On 14/10/24 05:39, Louis Chauvet wrote:
>>> On 11/10/24 - 10:53, Maira Canal wrote:
>>>> Hi Louis,
>>>>
>>>> On 10/11/24 06:36, Louis Chauvet wrote:
>>>>>
>>>>> Hi all,
>>>>>
>>>>> Until this point, this series has not received any major comments since
>>>>> v9. I will commit patches 1-9 next week if there are no further comments.
>>>>>
>>>>
>>>> Although we are maintainers of VKMS, it isn't recommended that we push
>>>> our own changes without even the Ack of another person. Please, read the
>>>> "drm-misc Committer Guidelines" [1].
>>>
>>> Hi Maíra, Maxime,
>>>
>>> I apologize for this rushed commit request. I sent the initial email with
>>> a delay before the commit action because I was not sure about the
>>> procedure and wanted to give others a chance to raise any concerns.
>>> Unfortunately, I overlooked the need to collect an Ack/Review for each
>>> patch, even when there hadn't been any responses for several months. I'm
>>> sorry for this oversight.
>>>
>>>> I can ack patches 05/15, 07/15, and 09/15, but it would be more
>>>> beneficial for the community if you ask for an ack (from me or from the
>>>> DRM maintainers, which are always around), instead of saying that you
>>>> are going to commit the patches without any review.
>>>
>>> I will be happy to ask for acknowledgments if needed, but as you mentioned
>>> multiple times: nobody is paid to maintain VKMS. Since you did not comment
>>> these series since July, when you told me you would review my patches, I
>>> assumed it was either okay or you no longer had the time to maintain
>>> (which I completely understand).
>>
>> Yeah, I'm a volunteer and no longer have time to maintain VKMS. A couple
>> of weeks ago I sent a patch removing myself as VKMS maintainer. This
>> doesn't imply that patches can be pushed without review.
> 
> I will acked-by and push your patch, it will be an easy "first commit". If
> I do something wrong during the process, please tell me.
> 
> Thanks for this precision, I understood this, and I will not push without
> reviews, don't worry!
> 
> Thanks a lot for all your reviews!
>   
>> We are a community with several active developers. Although I don't have
>> time to properly review your patches, you can try to gather other
>> developers to review your patches. You can try to use #dri-devel to get
>> reviewers.
> 
> Thanks for the tip, I will do this!
> 
>> That said, you can add my ACK to patches 05/15, 07/15, and 09/15 and
>> push the patches. I won't ack the YUV patches as I don't feel
>> comfortable reviewing/acking those.
> 
> Perfect for the patches 1..9, it will be a very nice step forward and will
> reduce my conflicts a lot with the rest of my work!
 > >> Acked-by: Maíra Canal <mairacanal@riseup.net>
>>
>> BTW if the patches are fixing IGT tests, please update the list of fails
>> and skips on DRM CI.
> 
> For this, how should I do? Commit the series and wait for the bot results?
> Run tests on my computer (I only have a x86 VM)? Is there some doc
> somewhere?

Check [1] for instructions on how to run the CI on GitLab.

[1] https://docs.kernel.org/gpu/automated_testing.html

Best Regards,
- Maíra

> 
> Thanks a lot,
> Louis Chauvet
> 
>> Best Regards,
>> - Maíra
>>
>>>
>>> So, I hereby formally request reviews/ACKs for the following series:
>>>
>>> [this series]:https://lore.kernel.org/all/20241007-yuv-v12-0-01c1ada6fec8@bootlin.com/
>>> [2]:https://lore.kernel.org/all/20241007-b4-new-color-formats-v2-0-d47da50d4674@bootlin.com/
>>> [3]:https://lore.kernel.org/all/20240516-writeback_line_by_line-v1-0-7b2e3bf9f1c9@bootlin.com/
>>>
>>> (I have to send a v2 for [3] because of rebase conflict, but nothing else
>>> changed)
>>>
>>> Thanks a lot,
>>> Louis Chauvet
>>>> [1] https://drm.pages.freedesktop.org/maintainer-tools/committer/committer-drm-misc.html
>>>>
>>>> Best Regards,
>>>> - Maíra
>>>>
>>>>> For patches 10-15, I am currently waiting for feedback from Maxime to
>>>>> send the next iteration with a fix for kunit tests.
>>>>>
>>>>> Thanks,
>>>>> Louis Chauvet
>>>>>
>>>>> On 07/10/24 - 18:10, Louis Chauvet wrote:
>>>>>> As all the rotation are now supported by VKMS, this simplification does
>>>>>> not make sense anymore, so remove it.
>>>>>>
>>>>>> Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
>>>>>> ---
>>>>>>     drivers/gpu/drm/vkms/vkms_plane.c | 7 +------
>>>>>>     1 file changed, 1 insertion(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkms_plane.c
>>>>>> index 8875bed76410..5a028ee96c91 100644
>>>>>> --- a/drivers/gpu/drm/vkms/vkms_plane.c
>>>>>> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
>>>>>> @@ -115,12 +115,7 @@ static void vkms_plane_atomic_update(struct drm_plane *plane,
>>>>>>     	frame_info->fb = fb;
>>>>>>     	memcpy(&frame_info->map, &shadow_plane_state->data, sizeof(frame_info->map));
>>>>>>     	drm_framebuffer_get(frame_info->fb);
>>>>>> -	frame_info->rotation = drm_rotation_simplify(new_state->rotation, DRM_MODE_ROTATE_0 |
>>>>>> -									  DRM_MODE_ROTATE_90 |
>>>>>> -									  DRM_MODE_ROTATE_270 |
>>>>>> -									  DRM_MODE_REFLECT_X |
>>>>>> -									  DRM_MODE_REFLECT_Y);
>>>>>> -
>>>>>> +	frame_info->rotation = new_state->rotation;
>>>>>>     	vkms_plane_state->pixel_read_line = get_pixel_read_line_function(fmt);
>>>>>>     }
>>>>>>
>>>>>> -- 
>>>>>> 2.46.2
>>>>>>


