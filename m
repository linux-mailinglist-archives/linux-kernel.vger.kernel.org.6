Return-Path: <linux-kernel+bounces-216990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3913190A96C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FEA21C220A1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8155194154;
	Mon, 17 Jun 2024 09:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=letovo.ru header.i=@letovo.ru header.b="PMyDpY93"
Received: from forward501c.mail.yandex.net (forward501c.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996E3192B7A;
	Mon, 17 Jun 2024 09:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615980; cv=none; b=AV12MtOR/7XG9ajlvK+B8vziur5aFbgJR536zDuKw7mjq/R1Uul7MG6tHwat8oPY9OQ77BUfMv+0bDG7xr1iZgXtxO7rNNWXagUnB4R5gQK6GhQP5X7OPDP1Iy15VGkYQrpyf0wYhmmYbn/HbZAilbLWE/8T+xRwLTUXlJzhBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615980; c=relaxed/simple;
	bh=Uvy1Xk2ZAkLuVPYpZssNE/Z7C6Ae58ILbuq4Fe4eXEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vb6bMLGUyNXDB51qvXwmv/LlKE1mZg+DNyLgzdjeQY/cZAVBMl2AoG0BVXIoTU3/WXM+4vXloZoPTdxifIAlXrWpXgq/z10BUhfM4WfYFZLwdUcGcZ8g09+avV81YzHDPBoHvEBVTbDZtJ761BuRZD3UR3lduRZr8g/XDE8Oo6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=letovo.ru; spf=pass smtp.mailfrom=letovo.ru; dkim=pass (1024-bit key) header.d=letovo.ru header.i=@letovo.ru header.b=PMyDpY93; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=letovo.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=letovo.ru
Received: from mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:3b2:0:640:ff71:0])
	by forward501c.mail.yandex.net (Yandex) with ESMTPS id ACBA960AA9;
	Mon, 17 Jun 2024 12:19:23 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GJDaJu1mBmI0-4F0L6Q5X;
	Mon, 17 Jun 2024 12:19:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=letovo.ru; s=mail;
	t=1718615963; bh=uaH0D6a92QUBHirpXx+Wuv+i1apwf/4pf2QkL5CvFUQ=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=PMyDpY93RUPkOuY5ieVtbzSon5cChY5q0hcC510yTVzgfRAqbFVRljl7iLks59SC8
	 tbKP76eqQ1yH2OYRCDILNYCSD/y7oiz8xxvTFEIap4xcYFiBC78PVFoZhVB823Hbap
	 PpZgA3iqxanj3H6xhf6G6UPslT4OgyevxfAwZoJw=
Authentication-Results: mail-nwsmtp-smtp-production-main-19.sas.yp-c.yandex.net; dkim=pass header.i=@letovo.ru
Message-ID: <f147be11-fc35-44c2-88e8-7421fee47ace@letovo.ru>
Date: Mon, 17 Jun 2024 13:19:17 +0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: Add bluetooth rfkill to
 Khadas Edge2
Content-Language: en-GB
To: Jacobe Zang <jacobe.zang@wesion.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de
Cc: nick@khadas.com, efectn@protonmail.com, jagan@edgeble.ai,
 dsimic@manjaro.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240617071112.3133101-1-jacobe.zang@wesion.com>
 <20240617071112.3133101-3-jacobe.zang@wesion.com>
From: Alexey Charkov <alexey.charkov@letovo.ru>
In-Reply-To: <20240617071112.3133101-3-jacobe.zang@wesion.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 17/06/2024 10:11, Jacobe Zang wrote:
> Add bluetooth node which managed by rfkill, bluetooth and
> wlan controller on Khadas Edge2 was BCM43438. In uart9 add
> RTS node in pinctrl.

You refer to wlan in the commit message, but there is nothing wlan 
related in the patch itself. Update the commit message perhaps?

> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> ---
>   .../boot/dts/rockchip/rk3588s-khadas-edge2.dts  | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> index 8c0bc675690dd..a82f10312eacd 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
> @@ -77,6 +77,14 @@ blue_led: led-2 {
>   		};
>   	};
>   
> +	bluetooth-rfkill {
> +		compatible = "rfkill-gpio";
> +		label = "rfkill-bluetooth";
> +		radio-type = "bluetooth";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&bt_reset_pin>;

Does it actually work this way? I thought you'd need to also reference 
the respective GPIO to be able to trigger its state, not just switch the 
pinctrl configuration to GPIO.


I'm also wondering if bt_reset_pin is the right one to use here. On my 
Rock 5B I had to trigger bt_wake_pin to get Bluetooth up and running.


Best regards,

Alexey


