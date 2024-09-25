Return-Path: <linux-kernel+bounces-337894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF789850C3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 03:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B740B1F2490D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 01:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A761494DF;
	Wed, 25 Sep 2024 01:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYZofYAe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E633A148FF2;
	Wed, 25 Sep 2024 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229416; cv=none; b=hxcGvwHnSicBI3QYCu+r9AiuOmuztkrrHq+ct9hg8t7c/foHRBsUNh8k3npiZ2MFCkD0x4NBl3yqQi0HTX7RAk5t0ejmulPJrHADWRqDb2g4G8JjG3hoPIn9+RNx6sYaJb1geMvG6bpeP9v1C3EQzjEWDj269MXFW8Z+OpCYGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229416; c=relaxed/simple;
	bh=9fxS2QULMOS9mbQo3JE7ITPh91eCmGqnu+5X9B+3q0g=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=q2rxUgOdvUoJji6aZF9ARs4qfEWzs61sCNcQdIIZvo5HmlFeruMlcqBWX16rVgzouwTAdHukZlsp5gwrhmyEjleX3s+rpEwGJmJBksc/53nmTFpQryYjanLtQ+LRymem/k+1BlSvngYnPGYMKo30fSMDVyfQa1mOHoRytez67gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYZofYAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48356C4CECD;
	Wed, 25 Sep 2024 01:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727229415;
	bh=9fxS2QULMOS9mbQo3JE7ITPh91eCmGqnu+5X9B+3q0g=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=gYZofYAeYKDhS+JcsCR1LfYtfy1/y2wUHt3Ocx8QsJu7ULOXJUDeBulUzodhGbV5u
	 9iPcRRjVRCTziTOpznbaoaOyd29f+WHZdCRKvFe9PtgGYFZqJfodZEg5fhivxx7AJM
	 UhQYp80fBNnTJKcdEaSRWn5Xs2F8gTVUe9CSo4FDFkeCdbLObXCLSRrEFLWwFX6cgq
	 7v+rZVTOoWCEUbV1pMb+jXws0UJLL7fN/zfFSUx6CUwA8wgAlbPk3C7DijEyyT6oUz
	 437h9YapLLZRtxkTPLLTM8A/JNCRYoP/Ero1PJvWoddwNdcwhRMNsFxxAv3bu5dCkn
	 xdPkxr1U3AVhQ==
Date: Tue, 24 Sep 2024 20:56:54 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 Shawn Guo <shawnguo@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
In-Reply-To: <20240924114053.127737-1-francesco@dolcini.it>
References: <20240924114053.127737-1-francesco@dolcini.it>
Message-Id: <172722910792.836115.6325079480022384908.robh@kernel.org>
Subject: Re: [PATCH v1 0/3] arm64: dts: freescale: imx8mp-verdin: Add Ivy
 carrier


On Tue, 24 Sep 2024 13:40:50 +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add support for the Toradex Verdin iMX8MP Ivy carrier board. Ivy is a carrier
> board designed for industrial environments, supporting industrial
> I/O interfaces such as CAN, RS485, RS232, Gigabit Ethernet, 0-25mA analog
> inputs, relays, PCIe and more. The board also includes a TPM for security
> applications.
> 
> https://www.toradex.com/products/carrier-board/ivy-carrier-board
> 
> João Paulo Gonçalves (3):
>   dt-bindings: arm: freescale: Add verdin imx8mp ivy board
>   arm64: dts: freescale: imx8mp-verdin: add labels to som nodes
>   arm64: dts: freescale: imx8mp-verdin: Add Ivy carrier board
> 
>  .../devicetree/bindings/arm/fsl.yaml          |   2 +
>  arch/arm64/boot/dts/freescale/Makefile        |   2 +
>  .../boot/dts/freescale/imx8mp-verdin-ivy.dtsi | 512 ++++++++++++++++++
>  .../freescale/imx8mp-verdin-nonwifi-ivy.dts   |  18 +
>  .../dts/freescale/imx8mp-verdin-wifi-ivy.dts  |  18 +
>  .../boot/dts/freescale/imx8mp-verdin.dtsi     |   5 +-
>  6 files changed, 555 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-ivy.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-ivy.dts
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-ivy.dts
> 
> --
> 2.39.5
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-verdin-nonwifi-ivy.dtb freescale/imx8mp-verdin-wifi-ivy.dtb' for 20240924114053.127737-1-francesco@dolcini.it:

arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-ivy.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-verdin-nonwifi-ivy.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-ivy.dtb: pcie-ep@33800000: reg: [[864026624, 4194304], [402653184, 134217728]] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx8mp-verdin-wifi-ivy.dtb: pcie-ep@33800000: reg-names: ['dbi', 'addr_space'] is too short
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#






