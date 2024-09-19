Return-Path: <linux-kernel+bounces-333820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46F997CE84
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 22:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C82A283700
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B4B14A4D2;
	Thu, 19 Sep 2024 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="m707pfNk"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F01CD15
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 20:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726778110; cv=none; b=ooNqC5fP72yCLGIquTwG+D1PNVQD1aTjPMy7q1yCsf33+n6Bc+AV1m/Ff5Z+btFp0PfLXIQKzKhvhmEVPNsGmovn6yNeWbSZPRLdsHQ5C7mGDtoZ/oMgBKy/89GPYJy1NvsnJPqh1vXgGkYts9+HD4Fp/50XzrHBtgjYW0JXjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726778110; c=relaxed/simple;
	bh=vLmxEphw6+wrRCdlVpHFnwOKk5//YBsqWF77UaNubgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oQdFCJqgN+UmCGbY8jaMe5Z310PIbz3b74jjhBXbfiqSoo8ts1iqHcIrzPAHQ/JrGRIPeO7OdWZ49LvswhU1jF1OYzaY0JTuk4400k3qB1X7o88G5YrqGtDWv+dkHjoeD8bFD6TTYKztNgYixIUXlb6vl9/7wV/Bt7d/AdoPbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=m707pfNk; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1726778091;
 bh=zz0FhRzCqVonO5BnvIqXHA8hVDwCov/EtnoRwJVPDww=;
 b=m707pfNklfj/F8bhdreoIYRnK6174Bsmox46pbvtGF+gFGVjCH6xcUJuOyK/ZIVso23Z+1X+m
 W8TlEP0LE067dPNfiu0Bj5gLqO8RSDmILIRlW03DNqnDwb5Hmcs1YvrPwINgO6gnrNfgcZ0OHMQ
 nW94IXG8eoC3CKG2KIXK9FZCEWhMU0PRkWN58ZCBK+jzKQ5k1qsBe9PoaumAZNPiHSeWcD/+VPU
 U8+gYLkvGGJawYU7CdRrzeAaGwZK9PSEzO6w9a6O7YL2/TIHkLMTGcl7Y15VRBuq6wai0bcn5Bf
 4eFpFaMXqEho5m61UR1zNR3QVvCRf4QjEsqzGUEKHaqQ==
Message-ID: <0dcb03be-dae1-4dcb-84d8-6ec204eab6ba@kwiboo.se>
Date: Thu, 19 Sep 2024 22:34:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] drm: bridge: dw_hdmi: Update EDID during hotplug
 processing
To: neil.armstrong@linaro.org
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240908132823.3308029-1-jonas@kwiboo.se>
 <20240908132823.3308029-10-jonas@kwiboo.se>
 <4bc6a5e6-f2cf-43ab-8555-4f8aaf9f2cd0@linaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <4bc6a5e6-f2cf-43ab-8555-4f8aaf9f2cd0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66ec8ae664435c8d6510ab67

Hi Neil,

On 2024-09-13 10:02, Neil Armstrong wrote:
> On 08/09/2024 15:28, Jonas Karlman wrote:
>> Update successfully read EDID during hotplug processing to ensure the
>> connector diplay_info is always up-to-date.
>>
>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>> ---
>> v2: No change
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> index c19307120909..7bd9f895f03f 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>> @@ -2457,6 +2457,18 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>>   
>>   	status = dw_hdmi_detect(hdmi);
>>   
>> +	/* Update EDID during hotplug processing (force=false) */
>> +	if (status == connector_status_connected && !force) {
>> +		const struct drm_edid *drm_edid;
>> +
>> +		drm_edid = dw_hdmi_edid_read(hdmi, connector);
>> +		if (drm_edid)
>> +			drm_edid_connector_update(connector, drm_edid);
>> +		cec_notifier_set_phys_addr(hdmi->cec_notifier,
>> +			connector->display_info.source_physical_address);
>> +		drm_edid_free(drm_edid);
>> +	}
>> +
>>   	if (status == connector_status_disconnected)
>>   		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
>>   
> 
> I wonder why we should read edid at each dw_hdmi_connector_detect() call,
> AFAIK it should only be when we have HPD pulses

That is what this change intends to help do.

As stated in the short comment EDID is only updated at HPD processing,
i.e. when force=false. To be on the safe side EDID is also only updated
here when connected and EDID could be read.

drm_helper_probe_detect() is called with force=true in the
fill_modes/get_modes call path that is triggered by userspace
or the kernel kms client.

After a HPD interrupt the call to drm_helper_hpd_irq_event() will call
check_connector_changed() that in turn calls drm_helper_probe_detect()
with force=false to check/detect if connector status has changed. It is
in this call chain the EDID may be read and updated in this detect ops.

Reading EDID here at HPD processing may not be fully needed, however it
help kernel keep the internal EDID state in better sync with sink when
userspace does not act on the HOTPLUG=1 uevent.

Regards,
Jonas

> 
> Neil


