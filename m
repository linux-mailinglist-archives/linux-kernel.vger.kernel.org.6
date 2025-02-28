Return-Path: <linux-kernel+bounces-539518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8D3A4A570
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 22:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EF23B41DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 21:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3801DE3D5;
	Fri, 28 Feb 2025 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hTWNkJCR"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EE51DE2C2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779671; cv=none; b=Sw3W3V6knnttV9F8JN6cn+KVNbDLfcSZ+SSYPn3AiaHpxD/Gn6wNo1zv1wzqzjsCuoEItuTOihpOvf/Yaq/k/65crSH1MWT6kw1bs7GiUY0T4aUITkdqVeIyH4XZvMtTN62WYgppotpEvm5TGhF9g+z7zngeuw/aUkSENyTAIYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779671; c=relaxed/simple;
	bh=SVycsf2vBTanvx9Jql8x6dueJJQBY1D3W6bCltuVcLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bRM97r8G3PievZyBOzDk1ureBQf+QvH9F+/7pCrLdLIo6/jDqOp/UfXMDRKgLjq1fdaTJjoT0+sCKK+37RwbmYKTgWMbt982yiELVC1NPQQe6cj0o8jZmQ38e7VV+h3hhe1oJPHa00GHTLUIRJUeLOITh66ndDgV5CtTuBifHS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hTWNkJCR; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XvT8i0gYAD/fd76Vlc8nu0fT/n8D8vv8feX230F+MwI=; b=hTWNkJCRHjsc07inGpzsYIM16D
	f3tsse1/4q/jB4/xdCp33PUMxmw71wqat/AyUd5z+a5wAGKGF05uAWtMHR0h4zICtGozTmTS7s6rm
	62yYkoFYgP+7yaUwzLbM6jKP7jJQFwK+tB2SoZsTOWftUqmLYKvtZmPklp2/lhxCZ1bUh32Fk2eeZ
	L/TF3rEg0N67ubYoPsBXVHzg1OKOVhQJKVGn5LkfxI3WBE4mA9WZ8aWpMBolZHxavpv8P/kmWlPhm
	M7GauGoIYyuaHk2xXbwfSCAz3Ui2G3iEAwtw46YHwFlbkcGhhCae/dY7vj22HDnRWttl+URF3E486
	X7jnIptw==;
Received: from [179.106.178.202] (helo=[192.168.5.235])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1to8JF-002H81-Q0; Fri, 28 Feb 2025 22:54:23 +0100
Message-ID: <58763d8e-46a1-4753-9401-987fb3dac50b@igalia.com>
Date: Fri, 28 Feb 2025 18:54:12 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm: Create an app info option for wedge events
To: Raag Jadav <raag.jadav@intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, amd-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?J0NocmlzdGlhbiBLw7ZuaWcn?= <christian.koenig@amd.com>,
 siqueira@igalia.com, airlied@gmail.com, simona@ffwll.ch,
 rodrigo.vivi@intel.com, jani.nikula@linux.intel.com, lucas.demarchi@intel.com
References: <20250228121353.1442591-1-andrealmeid@igalia.com>
 <20250228121353.1442591-2-andrealmeid@igalia.com>
 <Z8HGFRGOYvyCCWWu@black.fi.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <Z8HGFRGOYvyCCWWu@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Raag,

On 2/28/25 11:20, Raag Jadav wrote:
> Cc: Lucas
>
> On Fri, Feb 28, 2025 at 09:13:52AM -0300, André Almeida wrote:
>> When a device get wedged, it might be caused by a guilty application.
>> For userspace, knowing which app was the cause can be useful for some
>> situations, like for implementing a policy, logs or for giving a chance
>> for the compositor to let the user know what app caused the problem.
>> This is an optional argument, when `PID=-1` there's no information about
>> the app caused the problem, or if any app was involved during the hang.
>>
>> Sometimes just the PID isn't enough giving that the app might be already
>> dead by the time userspace will try to check what was this PID's name,
>> so to make the life easier also notify what's the app's name in the user
>> event.
>>
>> Signed-off-by: André Almeida <andrealmeid@igalia.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  2 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |  2 +-
>>   drivers/gpu/drm/drm_drv.c                  | 16 +++++++++++++---
>>   drivers/gpu/drm/i915/gt/intel_reset.c      |  3 ++-
>>   drivers/gpu/drm/xe/xe_device.c             |  3 ++-
>>   include/drm/drm_device.h                   |  8 ++++++++
>>   include/drm/drm_drv.h                      |  3 ++-
>>   7 files changed, 29 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 24ba52d76045..00b9b87dafd8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -6124,7 +6124,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>>   	atomic_set(&adev->reset_domain->reset_res, r);
>>   
>>   	if (!r)
>> -		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
>> +		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
>>   
>>   	return r;
>>   }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index ef1b77f1e88f..3ed9cbcab1ad 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -150,7 +150,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>   			amdgpu_fence_driver_force_completion(ring);
>>   			if (amdgpu_ring_sched_ready(ring))
>>   				drm_sched_start(&ring->sched, 0);
>> -			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
>> +			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
>>   			dev_err(adev->dev, "Ring %s reset succeeded\n", ring->sched.name);
>>   			goto exit;
>>   		}
>> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
>> index 17fc5dc708f4..48faafd82a99 100644
>> --- a/drivers/gpu/drm/drm_drv.c
>> +++ b/drivers/gpu/drm/drm_drv.c
>> @@ -522,6 +522,7 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
>>    * drm_dev_wedged_event - generate a device wedged uevent
>>    * @dev: DRM device
>>    * @method: method(s) to be used for recovery
>> + * @info: optional information about the guilty app
>>    *
>>    * This generates a device wedged uevent for the DRM device specified by @dev.
>>    * Recovery @method\(s) of choice will be sent in the uevent environment as
>> @@ -534,13 +535,14 @@ static const char *drm_get_wedge_recovery(unsigned int opt)
>>    *
>>    * Returns: 0 on success, negative error code otherwise.
>>    */
>> -int drm_dev_wedged_event(struct drm_device *dev, unsigned long method)
>> +int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>> +			 struct drm_wedge_app_info *info)
>>   {
>>   	const char *recovery = NULL;
>>   	unsigned int len, opt;
>>   	/* Event string length up to 28+ characters with available methods */
>> -	char event_string[32];
>> -	char *envp[] = { event_string, NULL };
>> +	char event_string[32], pid_string[15], comm_string[TASK_COMM_LEN];
>> +	char *envp[] = { event_string, pid_string, comm_string, NULL };
>>   
>>   	len = scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=");
>>   
>> @@ -562,6 +564,14 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method)
>>   	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
>>   		 "but recovered through reset" : "needs recovery");
>>   
>> +	if (info) {
>> +		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
>> +		snprintf(comm_string, sizeof(comm_string), "APP=%s", info->comm);
>> +	} else {
>> +		snprintf(pid_string, sizeof(pid_string), "%s", "PID=-1");
>> +		snprintf(comm_string, sizeof(comm_string), "%s", "APP=none");
>> +	}
> This is not much use for wedge cases that needs recovery, since at that point
> the userspace will need to clean house anyway.
>
> Which leaves us with only 'none' case and perhaps the need for standardization
> of "optional telemetry collection".
>
> Thoughts?

I had the feeling that 'none' was already meant to be used for that. Do 
you think we should move to another naming? Given that we didn't reach 
the merge window yet we could potentially change that name without much 
damage.

> Raag
>

