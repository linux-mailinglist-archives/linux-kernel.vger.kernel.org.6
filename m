Return-Path: <linux-kernel+bounces-423401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D56B9DA6E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D4E1B216F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C3C1F8EE0;
	Wed, 27 Nov 2024 11:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="MHKppqx3"
Received: from mail-m19731106.qiye.163.com (mail-m19731106.qiye.163.com [220.197.31.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551C81E0DCD;
	Wed, 27 Nov 2024 11:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732707349; cv=none; b=r8H/GC1A0CfLNBCkxaphqnBXQQ8Z6No0CzgePLkxiVRxKvaP0zPYsWXDC92Oks0vQ0zfr9dQM2/9EPa8Ko5v0WjqcVbcpbYDCoLF3mO/ELeLWAtjuHO5S8ynBKr/3665kyHu67J9J4NhIaNE7G3ceJc6XPNZYmSEnmPdkSUtR+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732707349; c=relaxed/simple;
	bh=JHzX4yK1UdmOsGXheIz4L1q12a/V+gtlDlK94iUpvuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=msft2wta/kfLoHNQVd32f2BSuhx1Epuc/GqKhtpHN3vGbkiEf1om8QdKEs/PwfAoxHjWI6T++xhTww2n+CXcM6ieY1PcBXJpcj4E8vOoz2iXRPcjeZVoS1pf8SPIJF3o+8OEwGsZpW4bkeuWqEcDETejv6v5afKUKfy9LXbdN/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=MHKppqx3; arc=none smtp.client-ip=220.197.31.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3fe683f3;
	Wed, 27 Nov 2024 19:00:10 +0800 (GMT+08:00)
Message-ID: <8df0acc8-b7aa-453f-b55c-30144f51d7cf@rock-chips.com>
Date: Wed, 27 Nov 2024 19:00:10 +0800
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
 <20241127075157.856029-5-damon.ding@rock-chips.com>
 <4260470.1IzOArtZ34@diego>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <4260470.1IzOArtZ34@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQxgZQ1ZIQ0tCTx0ZHxlDHR5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a936d4752a703a3kunm3fe683f3
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRA6Lgw5CDIpHS5NEwE3NhMU
	ChYaCh9VSlVKTEhJTEtOSUpJTENMVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJSUNPNwY+
DKIM-Signature:a=rsa-sha256;
	b=MHKppqx3/69QuoNhREUlt7wo6qUNbztr929L0BnEn2+9UfVCaFP8Pa0GA4fZZ92lKe+e0VQmieBZpCBg75bzcV0dR7PpPw1l8coEQLKAFbFB7lTzqcHTw1KeCKSnVxEtDGd6zJvbgLCQtA1pTrUMzV+fyCIcN/UadJcRfpp7tzA=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=GgVLM+pxB0mTT4Xgy0u5pynEp9OkHXXnOP4d8il9bhA=;
	h=date:mime-version:subject:message-id:from;

Hi Heiko:

On 2024/11/27 17:29, Heiko Stübner wrote:
> Hi Damon,
> 
> Am Mittwoch, 27. November 2024, 08:51:51 CET schrieb Damon Ding:
>> Add basic support for RBR/HBR/HBR2 link rates, and the voltage swing and
>> pre-emphasis configurations of each link rate have been verified according
>> to the eDP 1.3 requirements.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>> ---
> 
> [ ... huge block of DP phy support ...]
> 
> yes that block was huge, but I also don't see a way to split that up in a
> useful way, so it should be fine.
> 

As for the huge block of DP phy support, I will try to use the existing 
rk_hdptx_multi_reg_write() to set regs in next version, maybe the way 
can make the codes more concise.

> 
>> +static int rk_hdptx_phy_set_mode(struct phy *phy, enum phy_mode mode,
>> +				 int submode)
>> +{
>> +	return 0;
>> +}
> 
> I think it might make sense to go the same way as the DCPHY and also
> naneng combophy, to use #phy-cells = 1 to select the phy-mode via DT .
> 
> See [0] for Sebastians initial suggestion regarding the DC-PHY.
> The naneng combophy already uses that scheme of mode-selection too.
> 
> There is of course the issue of backwards-compatibility, but that can be
> worked around in the binding with something like:
> 
>   '#phy-cells':
>      enum: [0, 1]
>      description: |
>        If #phy-cells is 0, PHY mode is set to PHY_TYPE_HDMI
>        If #phy-cells is 1 mode is set in the PHY cells. Supported modes are:
>          - PHY_TYPE_HDMI
>          - PHY_TYPE_DP
>        See include/dt-bindings/phy/phy.h for constants.
> 
> PHY_TYPE_HDMI needs to be added to include/dt-bindings/phy/phy.h
> but PHY_TYPE_DP is already there.
> 
> That way we would standardize on one form of accessing phy-types
> on rk3588 :-) .
> 
> Also see the Mediatek CSI rx phy doing this too already [1]
> 
> 
> Heiko
> 
> [0] https://lore.kernel.org/linux-rockchip/udad4qf3o7kt45nuz6gxsvsmprh4rnyfxfogopmih6ucznizih@7oj2jrnlfonz/
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
> 

It is really a nice way to separate HDMI and DP modes.

> 
> 
> 
> 

Best regards,
Damon


