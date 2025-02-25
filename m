Return-Path: <linux-kernel+bounces-532373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFCBA44C23
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5C0188240E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA2B212FA9;
	Tue, 25 Feb 2025 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZe9Qkng"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A802212B3B;
	Tue, 25 Feb 2025 20:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514355; cv=none; b=K1sefNMM8nVohkeO3JxWNuuJMMjxnljJBZ9FPusq9VktKwWmATqRcm4PNQghXMa9HBb08K65zG+kus7hpVzj0PydRyMJhyH6qEZaQT3mD970naTI6Wke/P9Gaa7lQm1h9pixKwaDAPHnODgLVyFXiwaLX/JCOuM7R6dCJ9T1/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514355; c=relaxed/simple;
	bh=o9Fk+gFtqkDJKzeh44jxcdnyRxWUtu90QSRKPJrniEc=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=dYR20fxOsF1BTwMo8NM8t85KVkOvSW9oimbpA+q/zQBMy9LAfmH2b5sXJxetBENMjwTeoad9VYQc6JPxGT9q3IRjxq+rgNTLdDgr3O2hcbQuFIiBzA8IftrvyCxRyprMj2BA6FrWG4MLV0FHno5iE4KGzaWsaG29tL8mnTshNq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZe9Qkng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D552C4CEDD;
	Tue, 25 Feb 2025 20:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740514354;
	bh=o9Fk+gFtqkDJKzeh44jxcdnyRxWUtu90QSRKPJrniEc=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=IZe9QkngILC30nEEw6qustbEinAHZUpnbbyBWhBiJ5t9ACmDcyle2GBpv1kQoQKRY
	 rdfml+O8SwzX1C14iWVjFOHo2PoX38okfy3kcXeHZWRgWpczzm2299orjG0kYWZgJF
	 A8/XCMTptDdpa6eFYHwcqciZPWmVAY59Gj2D319QrSd8l6W8ZTwI5iaRkSd8MC0dCD
	 /z4fiHuaMxiqSz1acpXyDAnhod1vDKW636BPDg4fuL9sbxyncESeqghn/FpsN3eEg1
	 nhJGV9sWh8Szq0lOuRpy09sGL5+JfCHbtdec3zwfGQgVfiAPUydrvzV89y8IWfYgLe
	 7IMHhKL+mX+8A==
Date: Tue, 25 Feb 2025 14:12:32 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: s.hauer@pengutronix.de, festevam@gmail.com, shawnguo2@yeah.net, 
 shawnguo@kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 linux-arm-kernel@lists.infradead.org, hongxing.zhu@nxp.com, 
 conor+dt@kernel.org, krzk+dt@kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org
To: Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20250224170751.146840-1-Frank.Li@nxp.com>
References: <20250224170751.146840-1-Frank.Li@nxp.com>
Message-Id: <174051415001.2971194.5351687405398277268.robh@kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx95: add ref clock for pcie nodes


On Mon, 24 Feb 2025 12:07:51 -0500, Frank Li wrote:
> Add "ref" clock for i.MX95's pcie and fix below CHECK_DTBS warnings:
> arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie@4c300000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux'] is too short
> 	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie.yaml
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95.dtsi | 25 ++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/freescale/' for 20250224170751.146840-1-Frank.Li@nxp.com:

arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie-ep@4c300000: clocks: [[27, 87], [27, 36], [27, 35], [27, 88], [73, 0]] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie-ep@4c300000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux', 'ref'] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie-ep@4c300000: clocks: [[27, 87], [27, 36], [27, 35], [27, 88], [73, 0]] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie-ep@4c300000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux', 'ref'] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie-ep@4c380000: clocks: [[27, 87], [27, 36], [27, 35], [27, 88], [73, 0]] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie-ep@4c380000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux', 'ref'] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie-ep@4c380000: clocks: [[27, 87], [27, 36], [27, 35], [27, 88], [73, 0]] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#
arch/arm64/boot/dts/freescale/imx95-19x19-evk.dtb: pcie-ep@4c380000: clock-names: ['pcie', 'pcie_bus', 'pcie_phy', 'pcie_aux', 'ref'] is too long
	from schema $id: http://devicetree.org/schemas/pci/fsl,imx6q-pcie-ep.yaml#






