Return-Path: <linux-kernel+bounces-170401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602E58BD654
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 22:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17EFB283164
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 20:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAABF15B563;
	Mon,  6 May 2024 20:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWzg0ttT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C0F15B54C;
	Mon,  6 May 2024 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715028026; cv=none; b=rPwHaFTK2G6wldXDx0s3ubPnuS31HyxDGWx1c2e/c2IH1kFeSw6ZJXSmDdfzAvJ3z+10dv+6IiPhNzOn7qovOfH9QEqKuNpw4W2QaqxHqTBLFyb0/UEQUGIbfHA5a6gyTrmheXOEMcZcgRH3AEkDqcxQ7DHxVYqRRCCyJG11VvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715028026; c=relaxed/simple;
	bh=rWTABs0XgoNxHIEU6FB1ENUmGMXZUHEd53NHS+u7P5Q=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=d1Q4+1DllLFk7JaO+qaJxLQdk1DjCb56Ox5wwWXJcU9RNOZuz/GnMZ9y0iQKX/CelBHqQmVPLoU2/92KuGSptBNcnsl8E4koI7Kl5QGv70eHjWk6vO/5wQIMM1186Zg6670u30YkRZSBvJ0DgS1lnBOCXF0Vwzr6N3ZCwDFKO5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWzg0ttT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36FFAC116B1;
	Mon,  6 May 2024 20:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715028025;
	bh=rWTABs0XgoNxHIEU6FB1ENUmGMXZUHEd53NHS+u7P5Q=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PWzg0ttTovsQ2y7AKUfHCgx+faR7cSQGZ8Ndb6LhmM9gAyN/QaZXowrzYg3SbCfEJ
	 +jfw2cMI8ChtE1WTcBM/F7/jr6yc2Ats8gzQATR/qcpEl2TCwK21EBcUahjfhKDyNc
	 Dzw7eqCpaCBeeHle5FMhr3hB05S8iqJP6MU1f2Ra5p6/lGmLCd41oO/CcGe+wddJpW
	 zzbmqnA72DohDCAlN/XrVSpI0E8Rzc4dcADdzlc0yV/DpkqApCS8jpDpuprnaHv7tw
	 CBjkfeeuHnmG0ytcQ80Lu81BaUzgNFdNLteakKczzE8ELgnAePLZeTfmQslXJWv5u2
	 5kpzcNwAjOxxQ==
Date: Mon, 06 May 2024 15:40:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: kernel@pengutronix.de, s.hauer@pengutronix.de, shawnguo@kernel.org, 
 leoyang.li@nxp.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, festevam@gmail.com, 
 linux-arm-kernel@lists.infradead.org, marex@denx.de, imx@lists.linux.dev, 
 devicetree@vger.kernel.org
In-Reply-To: <20240504215344.861327-1-andreas@kemnade.info>
References: <20240504215344.861327-1-andreas@kemnade.info>
Message-Id: <171502764288.89501.11764429607857982890.robh@kernel.org>
Subject: Re: [PATCH 0/2] ARM: dts: mix: Add Kobo Clara HD rev B


On Sat, 04 May 2024 23:53:42 +0200, Andreas Kemnade wrote:
> Apparently there exists another revision of the Kobo Clara HD
> which has just different regulator setup. So add support for it.
> 
> For details: https://gitlab.com/postmarketOS/pmaports/-/issues/2356
> 
> Andreas Kemnade (2):
>   dt-bindings: arm: fsl: Add Kobo Clara HD rev B
>   ARM: dts: imx: Add Kobo Clara HD rev b
> 
>  .../devicetree/bindings/arm/fsl.yaml          |  6 ++
>  arch/arm/boot/dts/nxp/imx/Makefile            |  1 +
>  .../dts/nxp/imx/imx6sll-kobo-clarahd-b.dts    | 79 +++++++++++++++++++
>  3 files changed, 86 insertions(+)
>  create mode 100644 arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dts
> 
> --
> 2.39.2
> 
> 
> 


My bot found new DTB warnings on the .dts files added or changed in this
series.

Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
are fixed by another series. Ultimately, it is up to the platform
maintainer whether these warnings are acceptable or not. No need to reply
unless the platform maintainer has comments.

If you already ran DT checks and didn't see these error(s), then
make sure dt-schema is up to date:

  pip3 install dtschema --upgrade


New warnings running 'make CHECK_DTBS=y nxp/imx/imx6sll-kobo-clarahd-b.dtb' for 20240504215344.861327-1-andreas@kemnade.info:

arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: /soc/bus@2000000/spba-bus@2000000/spdif@2004000: failed to match any schema with compatible: ['fsl,imx6sl-spdif', 'fsl,imx35-spdif']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: serial@2034000: dma-name: b'rx\x00tx\x00' is not of type 'object', 'array', 'boolean', 'null'
	from schema $id: http://devicetree.org/schemas/dt-core.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: timer@2098000: compatible: 
'oneOf' conditional failed, one must be fixed:
	['fsl,imx6sl-gpt'] is too short
	'fsl,imx1-gpt' was expected
	'fsl,imx21-gpt' was expected
	'fsl,imx27-gpt' was expected
	'fsl,imx31-gpt' was expected
	'fsl,imx6sl-gpt' is not one of ['fsl,imx25-gpt', 'fsl,imx50-gpt', 'fsl,imx51-gpt', 'fsl,imx53-gpt', 'fsl,imx6q-gpt']
	'fsl,imx6dl-gpt' was expected
	'fsl,imx6sl-gpt' is not one of ['fsl,imx6ul-gpt', 'fsl,imx7d-gpt']
	from schema $id: http://devicetree.org/schemas/timer/fsl,imxgpt.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: anatop@20c8000: '#address-cells', '#size-cells', 'regulator-3p0@20c8120', 'temperature-sensor' do not match any of the regexes: 'pinctrl-[0-9]+', 'regulator-((1p1)|(2p5)|(3p0)|(vddcore)|(vddpu)|(vddsoc))$'
	from schema $id: http://devicetree.org/schemas/soc/imx/fsl,imx-anatop.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: regulator-3p0@20c8120: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/anatop-regulator.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: temperature-sensor: '#thermal-sensor-cells' is a required property
	from schema $id: http://devicetree.org/schemas/thermal/imx-thermal.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: /soc/bus@2000000/interrupt-controller@20dc000: failed to match any schema with compatible: ['fsl,imx6sll-gpc', 'fsl,imx6q-gpc']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: /soc/bus@2000000/pinctrl@20e0000: failed to match any schema with compatible: ['fsl,imx6sll-iomuxc']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: /soc/bus@2000000/csi@20e8000: failed to match any schema with compatible: ['fsl,imx6sll-csi', 'fsl,imx6s-csi']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: /soc/bus@2000000/csi@20e8000: failed to match any schema with compatible: ['fsl,imx6sll-csi', 'fsl,imx6s-csi']
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: lcd-controller@20f8000: compatible: 
'oneOf' conditional failed, one must be fixed:
	['fsl,imx6sll-lcdif', 'fsl,imx28-lcdif'] is too long
	'fsl,imx6sll-lcdif' is not one of ['fsl,imx23-lcdif', 'fsl,imx28-lcdif', 'fsl,imx6sx-lcdif', 'fsl,imx8mp-lcdif', 'fsl,imx93-lcdif']
	'fsl,imx6sx-lcdif' was expected
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: lcd-controller@20f8000: clocks: [[2, 129], [2, 123], [2, 0]] is too long
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#
arch/arm/boot/dts/nxp/imx/imx6sll-kobo-clarahd-b.dtb: lcd-controller@20f8000: clock-names: ['pix', 'axi', 'disp_axi'] is too long
	from schema $id: http://devicetree.org/schemas/display/fsl,lcdif.yaml#






