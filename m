Return-Path: <linux-kernel+bounces-555155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E5EA5A62F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62B5188AF5A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F211E47DD;
	Mon, 10 Mar 2025 21:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LlnBkGWx"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B01E5201
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642098; cv=none; b=doC6KC9rz9Y4hjEE4SDTM+Rkl9Io1V008sXz342jWyFGhmqDERhz4bEqmd+HKx4sNwlb8HqAjbruFAsjvpApjjYhx9tBu1ls0tM5VuFGoq/yX2IIqs4QXnkq0cFPzV3JovSJzT7B9WfhCl2guucxYunYEL5+KGuo+MO2Qis3cLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642098; c=relaxed/simple;
	bh=oJcRy0C6A9N83cK7nsZviOirJ21zn63Ib1laqW68HHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=urSADwguaMuiGgiSmTolgRiGCOxZuWI736GDDR5p99sdw7B08gW0WjyGPVfDygQq8HOl1HbwzFeSM0aFEICdWXL3c4m7y+yX7o9//hA5eN29GaOo3XM98bTzqMe6L3VnN0oXN6NndFPOq2DngWlqKvyxvKV3VMODAAkFXTi3cs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LlnBkGWx; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FahhrGFnxsHK71HoADExrTx+Kq0ZC+lhv0xf5Xsw7i8=; b=LlnBkGWxMA55UU1xzyyCQp3qZq
	C3SYJRCJzHL3z+Yb08fwmmb+M1ssvs0PBHBQVloBuRkwWGZ5kC9GyH/NdVLq8/H5Hpy6gufEo+IMD
	YYZqgEujrFI0inibds5S7vmg/ScQ/fntMsWFIeCTJ0kP4NCBML+nxCRfdffYzVuixZPZV4q+Me+Xg
	SSsUUJNO363P9AZhV7Dcrb7GQ0pZDIuKCzhdUseQxTqb4cQw/8MfZo41JC+DJChq9XpJl4AuVL9vc
	6TJ8DDugh1EUORIHJeYIuFs9LD0AQnZmzV4tyNT53KZZmyiIjJTenRvIs1ZdYIV7HSCDJ3IqgvMAS
	S8NCgsVw==;
Received: from [191.204.194.148] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1trkfG-006fFj-El; Mon, 10 Mar 2025 22:28:04 +0100
Message-ID: <db27ee44-f480-475b-be7e-710bd30eb7a5@igalia.com>
Date: Mon, 10 Mar 2025 18:27:53 -0300
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
 rodrigo.vivi@intel.com, jani.nikula@linux.intel.com,
 lucas.demarchi@intel.com, Xaver Hugl <xaver.hugl@kde.org>
References: <20250228121353.1442591-1-andrealmeid@igalia.com>
 <20250228121353.1442591-2-andrealmeid@igalia.com>
 <Z8HGFRGOYvyCCWWu@black.fi.intel.com>
 <58763d8e-46a1-4753-9401-987fb3dac50b@igalia.com>
 <Z8KgwswQQyGxhsR1@black.fi.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <Z8KgwswQQyGxhsR1@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 01/03/2025 02:53, Raag Jadav escreveu:
> On Fri, Feb 28, 2025 at 06:54:12PM -0300, André Almeida wrote:
>> Hi Raag,
>>
>> On 2/28/25 11:20, Raag Jadav wrote:
>>> Cc: Lucas
>>>
>>> On Fri, Feb 28, 2025 at 09:13:52AM -0300, André Almeida wrote:
>>>> When a device get wedged, it might be caused by a guilty application.
>>>> For userspace, knowing which app was the cause can be useful for some
>>>> situations, like for implementing a policy, logs or for giving a chance
>>>> for the compositor to let the user know what app caused the problem.
>>>> This is an optional argument, when `PID=-1` there's no information about
>>>> the app caused the problem, or if any app was involved during the hang.
>>>>
>>>> Sometimes just the PID isn't enough giving that the app might be already
>>>> dead by the time userspace will try to check what was this PID's name,
>>>> so to make the life easier also notify what's the app's name in the user
>>>> event.
>>>>
>>>> Signed-off-by: André Almeida <andrealmeid@igalia.com>

[...]

>>>>    	len = scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=");
>>>> @@ -562,6 +564,14 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method)
>>>>    	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
>>>>    		 "but recovered through reset" : "needs recovery");
>>>> +	if (info) {
>>>> +		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);
>>>> +		snprintf(comm_string, sizeof(comm_string), "APP=%s", info->comm);
>>>> +	} else {
>>>> +		snprintf(pid_string, sizeof(pid_string), "%s", "PID=-1");
>>>> +		snprintf(comm_string, sizeof(comm_string), "%s", "APP=none");
>>>> +	}
>>> This is not much use for wedge cases that needs recovery, since at that point
>>> the userspace will need to clean house anyway.
>>>
>>> Which leaves us with only 'none' case and perhaps the need for standardization
>>> of "optional telemetry collection".
>>>
>>> Thoughts?
>>
>> I had the feeling that 'none' was already meant to be used for that. Do you
>> think we should move to another naming? Given that we didn't reach the merge
>> window yet we could potentially change that name without much damage.
> 
> No, I meant thoughts on possible telemetry data that the drivers might
> think is useful for userspace (along with PID) and can be presented in
> a vendor agnostic manner (just like wedged event).

I'm not if I agree that this will only be used for telemetry and for the 
`none` use case. As stated by Xaver, there's use case to know which app 
caused the device to get wedged (like switching to software rendering) 
and to display something for the user after the recovery is done (e.g. 
"The game <app name> stopped working and Plasma has reset").

