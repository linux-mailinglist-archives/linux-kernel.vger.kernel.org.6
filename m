Return-Path: <linux-kernel+bounces-327216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44235977279
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 21:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76ECC1C212A1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2421BF816;
	Thu, 12 Sep 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="TbFaotKV"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84913DBBE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726170823; cv=none; b=pYUMlvct3ZHBpdGrg/C1AzV5C/i77U8XLVKp9lnKAUxJ3Vv8Opxv0WpWxL2/Qh+CsLmqkrCo/S81ie/5UvZTCNBGRO0W7nFEwpNBW2JrzKQSCB5vJdv6Dgw5iVTTA59zzetUwkjPPmwrnKWKlDLWTv3wD20UgreaNmvvLKrQ/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726170823; c=relaxed/simple;
	bh=gPwCkTrHQdbsIlO87NzXTZsyvl2I+63Uc/+HMghrN1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsNB7agQgzsowoNtQk/zL951+ABzMs0ryoiatK4IW9Q6I1NK+Wh7mud+W6ble/5iRkGhISg3HbGBG150bOZ9AA4siyv+JvsEhfDTZ0sSIrsWPSZNm7ruO2eu9h4bJK7VBsqkHBOn4brthsB3vdjgRwmYeMGNh6Uagcg8MxyWDgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=TbFaotKV; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1726170804;
 bh=r1OmUvvXBK2m/ZTQhR2+stgE0XRSFyk2GHzUddZ5Wps=;
 b=TbFaotKVrsa0TchV4o5DR4L2n6rXDXyvQK76MFEZFrYNEi0a8utv/ifedW1G/GJvlgMIleVGj
 lhVdLdXzYvLBUziOOaJAfy+3tEPkIbZhsDFwcA5rNSnry1mvHoOL1N5cBiFj2MhWEDzZZ9el7wJ
 INTl4xfiZH8k+pmtK5UT81YBVhn5ivCVGj/2lKQoKohY+UypgLO0PBuGSrHVDPt7ZF3g+lFCAfq
 ZgqqZAmLNtgmuK4AbtsAqLhFlj6LffaPVTlgUnnmwHzCyrdAZDCi9bKciGPyEb+kGc5hhAKeB+9
 32omUelNuR+l14xaLCVbpASlpV45ap8CRwoRfSbxJuQA==
Message-ID: <ed4b6913-f19b-4280-b3b2-f5bb1e7f47eb@kwiboo.se>
Date: Thu, 12 Sep 2024 21:53:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: rockchip: Enable all 3 USBs on Turing RK1
To: Sam Edwards <cfsworks@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ondrej Jirman <megi@xff.cz>,
 Chris Morgan <macromorgan@hotmail.com>, Alex Zhao <zzc@rock-chips.com>,
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jing Luo <jing@jing.rocks>, Kever Yang <kever.yang@rock-chips.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?Q?Daniel_Kukie=C5=82a?= <daniel@kukiela.pl>,
 Joshua Riek <jjriek@verizon.net>
References: <20240912025034.180233-1-CFSworks@gmail.com>
 <20240912025034.180233-5-CFSworks@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20240912025034.180233-5-CFSworks@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66e346b3fcb6c7d83e7b8dc6

Hi Sam,

On 2024-09-12 04:50, Sam Edwards wrote:
> The Turing RK1 contains 3 different USBs:
> - USB0: USB 2.0, OTG
> - USB1: USB 3.0, host
> - USB2: USB 2.0, host
> 
> This patch activates the necessary DT nodes to enable all 3 buses.
> 
> Future work will be needed on USB0: it is not USB 3.0, but Linux creates
> an unused USB 3.0 root hub and the controller also requires that USBDP0
> be powered up. However, it is possible to remove this dependency. By
> either patching the xHCI driver to ignore the enumerated USB 3.0 port or
> setting usb3otg0_host_num_u3_port=0 in the GRF to stop the controller
> from enumerating a USB 3.0 port in the first place, neither Linux nor
> the controller will expect USB 3.0 capability, and USBDP0 can then
> safely be removed from the `phys` property.
> 
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  .../boot/dts/rockchip/rk3588-turing-rk1.dtsi  | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> index f6a12fe12d45..6036c4fe6727 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
> @@ -666,3 +666,67 @@ &uart9 {
>  	pinctrl-0 = <&uart9m0_xfer>;
>  	status = "okay";
>  };
> +
> +/* USB 0: USB 2.0 only, OTG-capable */
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&usbdp_phy0 {
> +	/*
> +	 * TODO: On the RK1, USBDP0 drives the DisplayPort pins, and is not
> +	 * involved in this USB2-only bus.  However, if the USB3 port is
> +	 * enabled in the xHCI below, the controller will expect this PHY to be
> +	 * powered up and holding RX_STATUS idle, or else it will generate an
> +	 * endless stream of CSC events whenever a device is plugged in.  Until
> +	 * there is a way to communicate to usb_host0_xhci that it doesn't have
> +	 * a USB3 port, we have no choice but to power up USBDP0.
> +	 */

Sounds like this may be missing

	rockchip,dp-lane-mux = <0 1 2 3>;

or

	rockchip,dp-lane-mux = <3 2 1 0>;

if all lanes are used for DP and none are used for USB.

It should help describe the hw and also help the driver set mode to
UDPHY_MODE_DP and that should disable the u3 port, or there may be an
issue to fix in the phy driver.

> +	status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +	extcon = <&u2phy0>;
> +	maximum-speed = "high-speed";

If this only use the USB2 phy, this should probably also override the
default phys and phy-names props with:

	phys = <&u2phy0_otg>;
	phy-names = "usb2-phy";

Regards,
Jonas

> +	status = "okay";
> +};
> +
> +/* USB 1: USB 3.0, host only */
> +&u2phy1 {
> +	status = "okay";
> +};
> +
> +&u2phy1_otg {
> +	status = "okay";
> +};
> +
> +&usbdp_phy1 {
> +	status = "okay";
> +};
> +
> +&usb_host1_xhci {
> +	extcon = <&u2phy1>;
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +/* USB 2: USB 2.0, host only */
> +&u2phy2 {
> +	status = "okay";
> +};
> +
> +&u2phy2_host {
> +	status = "okay";
> +};
> +
> +&usb_host0_ehci {
> +	status = "okay";
> +};
> +
> +&usb_host0_ohci {
> +	status = "okay";
> +};


