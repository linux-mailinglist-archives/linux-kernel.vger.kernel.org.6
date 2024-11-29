Return-Path: <linux-kernel+bounces-425198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EDF9DBEC6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 03:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F897B2171F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D9714F132;
	Fri, 29 Nov 2024 02:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="bL/N3Unq"
Received: from mail-m2410.xmail.ntesmail.com (mail-m2410.xmail.ntesmail.com [45.195.24.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC85D1EA65;
	Fri, 29 Nov 2024 02:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732848560; cv=none; b=sUULFqN7pDaZ1dM9EuGXIkrCBtqp3bhA9/RENRF8OEObLG6+RXluXGMV6LmkDuGHGb/JLzp/OiLo7cm/1OLRw2gJQ+gfwXmoko8JvyD06eM7SEhmFvDiDmd+PDJ3vnkaqpyFcNej6kl3vnfynoqboMI9/VRu4TKX0HjLmJhGo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732848560; c=relaxed/simple;
	bh=jZsEIhMOHvFqsQDpPGAdCTDyPd8ZaTjCTiY8iPbXGNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aHe+64RdD2oVrh5RLTmVKJuI1ycw8GxiR6cD3h4dx1iP12QeL/hl90znKyF98LJr/+WHxGNYp6KhcnIhmNAAdqpFBejZPqu5VoKIjJF3ImZuAcdoM/EgOqZVm1lqTIpz1PDpxCgd/grw3Wk3KL2IDdxO4wtGVBEwzsN464O+3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=bL/N3Unq; arc=none smtp.client-ip=45.195.24.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 42b18083;
	Fri, 29 Nov 2024 10:43:57 +0800 (GMT+08:00)
Message-ID: <6e1f35c0-5ea8-414f-b3ea-4e7222c605ef@rock-chips.com>
Date: Fri, 29 Nov 2024 10:43:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/10] phy: phy-rockchip-samsung-hdptx: Add support for
 eDP mode
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 rfoss@kernel.org, vkoul@kernel.org, sebastian.reichel@collabora.com,
 cristian.ciocaltea@collabora.com, l.stach@pengutronix.de,
 andy.yan@rock-chips.com, hjc@rock-chips.com, algea.cao@rock-chips.com,
 kever.yang@rock-chips.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org
References: <20241127075157.856029-1-damon.ding@rock-chips.com>
 <4260470.1IzOArtZ34@diego>
 <8df0acc8-b7aa-453f-b55c-30144f51d7cf@rock-chips.com>
 <2131853.KlZ2vcFHjT@diego>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <2131853.KlZ2vcFHjT@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ0seTVZOHUxJTx1MQh8eT0lWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZS1VLVUtVS1kG
X-HM-Tid: 0a9375cdbbee03a3kunm42b18083
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pk06MTo5DzIoFSEqNTY2LAo6
	Iz0KCj1VSlVKTEhJQ09DSUhCTU5MVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITk9LNwY+
DKIM-Signature:a=rsa-sha256;
	b=bL/N3Unq55qSkA26JYoRtN15Zz23QknxZHD/t3byhVLAxtGQaDu8Vi0Y838Nayz2QgaE46cZpnKAmZ/I0Q41VPh89kl26riBDRD6ePNIsmUD9gvj5luW7GmvLFlikXGeWmb033lk9ZmjxL6Ht8auxKsmbc/UY9vu1VhuKgKFw88=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=kpe86r9iOvjOisEL0baYQ/8aMf7jHymtGoN0ZQJx9H0=;
	h=date:mime-version:subject:message-id:from;

Hi Heiko,

On 2024/11/27 19:04, Heiko Stübner wrote:
> Hi Damon,
> 
> Am Mittwoch, 27. November 2024, 12:00:10 CET schrieb Damon Ding:
>> Hi Heiko:
>>
>> On 2024/11/27 17:29, Heiko Stübner wrote:
>>> Hi Damon,
>>>
>>> Am Mittwoch, 27. November 2024, 08:51:51 CET schrieb Damon Ding:
>>>> Add basic support for RBR/HBR/HBR2 link rates, and the voltage swing and
>>>> pre-emphasis configurations of each link rate have been verified according
>>>> to the eDP 1.3 requirements.
>>>>
>>>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>>>> ---
>>>
>>> [ ... huge block of DP phy support ...]
>>>
>>> yes that block was huge, but I also don't see a way to split that up in a
>>> useful way, so it should be fine.
>>>
>>
>> As for the huge block of DP phy support, I will try to use the existing
>> rk_hdptx_multi_reg_write() to set regs in next version, maybe the way
>> can make the codes more concise.
> 
> I actually did like the the dp-side of the phy code.
> 
> That you need to add all the DP stuff can't be helped and I actually find
> real functions nicer than having anonymous register writes.
> 
> I.e. the hdmi-side with its register lists does write "magic" values to
> registers.
> 
> So personally I'd just leave the dp-functions as is please, until someone
> does complain (I was not trying to complain, just mentioned why I cut
> it from the reply :-) )
> 
> 
> Thanks
> Heiko
> 
> 
>>>> +static int rk_hdptx_phy_set_mode(struct phy *phy, enum phy_mode mode,
>>>> +				 int submode)
>>>> +{
>>>> +	return 0;
>>>> +}
>>>
>>> I think it might make sense to go the same way as the DCPHY and also
>>> naneng combophy, to use #phy-cells = 1 to select the phy-mode via DT .
>>>
>>> See [0] for Sebastians initial suggestion regarding the DC-PHY.
>>> The naneng combophy already uses that scheme of mode-selection too.
>>>
>>> There is of course the issue of backwards-compatibility, but that can be
>>> worked around in the binding with something like:
>>>
>>>    '#phy-cells':
>>>       enum: [0, 1]
>>>       description: |
>>>         If #phy-cells is 0, PHY mode is set to PHY_TYPE_HDMI
>>>         If #phy-cells is 1 mode is set in the PHY cells. Supported modes are:
>>>           - PHY_TYPE_HDMI
>>>           - PHY_TYPE_DP
>>>         See include/dt-bindings/phy/phy.h for constants.
>>>
>>> PHY_TYPE_HDMI needs to be added to include/dt-bindings/phy/phy.h
>>> but PHY_TYPE_DP is already there.
>>>
>>> That way we would standardize on one form of accessing phy-types
>>> on rk3588 :-) .
>>>
>>> Also see the Mediatek CSI rx phy doing this too already [1]
>>>
>>>
>>> Heiko
>>>
>>> [0] https://lore.kernel.org/linux-rockchip/udad4qf3o7kt45nuz6gxsvsmprh4rnyfxfogopmih6ucznizih@7oj2jrnlfonz/
>>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
>>>
>>
>> It is really a nice way to separate HDMI and DP modes.

I apologize for reopening the discussion about the phy-types setting.

With the .set_mode() of struct phy_ops, the HDMI and eDP dynamic 
switching can be achieved, which just depends on the right setting of
enum phy_mode in include/linux/phy/phy.h. So the previous way of 
configuring phy mode may be also good.

And other phys may want to support dynamic switching too, like the 
Rockchip USBDP combo phy.

>>
>>>
>>>
>>>
>>>
>>
>> Best regards,
>> Damon
>>
>>
> 
> 
> 
> 
> 
> 
Best regards,
Damon

