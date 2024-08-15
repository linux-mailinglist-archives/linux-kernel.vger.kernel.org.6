Return-Path: <linux-kernel+bounces-288211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D613195375C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134B41C251AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BC61B3F18;
	Thu, 15 Aug 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQiQHMS8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F31B29AD;
	Thu, 15 Aug 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736053; cv=none; b=sog7UVx88ggwrhIYgVH2nLsGvrzUamAMur6/TJGyh+Tgiq1ELvH6LNKajTichwjkYKWq3XfAQAKUsS81YF/3t/6LnOzSP9Um0g2WwPDfqIEKmAxj0QPKnO/IUEnZdiTqSSXejrT+T0ztHvRILBb/dW8K4QXDh6UJkWG5I6J38qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736053; c=relaxed/simple;
	bh=04LgzP7YEOA67MD8wfW6ktfx6oGLA3LHw3MuDqeib34=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=ZS1tBkW4n9YknYi3Q1qCIFvBz2gTx+9B+5pE0l6bHcMnW1sfxUbEcgOZIWYwymGniJm8iOP4qypQaxfK6Vm5T3oxSkWsOsQPB0Zh1YQaY+/hWrRFsFkl01DOoAo0vhOgs4Vml3ARhTH/DrvMzz3pByd56pFT5xuJcXv2sw9ueS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQiQHMS8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B53C4AF53;
	Thu, 15 Aug 2024 15:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723736052;
	bh=04LgzP7YEOA67MD8wfW6ktfx6oGLA3LHw3MuDqeib34=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=NQiQHMS8aquDQLk3IZdLkg99xNLoxgmaVBu/t5xPEyqC4/vTByrgWkr5St/b14EZn
	 k8mnK/BH1TkH9677d3DdRo3dxchzbEKfMfZAP2N7ZRYnzLDUCHngdYlnF0jG5PZ+Um
	 P6sx6+7G0FP2uJl2sIO3FTIda4qBTKlIYgUu7kcvPO5MW7s+EieaZF6vVMjSEcRxLS
	 zsmVVLN1dK9Rpc3WJkSVfgkEZ6coxUXWd6laXrPZ7SuFeYnPOP4xSVuUE+uN8Hbmct
	 T1aFGRYhvZOpohX83w73A/aN6AUcNPCvZklvdnOJ9mTvxiYB3ocwEw9oz6wax9boKE
	 tHWeyLw362sQQ==
Date: Thu, 15 Aug 2024 09:34:12 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: devicetree@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240815-fernlike-levitate-6004f5f46d66@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
 <20240815-fernlike-levitate-6004f5f46d66@spud>
Message-Id: <172373605037.1948470.1479087224226784558.robh@kernel.org>
Subject: Re: [RFC PATCH 10/11] dt-bindings: clk: microchip: mpfs: remove
 first reg region


On Thu, 15 Aug 2024 15:01:13 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The first reg region in this binding is not exclusively for clocks, as
> evidenced by the dual role of this device as a reset controller at
> present. The first region is however better described by a simple-mfd
> syscon, but this would have require a significant re-write of the
> devicetree for the platform, so the easy way out was chosen when reset
> support was first introduced. The region doesn't just contain clock and
> reset registers, it also contains pinctrl and interrupt controller
> functionality, so drop the region from the clock binding so that it can
> be described instead by a simple-mfd syscon rather than propagate this
> incorrect description of the hardware to the new pic64gx SoC.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/clock/microchip,mpfs-clkcfg.yaml | 33 +++++++++++--------
>  1 file changed, 19 insertions(+), 14 deletions(-)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.example.dts:22.21-47: Warning (reg_format): /example-0/soc/clock-controller@3E001000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.example.dts:20.51-25.15: Warning (avoid_default_addr_size): /example-0/soc/clock-controller@3E001000: Relying on default #address-cells value
Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.example.dts:20.51-25.15: Warning (avoid_default_addr_size): /example-0/soc/clock-controller@3E001000: Relying on default #size-cells value
Documentation/devicetree/bindings/clock/microchip,mpfs-clkcfg.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240815-fernlike-levitate-6004f5f46d66@spud

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


