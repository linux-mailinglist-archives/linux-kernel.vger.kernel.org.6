Return-Path: <linux-kernel+bounces-290389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B44955339
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC841C21450
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5166F1448E4;
	Fri, 16 Aug 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQ46Rvr/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028885283;
	Fri, 16 Aug 2024 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723846642; cv=none; b=jSqwSXV3PK8htigzZevlRWY5cVOqLLOQjUOMDvh2Eqgt7eLXBXrRNwPHaRirFhvaSe01tjGtOj+EgBzKsJ6AxI7t3v1sPBOdaqUKwSc6yL5ve75u7sDJ/VgiTO5fhyMInwSVOcYKnBJLeXMrP7bESyVnG6K/AA7SKa0D80IO6uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723846642; c=relaxed/simple;
	bh=YFXyLRdTdKL+XGNnS6T/ngMPukIr3Puqfais+ydAetM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spF+z0pIbotVk/iFAxOfEJuGds16evaDnj1c/dhSEV9i63f94zB4Iu8fa5yWsFwwjV+kHM+6epnyNY941DnStu2uPz2GDamOZt9xfGvLWQvlAmhoQez8UEPBKZKdeoLDO3fPySy4DbQ93jdwZ5GBvuq5vEw0ZPbnPYIaGGyPtUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQ46Rvr/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80B9C32782;
	Fri, 16 Aug 2024 22:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723846642;
	bh=YFXyLRdTdKL+XGNnS6T/ngMPukIr3Puqfais+ydAetM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NQ46Rvr/lioZMLsm92COpmjfnKW0ZP3KhambKoTbdNLlAXs5P1wNYOtiUhj7cAFym
	 uDoelhzBC3ka6JZdJNJB4bJgGA2l4oaTodC4bL1+vo5d0x0aszxz9EpGE0a6Didlad
	 Wn+qOod8UznAN9htBGUwApuZV4gqmsJmtMABegeBJ69E+TCl+BPRnlp4yJ4sJsIzF3
	 afpobyZCOam1dDgyA2FGBsePytJltND+5r87jAXsaXIOriJiedIaYxgxaqAXlpDY0v
	 uICzEnQbkHGL88wRpRw7PcWiR94u80KRLUmq6ACqLXQf8yomdjTuTxDDuYA9QxYWDI
	 JcV5wlClebpOw==
Date: Fri, 16 Aug 2024 16:17:21 -0600
From: Rob Herring <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:NXP PTN5150A CC LOGIC AND EXTCON DRIVER" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: extcon: ptn5150: add child node port
Message-ID: <20240816221721.GA2362530-robh@kernel.org>
References: <20240815203244.96963-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815203244.96963-1-Frank.Li@nxp.com>

On Thu, Aug 15, 2024 at 04:32:44PM -0400, Frank Li wrote:
> Add child node 'port' to allow connect to usb controller to do role-switch.
> Add example for id pin of ptn5150 have not connect to main chip's usb id
> pin.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/imx8mn-var-som-symphony.dtb: typec@3d: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
>         from schema $id: http://devicetree.org/schemas/extcon/extcon-ptn5150.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - add example for id pin have not connect to main chip's id example.
> - commit 095b96b2b fix "port" warning, but add new warning "connector" is
> not exist. And follow commit revert this change.
> 690085d866f08 Revert "arm64: dts: imx8mn-var-som-symphony: Describe the USB-C connector
> - I have not board in hand to debug why "connector" is not work.
> ---
>  .../bindings/extcon/extcon-ptn5150.yaml       | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> index d5cfa32ea52dd..39231f9952826 100644
> --- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> +++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
> @@ -37,6 +37,11 @@ properties:
>        GPIO pin (output) used to control VBUS. If skipped, no such control
>        takes place.
>  
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      A port node to link the usb controller for the dual role switch.
> +
>  required:
>    - compatible
>    - interrupts
> @@ -60,3 +65,44 @@ examples:
>              vbus-gpios = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
>          };
>      };
> +
> +  - |
> +    /* id pin of ptn5150 have not connected to chip's id pin */
> +    #include <dt-bindings/clock/imx8mn-clock.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/gpio/gpio.h>

Just add 'port' to the existing example if you want to. Don't need a 
whole other example just for that.

> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        ptn5150@1d {
> +            compatible = "nxp,ptn5150";
> +            reg = <0x1d>;
> +            interrupt-parent = <&msmgpio>;
> +            interrupts = <78 IRQ_TYPE_LEVEL_HIGH>;
> +            vbus-gpios = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
> +
> +            port {
> +                    typec1_dr_sw: endpoint {
> +                    remote-endpoint = <&usb1_drd_sw>;
> +                 };
> +            };
> +        };
> +    };
> +
> +    usb@32e40000 {
> +        compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb", "fsl,imx27-usb";
> +        reg = <0x32e40000 0x200>;
> +        interrupts = <&gic GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clk IMX8MN_CLK_USB1_CTRL_ROOT>;
> +        usb-role-switch;
> +
> +        port {
> +             usb1_drd_sw: endpoint {
> +                  remote-endpoint = <&typec1_dr_sw>;
> +             };
> +        };
> +    };
> +
> -- 
> 2.34.1
> 

