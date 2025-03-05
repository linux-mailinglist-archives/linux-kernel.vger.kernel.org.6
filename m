Return-Path: <linux-kernel+bounces-547868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10471A50E87
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 23:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E46DE3ABC89
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0829266B52;
	Wed,  5 Mar 2025 22:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1bZiT7N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038501FF61B;
	Wed,  5 Mar 2025 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213416; cv=none; b=MAugsdzuRWghEz48wO1u/mfEVqjvu6bmNp1534ABUwtjKZy2kPwjEMZgivtdPLFjHKh5MoCtH7qOsLcMFoAkzv60+2GKdy7ECOlbXfc/XkAMbZmDIxXkY5C8G7oQXibjBtL+IaNeSBv6hz5O/u54Se9fH1k6g0iOeGLhe6P0EqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213416; c=relaxed/simple;
	bh=KBHpbC5osndmf5oDhHBlgu8LureeUZlnUDS/VBH0eSk=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=VHQuHMNnlEWsFxKjajzGUpLdBTAalOPN3YM4agYKjyYAnbcpFl3JI+PagOUJ3vC5oWaNMrTD2nWixaD6YlwqjK6Nmu+8PvpDXtRQkd5fyKHovcCZKhJ4xnG+Mp4MDAltZZrQkkaBev47ItpHrDuNgy1UWGVNP0E0SjSdflS8JjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1bZiT7N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2B6C4CEE0;
	Wed,  5 Mar 2025 22:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213415;
	bh=KBHpbC5osndmf5oDhHBlgu8LureeUZlnUDS/VBH0eSk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=r1bZiT7NwYXoQhaCMEjbK91+E+DffB5/lm5IXRZH07OBdWXqtAT/BxJ2Od0VUGi1+
	 +V8ak2pZsbo6pB3WgPW7CqW9OdFqupRAKSnxe42ZJZZYOUZUshM+Pq5b5Hox4xAGTJ
	 abPigQ3XEnezCY0xXRv5xPm+9k23kl63eY3ObEj9RGuvCrXRG3mXYEu7uP2GPEH0Kf
	 S4oaP8JUKwV6IcGwRpzMaKyDiEmbIpshEsn5HV1a0Lch6Ll6CGsnLS78SHXwhNFrhm
	 CSfkgEVIQA39o/Gfwa2ut9h8px+uA0LeTr5YtRHO64jTYXHy/XUwZ701ZuORvoag6y
	 ZnWPQa05voAfA==
Date: Wed, 05 Mar 2025 16:23:34 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dinguyen@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
To: Matthew Gerlach <matthew.gerlach@altera.com>
In-Reply-To: <20250305194951.7226-1-matthew.gerlach@altera.com>
References: <20250305194951.7226-1-matthew.gerlach@altera.com>
Message-Id: <174121292996.2932278.13028328347189315075.robh@kernel.org>
Subject: Re: [PATCH 0/2] Add bindings and DTS for the Agilex7 M-Series
 SoCDK


On Wed, 05 Mar 2025 11:49:49 -0800, Matthew Gerlach wrote:
> This patch set adds device tree bindings and a DTS for the Intel Agilex7
> M-Series SoC Development Kit:
> https://www.intel.com/content/www/us/en/products/details/fpga/development-kits/agilex/agm039.html
> 
> Patch 1:
>   Define the device tree binding for the Agilex7 M-Series SoCDK.
> 
> Patch 2:
>   Add the DTS for the Agilex7 M-Series SoCDK.
> 
> Matthew Gerlach (2):
>   dt-bindings: intel: document Agilex7 M-Series SoCDK
>   arm64: dts: socfpga: add Agilex7 M-Series SoCDK
> 
>  .../bindings/arm/intel,socfpga.yaml           |   5 +
>  arch/arm64/boot/dts/intel/Makefile            |   1 +
>  .../boot/dts/intel/socfpga_agilex7m_socdk.dts | 108 ++++++++++++++++++
>  3 files changed, 114 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dts
> 
> --
> 2.35.3
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/intel/' for 20250305194951.7226-1-matthew.gerlach@altera.com:

arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /firmware/svc: failed to match any schema with compatible: ['intel,agilex-svc']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /firmware/svc/fpga-mgr: failed to match any schema with compatible: ['intel,agilex-soc-fpga-mgr']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: cb-intosc-hs-div2-clk: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: cb-intosc-ls-clk: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: f2s-free-clk: 'clock-frequency' is a required property
	from schema $id: http://devicetree.org/schemas/clock/fixed-clock.yaml#
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/ethernet@ff800000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/ethernet@ff800000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/ethernet@ff802000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/ethernet@ff802000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/ethernet@ff804000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/ethernet@ff804000: failed to match any schema with compatible: ['altr,socfpga-stmmac-a10-s10', 'snps,dwmac-3.74a', 'snps,dwmac']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr: failed to match any schema with compatible: ['altr,socfpga-s10-ecc-manager', 'altr,socfpga-a10-ecc-manager']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr: failed to match any schema with compatible: ['altr,socfpga-s10-ecc-manager', 'altr,socfpga-a10-ecc-manager']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr/sdramedac: failed to match any schema with compatible: ['altr,sdram-edac-s10']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr/ocram-ecc@ff8cc000: failed to match any schema with compatible: ['altr,socfpga-s10-ocram-ecc', 'altr,socfpga-a10-ocram-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr/ocram-ecc@ff8cc000: failed to match any schema with compatible: ['altr,socfpga-s10-ocram-ecc', 'altr,socfpga-a10-ocram-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr/usb0-ecc@ff8c4000: failed to match any schema with compatible: ['altr,socfpga-s10-usb-ecc', 'altr,socfpga-usb-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr/usb0-ecc@ff8c4000: failed to match any schema with compatible: ['altr,socfpga-s10-usb-ecc', 'altr,socfpga-usb-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr/emac0-rx-ecc@ff8c0000: failed to match any schema with compatible: ['altr,socfpga-s10-eth-mac-ecc', 'altr,socfpga-eth-mac-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr/emac0-rx-ecc@ff8c0000: failed to match any schema with compatible: ['altr,socfpga-s10-eth-mac-ecc', 'altr,socfpga-eth-mac-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr/emac0-tx-ecc@ff8c0400: failed to match any schema with compatible: ['altr,socfpga-s10-eth-mac-ecc', 'altr,socfpga-eth-mac-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr/emac0-tx-ecc@ff8c0400: failed to match any schema with compatible: ['altr,socfpga-s10-eth-mac-ecc', 'altr,socfpga-eth-mac-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr/sdmmca-ecc@ff8c8c00: failed to match any schema with compatible: ['altr,socfpga-s10-sdmmc-ecc', 'altr,socfpga-sdmmc-ecc']
arch/arm64/boot/dts/intel/socfpga_agilex7m_socdk.dtb: /soc@0/eccmgr/sdmmca-ecc@ff8c8c00: failed to match any schema with compatible: ['altr,socfpga-s10-sdmmc-ecc', 'altr,socfpga-sdmmc-ecc']






