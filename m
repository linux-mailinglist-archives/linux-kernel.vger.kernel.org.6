Return-Path: <linux-kernel+bounces-385231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9936A9B344A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D3C281843
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE241DE2C4;
	Mon, 28 Oct 2024 15:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="tOaWGvD9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857551DD0DB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127859; cv=none; b=QliteivyizGpXBsQ82XdrbcWHYS6Bh54V2zJQdlJbDh6WpqJ20DUkWEZQT0SzSMzzp7aNOL1TUSr3V5zZZieZWggPWHU808tzNuO6i/8gL5dAniNPbidLJ9cArI/GPxAxn9VdMlZDamZltbr1B5XcBqpAr6AwsiZdEw7P/W0faM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127859; c=relaxed/simple;
	bh=2Lcr1QBtlLAP2/LIKLk4wPL8X/G0dPlaRTNHfXBItBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1nBZ/wLtJbKuI5flvZnI5Ue7rbVCwpwXP/H9bjXjEsW64OVsiAru+6cSl4rbdTBgeYHDHiq1R5W/73GSJBs0zcNuTw3enrWCvNfjALPcAf64EFDajKncFCed6chdqMEp+XWvPXSfJrPvlVRizJhuQvAzsvnGG8GUNJ7t3GcVeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=tOaWGvD9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 538C543;
	Mon, 28 Oct 2024 16:04:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1730127854;
	bh=2Lcr1QBtlLAP2/LIKLk4wPL8X/G0dPlaRTNHfXBItBc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tOaWGvD9AJO2ZxBnsYJ2lCXaS/PychLABXC2Q3g9RoP5Gu2BHdH23AX67SdeHWL4v
	 dXS7+aGOprzooBPKjHZiX3I3Bvpu+cCidTaUJ+A+PP0biV77KfO6tsD1S2/oFwybFM
	 jP3YWnxDedzq50LcLsiMyBhDqBOQc/G5PiRe7nSU=
Message-ID: <20cf573c-d05f-444c-9463-f342a750f6cb@ideasonboard.com>
Date: Mon, 28 Oct 2024 17:04:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/8] drm: zynqmp_dp: IRQ cleanups and debugfs support
To: Sean Anderson <sean.anderson@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 David Airlie <airlied@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, "Sagar, Vishal" <vishal.sagar@amd.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 dri-devel@lists.freedesktop.org
References: <20240809193600.3360015-1-sean.anderson@linux.dev>
 <5e9769dd-459a-4ff3-aebb-bb7057192733@linux.dev>
 <a023bd66-8f42-4f27-9aa2-5097b2574562@ideasonboard.com>
 <e959a01f-b466-4076-8219-a6c83a7194c0@linux.dev>
 <07766e5e-6009-4b8e-8a50-30ba0fe763f5@linux.dev>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <07766e5e-6009-4b8e-8a50-30ba0fe763f5@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 25/10/2024 17:58, Sean Anderson wrote:
> Hi Tomi,
> 
> On 10/3/24 10:53, Sean Anderson wrote:
>> On 10/2/24 10:50, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> On 01/10/2024 21:31, Sean Anderson wrote:
>>>> On 8/9/24 15:35, Sean Anderson wrote:
>>>>> This series cleans up the zyqnmp_dp IRQ and locking situation. Once
>>>>> that's done, it adds debugfs support. The intent is to enable compliance
>>>>> testing or to help debug signal-integrity issues.
>>>
>>> I think the patches 1-7 look fine, and I think I can pick those already to drm-misc if you're ok with that.
>>>
>>> I'm a bit unsure about patch 8, probably mainly because I don't have experience with the compliance testing.
>>>
>>> How have you tested this? With some DP analyzer/tester, I presume?
>>
>> For my test setup I used an oscilloscope hooked up to the displayport
>> output using a fixture that broke the signals out to SMA. Since the
>> oscilloscope cannot emulate a sink, I first had the output connected to
>> a monitor. Then I disabled HPD and reconnected the output to my fixture.
>> This process is described in more detail in the documentation.
>>
>>> I think none of this (patch 8) is needed by almost anybody.
>>
>> Well, I found it very useful for debugging a signal integrity issue I
>> was having. Once I could have a look at the signals it was very clear
>> what the problem was.
>>
>>> Even among zynqmp_dp developers I assume it's very rare to have the
>>> hardware for this. I wonder if it would make sense to have the debugfs
>>> and related code behind a compile option (which would be nice as the
>>> code wouldn't even compiled in), or maybe a module parameter (which
>>> would be nice as then "anyone" can easily enable it for compliance
>>> testing). What do you think?
>>
>> Other drivers with these features just enabled it unconditionally, so I
>> didn't bother with any special config.
>>
>>> I also somehow recall that there was some discussion earlier about
>>> how/if other drivers support compliance testing. But I can't find the
>>> discussion. Do you remember if there was such discussion, and what was
>>> the conclusion? With a quick look, everything in the debugfs looks
>>> generic, not xilinx specific.
>>
>> The last it got discussed was back in [1], but I never got any further
>> response. I agree that some of this is generic, and could probably be
>> reworked into some internal helpers. But I don't have the bandwidth at
>> the moment to do that work.
>>
>> --Sean
>>
>> [1] http://lore.kernel.org/dri-devel/cda22b0c-8d7c-4ce2-9a7c-3b5ab540fa1f@linux.dev
> 
> Does this all make sense to you? At the moment I don't believe I have any
> changes I need to resend for (although this series is archived in patchwork [1]
> for some reason).
> 
> --Sean
> 
> [1] https://patchwork.kernel.org/project/dri-devel/list/?series=878338&archive=both

I was hoping to get tested-by from amd, as I can't test this properly, 
but it's probably pointless to wait.

The biggest hesitation I have is what I mentioned earlier: this adds a 
lot of code which is not for normal use. It would be nice to split this 
into a separate file, maybe behind a compile option, but I fear that'll 
require a more restructuring of the driver.

So, I think it's fine, I'll apply this tomorrow.

  Tomi


