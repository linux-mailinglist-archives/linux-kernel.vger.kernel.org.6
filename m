Return-Path: <linux-kernel+bounces-537681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD701A48F0D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18FE3B4416
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69F816ABC6;
	Fri, 28 Feb 2025 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="op4mOU0P"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8EA15A87C
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740712739; cv=none; b=b3Fvty4dsoT6dpMr0p7Vo3Rxiv0JQgZ7FGDmgX5d2A2CLmD3qSpdo9ttQ+MLWfE7xqnPE+Y/9LYbsOLDk30md7pQ5s2gd2QKbFSPGEiahF+/7H9Lol+TY/7L5zK1aNIX8uSgqgtHwmO/tXYV4P4FLJHzwhBPj6UaRh5B/JGvN4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740712739; c=relaxed/simple;
	bh=fC4XySks2OrtI2BeNQrnGvm03KhQ8Zp0VSzwI/DVunQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LppQLPM4xkGxRCBwl1cSpUaJpGBVLrqgoP9Infe1KdChWK63PYb+efXMkdBqRxofXWM2dtuKe0VIZO3iuueMZU+wzxuIK0QEon6zn4yJkJvxI6mXstNlYKUqsqy+sIM0As/hLYeKhLLd3LxQvzbGInxG/BycPXQSSQ0mPBmjYgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=op4mOU0P; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1740712734;
	bh=fC4XySks2OrtI2BeNQrnGvm03KhQ8Zp0VSzwI/DVunQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=op4mOU0P5ExOI1miPRWPl+bw9lwVxDscJVXPeW75Q03ckRuDQON72jXoUv9/mWNCB
	 QxHSDVZNLf6zE02BZkdOEpXVD/O9mNc8g57laJos6LLzNQLiO9GLd2YStauYabWKh5
	 a0YQ6xTqdmysY5Hv5ksrdtxZ2R3bO0KJ3IkHEMZmsTmOIoHZ1ipl1zya8mCdjH7h/P
	 kgWUsg0vCu/6SQAoep8W6Lj2mOXu1doS7GDjGOPCtx/AZ5OgYglEWUGt6EIxoyWi1G
	 QQ4T/YB6JebF1DV5EeROw66LCexvfuQ8xODRnbfV3/qyPsxAORHeo26P/flhQeXDEz
	 EzzPcNbsgUE5g==
Received: from [192.168.50.250] (unknown [171.76.85.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E58EA17E0663;
	Fri, 28 Feb 2025 04:18:51 +0100 (CET)
Message-ID: <b7c1ca07-e59e-4819-b81a-d4c53c11f830@collabora.com>
Date: Fri, 28 Feb 2025 08:48:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm/ci: remove CI_PRE_CLONE_SCRIPT
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com,
 helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch,
 robdclark@gmail.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, guilherme.gallo@collabora.com,
 sergi.blanch.torne@collabora.com, valentine.burley@collabora.com,
 linux-kernel@vger.kernel.org
References: <20250227043640.411696-1-vignesh.raman@collabora.com>
 <ukzyfymij2yilyy7ofyi3hj4urlrxxbx5rre3f7qg4zgkc65u5@vbutj63ucctc>
Content-Language: en-US
From: Vignesh Raman <vignesh.raman@collabora.com>
In-Reply-To: <ukzyfymij2yilyy7ofyi3hj4urlrxxbx5rre3f7qg4zgkc65u5@vbutj63ucctc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 27/02/25 11:21, Dmitry Baryshkov wrote:
> On Thu, Feb 27, 2025 at 10:06:24AM +0530, Vignesh Raman wrote:
>> If we are not caching the git archive, do not
>> set CI_PRE_CLONE_SCRIPT. Setting it makes CI
>> try to download the cache first, and if it is
>> missing, it tries to clone the repo within a
>> time limit, which can cause build failures.
> 
> Please wrap the commit message according to the guidelines. 47 chars in
> a line is way too short.
> 
> BTW: this didn't help with the python-artifacts issue. It still times
> out.

The issue was with shallow cloning, and I have posted another patch.
https://lore.kernel.org/dri-devel/20250228031501.483475-1-vignesh.raman@collabora.com/T/#u

The commit message is wrapped according to the guidelines in this patch.

Thanks.

Regards,
Vignesh

> 
>>
>> Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
>> ---
>>   drivers/gpu/drm/ci/gitlab-ci.yml | 6 ------
>>   1 file changed, 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
>> index f4e324e156db..0bc4ac344757 100644
>> --- a/drivers/gpu/drm/ci/gitlab-ci.yml
>> +++ b/drivers/gpu/drm/ci/gitlab-ci.yml
>> @@ -13,12 +13,6 @@ variables:
>>     FDO_UPSTREAM_REPO: helen.fornazier/linux   # The repo where the git-archive daily runs
>>     MESA_TEMPLATES_COMMIT: &ci-templates-commit d5aa3941aa03c2f716595116354fb81eb8012acb
>>     DRM_CI_PROJECT_URL: https://gitlab.freedesktop.org/${DRM_CI_PROJECT_PATH}
>> -  CI_PRE_CLONE_SCRIPT: |-
>> -          set -o xtrace
>> -          curl -L --retry 4 -f --retry-all-errors --retry-delay 60 -s ${DRM_CI_PROJECT_URL}/-/raw/${DRM_CI_COMMIT_SHA}/.gitlab-ci/download-git-cache.sh -o download-git-cache.sh
>> -          bash download-git-cache.sh
>> -          rm download-git-cache.sh
>> -          set +o xtrace
>>     S3_JWT_FILE: /s3_jwt
>>     S3_JWT_FILE_SCRIPT: |-
>>         echo -n '${S3_JWT}' > '${S3_JWT_FILE}' &&
>> -- 
>> 2.47.2
>>
> 


