Return-Path: <linux-kernel+bounces-262089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B85CB93C0A1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B0E62827BA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378F91991AB;
	Thu, 25 Jul 2024 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="wO/rdIPh"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C9197531
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906227; cv=none; b=uPK5IPB6bjFTWhvic5srgkyfozs2SlVe5kpVj/TKyXY3NsOrrNL8NG2eXaJAbCzEH1F29xHiDvqcuLi08n21fCxu6SRq81aFTfWHOBBRp39HW3JngoY/SGV63pLF9o+sTMUxMi3CdwVhV1pZd5Rr2iRXfsOnDwp2Wb5Klp/TPc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906227; c=relaxed/simple;
	bh=tptBPDrVUM+pVxg+f9/dNjhw2c0MQ9II1r+dXQ643rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DxuCwp0JqNSFuIEAi2YEc3fvMLLTKJElSD5ZYe8nIid25TLMOhxck5m1G9qbYYbiDUknYKK2pqXL2VmyCZFt8+8KUgw4nQkd8CeTDmTnPDBLyZi0J7mldfjpleE/G/cyfilPeDmPPXdF4xAyhKiyAkosfXiSXMSPCsg4eHYTfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=wO/rdIPh; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1721906212;
 bh=FF5YZfuwDslc6950RbhVfLttALYeKLTw/VHlmyMruRA=;
 b=wO/rdIPhATeZWhzXN85wrzsyHyXPHGNL37U6Mmrei4cjmTzovxNfBTV2JrYnUj80nzocuu6Yi
 ZkXYJ5yrMg3WZEtgnNfbbSBvWkDxgc5tlOXPI3r3dTfaFf06tfSS3XwTU/5PehU+Cr9Xk//VMSM
 pA2Vwhz4bVbKQvtCPABG1YM3ze/YkmePqiEJq9eKCrC0UMtbm0eODT+BSy0vsCSaGwS6ypRLYPP
 RBfs9GfpAw819l9zDPoAFvG2WBR8ZqliKnNUxRrWrM4aFnEsKE5+6mY4vO2y53n1WfPHIvajqYf
 3xZKqyS0lIp5AJ376wOvnX/Grhqbd6eGSmyYI7gtGwIQ==
Message-ID: <90607371-2826-4448-a459-9b8a1cf6079f@kwiboo.se>
Date: Thu, 25 Jul 2024 13:06:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/5] drm/connector: implement generic HDMI codec
 helpers
To: Maxime Ripard <mripard@kernel.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20240615-drm-bridge-hdmi-connector-v1-0-d59fc7865ab2@linaro.org>
 <20240615-drm-bridge-hdmi-connector-v1-3-d59fc7865ab2@linaro.org>
 <20240621-glorious-oryx-of-expression-1ad75f@houat>
 <CAA8EJpr=ervT-KD+tYphPeTfrFGDfSaxNaYC5hfzmtVch5v10g@mail.gmail.com>
 <20240626-spiked-heavenly-kakapo-1dafce@houat>
 <pkfbp4xyg5za3vnlpryhbflb6nvp7s3bs3542wk3y5zsonoy7l@y5qcua6kfi4h>
 <20240627-meaty-bullfrog-of-refinement-cc9d85@houat>
 <cwxmu5a37qaqerpaolohxw57nzerkvlumx4dsqwmqwx5t7xhxo@kq6j63hfydra>
 <20240725-rainbow-nuthatch-of-brotherhood-bbcedc@houat>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240725-rainbow-nuthatch-of-brotherhood-bbcedc@houat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66a231c2fa07ff5ac5ece8c0

On 2024-07-25 11:25, Maxime Ripard wrote:
> On Thu, Jun 27, 2024 at 04:29:49PM GMT, Dmitry Baryshkov wrote:
>> On Thu, Jun 27, 2024 at 11:49:37AM GMT, Maxime Ripard wrote:
>>> On Wed, Jun 26, 2024 at 07:09:34PM GMT, Dmitry Baryshkov wrote:
>>>> On Wed, Jun 26, 2024 at 04:05:01PM GMT, Maxime Ripard wrote:
>>>>> On Fri, Jun 21, 2024 at 02:09:04PM GMT, Dmitry Baryshkov wrote:
>>>>>> On Fri, 21 Jun 2024 at 12:27, Maxime Ripard <mripard@kernel.org> wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> Sorry for taking some time to review this series.
>>>>>>
>>>>>> No problem, that's not long.
>>>>>>
>>>>>>>
>>>>>>> On Sat, Jun 15, 2024 at 08:53:32PM GMT, Dmitry Baryshkov wrote:
>>>>>>>> Several DRM drivers implement HDMI codec support (despite its name it
>>>>>>>> applies to both HDMI and DisplayPort drivers). Implement generic
>>>>>>>> framework to be used by these drivers. This removes a requirement to
>>>>>>>> implement get_eld() callback and provides default implementation for
>>>>>>>> codec's plug handling.
>>>>>>>>
>>>>>>>> The framework is integrated with the DRM HDMI Connector framework, but
>>>>>>>> can be used by DisplayPort drivers.
>>>>>>>>
>>>>>>>> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>>>>>>>> ---
>>>>>>>>  drivers/gpu/drm/Makefile                   |   1 +
>>>>>>>>  drivers/gpu/drm/drm_connector.c            |   8 ++
>>>>>>>>  drivers/gpu/drm/drm_connector_hdmi_codec.c | 157 +++++++++++++++++++++++++++++
>>>>>>>>  include/drm/drm_connector.h                |  33 ++++++
>>>>>>>>  4 files changed, 199 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
>>>>>>>> index 68cc9258ffc4..e113a6eade23 100644
>>>>>>>> --- a/drivers/gpu/drm/Makefile
>>>>>>>> +++ b/drivers/gpu/drm/Makefile
>>>>>>>> @@ -45,6 +45,7 @@ drm-y := \
>>>>>>>>       drm_client_modeset.o \
>>>>>>>>       drm_color_mgmt.o \
>>>>>>>>       drm_connector.o \
>>>>>>>> +     drm_connector_hdmi_codec.o \
>>>>>>>>       drm_crtc.o \
>>>>>>>>       drm_displayid.o \
>>>>>>>>       drm_drv.o \
>>>>>>>> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
>>>>>>>> index 3d73a981004c..66d6e9487339 100644
>>>>>>>> --- a/drivers/gpu/drm/drm_connector.c
>>>>>>>> +++ b/drivers/gpu/drm/drm_connector.c
>>>>>>>> @@ -279,6 +279,7 @@ static int __drm_connector_init(struct drm_device *dev,
>>>>>>>>       mutex_init(&connector->mutex);
>>>>>>>>       mutex_init(&connector->edid_override_mutex);
>>>>>>>>       mutex_init(&connector->hdmi.infoframes.lock);
>>>>>>>> +     mutex_init(&connector->hdmi_codec.lock);
>>>>>>>>       connector->edid_blob_ptr = NULL;
>>>>>>>>       connector->epoch_counter = 0;
>>>>>>>>       connector->tile_blob_ptr = NULL;
>>>>>>>> @@ -529,6 +530,12 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
>>>>>>>>
>>>>>>>>       connector->hdmi.funcs = hdmi_funcs;
>>>>>>>>
>>>>>>>> +     if (connector->hdmi_codec.i2s || connector->hdmi_codec.spdif) {
>>>>>>>> +             ret = drmm_connector_hdmi_codec_alloc(dev, connector, hdmi_funcs->codec_ops);
>>>>>>>> +             if (ret)
>>>>>>>> +                     return ret;
>>>>>>>> +     }
>>>>>>>> +
>>>>>>>>       return 0;
>>>>>>>>  }
>>>>>>>>  EXPORT_SYMBOL(drmm_connector_hdmi_init);
>>>>>>>> @@ -665,6 +672,7 @@ void drm_connector_cleanup(struct drm_connector *connector)
>>>>>>>>               connector->funcs->atomic_destroy_state(connector,
>>>>>>>>                                                      connector->state);
>>>>>>>>
>>>>>>>> +     mutex_destroy(&connector->hdmi_codec.lock);
>>>>>>>>       mutex_destroy(&connector->hdmi.infoframes.lock);
>>>>>>>>       mutex_destroy(&connector->mutex);
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/drm_connector_hdmi_codec.c b/drivers/gpu/drm/drm_connector_hdmi_codec.c
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..a3a7ad117f6f
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/gpu/drm/drm_connector_hdmi_codec.c
>>>>>>>> @@ -0,0 +1,157 @@
>>>>>>>> +/*
>>>>>>>> + * Copyright (c) 2024 Linaro Ltd
>>>>>>>> + *
>>>>>>>> + * Permission to use, copy, modify, distribute, and sell this software and its
>>>>>>>> + * documentation for any purpose is hereby granted without fee, provided that
>>>>>>>> + * the above copyright notice appear in all copies and that both that copyright
>>>>>>>> + * notice and this permission notice appear in supporting documentation, and
>>>>>>>> + * that the name of the copyright holders not be used in advertising or
>>>>>>>> + * publicity pertaining to distribution of the software without specific,
>>>>>>>> + * written prior permission.  The copyright holders make no representations
>>>>>>>> + * about the suitability of this software for any purpose.  It is provided "as
>>>>>>>> + * is" without express or implied warranty.
>>>>>>>> + *
>>>>>>>> + * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
>>>>>>>> + * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
>>>>>>>> + * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
>>>>>>>> + * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
>>>>>>>> + * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
>>>>>>>> + * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
>>>>>>>> + * OF THIS SOFTWARE.
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#include <linux/mutex.h>
>>>>>>>> +#include <linux/platform_device.h>
>>>>>>>> +
>>>>>>>> +#include <drm/drm_connector.h>
>>>>>>>> +#include <drm/drm_managed.h>
>>>>>>>> +
>>>>>>>> +#include <sound/hdmi-codec.h>
>>>>>>>> +
>>>>>>>> +static int drm_connector_hdmi_codec_get_eld(struct device *dev, void *data,
>>>>>>>> +                                         uint8_t *buf, size_t len)
>>>>>>>> +{
>>>>>>>> +     struct drm_connector *connector = data;
>>>>>>>> +
>>>>>>>> +     //  FIXME: locking against drm_edid_to_eld ?
>>>>>>>> +     memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
>>>>>>>> +
>>>>>>>> +     return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int drm_connector_hdmi_codec_hook_plugged_cb(struct device *dev,
>>>>>>>> +                                                 void *data,
>>>>>>>> +                                                 hdmi_codec_plugged_cb fn,
>>>>>>>> +                                                 struct device *codec_dev)
>>>>>>>> +{
>>>>>>>> +     struct drm_connector *connector = data;
>>>>>>>> +
>>>>>>>> +     mutex_lock(&connector->hdmi_codec.lock);
>>>>>>>> +
>>>>>>>> +     connector->hdmi_codec.plugged_cb = fn;
>>>>>>>> +     connector->hdmi_codec.plugged_cb_dev = codec_dev;
>>>>>>>> +
>>>>>>>> +     fn(codec_dev, connector->hdmi_codec.last_state);
>>>>>>>> +
>>>>>>>> +     mutex_unlock(&connector->hdmi_codec.lock);
>>>>>>>> +
>>>>>>>> +     return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +void drm_connector_hdmi_codec_plugged_notify(struct drm_connector *connector,
>>>>>>>> +                                          bool plugged)
>>>>>>>> +{
>>>>>>>> +     mutex_lock(&connector->hdmi_codec.lock);
>>>>>>>> +
>>>>>>>> +     connector->hdmi_codec.last_state = plugged;
>>>>>>>> +
>>>>>>>> +     if (connector->hdmi_codec.plugged_cb &&
>>>>>>>> +         connector->hdmi_codec.plugged_cb_dev)
>>>>>>>> +             connector->hdmi_codec.plugged_cb(connector->hdmi_codec.plugged_cb_dev,
>>>>>>>> +                                              connector->hdmi_codec.last_state);
>>>>>>>> +
>>>>>>>> +     mutex_unlock(&connector->hdmi_codec.lock);
>>>>>>>> +}
>>>>>>>> +EXPORT_SYMBOL(drm_connector_hdmi_codec_plugged_notify);
>>>>>>>
>>>>>>> I think we should do this the other way around, or rather, like we do
>>>>>>> for drm_connector_hdmi_init. We'll need a hotplug handler for multiple
>>>>>>> things (CEC, HDMI 2.0, audio), so it would be best to have a single
>>>>>>> function to call from drivers, that will perform whatever is needed
>>>>>>> depending on the driver's capabilities.
>>>>>>
>>>>>> I see, this API is probably misnamed. The hdmi_codec_ops use the
>>>>>> 'plugged' term,
>>>>>
>>>>> Is it misnamed?
>>>>>
>>>>> It's documented as:
>>>>>
>>>>>   Hook callback function to handle connector plug event. Optional.
>>>>>
>>>>>> but most of the drivers notify the ASoC / codec during atomic_enable /
>>>>>> atomic_disable path, because usually the audio path can not work with
>>>>>> the video path being disabled.
>>>>>
>>>>> That's not clear to me either:
>>>>>
>>>>>   - rockchip/cdn-dp, msm/dp/dp-audio, dw-hdmi, seem to call it at
>>>>>     enable/disable
>>>>>
>>>>>   - anx7625, mtk_hdmi and mtk_dp calls it in detect
>>>>>
>>>>>   - adv7511, ite-it66121, lontium-lt9611, lontium-lt9611uxc, sii902x,
>>>>>     exynos, tda998x, msm_hdmi, sti, tegra, vc4 don't call it at all.
>>>>>
>>>>> So it doesn't look like there's a majority we can align with, and
>>>>> neither should we: we need to figure out what we *need* to do and when,
>>>>> and do that.
>>>>>
>>>>> From the documentation and quickly through the code though, handling it
>>>>> in detect looks like the right call.
>>>>
>>>> It is tempting to have it in the hotplug call. However:
>>>>
>>>> - It is used to send events to the ASoC Jack, marking the output as
>>>>   plugged or unplugged. Once the output is plugged, userspace might
>>>>   consider using it for the audio output. Please correct me if I'm
>>>>   wrong, but I don't think one can output audio to the HDMI plug unless
>>>>   there is a video stream.
>>>
>>> That's something to check in the HDMI spec and with the ALSA
>>> maintainers.
>>
>> Mark and Liam are on CC list. I've also pinged Mark on the IRC (on
>> #alsa, if the channel logs are preserved somewhere)
>>
>> <lumag> I'm trying to implement a somewhat generic implementation that the drivers can hook in. The main discussion is at [link to this discussion]
>> <lumag> So in theory that affects all ASoC platforms having HDMI or DP audio output
>> <broonie> In that case I'd be conservative and try to follow the state of the physical connection as closely as possible.
>>
>> So it is really 'plugged'.
> 
> Ack.
> 
>>>> - Having it in the hotplug notification chain is also troublesome. As
>>>>   Dave pointed out in the quoted piece of code, it should come after
>>>>   reading the EDID on the connect event. On the disconnect event it
>>>>   should probably come before calling the notification chain, to let
>>>>   audio code interract correctly with the fully enabled display devices.
>>>
>>> EDIDs are fetched when hotplug is detected anyway, and we need it for
>>> other things anyway (like CEC).
>>
>> I see that:
>>
>> - VC4 reads EDID and sets CEC address directly in hotplug notifier and
>>   then again in get_modes callback. (why is it necessary in the hotplug
>>   notifier, if it's done anyway in get_modes?)
> 
> vc4 is probably somewhat correct, but also a bit redundant here: the CEC
> physical address is supposed to be set when we detect a sink.
> 
> When that sink is removed, we don't have a physical address anymore and
> we thus need to call cec_phys_addr_invalidate.
> 
> When a sink is plugged again, we need to call cec_s_phys_addr() with the
> sink address.
> 
> So what vc4_hdmi_handle_hotplug is doing is fine, but the one in the
> get_modes might be redundant.
> 
>> - sun4i sets CEC address from get_modes
> 
> Yeah, that doesn't work. 
> 
> If the display is switched to another one and if the userspace doesn't
> react to the hotplug event by calling get_modes, the physical address
> will be the old one.
> 
> But since it's a polled hotplug, it's a situation that generally sucks.
> 
>> - ADV7511 does a trick and sets CEC address from edid_read() callback
>>   (with the FIXME from Jani that basically tells us to move this to
>>   get_modes)
> 
> Same situation than sun4i here, except for the fact that it can handle
> hotplug through an interrupt.
> 
>> - omapdrm clears CEC address from hpd_notify, but sets it from the
>>   edid_read() callback with the same FIXME.
> 
> I think it's still broken there. It properly clears the physical address
> when the sink is disconnected, but relies on someone calling get_modes
> to set it again, which isn't guaranteed.
> 
>> - i915 sets CEC address from .detect_ctx callback
> 
> That one is vc4 minus the get_modes redundancy.
> 
>> So there is no uniformity too. Handling it from drm_bridge_connector() /
>> get_modes might help, but that requires clearing one of TODO items.
> 
> There's no uniformity, but I guess both vc4 and i915 are much more
> battle-tested than sun4i, omapdrm, or adv7511 might be, and they both
> behave pretty much the same.
> 
> Generally speaking (and it might be sad), but i915 is what userspace
> expects, so it's usually what we want to follow.

For the dw-hdmi connector I also moved the edid read and cec phys addr
handling from hpd irq to the detect callback in [1]. That seem to be the
best option as it gets called by core after/during hpd processing and
also more closely matches i915.

Was not fully sure what to do about the hdmi-codec callback so left it
at enable/disable as that seemed to best match the expected plugged
state. However, dw-hdmi connector will more than likely trigger a
disconnected/connected state change and a disable/enable cycle during
an edid refresh from the sink, i.e. when a connected AVR is powered on
or off, so it does now always match the physical plugged state.

[1] https://lore.kernel.org/all/20240611155108.1436502-1-jonas@kwiboo.se/

Regards,
Jonas

> 
> Maxime


