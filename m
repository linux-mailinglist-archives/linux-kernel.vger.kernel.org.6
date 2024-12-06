Return-Path: <linux-kernel+bounces-434339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7F59E6522
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51BA01884D43
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 03:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64780191F78;
	Fri,  6 Dec 2024 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="kPHScr15"
Received: from mail-m12796.qiye.163.com (mail-m12796.qiye.163.com [115.236.127.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE113DDDF;
	Fri,  6 Dec 2024 03:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733456627; cv=none; b=kJW9tr1kmQaBpdlROopxGT1Y8DmV0rV0zo0mcNQvN35tWwEr0NEl6OHV8+AAUBWc+IOIhuK+AhpoLpaVaBKfuNKzftVsB0s41P6kt2ti7g99OB4OKgQxklJi7X/ltom+ZeTEGqpE1T6yZEhA9HC1IMJKr9OtaJuXZrKqv4TgW74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733456627; c=relaxed/simple;
	bh=dRuKrSs44UIo3EnTnqZjyoP90LhCHzf77THqP4gcSZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHIWaLPJDX6QL45TzJNbHgXLUPJoxYlwHwy4PqGvVhHQSkNfdRWS+B+FryIycuvG0bIpkKW6e4Xe0sr29RzGF0ivuVOb8gzbPDuvq10nHdkA5H/IoBENK9wVTHpNWpVblaaYbEx5Jf/lBrJc7PE/9N1rAgF+bgKSHFJXwRgHFpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=kPHScr15; arc=none smtp.client-ip=115.236.127.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4df43c1a;
	Fri, 6 Dec 2024 11:28:21 +0800 (GMT+08:00)
Message-ID: <c0bc25b7-6e41-4ed8-ae8d-692a908607df@rock-chips.com>
Date: Fri, 6 Dec 2024 11:28:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/10] phy: phy-rockchip-samsung-hdptx: Add support for
 eDP mode
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rfoss@kernel.org, vkoul@kernel.org,
 cristian.ciocaltea@collabora.com, l.stach@pengutronix.de,
 andy.yan@rock-chips.com, hjc@rock-chips.com, algea.cao@rock-chips.com,
 kever.yang@rock-chips.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20241127075157.856029-1-damon.ding@rock-chips.com>
 <2131853.KlZ2vcFHjT@diego>
 <6e1f35c0-5ea8-414f-b3ea-4e7222c605ef@rock-chips.com>
 <2886747.Y6S9NjorxK@diego>
 <h4giob7bcrh7qmtepti6huym2llw4ujfmeff76vrgpahb5zy6x@dz6zghsifww5>
 <2342f342-672c-447e-90d8-674b748af6a4@rock-chips.com>
 <abzu2chif2g3urxoqbm3gbe6cciexbmqvn44qezrx4hgllfkkn@7bzi5jl3stqe>
 <42035ebe-09b7-4005-912a-8ec72d5dabcc@rock-chips.com>
 <5ncdog66jtc4s7vxk2yt4jkknf2es3whvweuqmrxbot3azi5ge@t6s3xadkiasp>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <5ncdog66jtc4s7vxk2yt4jkknf2es3whvweuqmrxbot3azi5ge@t6s3xadkiasp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0JDQlYdSBoZS0sfTx0dTx9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a939a02e70703a3kunm4df43c1a
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MhQ6GTo4OjIpSgEZKCkWFzww
	FhVPCilVSlVKTEhIT05OTEtITkhNVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJTUtLNwY+
DKIM-Signature:a=rsa-sha256;
	b=kPHScr159WsiJG96Ork6FzwSMNbCQmUyQiTo49UIfTNDjTnurol/onZC7EOZpN8egR0d5Wltmfu4s4A1J2M/lM0yadBTKzrhmL5jyZk8oBUo6Ei1RJqUkOFc+a+RMgvgkwTIS2d4wyBGm1zAptOnnzrxcMoGdC5S+7C9miLNpcc=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=OkOQFcENXzlE05E2GhFQKZHqHer5Jyvf4HzPjb5KtAk=;
	h=date:mime-version:subject:message-id:from;

Hi Sebastian,

On 2024/12/6 2:04, Sebastian Reichel wrote:
> Hello Damon,
> 
> On Thu, Dec 05, 2024 at 09:13:33AM +0800, Damon Ding wrote:
>> Firstly, the term "the HDMI and eDP dynamic switching" can be somewhat
>> misleading, because the eDP usually does not support hot plug. The RK3588
>> eDP is often used as DP, and it actually supports DP 1.2. Therefore, it is
>> better to use the "the HDMI and DP dynamic switching" description.
> 
> The part unclear to me is how the dynamic switching is supposed to
> happen. Looking at the TRM the hotplug detect signals also seem to be
> shared between HDMI and eDP. Can the RK3588S EVB distinguish if HDMI
> or eDP has been plugged, or does this require some user interaction
> to set the right mode?

Indeed, HDMI and eDP share the same pin for hotplug detect. However, 
some users may connect the hotplug detection pin of DP-connector with an 
unexpected pin that can not support the iomux of hotplug detect function 
on RK3588 SoC. This could be due to a flaw in the hardware design, a 
conflict in pin multiplexing, or other factors. Therefore, we support 
the GPIO HDP function for the eDP, as DP also supports this for the same 
reasons.

If the dynamic switching is enabled, HDMI detects the HPD signal through 
  the hotplug detect function pin, while eDP uses one of the available 
GPIO pins to do this.

What's more, if the user connects an HDMI cable first and than connects 
a DP cable as well, despite our clear instruction against using HDMI and 
eDP simultaneously, the status register of GRF will indicate that HDMI 
has been connected. Meanwhile, during the HPD detection process for eDP, 
it will return "connector_status_disconnected". The reverse scenario 
also applies.

> 
>> Indeed, the devm_phy_get(dp->dev, "dp") and devm_of_phy_get_by_index() will
>> help to get the phy reference in .probe() or .bind().
>>
>> However, the phy_set_mode() may be still needed in the HDMI and DP dynamic
>> switching application scenarios. We need the enum phy_mode
>> PHY_MODE_DP/PHY_MODE_HDMI to differentiate the configuration processes in
>> .power_on(), .power_off() and .configure() of struct phy_ops, which will be
>> called in conjunction with plugging in and unplugging an HDMI or DP cable.
> 
> I suppose you could fetch the PHY in power_on() and release it in
> power_off(). But using phy_set_mode() might indeed be better here.
> 

As a future expansion, the .set_mode() can also be helpful in the txffe 
level adjustment for HDMI 2.1. :)

> -- Sebastian

Best regards,
Damon

