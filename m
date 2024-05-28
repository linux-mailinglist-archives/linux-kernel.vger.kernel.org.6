Return-Path: <linux-kernel+bounces-192270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9188D1AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82541B28E18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5A273518;
	Tue, 28 May 2024 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TW0193bR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD61D5B1E5;
	Tue, 28 May 2024 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716898560; cv=none; b=l/SedcOl/4AXNQcOLFFDPF3XSePYffheFbegYVBDQq1TLR2AdWm04ulewYAh8VEriqXapOFpnNvIG36azGrM8fbzJnNEuPCiJD0KJgl6UaCzWKFtZH08spWtppV0OjWvmImfbDd/JVnWWzW1bEHvIMRDYI4hd8Nkskb5w2rvMRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716898560; c=relaxed/simple;
	bh=B6ImZzl1ymUfsSip34+ZJslfy/Att2gpk1uY569vkH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sgLzhMWyHWy4vCqTQGnJDLtwxezXUn59pXBR3Fzn3vUQ8GC9lYqqhz9AJXYcAP46DrK92lT7nUaQIRbd8cv0pwNhKqQCX9a9fwPqsKW6zE0c7wLrAfHy7utMud5PnEg2EB5EY+sNwVdLwjlvJIscEwKf3SYz8ev8sfBwkdV5lWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TW0193bR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07666C3277B;
	Tue, 28 May 2024 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716898559;
	bh=B6ImZzl1ymUfsSip34+ZJslfy/Att2gpk1uY569vkH4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TW0193bRaPdrJP/Eacghq8tKLTCyAbhkH0PnIzfuzXwdgPrhw0j6/1E98jLtGAKc7
	 fXr77u70bdveNDlvhlu2+QB0+DyrR6X3mHwyYBD3/HObINsXFxAWk4VnBSPmHM0XyW
	 ltdOI4iOvBgtdPZlLW8KyH07H+DiGIynREUI7aeLIlldyXRtu2ESWogfWdntxNKI19
	 ZrnMfdsNNGNzNNpfN8p2gECsV7Wfon3Mr6Xl1KNJYk/Fmih6FdG5BnIi/VmMsXEY7p
	 i4NFCdDGT/zFyQqak3bIrPHPj44rVaQC6Hor22LvfOnqBFJPIojYpH9PVvAZATeJTz
	 xGJ9HeBLxqoSQ==
Message-ID: <f52d9569-a399-422f-9cf0-b0bf69b64d18@kernel.org>
Date: Tue, 28 May 2024 15:15:53 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] arm64: dts: ti: k3-j722s-main: Redefine USB1 node
 description
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240524090514.152727-1-s-vadapalli@ti.com>
 <20240524090514.152727-3-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240524090514.152727-3-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 24/05/2024 12:05, Siddharth Vadapalli wrote:
> From: Ravi Gunasekaran <r-gunasekaran@ti.com>
> 
> USB1 controller on J722S and AM62P are from different vendors.
> Redefine the USB1 node description for J722S by deleting the
> node inherited from AM62P dtsi.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
> v2:
> https://lore.kernel.org/r/20240513114443.16350-3-r-gunasekaran@ti.com/
> No changes since v2.
> 
> v1:
> https://lore.kernel.org/r/20240429120932.11456-3-r-gunasekaran@ti.com/
> Changes since v1:
> - The entire node which was added in k3-j722s.dtsi in v1 in now moved to
>   k3-j722s-main.dtsi as USB is a main domain peripheral.
> - Used generic node names - renamed "cdns-usb@f920000" to "usb@f920000".
> 
>  arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 39 +++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> index 0dac8f1e1291..b069cecebfd9 100644
> --- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
> @@ -6,6 +6,13 @@
>  
>  #include <dt-bindings/phy/phy-ti.h>
>  
> +/*
> + * USB1 controller on AM62P and J722S are of different IP.
> + * Delete AM62P's USBSS1 node definition and redefine it for J722S.
> + */
> +
> +/delete-node/ &usbss1;
> +

This is odd and indicates issues with current DT file inclusion.
We need to split out the non common IPs (e.g. USB) out of the common k3-am62p-main.dtsi file Maybe call it k3-am62-main-common.dtsi.
Only keep am62p specific stuff in k3-am62p-main.dtsi.

Include k3-am62-main-common.dtsi and k3-am62p-main.dtsi for AM62P
Include k3-am62-main-common.dtsi and k3-j722s-main.dtsi for J722S

This way you don't need to call /delete-node/

>  / {
>  	serdes_refclk: clk-0 {
>  		compatible = "fixed-clock";
> @@ -52,6 +59,38 @@ serdes0: serdes@f000000 {
>  			status = "disabled"; /* Needs lane config */
>  		};
>  	};
> +
> +	usbss1: usb@f920000 {
> +		compatible = "ti,j721e-usb";
> +		reg = <0x00 0x0f920000 0x00 0x100>;
> +		power-domains = <&k3_pds 278 TI_SCI_PD_EXCLUSIVE>;
> +		clocks = <&k3_clks 278 3>, <&k3_clks 278 1>;
> +		clock-names = "ref", "lpm";
> +		assigned-clocks = <&k3_clks 278 3>; /* USB2_REFCLK */
> +		assigned-clock-parents = <&k3_clks 278 4>; /* HF0SC0 */
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +		status = "disabled";
> +
> +		usb1: usb@31200000{
> +			compatible = "cdns,usb3";
> +			reg = <0x00 0x31200000 0x00 0x10000>,
> +			      <0x00 0x31210000 0x00 0x10000>,
> +			      <0x00 0x31220000 0x00 0x10000>;
> +			reg-names = "otg",
> +				    "xhci",
> +				    "dev";
> +			interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>, /* irq.0 */
> +				     <GIC_SPI 232 IRQ_TYPE_LEVEL_HIGH>, /* irq.6 */
> +				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>; /* otgirq */
> +			interrupt-names = "host",
> +					  "peripheral",
> +					  "otg";
> +			maximum-speed = "super-speed";
> +			dr_mode = "otg";
> +		};
> +	};
>  };
>  
>  &main_conf {

-- 
cheers,
-roger

