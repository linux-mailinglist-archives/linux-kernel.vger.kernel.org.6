Return-Path: <linux-kernel+bounces-552931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA431A58123
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 07:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D70E016BA07
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85727145A18;
	Sun,  9 Mar 2025 06:36:19 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC43F4C79
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741502179; cv=none; b=mLXETxUg000T46WWEnF+BUYzV+eVhfj7yRWRh40RfslClz+84Jucpnm2F/FEVPtl5dYYhG5o7zoTrV9JuQ7lnnWrXWex7QGAxIyEuI4/HRAAARN5xqC1VDiHjtQaDOBb3kWbk6yBo5cj38pQwprGjJ4T7FHc2O6bZJhmfPx7EEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741502179; c=relaxed/simple;
	bh=/fOLXHkAsCxPZjc64DW9dMH8H/ht8L+hRC6aW4aqF+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBn7m3nOqpSlNY02foVyUbE4S3qL6tNJ/CQmH1q847fPPIz1dwJABRTH0CbwPPv/IUUSjrpRtfeSaqs0qjMlVrYThM/5y641p16CMgcXZWA01J5Fu3Sz0bFBeBonLxZrNmtkMv3lTapVyDRohfOw+oNDmtKA7pvUwISzlwgk3Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: bizesmtpip4t1741502154t5gjj86
X-QQ-Originating-IP: PIiBMmc3En4vJW7/I3LQGRV2j1PvNOrAV1RB8S3SouM=
Received: from [IPV6:240f:10b:7440:1:893e:bed3 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 09 Mar 2025 14:35:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2792177622462223588
Message-ID: <3605ABCB7EF60115+2de06a28-1b3d-4a0e-b960-9e0a74c6e19d@radxa.com>
Date: Sun, 9 Mar 2025 15:35:46 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm64: dts: rockchip: Enable DisplayPort for rk3588s
 Cool Pi 4B
To: Andy Yan <andyshrk@163.com>, heiko@sntech.de
Cc: neil.armstrong@linaro.org, sebastian.reichel@collabora.com,
 devicetree@vger.kernel.org, hjc@rock-chips.com, mripard@kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 yubing.zhang@rock-chips.com, dri-devel@lists.freedesktop.org,
 Andy Yan <andy.yan@rock-chips.com>, krzk+dt@kernel.org, robh@kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250223113036.74252-1-andyshrk@163.com>
 <20250223113036.74252-7-andyshrk@163.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <20250223113036.74252-7-andyshrk@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N4KH/PyO63Qv6cN9E8XhJf3/DwmPZL22gVmog9Z7O+1PMH9IVCb9E4Ia
	OKptXoxvmUC20f8ZhEBHVkOHz6sklwf6O1Mbk2iCc/Cj3Mr+alpJ+U7aXEOSH36pR66+BPs
	5s/bSZE2F+YDvtRjANSx1n/plnCjRE+6KnKDP+OM1I5IOrjK8PEHeq21G5g+DpJnD5enGED
	1KtybPC4HV7Z/Z5CnkXtD9FWtjZVTSNxbOSQZ+WL6o4jVHz97aNxOTe+wFap7TVZO86eP76
	oqm1/V6HnxmydQfAnRb6zbfnPSa99jYAdO29cwpvhasvasMUF3eWedgY9qyCqThloyN+D4v
	LKXlPt+AG0Ac6gjHur0IgOGRPR5J+3EHkQs0gUthl+7cU6y2R1DK3/eRVzSluyaNVM5ToAC
	3VPDwAKR/9lCaQh+84Gb3EX1XfG2f5pAYzz7/bnxeL08stsZ63B1JoX/9fuZfrgrm+ciZt/
	Ki2CckmyMEu9/KnKG4gDPD2WTnO3kVCgN60ZyVjqYis4IR+oZ/AVi/mQcLm+ywS9r2+2Jjw
	CH7KYapu6odl6zI5MDMv6z3PEWiENEwL4wDRCBV2Ua6w2MyVC2+ZGkhedbzj0uvSpmnjTZN
	94Tt/pNiQUlF4Z/IO+02f8NsnKahcbwl49kAOYTlPZdKT/W2qVzOGGkiI6ObgQj2lY4j7eD
	PGTb7RWlQSI8t48YO3Tu0txc2bHuiUJUJcd/wDnaTmpanHUnmBwRZTG0tpZRe88miRgrQ5C
	eX5aNuvjHSf+MuLwK5VeBLMssRFzVscp3HpWmdQ3ZDaDY0VWJQftcf34SLGNJMfPSi3CeZM
	x6bOcRrPzbls8OrLO3peecZUgH5VKXOU06I222S20WVZZ4t+LTbKPdZuEyTd1pXpsNHWCz1
	zQUv+ntHyqS79LRcfZLP1noBN81CygKDiy0vJWtZhuM22sb4GUVjvbfYGHmb5Q10JzwjdWq
	iTawapIn0BUmoq9tNozSqm5WI
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi Andy,

On 2/23/25 20:30, Andy Yan wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> Enable the Mini DisplayPort on this board.
> Note that ROCKCHIP_VOP2_EP_DP0 is defined as 10 in dt-binding header,
> but it will trigger a dtc warning like "graph node unit address error,
> expected "a"" if we use it directly after endpoint, so we use "a"
> instead here.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>   .../boot/dts/rockchip/rk3588s-coolpi-4b.dts   | 37 +++++++++++++++++++
>   1 file changed, 37 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
> index e892dd7c91aa..0f58eb56557f 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-coolpi-4b.dts
> @@ -39,6 +39,18 @@ chosen {
>   		stdout-path = "serial2:1500000n8";
>   	};
>   
> +	dp-con {
> +		compatible = "dp-connector";
> +		label = "DP OUT";
> +		type = "mini";
> +
> +		port {
> +			dp_con_in: endpoint {
> +				remote-endpoint = <&dp0_out_con>;
> +			};
> +		};
> +	};
> +
>   	hdmi-con {
>   		compatible = "hdmi-connector";
>   		type = "d";
> @@ -220,6 +232,24 @@ &gpu {
>   	status = "okay";
>   };
>   
> +&dp0 {
> +	status = "okay";
> +	pinctrl-0 = <&dp0m0_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&dp0_in {
> +	dp0_in_vp2: endpoint {
> +		remote-endpoint = <&vp2_out_dp0>;
> +	};
> +};
> +
> +&dp0_out {
> +	dp0_out_con: endpoint {
> +		remote-endpoint = <&dp_con_in>;
> +	};
> +};
> +

These three nodes should be placed above the &gpu node.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

>   &hdmi0 {
>   	status = "okay";
>   };
> @@ -889,3 +919,10 @@ vp0_out_hdmi0: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
>   		remote-endpoint = <&hdmi0_in_vp0>;
>   	};
>   };
> +
> +&vp2 {
> +	vp2_out_dp0: endpoint@a {
> +		reg = <ROCKCHIP_VOP2_EP_DP0>;
> +		remote-endpoint = <&dp0_in_vp2>;
> +	};
> +};


