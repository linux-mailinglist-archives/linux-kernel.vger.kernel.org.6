Return-Path: <linux-kernel+bounces-334290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E791E97D529
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 14:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949AC280FE2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E8913D8A0;
	Fri, 20 Sep 2024 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="T6f851+U"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C413A271
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 12:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726833756; cv=none; b=MAP/d14eAqzkrdSuZ0ETvUKwwDrslygeD3u0ZNpjVJ5//Pxq7x8JrXNHnbdT6x8yHA3wv0V/4EE4kvtqM7RcjFNeZZCS8YVAlJbvrOuHjsfEIYlfyvhmmWzeWS2XBV8mHrOI5dTvAN1zmCzRlNfgSSVC/LrIY1CaJGagSHuZ2K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726833756; c=relaxed/simple;
	bh=SRRebwSx7/jlASkx6KmF7/UeIP7lHyUQ/s5A7P7giaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cxr2bTtG70yzJ78Mp/JyoLDvDFgCTG1MfHENIhlWOW8LLKnO5oe352a/9LoHrJ70VzgHl+iIpGJrRrWeiZEH/myNSJr13Ud+elUk2zB9weFO+lQTZgFPZhaynROH6JSCXd5/3/4lUAc7PXmiBTSn1RBKbpWLmUp3Ehd7XUtt+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=T6f851+U; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1726833746;
 bh=YPYl+tQZMmhVuW6En3H83eNOir+B/MTvUugkSsrwG3g=;
 b=T6f851+UxIQXtR9gBBI61Z+Obu6GwDc1YnZ8Fvv3uTHZ5nldouqP3m809C4MKkfDHN4+lUpLK
 ux/m3vSpCrqnPY+U9sn17sO29zFOdJilaSc/lOn2LUWKztPKOG9qyVEEpYfUzPUHgj9+5RcfGiq
 TDuNTL/R4atIcx4kUC/dnCEgzeIxRRdVKwYv1sYeSopODDiwCob1YSsOcbOm9q+t09RdRGKWuUN
 abEf43DRKtEodts0Jebu+VCaL3w39zSv0etAwDZPNpYje609gcc4u02NfKmC8w/VoM6G50F4+gl
 eWMDh8vhCBywHE5WFE4gQhpQ97kKAID2ywe6X+duXQMw==
Message-ID: <5cdd34d6-76e4-4ee1-aaff-93894857ec2a@kwiboo.se>
Date: Fri, 20 Sep 2024 13:51:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/10] drm: bridge: dw_hdmi: Update EDID during hotplug
 processing
To: neil.armstrong@linaro.org, Maxime Ripard <mripard@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <didi.debian@cknow.org>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240908132823.3308029-1-jonas@kwiboo.se>
 <20240908132823.3308029-10-jonas@kwiboo.se>
 <4bc6a5e6-f2cf-43ab-8555-4f8aaf9f2cd0@linaro.org>
 <0dcb03be-dae1-4dcb-84d8-6ec204eab6ba@kwiboo.se>
 <e865e42c-a528-45bb-bdf5-df1cd103e695@linaro.org>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <e865e42c-a528-45bb-bdf5-df1cd103e695@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 207.246.76.47
X-ForwardEmail-ID: 66ed61bd012156b78323792b

On 2024-09-20 09:04, neil.armstrong@linaro.org wrote:
> On 19/09/2024 22:34, Jonas Karlman wrote:
>> Hi Neil,
>>
>> On 2024-09-13 10:02, Neil Armstrong wrote:
>>> On 08/09/2024 15:28, Jonas Karlman wrote:
>>>> Update successfully read EDID during hotplug processing to ensure the
>>>> connector diplay_info is always up-to-date.
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>> v2: No change
>>>> ---
>>>>    drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 12 ++++++++++++
>>>>    1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> index c19307120909..7bd9f895f03f 100644
>>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
>>>> @@ -2457,6 +2457,18 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
>>>>    
>>>>    	status = dw_hdmi_detect(hdmi);
>>>>    
>>>> +	/* Update EDID during hotplug processing (force=false) */
>>>> +	if (status == connector_status_connected && !force) {
>>>> +		const struct drm_edid *drm_edid;
>>>> +
>>>> +		drm_edid = dw_hdmi_edid_read(hdmi, connector);
>>>> +		if (drm_edid)
>>>> +			drm_edid_connector_update(connector, drm_edid);
>>>> +		cec_notifier_set_phys_addr(hdmi->cec_notifier,
>>>> +			connector->display_info.source_physical_address);
>>>> +		drm_edid_free(drm_edid);
>>>> +	}
>>>> +
>>>>    	if (status == connector_status_disconnected)
>>>>    		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
>>>>    
>>>
>>> I wonder why we should read edid at each dw_hdmi_connector_detect() call,
>>> AFAIK it should only be when we have HPD pulses
>>
>> That is what this change intends to help do.
>>
>> As stated in the short comment EDID is only updated at HPD processing,
>> i.e. when force=false. To be on the safe side EDID is also only updated
>> here when connected and EDID could be read.
>>
>> drm_helper_probe_detect() is called with force=true in the
>> fill_modes/get_modes call path that is triggered by userspace
>> or the kernel kms client.
>>
>> After a HPD interrupt the call to drm_helper_hpd_irq_event() will call
>> check_connector_changed() that in turn calls drm_helper_probe_detect()
>> with force=false to check/detect if connector status has changed. It is
>> in this call chain the EDID may be read and updated in this detect ops.
>>
>> Reading EDID here at HPD processing may not be fully needed, however it
>> help kernel keep the internal EDID state in better sync with sink when
>> userspace does not act on the HOTPLUG=1 uevent.
> 
> 
> I understand but if somehow a dw-hdmi integration fails to have HDP working
> properly, EDID will be read continuously which is really not what we want.

I do not fully understand when or how that could happen.

The dw_hdmi_detect() -> phy.ops->read_hpd() call chain only return
connected status when HPD is high, for what I can see from all current
integrations.

The default dw_hdmi_phy_read_hpd() used by all but meson should only
return connected status when the HPD is high:

	return hdmi_readb(hdmi, HDMI_PHY_STAT0) & HDMI_PHY_HPD ?
		connector_status_connected : connector_status_disconnected;

DRM_CONNECTOR_POLL_HPD is also used for all integrations so there should
not be any polling happening that would trigger multiple detect calls.

I guess this could/should be improved to also check for the polled type
to not cause multiple unnecessary EDID reads, in case a future
integration need to poll connector status.

> 
> HDMI 1.4b specifies in Section 8.5 and Appendix A:
> ============><==========================================
> An HDMI Sink shall not assert high voltage level on its Hot Plug Detect pin when the E-EDID
> is not available for reading.
> An HDMI Sink shall indicate any change to the contents of the E-EDID by driving a low
> voltage level pulse on the Hot Plug Detect pin. This pulse shall be at least 100 msec.
> ============><==========================================
> 
> So this is OK with the first sentence, and should also work with the second one because
> right after the pulse we will read the EDID again, but I think we should have a much
> more robust way to detect those 100ms pulses, no ?

Using a work queue to debounce reacting on HPD event for >100 ms when
HPD goes from high to low and a few ms when it goes from low to high
could probably further prevent unnecessary detect calls, and also help
avoid a possible unnecessary disable/enable cycle.

I have not seen anything other in core that handles the EDID refresh in
any special way, but I may have missed something?

Will try to use a debounce work queue to delay any calls to
helper_hpd_irq_event() and drm_bridge_hpd_notify() and see if that could
improve the HPD handling.

Regards,
Jonas

> 
> Maxime, do you have an opinion on this ?
> 
> Neil
> 
>>
>> Regards,
>> Jonas
>>
>>>
>>> Neil
>>
> 


