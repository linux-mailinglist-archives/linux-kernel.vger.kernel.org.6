Return-Path: <linux-kernel+bounces-369027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC69A17F2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 03:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237951F214FC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EB61C695;
	Thu, 17 Oct 2024 01:33:23 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3ED101C8
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 01:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729128802; cv=none; b=prJtrH3dV3a75c33vmET+QjzLg1bjUE22BZOFcCH5+74/cIAqLloSsoq8W0H35fnKTAXT90ru3fkfyQj/dCxNKR+vxD2I2LmknlVNiKYrKjJbs3DpI+rYyv//HzgQ62zMjjS5/lY2uT6D1WyJUqzJQTDGQH2tVGKivNghNVbsWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729128802; c=relaxed/simple;
	bh=FGlYbBRb0UnNiEVWLyTkNIhYYRhzXYfvNrn0qkG9CJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GIykuS651o7XIY+wXhC66hsdb8908RyaD01ceBay378RIzCePfHYaozZESfyr6WxyEOhA/k0AOiLvVcQfS3s6/n8SgKb/L7E4gpkrbm5+ivCSk48QdZCrKvnN088qlocLgjgvCZlNxvj9sR3W2s526UDVgWC+sBprkMUz4lntJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XTVgG1rxYz1SCpK;
	Thu, 17 Oct 2024 09:31:54 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id CE4B7140157;
	Thu, 17 Oct 2024 09:33:09 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Oct 2024 09:33:08 +0800
Message-ID: <8ddc72c9-8662-59d0-c3b6-904f2688cb29@huawei.com>
Date: Thu, 17 Oct 2024 09:33:07 +0800
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
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241016-poised-athletic-adder-ef2998@houat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/10/16 17:35, Maxime Ripard wrote:
> On Mon, Oct 14, 2024 at 08:52:01PM GMT, Jinjie Ruan wrote:
>> As Maxime suggested, add a new helper
>> drm_kunit_helper_display_mode_from_cea_vic(), it can replace
>> the direct call of drm_display_mode_from_cea_vic(), and it will
>> help solving the `mode` memory leaks.
>>
>> Suggested-by: Maxime Ripard <mripard@kernel.org>
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>>  drivers/gpu/drm/tests/drm_kunit_helpers.c | 40 +++++++++++++++++++++++
>>  include/drm/drm_kunit_helpers.h           |  6 ++++
>>  2 files changed, 46 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
>> index aa62719dab0e..dc70bafcd394 100644
>> --- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
>> +++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
>> @@ -311,6 +311,46 @@ drm_kunit_helper_create_crtc(struct kunit *test,
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
>> + * drm_kunit_helper_display_mode_from_cea_vic() - return a mode for CEA VIC
>> +						  for a KUnit test
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
>> +drm_kunit_helper_display_mode_from_cea_vic(struct kunit *test,
>> +					   struct drm_device *dev,
>> +					   u8 video_code)
>> +{
>> +	struct drm_display_mode *mode;
>> +	int ret;
>> +
>> +	mode = drm_display_mode_from_cea_vic(dev, video_code);
>> +
>> +	ret = kunit_add_action_or_reset(test,
>> +					kunit_action_drm_mode_destroy,
>> +					mode);
>> +	if (ret)
>> +		return NULL;
>> +
>> +	return mode;
>> +}
>> +EXPORT_SYMBOL_GPL(drm_kunit_helper_display_mode_from_cea_vic);
>> +
> 
> I think you can drop the "helper" name there, it's usually reserved for
> blanket implementation of DRM hooks. This one isn't a hook, so just
> calling it drm_kunit_display_mode_from_cea_vic makes a bit more sense to
> me.
> 
>>  MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
>>  MODULE_DESCRIPTION("KUnit test suite helper functions");
>>  MODULE_LICENSE("GPL");
>> diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
>> index e7cc17ee4934..1e7fd4be550c 100644
>> --- a/include/drm/drm_kunit_helpers.h
>> +++ b/include/drm/drm_kunit_helpers.h
>> @@ -4,6 +4,7 @@
>>  #define DRM_KUNIT_HELPERS_H_
>>  
>>  #include <drm/drm_drv.h>
>> +#include <drm/drm_edid.h>
>>
>>  #include <linux/device.h>
>>  
>> @@ -120,4 +121,9 @@ drm_kunit_helper_create_crtc(struct kunit *test,
>>  			     const struct drm_crtc_funcs *funcs,
>>  			     const struct drm_crtc_helper_funcs *helper_funcs);
>>  
>> +struct drm_display_mode *
>> +drm_kunit_helper_display_mode_from_cea_vic(struct kunit *test,
>> +					   struct drm_device *dev,
>> +					   u8 video_code);
> 
> It's not clear to me what you need the drm_edid header, you just return
> a drm_display_mode pointer so you can just forward declare the structure


There is a compile error without the header，because there is no
"drm_display_mode_from_cea_vic()" declare.

drivers/gpu/drm/tests/drm_kunit_helpers.c:341:16: error: implicit
declaration of function ‘drm_display_mode_from_cea_vic’; did you mean
‘drm_kunit_display_mode_from_cea_vic’?
[-Werror=implicit-function-declaration]
  341 |         mode = drm_display_mode_from_cea_vic(dev, video_code);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      |                drm_kunit_display_mode_from_cea_vic
drivers/gpu/drm/tests/drm_kunit_helpers.c:341:14: warning: assignment to
‘struct drm_display_mode *’ from ‘int’ makes pointer from integer
without a cast [-Wint-conversion]
  341 |         mode = drm_display_mode_from_cea_vic(dev, video_code);
      |              ^


> 
> Once fixed
> Acked-by: Maxime Ripard <mripard@kernel.org>
> 
> Maxime

