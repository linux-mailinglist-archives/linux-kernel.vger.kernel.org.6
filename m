Return-Path: <linux-kernel+bounces-372602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2980F9A4AE2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 03:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3ADD1F22463
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 01:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAA21CC160;
	Sat, 19 Oct 2024 01:41:58 +0000 (UTC)
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722DBA47;
	Sat, 19 Oct 2024 01:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729302118; cv=none; b=KM8RPiLemOFWKA16qJDW6RhgX0I8DNxUgUoB5T+/KVxFbVC98+GEgsiuqhhmCijs/ugD6YDVzNyDP5EkTcTHpd5Njw8mioSx2uXQjyqurbELotmIUP6MrLcVUMvImvjoIZ0o7vhUmmWDvZhpKLn+qdFP2MWlGNUVZupvHxz29qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729302118; c=relaxed/simple;
	bh=BOk05Y/y0uAQe31NhNWG1MGnKCYCls7rUmmoZZRLibw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tz3nwEYagKDRqxR9qdc1irGFxBY7d916Rw9KROokT2ZFUSWRPu02PpnHwH9gmNHiwU0aLARGe04fl5MJGmiRhwvRfJL7hjzOC7ReXoKhvQTAVZeYTi1Q/507oZZRVCf3ZW9x6IPjDDwoDKbSGHbvnnnYlZ/zj58A4AnZz2qrhaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip4t1729302101tvi18dz
X-QQ-Originating-IP: ynXIJcmp3WHc/o4G+1XDGVUvagsnCUWFysOJgE/1ozI=
Received: from [IPV6:240f:10b:7440:1:cb8d:6c02 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 19 Oct 2024 09:41:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13226523954872317656
Message-ID: <5E49B36195743C7C+3eb032f1-fda6-4a61-bcaa-8ce34256cb51@radxa.com>
Date: Sat, 19 Oct 2024 10:41:35 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: dts: rockchip: Enable HDMI0 on rock-5b
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241019-rk3588-hdmi0-dt-v1-0-bd8f299feacd@collabora.com>
 <20241019-rk3588-hdmi0-dt-v1-2-bd8f299feacd@collabora.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241019-rk3588-hdmi0-dt-v1-2-bd8f299feacd@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NgRM4dHY2JYJ4NeKvRKHj+KVewdSLzxYb+M5RWQiXGgWkLMw7T91cEdT
	DdXIUZ/Q7iruiKeSrX49Gmu69OoTJEHekUOfFzWndc8g1XxSfnbcXXn29kDqWNKV+ngw6MV
	VlhWJyd80Ia//u2VGGmNPVCZsnhomF/tfn0mxNskRB8ijydZ8Vi1ufpFGc0Aq4nu0REzsJH
	PfwP+DisqKjJxgiaWKkVFCnmhPRzlsunUtW26aD6RLZwpWeObwM2ErUTBnXXpnEVn85gjr5
	cPp6x+kFXROaoUrOZ3UIkMPibTPBsgv4x0vl1VpoNTSbv2xc//ZETx4e9RoFbvEtxsuRphu
	1YoWAT3mTALdhMPU3xRj8s9LFUUbEx5/GGtdu/51D5WC+IFWVpYHY1X1zmbIGggYZIXwuTY
	HJwFXO84T7uUfNtmtJR30snP1ys7xUWJHgM1bS3f3zbKz2vUE1Med+SvkBAhOUB27+kSq+j
	efeLGrmo4KhT9OoXkCVjuO3XKNyWf14JNDPPXzQJ24cfuXkPHdKhQD3N1GfVL9T0WgrLNQ9
	dVCeeImHAYbbt1BNvXB3AMZXe1GsHk219VWXrqiTtbU+fJECsB2p2gWTcVD+z+jV2XCXgL1
	kW/ubsQOc6tKyHFJFyws0puqrndxvPWrnF0ssztrg2qr/UPVh4YOgYEGNlAysvnLul0f8W7
	s4h3wHOnFiXjlDQMyHfnJd/TIhke779x64x2kFCLZDGuDjjs7oqMbE1w3Xl6WG/wzfNLuxS
	6abkjaCAVloBiCYnIH1ZGBSyvQ9Mxru0unbNVfFyX5iZG8PLa4tFXJ41lBvvve75srkr2Pz
	3FEEf4k+Thp8cRfs7Jtt//BW5V3xievJs72wuVm7ZHrr5Mc5Vr0KYyUgzP9R3mKoPXmQ0rR
	n16TTmkiIjN5DUzLELAJHeMKzNkB/n65nhZS07aChtM=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Hi,

thank you very much for your work!

On 10/19/24 06:39, Cristian Ciocaltea wrote:
> Add the necessary DT changes to enable HDMI0 on Rock 5B.

Rock 5B -> (Radxa) ROCK 5B

> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Tested-by: FUKAUMI Naoki <naoki@radxa.com>

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> ---
>   arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 47 +++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index d6fff5b86b87020f115ce64795aee90c002a2255..0c3baf74981b714eb2a1edbc3fbbb69cd688cfc2 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -4,6 +4,7 @@
>   
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/leds/common.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
>   #include "rk3588.dtsi"
>   
>   / {
> @@ -37,6 +38,17 @@ analog-sound {
>   		pinctrl-0 = <&hp_detect>;
>   	};
>   
> +	hdmi0-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi0_con_in: endpoint {
> +				remote-endpoint = <&hdmi0_out_con>;
> +			};
> +		};
> +	};
> +
>   	leds {
>   		compatible = "gpio-leds";
>   		pinctrl-names = "default";
> @@ -192,6 +204,26 @@ &gpu {
>   	status = "okay";
>   };
>   
> +&hdmi0 {
> +	status = "okay";
> +};
> +
> +&hdmi0_in {
> +	hdmi0_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi0>;
> +	};
> +};
> +
> +&hdmi0_out {
> +	hdmi0_out_con: endpoint {
> +		remote-endpoint = <&hdmi0_con_in>;
> +	};
> +};
> +
> +&hdptxphy_hdmi0 {
> +	status = "okay";
> +};
> +
>   &i2c0 {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&i2c0m2_xfer>;
> @@ -858,3 +890,18 @@ &usb_host1_xhci {
>   &usb_host2_xhci {
>   	status = "okay";
>   };
> +
> +&vop_mmu {
> +	status = "okay";
> +};
> +
> +&vop {
> +	status = "okay";
> +};
> +
> +&vp0 {
> +	vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
> +		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
> +		remote-endpoint = <&hdmi0_in_vp0>;
> +	};
> +};

