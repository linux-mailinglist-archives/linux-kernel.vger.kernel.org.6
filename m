Return-Path: <linux-kernel+bounces-209072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD81902CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2717DB22A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5DF152782;
	Mon, 10 Jun 2024 23:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RHeTcGX2"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79C23BB48;
	Mon, 10 Jun 2024 23:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718063691; cv=none; b=KVqOUt9mkVBCVKp3e3Hf4JtoqYMMp7W9WbMwec1iVZalk5LfR9mg0gcX47RkRCsiEmEH48O1WjcG+LU8BCgCP2aMjHkodpuG3JsX/kepTSv8lyDrkCm6ep1VKl9iO5cRfKjFM66C0qS3aNmW/fxI/CODdMKKmkplEOl6XNtvzmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718063691; c=relaxed/simple;
	bh=7108FfqKDS2AoueEaQoE2SvY/tEoGg1AWLOfJWgP2o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTZtKbkT1RPzV6is+jWjw6rIn+/osXYErrb7rhhQAdIqZPLlSwSqI2Qu0y+jm3gTZMyOaJQTiZooMsz0gly8WmOpWhd1YnRsYrycfC+yit9TCB1ACptzXSfSly0DBCV5juw6Cf9iydrM4pArHnMt6h4264HMIPkNm1Gd620wDKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RHeTcGX2; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1C91329A;
	Tue, 11 Jun 2024 01:54:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1718063675;
	bh=7108FfqKDS2AoueEaQoE2SvY/tEoGg1AWLOfJWgP2o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RHeTcGX2fWDOd8ZPvYpR+Eiskko+q00VB/BYDyvThkE31xfchmhOWkJwbTLhFCCIt
	 U28eGIlDGwyyNWpkw41Msz4aSluDcoJnh6Qmz1XIxIu2RHiTguyKC4zjxpbrz14D+A
	 O2dbpO67j2iatUq2K/eUwRDw3dVV4565RsFBvNQc=
Date: Tue, 11 Jun 2024 02:54:27 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: linux-kernel@vger.kernel.org, kernel@collabora.com,
	Daniel Scally <dan.scally@ideasonboard.com>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/1] arm64: dts: imx8mp-debix-model-a: Enable HDMI
 output
Message-ID: <20240610235427.GD31989@pendragon.ideasonboard.com>
References: <20240610234307.96766-1-chris.obbard@collabora.com>
 <20240610234307.96766-2-chris.obbard@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240610234307.96766-2-chris.obbard@collabora.com>

Hi Chris,

Thank you for the patch.

On Tue, Jun 11, 2024 at 12:42:38AM +0100, Christopher Obbard wrote:
> Enable the HDMI output on the Debix Model A SBC, using the HDMI encoder
> present in the i.MX8MP SoC.
> 
> This has been tested with a generic 1080p HDMI display, along with a
> smaller 1280x800 HDMI display.
> 
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>

I've been running with this patch in my tree for a while,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Shawn, could you merge this for v6.11 ?

> ---
> 
> Changes in v2:
> - Do not set SION (Software Input ON) bit in pinmux pin config register.
> - Small changes to commit log/cover letter.
> - v1: https://lore.kernel.org/linux-arm-kernel/20240415114135.25473-1-chris.obbard@collabora.com/
> 
>  .../dts/freescale/imx8mp-debix-model-a.dts    | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> index 9b8f97a84e61..af02af9e5334 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
> @@ -20,6 +20,18 @@ chosen {
>  		stdout-path = &uart2;
>  	};
>  
> +	hdmi-connector {
> +		compatible = "hdmi-connector";
> +		label = "hdmi";
> +		type = "a";
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint = <&hdmi_tx_out>;
> +			};
> +		};
> +	};
> +
>  	leds {
>  		compatible = "gpio-leds";
>  		pinctrl-names = "default";
> @@ -94,6 +106,28 @@ ethphy0: ethernet-phy@0 { /* RTL8211E */
>  	};
>  };
>  
> +&hdmi_pvi {
> +	status = "okay";
> +};
> +
> +&hdmi_tx {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hdmi>;
> +	status = "okay";
> +
> +	ports {
> +		port@1 {
> +			hdmi_tx_out: endpoint {
> +				remote-endpoint = <&hdmi_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&hdmi_tx_phy {
> +	status = "okay";
> +};
> +
>  &i2c1 {
>  	clock-frequency = <400000>;
>  	pinctrl-names = "default";
> @@ -239,6 +273,10 @@ &i2c6 {
>  	status = "okay";
>  };
>  
> +&lcdif3 {
> +	status = "okay";
> +};
> +
>  &snvs_pwrkey {
>  	status = "okay";
>  };
> @@ -356,6 +394,15 @@ MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16				0x19
>  		>;
>  	};
>  
> +	pinctrl_hdmi: hdmigrp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_HDMI_DDC_SCL__HDMIMIX_HDMI_SCL			0x1c3
> +			MX8MP_IOMUXC_HDMI_DDC_SDA__HDMIMIX_HDMI_SDA			0x1c3
> +			MX8MP_IOMUXC_HDMI_HPD__HDMIMIX_HDMI_HPD				0x19
> +			MX8MP_IOMUXC_HDMI_CEC__HDMIMIX_HDMI_CEC				0x19
> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1grp {
>  		fsl,pins = <
>  			MX8MP_IOMUXC_I2C1_SCL__I2C1_SCL					0x400001c2

-- 
Regards,

Laurent Pinchart

