Return-Path: <linux-kernel+bounces-528142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35ABDA41414
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 04:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BB8516E686
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 03:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BD31A5BAF;
	Mon, 24 Feb 2025 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TtkboSsl"
Received: from mail-m49234.qiye.163.com (mail-m49234.qiye.163.com [45.254.49.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4589F510;
	Mon, 24 Feb 2025 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368195; cv=none; b=M6ZR5vnXGjL45IEUmDslOhGeKWAoywJTO7pSLXNBIr+GzFoq7r790a05y6bIZ4MMjunfYJVA01N+5SgFPFHBzjirJNf84NWWSxx7mfYaTy5swrHOecx8AjKd3LmGDuDhXjByyBcpKdrk8lzQ1Y01ZKPDmop8vLsi33VjnO3VLEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368195; c=relaxed/simple;
	bh=LOuJmP3uQScRvJ5ZPD10rClOLn9+/7bBpKXhwP0o8sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoQxhnKtcWbGKvQQ5Ddi0cPujyrPvyzGOd5w1Sb0xEPJOeY2wH1FVCp3EZTK8iGzKwVsuEVfXaRbqa+KrCeWInrgjCWDQ4kgK7mAByz1OG7rYOo0VmWqYEDC5dbvyJipcOchVRmjooJFS7f/70KcB4cmNvmY1qax0hJMfEzqIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TtkboSsl; arc=none smtp.client-ip=45.254.49.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bf356a8d;
	Mon, 24 Feb 2025 11:21:02 +0800 (GMT+08:00)
Message-ID: <731abf8f-b157-47d4-a9e1-9aed6f5b4e37@rock-chips.com>
Date: Mon, 24 Feb 2025 11:21:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/14] Add eDP support for RK3588
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: heiko@sntech.de, robh@kernel.org, conor+dt@kernel.org,
 algea.cao@rock-chips.com, rfoss@kernel.org, devicetree@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 hjc@rock-chips.com, kever.yang@rock-chips.com, dmitry.baryshkov@linaro.org,
 vkoul@kernel.org, andy.yan@rock-chips.com, krzk+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de
References: <20250123100747.1841357-1-damon.ding@rock-chips.com>
 <5044FFCB-B325-40D0-BA82-03AF64EAF029@gmail.com>
 <tg6eyew4qahuxqakmmejne7xx2rkouj6htp55acun4ajz2irz2@vlmvqv3zc5vc>
 <C81810F2-6E9B-4DCC-85D1-CCB63CBFBFEA@gmail.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <C81810F2-6E9B-4DCC-85D1-CCB63CBFBFEA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUtLHlYYHkhNH0oeTh5DHkNWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9535f8f24203a3kunmbf356a8d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46Djo5AjIXNxwdLSo9TD1L
	FQMwClZVSlVKTE9LSE1MSU1PS09IVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFITExLNwY+
DKIM-Signature:a=rsa-sha256;
	b=TtkboSslEuG3O6Q33PmEvHv28Jvg5WyhYR2LFUqcKFp4BOeB/mohA8ndDgbxGn5eNvpe7Fkf8HB8qjnmn2aLu9BlykbGs6RCVL395hZUmPJW9eyvlAmbaEAF23buy2DkdSvordvN2UaJJ3yxiUObEM3aHwA/1rf/oZ7kgAjYhgE=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=SUWTCb0GbfrLEePUqui3jDgm691jrzdjRDy4hq8S9z0=;
	h=date:mime-version:subject:message-id:from;

Hi Piotr,

On 2025/2/14 20:00, Piotr Oniszczuk wrote:
> 
> 
>> Wiadomość napisana przez Sebastian Reichel <sebastian.reichel@collabora.com> w dniu 13 lut 2025, o godz. 18:26:
>>
>> Hello Piotr,
>>
>>
>> The RK3588 has two different DP controllers. The one handled in this
>> series should get the eDP port running, which is routed to the
>> "eDP Panel" in the block diagram on page 3 of the Rock 5 ITX schematics.
>> So this series adds support for using "HDMI/eDP TX0" and "HDMI/eDP TX1"
>> in DP mode.
>>
>> The port routed to HDMI0 via RA620 is the other DP controller, which
>> also exists twice: "TYPEC0/DP0" and "TYPEC1/DP1". This DP controller
>> is not yet supported upstream and there is no pending patchset. As far
>> as I know Rockchip plans to work on preparing upstream support for that
>> soon.

Yes, Andy has recently updated the DP controller related patchset:
https://patchwork.kernel.org/project/linux-rockchip/list/?series=936784

>>
> 
> Oh - this is very valuable info and explains a lot.
> Thx.
> 
>> Note, that the two DisplayPort controllers are completely different.
>> The HDMI/eDP controller is a design from Analogix and the TypeC/DP
>> controller is a design from Synopsys.
>>
>> P.S.: Heiko merged support for HDMI1 (RK3588 SoC level) recently. So you
>> should be able to get that running by some DT additions to the Rock 5
>> ITX board DT with the latest linux-next code :)
>>
> 
> And it works perfectly on all my 3588 bards (including audio and my cec addition)
> But only on boards using both hdmi tx0 and tx1 to hdmi0/hdmi1 ports.
> 
> on rock5 itx:

According to the schematic of ROCK 5 ITX, I find the display routes are:
- DP0 -> TYPEC0 Connector
- DP1 -> RA620 -> HDMI Connector (Andy's patch series will help it work)
- HDMI/eDP TX0 -> eDP Panel (This patch series will help it work)
- HDMI/eDP TX1 -> HDMI Connector

So the HDMI/eDP TX0 should be enabled as eDP in DTS. Maybe it's just a 
test to enable both HDMI0 and HDMI1 in the ROCK 5 ITX board?

> With both hdmi tx0 and tx1 enabled in dts it looks like kernel detects hdmi tx0 as connected and tries read edid.
> As nothing is connected to J11 (eDP con) - i’m getting i2c ddc timeouts
> [   54.188880] dwhdmiqp-rockchip fde80000.hdmi: i2c read timed out
> [   54.292207] dwhdmiqp-rockchip fde80000.hdmi: i2c read timed out
> [   54.395554] dwhdmiqp-rockchip fde80000.hdmi: i2c read timed out
> 

I think the reason may be that HDMI0 is enabled, and HPD pin of HDMI0 is 
also configured, but the HPD pin is in an unstable state in the 
hardware, which is mistakenly detected as connected.

> 
> disabling hdmi0 makes kernel talking to hdmi1 but with issues:
> [    0.540446] dwhdmiqp-rockchip fdea0000.hdmi: registered DesignWare HDMI QP I2C bus driver
> [    0.541230] rockchip-drm display-subsystem: bound fdea0000.hdmi (ops dw_hdmi_qp_rockchip_ops)
> [    0.542285] [drm] Initialized rockchip 1.0.0 for display-subsystem on minor 0
> [    0.542933] rockchip-drm display-subsystem: [drm] Cannot find any crtc or sizes
> [    0.543605] rockchip-drm display-subsystem: [drm] Cannot find any crtc or sizes
> 
> and here i’m a bit puzzled as on other 3588 boards (i.e. rock5b) - when i connected monitor to hdmi1 - all works perfectly
> (kernel, OS and app nicely skipping hdmi0 and talking to actually connected hdmi1 port. all works)
> 
> on rock5 itx this not works.
> 
> my observations so far are:
> -on rock5 itx hdmi0 is falsely detected as connected - even when eDP connector (J11) has nothing connected
> -on rock5 itx disabling hdmi0 in dts breaks hdmi1
> -on other 3588 (e.g. rock 5b) disabling hdmi0 in dts NOT breaks hdmi1
> 
> strange….
> 
> 

Best regards
Damon


