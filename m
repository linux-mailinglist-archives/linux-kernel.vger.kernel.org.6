Return-Path: <linux-kernel+bounces-558964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B37A5EDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 09:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E85C3B15B6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C53260374;
	Thu, 13 Mar 2025 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpXfG2Hh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC1D52E3391;
	Thu, 13 Mar 2025 08:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741853447; cv=none; b=tIHpPEvQDE2h0QE0cLQ/E7GNugZ52dFs8ylnPdOZ0Z2CDf23+WaHz9FMGfllTVQ1KQFiIJagAadqOI/S2ho9/xoA2rlGxjJUKtrDGOLHVwKyIRh+RnyWfAY6AKg/BUnCB9rjn56gbdq+HCktGaL4joWtFtmwhG7W8OwACIWjMeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741853447; c=relaxed/simple;
	bh=Zp1VrZoXU/0dSvEI86TANfaHnZV5iTRbrfgotlEDFRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bJL2VDAF5kHq0Do1ccfnLCU4mdHiSAXuXiFioyRdZ6NtQ/ir0d8KK6bOoRa+1aC9W5dJ50IGrKswyMTWAWkYkagGKIxQahP1xeY0KoxozX0a6f8tNSlnWrNPX8Y5a2jfYCmNqLb5oBOx8yiEflpvf8HogBwx6/WJqMEyH9+DFeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpXfG2Hh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192C1C4CEE9;
	Thu, 13 Mar 2025 08:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741853446;
	bh=Zp1VrZoXU/0dSvEI86TANfaHnZV5iTRbrfgotlEDFRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpXfG2HhBD0lvTWWhRZA+1T8htRe+xTYjak3WeCBc7WDn9XNvGVXbCye4eQHWGXQx
	 tDbB1ms2wNbC4aEE3MROlHrWhcxKkySOS7TESW0MK8akdtqAYX8xdfbUGc0S7l3Ieo
	 bvMrAGxYbhEv0F405l+dTAhBKbRrUI5WgeKlc1OYbxkQoD2AiuvrnBtsFFh7yHmSjg
	 VSIflVkoxTCLnojftgiyh96Dk22WoaGJ0B6JXAGJACTduRHPzr1c6Fqh0CS2dE28N2
	 iWOZfLVkFcRXWfUISQzeA+efY0As4cm82VNBDuhZi5FmIm7v2hrA1Qesz3PKfbSrrp
	 jw/RBgrYdOfVA==
Date: Thu, 13 Mar 2025 10:10:40 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, hjc@rock-chips.com, mripard@kernel.org, 
	cristian.ciocaltea@collabora.com, neil.armstrong@linaro.org, yubing.zhang@rock-chips.com, 
	krzk+dt@kernel.org, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	robh@kernel.org, sebastian.reichel@collabora.com, 
	Andy Yan <andy.yan@rock-chips.com>, "stephen@radxa.com" <stephen@radxa.com>
Subject: Re: [PATCH v2 7/7] arm64: dts: rockchip: Enable DP2HDMI for ROCK 5
 ITX
Message-ID: <y7ouhmfbls3vcumrgudcvhlahxx7iqliimeq4cljko4xfwgzcb@45iozv6spswb>
References: <20250312104214.525242-1-andyshrk@163.com>
 <20250312104214.525242-8-andyshrk@163.com>
 <q3y36jgswj4xa2g3hnptc6kgzphbqfg675r5paa2lwvdseytio@jysj4f2i6osu>
 <5858d492.44b.1958ceb23dd.Coremail.andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5858d492.44b.1958ceb23dd.Coremail.andyshrk@163.com>

On Thu, Mar 13, 2025 at 08:32:55AM +0800, Andy Yan wrote:
> 
> Hi Dmitry,
> 
> At 2025-03-12 20:39:17, "Dmitry Baryshkov" <lumag@kernel.org> wrote:
> >On Wed, Mar 12, 2025 at 06:42:08PM +0800, Andy Yan wrote:
> >> From: Andy Yan <andy.yan@rock-chips.com>
> >> 
> >> The HDMI Port next to Headphone Jack is drived by
> >> DP1 on rk3588 via a dp2hdmi converter.
> >> 
> >> Add related dt nodes to enable it.
> >> 
> >> Note: ROCKCHIP_VOP2_EP_DP1 is defined as 11 in dt-binding header,
> >> but it will trigger a dtc warning like "graph node unit address
> >> error, expected "b"" if we use it directly after endpoint, so we
> >> use "b" instead here.
> >> 
> >> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> >> ---
> >> 
> >> (no changes since v1)
> >> 
> >>  .../boot/dts/rockchip/rk3588-rock-5-itx.dts   | 37 +++++++++++++++++++
> >>  1 file changed, 37 insertions(+)
> >> 
> >> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> >> index 67b886329248..29f10ec9f0c1 100644
> >> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> >> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5-itx.dts
> >> @@ -57,6 +57,18 @@ analog-sound {
> >>  			  "Headphone", "Headphones";
> >>  	};
> >>  
> >> +	dp-con {
> >> +		compatible = "dp-connector";
> >
> >You've written that it is an HDMI connector. Could you possibly clarify,
> >why is it being registered as a DP connector? Is there any kind of
> >a bridge between the DP controller and the HDMI connector?
> 
> When I was preparing this patch at that time, I also had some doubts. 
> Whether it should be registered as a DP connector or an HDMI connector. 
> There is a DP2HDMI conversion chip between the DP of RK3588 and this hdmi 
> interface, but this conversion chip does not require a software driver. 
> If the current writing is incorrect, I will change it to hdmi-connector in the next version.

Yes. Please add the RA620 chip to simple-bridge.c and simple-bridge.yaml
and use HDMI connector here.

> 
> Thanks
> >
> >> +		label = "DP OUT";
> >> +		type = "full-size";
> >> +
> >> +		port {
> >> +			dp_con_in: endpoint {
> >> +				remote-endpoint = <&dp1_out_con>;
> >> +			};
> >> +		};
> >> +	};
> >> +
> >>  	gpio-leds {
> >>  		compatible = "gpio-leds";
> >>  		pinctrl-names = "default";
> >> @@ -268,6 +280,24 @@ &cpu_l3 {
> >>  	cpu-supply = <&vdd_cpu_lit_s0>;
> >>  };
> >>  
> >> +&dp1 {
> >> +	status = "okay";
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&dp1m0_pins>;
> >> +};
> >> +
> >> +&dp1_in {
> >> +	dp1_in_vp2: endpoint {
> >> +		remote-endpoint = <&vp2_out_dp1>;
> >> +	};
> >> +};
> >> +
> >> +&dp1_out {
> >> +	dp1_out_con: endpoint {
> >> +		remote-endpoint = <&dp_con_in>;
> >> +	};
> >> +};
> >> +
> >>  &gpu {
> >>  	mali-supply = <&vdd_gpu_s0>;
> >>  	status = "okay";
> >> @@ -1262,3 +1292,10 @@ vp1_out_hdmi1: endpoint@ROCKCHIP_VOP2_EP_HDMI1 {
> >>  		remote-endpoint = <&hdmi1_in_vp1>;
> >>  	};
> >>  };
> >> +
> >> +&vp2 {
> >> +	vp2_out_dp1: endpoint@b {
> >> +		reg = <ROCKCHIP_VOP2_EP_DP1>;
> >> +		remote-endpoint = <&dp1_in_vp2>;
> >> +	};
> >> +};
> >> -- 
> >> 2.34.1
> >> 
> >
> >-- 
> >With best wishes
> >Dmitry

-- 
With best wishes
Dmitry

