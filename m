Return-Path: <linux-kernel+bounces-372629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB33C9A4B34
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 06:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 036D2B21CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 04:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF01D2F73;
	Sat, 19 Oct 2024 04:42:38 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DBC20334;
	Sat, 19 Oct 2024 04:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729312958; cv=none; b=GyHrYldWSqiGo9bT52r/FsqklA5SPQtkwicihKnStGmCEgKTaX904nszRyP3c0ntg03ZjOiw0glPmLdEWJXfAxQiD8k0Zm6YiQ5TpHOZPJj8BLLTjdgeYfdMymC57Ab6/tM6l8BZkyzADWB3YRdvYGbkdEGRF101ASljDUCztxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729312958; c=relaxed/simple;
	bh=BSFVuHYTGSJ63lyXEHZPmyeWVlrsWwib87kwLinyM2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HeMEJjwz2EH2cbyZb5cgrFfsiJ/KtPV9i1iBumZpTAmJqgmEE2p4HSErWxiT2Ae4ljCe8SbbylwIV0g8pxH6WZt2ry5w949w4pHyShL6LvqPa4z2kCkW6edhE98pHarxLD1Fs9Zs2TnD3Xd1o7sbgQVOmrdEGqPczHZDMF3rvGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip2t1729312930tfrg5ja
X-QQ-Originating-IP: PFgNwIWMhEtDdVnAuM0TWSxgSVMwkKW1c0HSyTf66pU=
Received: from [IPV6:240f:10b:7440:1:8680:8ad4 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 19 Oct 2024 12:42:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17043883481862814476
Message-ID: <6FF0CF3856870371+bbebd66b-e19c-40c2-863b-1d6c5c30c461@radxa.com>
Date: Sat, 19 Oct 2024 13:42:05 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH UNTESTED 5/5] arm64: dts: rockchip: Enable HDMI0 on
 rock-5a
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Luis de Arquer <ldearquer@gmail.com>, Alexandre ARNOUD <aarnoud@me.com>
Cc: kernel@collabora.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20241019-rk3588-hdmi0-dt-v1-0-bd8f299feacd@collabora.com>
 <20241019-rk3588-hdmi0-dt-v1-5-bd8f299feacd@collabora.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20241019-rk3588-hdmi0-dt-v1-5-bd8f299feacd@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NDNaZgy3Og6AVKgQVTxFidsaRoCyXc63tVaCYdrWjcDaTkiVw9LLITI2
	vHZkOJvWvztfWw63/nZcYwPR89GxtlFofAflQO7HQCxEhTnNul5BwNDDIjrYnLKuoKBcktS
	UfdKX0CrCMgGFsTqBFIBmsVsD2zzLS6K/vjplR99flLUXsia9ZmWbICWkpsclK+ATJ+06Jn
	aNX549QimuOLHHtWFarottcANZ6DbLjr+lJMkO2DfoE7XvOXqyFoJCGMY5AjPWFXKN3ADLF
	1hVjeegIBUtZ9AuJJXB6bExXcPAQV8fAzLi4OAOlSMcqiJA+NEVgC/OnddA0mZt2axKDU37
	t31uMpmhcy5Bin31QXBnWIqTrdaLiHGtC0YLvTu6fbUPXq00Uwpn15YFsKAkwDftu8WL60b
	3FKyGvOBjPqrXnrRhhmJoYahcpiz20IjQ7rKxbRSLcUNTPp7qQyZHXVDCIZ3zlkLJ4X8+Wb
	LqEMdOGIIlAVMRWDLml6p/IVU5oRp76JSwnBhD92AFCAJcc63iW8Y1dMJSie78Ecwc3x8OS
	VQL4XlzMVwijrkaHf4axgF/Uq+tpHjqqDdSO+QPLbqk70iodoAmcKqmz/KRZYNFNxwo3xP8
	q9eEvy2Gx5qODHC8I55ZEWEFMow+xepTReIX78hCBMZ+a5LOcDwjC5c6gv0J2wXhzOdoWnN
	ThwrGueapARecBeajb+DhVxQaBxVgyVvDzNpLEahAdtYXhcSMgkrrgJg+P+4G43ByrGEGU3
	HQf/wSkq2DY/PGPSIVUctbsOtCCJ1sdtNpESGF8K1qP05khD6GG2jY4CqWOWssgTOWv0ov/
	93DhAa2lSwRCqVZy5hZurBe6tIBYKiDewWyTSr5YP2BfnAisE1P6joj7mwx6+QGInUOH/lf
	R0OyGJ7DOO7okGcfe5a8eRZzYDmlzUXuqwhkj99+Q9yzOVlVqMqCaw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Hi,

On 10/19/24 06:39, Cristian Ciocaltea wrote:
> Add the necessary DT changes to enable HDMI0 on Rock 5A.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts | 47 ++++++++++++++++++++++++
>   1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> index 87fce8d9a964cd53d179ce214ae1c0ff505a2dce..1fd122250b0c70e729b7a2239ab5f288a6387a70 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
> @@ -5,6 +5,7 @@
>   #include <dt-bindings/gpio/gpio.h>
>   #include <dt-bindings/leds/common.h>
>   #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
>   #include "rk3588s.dtsi"
>   
>   / {
> @@ -35,6 +36,17 @@ chosen {
>   		stdout-path = "serial2:1500000n8";
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
> @@ -296,6 +308,26 @@ &gmac1_rgmii_clk
>   	status = "okay";
>   };
>   
> +&hdmi0 {
> +	status = "okay";
> +};

on ROCK 5A, HPD pin is different.

how about this?

diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts 
b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
index f4293d666368..600028fcad88 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-rock-5a.dts
@@ -314,6 +314,9 @@ &gmac1_rgmii_clk
  };

  &hdmi0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdmim0_tx0_cec &hdmim1_tx0_hpd
+		     &hdmim0_tx0_scl &hdmim0_tx0_sda>;
  	status = "okay";
  };


(I don't know why HDMI worked on ROCK 5C... it should be same as 5A)

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

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
>   &mdio1 {
>   	rgmii_phy1: ethernet-phy@1 {
>   		/* RTL8211F */
> @@ -788,3 +820,18 @@ &usb_host1_ohci {
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


