Return-Path: <linux-kernel+bounces-252729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B41931766
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94801C2177C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE151DFFD;
	Mon, 15 Jul 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="A2vCWne3"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6712A522A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721056520; cv=none; b=VePRFMKnDd6h8Pf2Rb6ykobGFbKlJF03nMhxzWAK1VQNn2UWnk0DEGVcxRK3vI+mD3WsBMxnCw6olIQ2LeGuWhEY2eqzw8wvF8ZAU8oFJxJoKlWf/2FmCGhzNaMpZQSTotmzyHwt4le4lJwqdZVtLNcuN4ZQHOdsg3NNqteXe30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721056520; c=relaxed/simple;
	bh=znSmUfWoC7rBrMs1rhKcz2Db5MhWL+xijXBzpkf0hw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Ex+75Gfjc/exq+tuxBUXYUasQforNcrj6WWQU8gv2JZ9fFwRDwDDKINeR3xqJ95v9A6/JO6cwIE+tAgsG5DupvJLzdzZcaHBBhXGOZEd1u+xe5Oda2mAJJBw9/PpUzSgV5yOducp/zmmR3NOV/XH60JvheO2T8lqnu5etNxdCbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=A2vCWne3; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <a2dd894e-7311-40e6-b3fb-050073109fc8@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721056516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWR3vzWpOfUMxQ0FtEPsE7YlYq0MdBZJ3U0xlrOYZ5E=;
	b=A2vCWne3Tray7xOi/gOJBlEMnVyzk0f0mub7o7SgoqbKDwPP8QzD7mHcQwMDgQ6mteXzSW
	MbPH/wC6LiPbCwPjSGDGPL5QA1J+e0FUn9tyG+rqX9aUC4Y4d49OfJIHX8HqjtWgb37f0I
	YgDE8INT7AHtc+5Kn8lXYICwH10UjRBtFcjBmjwh4JIGtEg0nv8SZ0jU2MTuB2vVEkcQ8n
	9OloaXj6lj1n+gVv5jUoYVAAEap2ntY3Kd59r7UICAaNgXnrj/8Q+fLRozkXMsBYB7OZu2
	FDpz3UgUGMMq7UkUD3gmFvoRIin5kgWNN8vnOkKE8I/FfvHmNFzm8MuUC7j12g==
Date: Mon, 15 Jul 2024 22:15:07 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add quirk for OrangePi Neo
To: Hans de Goede <hdegoede@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240715045818.1019979-1-philm@manjaro.org>
 <afc7f155-9442-4603-b276-78f3df1f2b8f@redhat.com>
Content-Language: en-US
Cc: 'Roman Gilg' <romangg@manjaro.org>, Furkan Kardame <f.kardame@manjaro.org>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <afc7f155-9442-4603-b276-78f3df1f2b8f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

Hi Hans,

thx for the fast pick-up of my patch. With the first sent of my patch 
the comment landed in the subject. Seems git needed an extra empty line 
to send out the patch properly.

On 15/7/24 20:46, Hans de Goede wrote:
> Hi,
> 
> On 7/15/24 6:57 AM, Philip Mueller wrote:
>> This adds a DMI orientation quirk for the OrangePi Neo Linux Gaming Handheld.
>>
>> Signed-off-by: Philip Mueller <philm@manjaro.org>
> 
> Thanks, patch looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> I have pushed this to drm-misc-fixes now.
> 
> Regards,
> 
> Hans
> 
> 
> 
>> ---
>>   drivers/gpu/drm/drm_panel_orientation_quirks.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> index 3860a8ce1e2d..903f4bfea7e8 100644
>> --- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> +++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
>> @@ -414,6 +414,12 @@ static const struct dmi_system_id orientation_data[] = {
>>   		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ONE XPLAYER"),
>>   		},
>>   		.driver_data = (void *)&lcd1600x2560_leftside_up,
>> +	}, {	/* OrangePi Neo */
>> +		.matches = {
>> +		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "OrangePi"),
>> +		  DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "NEO-01"),
>> +		},
>> +		.driver_data = (void *)&lcd1200x1920_rightside_up,
>>   	}, {	/* Samsung GalaxyBook 10.6 */
>>   		.matches = {
>>   		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
> 

-- 
Best, Philip


