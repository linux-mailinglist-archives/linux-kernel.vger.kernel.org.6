Return-Path: <linux-kernel+bounces-369740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D09A21F9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6821C21A87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6AE1DD0E0;
	Thu, 17 Oct 2024 12:16:38 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AA1D517D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729167397; cv=none; b=un5IFqY/SkVx2KjKF8sJ1kz0ZLBsU4JPeJdxZM9yBYdDsPw3ag0awJ1i+GQ06CwgOuMvVnnWXP3f9BhYofv9f1WFYmJOjcqVt4mE2/CIEpQGygTgrTRU6P8Kwpdo8w2vQhGFu80UGo7FpJoAeLdYqY/PtyMeJfQIWSZgZeVZ5Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729167397; c=relaxed/simple;
	bh=xxFpiy1c6sfeEWDjUQ5vY27/eiHLweEmueOk3IZiqRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mSNwEpBfTDwbVOYyhE1uyTpzOCcbO2ZP8SuaHFA8WcRU2FA/zrjG9WjPhc7CT+163p4BF3X+a0qiWOb8U1yrWZTZD6FJLIMbihzwG3EZhVQvu1Nv9qfJVp081bh3dmIkmFvk5WzjcBx9r7dmETP5ZAPjxzwNzk3kaf9LLktbiWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XTmzB2JVpz1ynDc;
	Thu, 17 Oct 2024 20:16:38 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 3584A1400CF;
	Thu, 17 Oct 2024 20:16:32 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Oct 2024 20:16:30 +0800
Message-ID: <2621a412-1ca6-5282-ffba-30b544466076@huawei.com>
Date: Thu, 17 Oct 2024 20:16:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/4] drm/tests: helpers: Add helper for
 drm_display_mode_from_cea_vic()
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>
CC: <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <christian.koenig@amd.com>,
	<ray.huang@amd.com>, <dmitry.baryshkov@linaro.org>,
	<dave.stevenson@raspberrypi.com>, <mcanal@igalia.com>,
	<quic_jjohnson@quicinc.com>, <skhan@linuxfoundation.org>,
	<davidgow@google.com>, <karolina.stolarek@intel.com>,
	<Arunpravin.PaneerSelvam@amd.com>, <thomas.hellstrom@linux.intel.com>,
	<asomalap@amd.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20241014125204.1294934-1-ruanjinjie@huawei.com>
 <20241014125204.1294934-2-ruanjinjie@huawei.com>
 <20241016-poised-athletic-adder-ef2998@houat>
 <8ddc72c9-8662-59d0-c3b6-904f2688cb29@huawei.com>
 <20241017-fearless-terrier-from-avalon-b9769f@houat>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241017-fearless-terrier-from-avalon-b9769f@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/10/17 20:13, Maxime Ripard wrote:
> On Thu, Oct 17, 2024 at 09:33:07AM GMT, Jinjie Ruan wrote:
>>>> diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
>>>> index e7cc17ee4934..1e7fd4be550c 100644
>>>> --- a/include/drm/drm_kunit_helpers.h
>>>> +++ b/include/drm/drm_kunit_helpers.h
>>>> @@ -4,6 +4,7 @@
>>>>  #define DRM_KUNIT_HELPERS_H_
>>>>  
>>>>  #include <drm/drm_drv.h>
>>>> +#include <drm/drm_edid.h>
>>>>
>>>>  #include <linux/device.h>
>>>>  
>>>> @@ -120,4 +121,9 @@ drm_kunit_helper_create_crtc(struct kunit *test,
>>>>  			     const struct drm_crtc_funcs *funcs,
>>>>  			     const struct drm_crtc_helper_funcs *helper_funcs);
>>>>  
>>>> +struct drm_display_mode *
>>>> +drm_kunit_helper_display_mode_from_cea_vic(struct kunit *test,
>>>> +					   struct drm_device *dev,
>>>> +					   u8 video_code);
>>>
>>> It's not clear to me what you need the drm_edid header, you just return
>>> a drm_display_mode pointer so you can just forward declare the structure
>>
>>
>> There is a compile error without the header，because there is no
>> "drm_display_mode_from_cea_vic()" declare.
>>
>> drivers/gpu/drm/tests/drm_kunit_helpers.c:341:16: error: implicit
>> declaration of function ‘drm_display_mode_from_cea_vic’; did you mean
>> ‘drm_kunit_display_mode_from_cea_vic’?
>> [-Werror=implicit-function-declaration]
>>   341 |         mode = drm_display_mode_from_cea_vic(dev, video_code);
>>       |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>       |                drm_kunit_display_mode_from_cea_vic
>> drivers/gpu/drm/tests/drm_kunit_helpers.c:341:14: warning: assignment to
>> ‘struct drm_display_mode *’ from ‘int’ makes pointer from integer
>> without a cast [-Wint-conversion]
>>   341 |         mode = drm_display_mode_from_cea_vic(dev, video_code);
>>       |              ^
> > Right, but the error is in the C file, not the header.

Yes, I have updated it to C file in V3, thank you!

> 
> Maxime

