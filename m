Return-Path: <linux-kernel+bounces-446259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD279F21EC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 03:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BFF3165E61
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Dec 2024 02:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A248F40;
	Sun, 15 Dec 2024 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="PFRY8Kix"
Received: from mail-m83151.xmail.ntesmail.com (mail-m83151.xmail.ntesmail.com [156.224.83.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44815D299;
	Sun, 15 Dec 2024 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.83.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734230281; cv=none; b=COByC6FCbIQZRfHAHCYx7iu4mC95rPmWpgcu0ig/Xyc0WqAYsHfNVVvpM1JImTZveWURGP3VkaX7OmReYzTfjlq+WOTzyWlHt3NwwNG9L//ytwaSf+CE+0iKQLubcrXIKPk1R7GK0xu1vohmWBJhzUw7zA3gLgmiUWjGU+0viec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734230281; c=relaxed/simple;
	bh=/YORe67aIUZMFJibeyP7hT83qtb3SI6+SCyY33l/79g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=U0VkHxsTZZeG+d6U0Hr3fo0rNZZnQ8+cCZ1x91aHq46N32eQxu48c+UOxnGdqSZIz6smzopB00J7WzglRyon9tpW1T8kZmrg12GmV0vlxFAa+01BXHmkwLKCOuPK1jxCtchllPPAKvtPaj9V5sGmG6CjniK67uh1kJ81LsuxhaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=PFRY8Kix; arc=none smtp.client-ip=156.224.83.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5bf41739;
	Sun, 15 Dec 2024 10:32:38 +0800 (GMT+08:00)
Message-ID: <e1f0610d-bb63-4b11-88a2-29432529b9f4@rock-chips.com>
Date: Sun, 15 Dec 2024 10:32:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damon Ding <damon.ding@rock-chips.com>
Subject: Re: [PATCH v1 00/10] Add eDP support for RK3588
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
 <5939852.zQ0Gbyo6oJ@diego>
Content-Language: en-US
In-Reply-To: <5939852.zQ0Gbyo6oJ@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGR5JSlYZTUhLT0wfTENJTh5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93c8291fde03a3kunm5bf41739
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PD46CSo4TzIPUSM#ChdCKTgy
	SjwKCghVSlVKTEhPSUlCQk1LSklDVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFPTEtCNwY+
DKIM-Signature:a=rsa-sha256;
	b=PFRY8KixxPIQEViF7qwLqT/gkORCvKmT17vHXMLWltSgq+Blf9mwMLC2/jBR7T9ZCjXX+xz/TCfaztVTyz+EKWltg6diYHIKj+8z+Hon7+TJazNFF5qSoXvbM+iadgYafNwFWxKxjCPnyaki93zTVanXhcQMY6Csg+ZkKLeRDgU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=g1p9y8WVTZB74L//6+ABz7CWQWr9pmRvHJbZBmlw+AM=;
	h=date:mime-version:subject:message-id:from;

Hi Heiko,

On 2024/12/6 22:35, Heiko Stübner wrote:
> Hi Daemon,
> 
> Am Mittwoch, 27. November 2024, 08:51:47 CET schrieb Damon Ding:
>> These patchs have been tested with a 1536x2048p60 eDP panel on
>> RK3588S EVB1 board, and HDMI 1080P/4K display also has been verified
>> on RK3588 EVB1 board.
>>
>> Patch 1~3 are the RK3588 eDP support of Rockchip analogix_dp driver.
>> Patch 4   is the eDP mode support of samsung hdptx phy driver.
>> Patch 5~6 are the Rk3588 eDP support of Aanalogix DP driver. Add phy
>>            interfaces is to configure the HDMI/eDP TX Combo PHY.
>> Patch 7~8 are the renaming of hdptxphy node. It is not only used by
>>            HDMI display but also for the eDP display.
>> Patch 9   is the addition of RK3588 eDP0 node.
>> Patch 10  is to enable the eDP0 display on RK3588S EVB1 board.
> 
> Could you maybe also bring over functionality for real bridge-handling?
> That way we'd have support for things like the dp-connector bridge.
> 
> In the 6.1 vendor-tree I've found commits
> 94e598190128 ("drm/rockchip: analogix_dp: Add support for external bridge")
> 437e0a901b14 ("drm/bridge: analogix_dp: Support split mode for bridge chain")
> 
> needing a bit of cleanup of course, but that would get rid of the driver
> not handling the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag too.
> 
> With a bit of streamlining, we could maybe even get rid of the panel-part
> completely, similar to how the dw-dsi controllers do it [0]
> 
> 

Indeed, the patches related to the bridge support have not been included 
in this series. My intention was to first implement the basic display 
functionality, and then gradually add other features, including the 
support for bridge-handling. Otherwise, this series of patches may be 
too large. :-)

What's more, RK3576 SoC also supports the eDP display, so the subsequent 
patch series will come soon.

> 
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c#n335
> devm_drm_of_get_bridge() combines drm_of_find_panel_or_bridge()
> with devm_drm_panel_bridge_add(), so indepent of it being either a
> panel or other bridge, the driver below only needs to handle bridges.
> 
>> Damon Ding (10):
>>    drm/rockchip: analogix_dp: Use formalized struct definition for grf
>>      field
>>    dt-bindings: display: rockchip: analogix-dp: Add support for RK3588
>>    drm/rockchip: analogix_dp: Add support for RK3588
>>    phy: phy-rockchip-samsung-hdptx: Add support for eDP mode
>>    drm/bridge: analogix_dp: add support for RK3588
>>    drm/bridge: analogix_dp: Add support for phy configuration.
>>    dt-bindings: display: rockchip: Fix label name of hdptxphy for RK3588
>>      HDMI TX Controller
>>    arm64: dts: rockchip: Fix label name of hdptxphy for RK3588
>>    arm64: dts: rockchip: Add eDP0 node for RK3588
>>    arch64: dts: rockchip: Enable eDP0 display on RK3588S EVB1 board
>>
>>   .../rockchip/rockchip,analogix-dp.yaml        |   1 +
>>   .../rockchip/rockchip,rk3588-dw-hdmi-qp.yaml  |   2 +-
>>   arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  33 +-
>>   .../dts/rockchip/rk3588-coolpi-cm5-evb.dts    |   2 +-
>>   .../rockchip/rk3588-coolpi-cm5-genbook.dts    |   2 +-
>>   .../boot/dts/rockchip/rk3588-evb1-v10.dts     |   2 +-
>>   .../rk3588-friendlyelec-cm3588-nas.dts        |   2 +-
>>   .../arm64/boot/dts/rockchip/rk3588-jaguar.dts |   2 +-
>>   .../boot/dts/rockchip/rk3588-nanopc-t6.dtsi   |   2 +-
>>   .../dts/rockchip/rk3588-orangepi-5-plus.dts   |   2 +-
>>   .../boot/dts/rockchip/rk3588-rock-5b.dts      |   2 +-
>>   .../boot/dts/rockchip/rk3588-tiger-haikou.dts |   2 +-
>>   .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   |   2 +-
>>   .../boot/dts/rockchip/rk3588s-evb1-v10.dts    |  84 ++
>>   .../dts/rockchip/rk3588s-indiedroid-nova.dts  |   2 +-
>>   .../boot/dts/rockchip/rk3588s-nanopi-r6.dtsi  |   2 +-
>>   .../boot/dts/rockchip/rk3588s-odroid-m2.dts   |   2 +-
>>   .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi |   2 +-
>>   .../boot/dts/rockchip/rk3588s-rock-5a.dts     |   2 +-
>>   .../boot/dts/rockchip/rk3588s-rock-5c.dts     |   2 +-
>>   .../drm/bridge/analogix/analogix_dp_core.c    |   8 +-
>>   .../drm/bridge/analogix/analogix_dp_core.h    |   2 +
>>   .../gpu/drm/bridge/analogix/analogix_dp_reg.c |  90 ++
>>   .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 112 ++-
>>   .../phy/rockchip/phy-rockchip-samsung-hdptx.c | 936 +++++++++++++++++-
>>   include/drm/bridge/analogix_dp.h              |   3 +-
>>   26 files changed, 1206 insertions(+), 97 deletions(-)
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



