Return-Path: <linux-kernel+bounces-353722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BDC9931BE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:44:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0ECA1F23664
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9A11D9663;
	Mon,  7 Oct 2024 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWiZpewI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9661D47AC;
	Mon,  7 Oct 2024 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315888; cv=none; b=LHOAmAvkexE/UKOSGU9K9ph2h5hPXksgQH5ZnV5Bnx+L8w+rE7bk/7bLX8M//rHghUrsKlTKTUDpIfWhRT6G1gvUfulk1o3vcyBFE5aBkPYn9FsTwzMhHPCmQzuNVRCiL0wc3S7N6nwnmVvhd6LJ8Rns0RJ02V6t1Lsi36HcCKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315888; c=relaxed/simple;
	bh=Q4/OzFB1Schq/trl8k59y62zvrR/CXceziUC8gYKx3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJMHQRuKwHW1kCSI1n1OiuhWu2+w3NPPx/6VHotHa3Q1dbaEVHT6NT0lz7cRRHX7kvkLVmKvr7VcjArRDvO4pVqACTVL4OpTpv1iWqiYpn+Os53SvyweIA+IiD3rS+FEhMc+Cm+tWsy+enziibRzC21nbRNI1I5AtnQkIrN1VTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWiZpewI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8405BC4CEC6;
	Mon,  7 Oct 2024 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728315887;
	bh=Q4/OzFB1Schq/trl8k59y62zvrR/CXceziUC8gYKx3A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kWiZpewIM1LFfoihgb292QAqCYBjGj1BYB4SZo2SLEvFIBn7qYDGBgyMPhIgAP/ec
	 Ssj9wSXfiJrIzxDAlZH9AAU6xgPYD7R/Dlpi1oFrb5XyLYfYb9dFvl2IbHwiOcaVNn
	 tW/mekuOSC2XeJoVNYeKaWmgPQBfroauSuBoA1fvNSfSNNc1SqRJcClfJiHcVNa+sU
	 /i9V+wBCr+7QFP/rdo/225fSr0GwvOQdFKiwPGMBE8yEk/Z/F2TADL80W2AeR+MemW
	 wGBTLK8/T2/AA/K8QILzdrArMt7TEl8kuPv1uzBmwaRnMshau6AWJYejV0lVH0CbM8
	 Wjv0x2tzJmLOg==
Date: Mon, 7 Oct 2024 10:44:46 -0500
From: Rob Herring <robh@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: linux-kernel@vger.kernel.org,
	Parth Pancholi <parth.pancholi@toradex.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: add TUSB73x0 PCIe
Message-ID: <20241007154446.GA726246-robh@kernel.org>
References: <20241007093205.27130-1-francesco@dolcini.it>
 <20241007093205.27130-2-francesco@dolcini.it>
 <172831060758.15259.15265542019562102842.robh@kernel.org>
 <20241007142920.GA60623@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007142920.GA60623@francesco-nb>

On Mon, Oct 07, 2024 at 04:29:20PM +0200, Francesco Dolcini wrote:
> Hello,
> 
> On Mon, Oct 07, 2024 at 09:16:48AM -0500, Rob Herring (Arm) wrote:
> > On Mon, 07 Oct 2024 11:32:04 +0200, Francesco Dolcini wrote:
> > > From: Parth Pancholi <parth.pancholi@toradex.com>
> > > 
> > > Add device tree bindings for TI's TUSB73x0 PCIe-to-USB 3.0 xHCI
> > > host controller. The controller supports software configuration
> > > through PCIe registers, such as controlling the PWRONx polarity
> > > via the USB control register (E0h).
> > > 
> > > Similar generic PCIe-based bindings can be found as qcom,ath11k-pci.yaml
> > > as an example.
> > > 
> > > Datasheet: https://www.ti.com/lit/ds/symlink/tusb7320.pdf
> > > Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > ---
> > > v2: rename property to ti,tusb7320-pwron-active-high and change type to flag
> > > ---
> > >  .../bindings/usb/ti,tusb73x0-pci.yaml         | 60 +++++++++++++++++++
> > >  1 file changed, 60 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.yaml
> > > 
> > 
> > My bot found errors running 'make dt_binding_check' on your patch:
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/ti,tusb73x0-pci.example.dtb: pcie@0: usb@0:compatible: ['pci104C,8241'] does not contain items matching the given schema
> > 	from schema $id: http://devicetree.org/schemas/pci/pci-bus-common.yaml#
> > 
> > doc reference errors (make refcheckdocs):
> > 
> > See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241007093205.27130-2-francesco@dolcini.it
> > 
> > The base for the series is generally the latest rc1. A different dependency
> > should be noted in *this* patch.
> > 
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure 'yamllint' is installed and dt-schema is up to
> > date:
> > 
> > pip3 install dtschema --upgrade
> 
> I do not have this error locally, and I am not sure I see the issue in
> the yaml file ...
> 
> $ make dt_binding_check W=1 DT_SCHEMA_FILES=ti,tusb73x0-pci.yaml

DT_SCHEMA_FILES limits what is tested.

The issue is your compatible string should be lowercase hex.

Rob

