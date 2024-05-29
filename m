Return-Path: <linux-kernel+bounces-193881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5588D3399
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 11:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A16B26BF6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17983175570;
	Wed, 29 May 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="McsTEN60"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A498116EBF2;
	Wed, 29 May 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976113; cv=none; b=JHrFzVQrpIrzDszNKYYHQW0OkP5r7Argkbn267Zr8j4ul35IUOSFTEEdOaUjM357pyIu539s14E31u+0PZMjOcYjn4l8U4iWAf7P0jT3//TzakkEH07RkQe1IwdQDwgifHUEl6OCM5LNG1iwN69trAdawlHKK3232mQpU7UFuNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976113; c=relaxed/simple;
	bh=qf6ymj3RFfkiiaCFpxQKjdAF3Bl843ub+B+34Y8z/as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddeTPaKBOWT+jjV65vVm2Xf+eX4cEZ0CqEdONuuT//WJo2RCTuU5xf1lw4LgE8hsUR0ZDFgD/Eym8RY47qqxu+xqzbfVy0Njmq3zUwHqT20s9MwXSupysjTJjACKkiNyTJnN4GaYgwO8asGNfhOw8GHmcC0+/HnyRuKcguB1sUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=McsTEN60; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716976108;
	bh=qf6ymj3RFfkiiaCFpxQKjdAF3Bl843ub+B+34Y8z/as=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=McsTEN60Vjt8NdHBol50pxTr9PPR0mANAwkso+KggPtbLZ96gx6WFt39jPm6RaST2
	 9WqjTcIfbEqEMhdoXNljZZnOeUD6j0Y4bb4lPy08ZQ3TCXVOmmqJSvKdPGkTUDWURP
	 VXfmKfgIig01ItkT2gCBlOaVsCXhP8ScrJn91p4t5ICU3QWERtAcUqalqq35HiaG4h
	 0q5we2lYK1Ihh8muJAvwG+jH9RT1I3ZRltKrUpY80G3rY4+t/ccXt201Zkg9R2Oz77
	 FaIYlc7dSvWos34mvwzBQejHsnFwEeLUGa2WrJvFiFAgKvkFZSmJrJh+6Z7HPjYq7C
	 Dvhq2jHBKWPTQ==
Received: from [100.66.96.193] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 86B76378205D;
	Wed, 29 May 2024 09:48:24 +0000 (UTC)
Message-ID: <12f14064-fd1c-4e9c-94ee-ba7d492a4056@collabora.com>
Date: Wed, 29 May 2024 15:18:22 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] drm/ci: uprev IGT
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.koike@collabora.com, airlied@gmail.com, daniel@ffwll.ch,
 robdclark@gmail.com, david.heidelberg@collabora.com,
 guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com,
 mcanal@igalia.com, linux-mediatek@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 amd-gfx@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <20240529024049.356327-1-vignesh.raman@collabora.com>
 <20240529024049.356327-5-vignesh.raman@collabora.com>
 <bj6mpegmxo6i5o34xyxwiytdaokv2u6p5iu4eoek3ctqimwviy@jbo5aw7gy4ue>
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <bj6mpegmxo6i5o34xyxwiytdaokv2u6p5iu4eoek3ctqimwviy@jbo5aw7gy4ue>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 29/05/24 13:39, Dmitry Baryshkov wrote:
> On Wed, May 29, 2024 at 08:10:47AM +0530, Vignesh Raman wrote:
>> test-list.txt and test-list-full.txt are not generated for
>> cross-builds and they are required by drm-ci for testing
>> arm32 targets. This is fixed in igt-gpu-tools. So uprev
>> IGT to include the commit which fixes this issue. Also
>> disable building xe driver tests for non-intel platforms.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> ---
>>
>> v2:
>>    - Split IGT uprev to seperate patch.
>>
>> v3:
>>    - No changes.
>>
>> ---
>>   drivers/gpu/drm/ci/build-igt.sh  | 4 ++++
>>   drivers/gpu/drm/ci/gitlab-ci.yml | 2 +-
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/ci/build-igt.sh b/drivers/gpu/drm/ci/build-igt.sh
>> index b7d2a49a6db3..eddb5f782a5e 100644
>> --- a/drivers/gpu/drm/ci/build-igt.sh
>> +++ b/drivers/gpu/drm/ci/build-igt.sh
>> @@ -45,6 +45,10 @@ MESON_OPTIONS="-Doverlay=disabled                    \
>>                  -Dlibunwind=enabled                   \
>>                  -Dprefix=/igt"
>>   
>> +if [[ "$KERNEL_ARCH" = "arm64" ]] || [[ "$KERNEL_ARCH" = "arm" ]]; then
>> +    MESON_OPTIONS="$MESON_OPTIONS -Dxe_driver=disabled"
>> +fi
>> +
>>   mkdir -p /igt
>>   meson build $MESON_OPTIONS $EXTRA_MESON_ARGS
>>   ninja -C build -j${FDO_CI_CONCURRENT:-4} || ninja -C build -j 1
>> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
>> index 8f32de63d92e..1b29c3b6406b 100644
>> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
>> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
>> @@ -5,7 +5,7 @@ variables:
>>     UPSTREAM_REPO: git://anongit.freedesktop.org/drm/drm
>>     TARGET_BRANCH: drm-next
>>   
>> -  IGT_VERSION: d2af13d9f5be5ce23d996e4afd3e45990f5ab977
>> +  IGT_VERSION: 0df7b9b97f9da0e364f5ee30fe331004b8c86b56
> 
> Let's land this, then I'll ask to uprev to
> dc2d7fb4f978048b87707ea9ec32da748b01b378, which fixes an issue with the
> writeback tests on MSM devices.

Sure. Once this is merged, we can uprev to the latest IGT.

Regards,
Vignesh

> 
>>   
>>     DEQP_RUNNER_GIT_URL: https://gitlab.freedesktop.org/anholt/deqp-runner.git
>>     DEQP_RUNNER_GIT_TAG: v0.15.0
>> -- 
>> 2.40.1
>>
> 

