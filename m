Return-Path: <linux-kernel+bounces-447152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C8C9F2E02
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 11:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198FE163D27
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E47203709;
	Mon, 16 Dec 2024 10:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="TC9dxZs/"
Received: from mail-m15593.qiye.163.com (mail-m15593.qiye.163.com [101.71.155.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2C3154C0F;
	Mon, 16 Dec 2024 10:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734344151; cv=none; b=Vmj7RP4OjJo0wgQWO5QegMiG7LWj6eRFZHIqIpOnI/Gf4MeutcqLeQWXPR+ZXYEDRreLw6VS7Exv1gzq+dN3NFJFMktJTy32HjlXMetcJ9EUSgqjliZ4H+lSaoGnYz1fLhfgs6OKj5ILwARkasAepT+Bul1hoR7xVnuy0cpMfJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734344151; c=relaxed/simple;
	bh=5ggMXUrSNeavJL9/QlVA/KsDfdnXPINB1sEk37E28V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OX63s6KUKWAL23FY3Vvw1IYMiPTsjk/H2JsCKDtg40IDE6OD5IauPFXSDzln0ciX85/cZ/fjCoCTcdPdFp4x21lx8zA9b53co7Nass2d8LADV40ifPDE2fKYiAn7VIwnfXZNhibTkM5nrfDv46mb8rxz6IvWmG/rS3n0IWhGM0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=TC9dxZs/; arc=none smtp.client-ip=101.71.155.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 5dd55b80;
	Mon, 16 Dec 2024 18:15:38 +0800 (GMT+08:00)
Message-ID: <d0f89644-77b9-4bcd-9fab-42a10185c72f@rock-chips.com>
Date: Mon, 16 Dec 2024 18:15:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] arm64: dts: rockchip: Enable eDP0 display on
 RK3588S EVB1 board
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, rfoss@kernel.org, vkoul@kernel.org,
 sebastian.reichel@collabora.com, cristian.ciocaltea@collabora.com,
 l.stach@pengutronix.de, andy.yan@rock-chips.com, hjc@rock-chips.com,
 algea.cao@rock-chips.com, kever.yang@rock-chips.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20241216031225.3746-1-damon.ding@rock-chips.com>
 <20241216031225.3746-11-damon.ding@rock-chips.com>
 <ay2im4itrj3k4p2ksobgsk77b7m4laaxctkfcpffqxj5ttxenm@mzdizmf3mlcb>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <ay2im4itrj3k4p2ksobgsk77b7m4laaxctkfcpffqxj5ttxenm@mzdizmf3mlcb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGh0fHVYYQxlMQh9DS0lMGEhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a93cef75dd303a3kunm5dd55b80
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pxw6TCo6LjIREBkNNwNINi8T
	VjAwCw1VSlVKTEhPSE9PSkhCQkhCVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS09KNwY+
DKIM-Signature:a=rsa-sha256;
	b=TC9dxZs/icAtO8OBygxS0RnpXEPu9qYtxe8eogDOgm3/nfYNDxZL7DAwNK72v5fA1kE1RnEuSUkU6dFhcd5nbWBqLdG0NiliydADY/owu7A8t1jtyNkaGpqpmRY3ifAaE2oMxgKBvn2obvJIaxk6h2pfI+KeVfL0pujMSR5MSyY=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=bIZOhBSbBlumClO+5WBpvKWp8vXqGKwf+GCHshUCQ6I=;
	h=date:mime-version:subject:message-id:from;

Hi Dmitry,

On 2024/12/16 17:06, Dmitry Baryshkov wrote:
> On Mon, Dec 16, 2024 at 11:12:24AM +0800, Damon Ding wrote:
>> Add the necessary DT changes to enable eDP0 on RK3588S EVB1 board:
>> - Add edp-panel node
>> - Set pinctrl of pwm12 for backlight
>> - Enable edp0/hdptxphy0/vp2
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>>
>> ---
>>
>> Changes in v2:
>> - Remove brightness-levels and default-brightness-level properties in
>>    backlight node.
>> - Add the detail DT changes to commit message.
>> ---
>>   .../boot/dts/rockchip/rk3588s-evb1-v10.dts    | 50 +++++++++++++++++++
>>   1 file changed, 50 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
>> index bc4077575beb..5c1ea25b6524 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-evb1-v10.dts
>> @@ -9,6 +9,7 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/input/input.h>
>>   #include <dt-bindings/pinctrl/rockchip.h>
>> +#include <dt-bindings/soc/rockchip,vop2.h>
>>   #include <dt-bindings/usb/pd.h>
>>   #include "rk3588s.dtsi"
>>   
>> @@ -120,6 +121,18 @@ backlight: backlight {
>>   		pwms = <&pwm12 0 25000 0>;
>>   	};
>>   
>> +	edp_panel: edp-panel {
>> +		compatible = "lg,lp079qx1-sp0v";
> 
> Please use aux-bus and a generic "edp-panel" entry for newer platforms
> instead of declaring the panel on the platform bus. Placing eDP panels
> on the platform bus has been deprecated for quite a while.

I will apply the aux-bus in the next version. :-)

> 
>> +		backlight = <&backlight>;
>> +		power-supply = <&vcc3v3_lcd_edp>;
>> +
>> +		port {
>> +			panel_in_edp: endpoint {
>> +				remote-endpoint = <&edp_out_panel>;
>> +			};
>> +		};
>> +	};
>> +
>>   	combophy_avdd0v85: regulator-combophy-avdd0v85 {
>>   		compatible = "regulator-fixed";
>>   		regulator-name = "combophy_avdd0v85";
> 
Best regards,
Damon

