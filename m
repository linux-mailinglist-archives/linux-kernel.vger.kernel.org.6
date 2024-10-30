Return-Path: <linux-kernel+bounces-388036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB389B5993
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5121F24593
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 01:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D06842AA2;
	Wed, 30 Oct 2024 01:48:45 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171C3398E
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 01:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252924; cv=none; b=R6gQcDeiRD8iwtnOL0OixsH3PEfrH9kUmW+Q3HlgJQdldaeIr9Fu6mwBchT7o6UrW9etxRRz24F80Vetw27mXdF+kj9RnM1eVR1j5Irr6cJRCP/GmFIuRU5P9cmxjBz4EKaeN1IXqknJsC52jOnhSFeXXcY0wYMxGW0tsmuQNkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252924; c=relaxed/simple;
	bh=rhoaOuqDJNil2klkhAws95rS0vuhTdTcJ9PE/AzBKWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sH5KiPBwczM4QNVMhK5Qaad/18maHRZXUVj/hwaedCgdc90NTpvMdK0AGW9y1Et+Qs2eIc2h1wXDg5YVzRFrx9Fk70v6jWM+wy2JG5PJpHVgbyiAyK/fBotbh/HqQp2gcnJnT2WXAP3x2DNrxtT7lxEuuEmHBO8L1By3F+1t3Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XdVMX1QH6zDqV3;
	Wed, 30 Oct 2024 09:46:00 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id 920A91400DC;
	Wed, 30 Oct 2024 09:48:33 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Oct 2024 09:48:32 +0800
Message-ID: <81fb3a17-4e2d-d21e-71a1-222b85b0ff9b@huawei.com>
Date: Wed, 30 Oct 2024 09:48:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 1/4] drm/tests: helpers: Add helper for
 drm_display_mode_from_cea_vic()
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>
CC: <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
	<airlied@gmail.com>, <simona@ffwll.ch>, <christian.koenig@amd.com>,
	<ray.huang@amd.com>, <dmitry.baryshkov@linaro.org>,
	<dave.stevenson@raspberrypi.com>, <quic_jjohnson@quicinc.com>,
	<mcanal@igalia.com>, <davidgow@google.com>, <skhan@linuxfoundation.org>,
	<karolina.stolarek@intel.com>, <Arunpravin.PaneerSelvam@amd.com>,
	<thomas.hellstrom@linux.intel.com>, <asomalap@amd.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20241017063125.3080347-1-ruanjinjie@huawei.com>
 <20241017063125.3080347-2-ruanjinjie@huawei.com>
 <20241029-dancing-hissing-bullfrog-b6d0ed@houat>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241029-dancing-hissing-bullfrog-b6d0ed@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/29 16:16, Maxime Ripard wrote:
> On Thu, Oct 17, 2024 at 02:31:22PM +0800, Jinjie Ruan wrote:
>> As Maxime suggested, add a new helper
>> drm_kunit_display_mode_from_cea_vic(), it can replace the direct call
>> of drm_display_mode_from_cea_vic(), and it will help solving
>> the `mode` memory leaks.
>>
>> Acked-by: Maxime Ripard <mripard@kernel.org>
>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v3:
>> - Adjust drm/drm_edid.h header to drm_kunit_helpers.c.
>> - Drop the "helper" in the helper name.
>> - Add Acked-by.
>> ---
>>  drivers/gpu/drm/tests/drm_kunit_helpers.c | 40 +++++++++++++++++++++++
>>  include/drm/drm_kunit_helpers.h           |  4 +++
>>  2 files changed, 44 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
>> index aa62719dab0e..565172990044 100644
>> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
>> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
>> @@ -3,6 +3,7 @@
>>  #include <drm/drm_atomic.h>
>>  #include <drm/drm_atomic_helper.h>
>>  #include <drm/drm_drv.h>
>> +#include <drm/drm_edid.h>
>>  #include <drm/drm_fourcc.h>
>>  #include <drm/drm_kunit_helpers.h>
>>  #include <drm/drm_managed.h>
>> @@ -311,6 +312,45 @@ drm_kunit_helper_create_crtc(struct kunit *test,
>>  }
>>  EXPORT_SYMBOL_GPL(drm_kunit_helper_create_crtc);
>>  
>> +static void kunit_action_drm_mode_destroy(void *ptr)
>> +{
>> +	struct drm_display_mode *mode = ptr;
>> +
>> +	drm_mode_destroy(NULL, mode);
>> +}
>> +
>> +/**
>> + * drm_kunit_display_mode_from_cea_vic() - return a mode for CEA VIC
>> +					   for a KUnit test
>> + * @test: The test context object
>> + * @dev: DRM device
>> + * @video_code: CEA VIC of the mode
>> + *
>> + * Creates a new mode matching the specified CEA VIC for a KUnit test.
>> + *
>> + * Resources will be cleaned up automatically.
>> + *
>> + * Returns: A new drm_display_mode on success or NULL on failure
>> + */
>> +struct drm_display_mode *
>> +drm_kunit_display_mode_from_cea_vic(struct kunit *test, struct drm_device *dev,
>> +				    u8 video_code)
>> +{
>> +	struct drm_display_mode *mode;
>> +	int ret;
>> +
>> +	mode = drm_display_mode_from_cea_vic(dev, video_code);
> 
> I'd rather return directly if mode is NULL here...
> 
>> +	ret = kunit_add_action_or_reset(test,
>> +					kunit_action_drm_mode_destroy,
>> +					mode);
>> +	if (ret)
>> +		return NULL;
> 
> Because it doesn't really make much sense to register a cleanup action
> if we know that it's going to be useless, and possibly be executed right
> away.

Sure, will udpate it.

> 
> Maxime

