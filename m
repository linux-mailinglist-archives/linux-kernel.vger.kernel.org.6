Return-Path: <linux-kernel+bounces-288210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70C995375B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 17:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B15E1F21867
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C111B32C2;
	Thu, 15 Aug 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsxpUceS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8338E1B1417;
	Thu, 15 Aug 2024 15:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723736052; cv=none; b=TiZYfEi6KmdXknSUfkdsuVYVzPoZqfEaGrK7brr52XPKo2MEqwTu7DL+HWIauIYbfYOKahD3Wf5VOwhDsPR1Getgr5vxayJ53qpycmD3Ma+oyMdcYyUhQO4bnD9Tdrovm6D/i7IvznsYylr/qcrB0F8BfYHTGVgOfA08MC6WrLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723736052; c=relaxed/simple;
	bh=AW4TlLRmEDZOFTUbLxWAekcWzjzmHFDWoVLpWKnxXiU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=raq9NKsO0PsWhNia28aV32Do3m2WEzo4BnsufrKVU2VmIsxlimHZFfjf9m6LwdU29bThcqsVxRVMIADP56B0BSwylrOPfXgfMlCfswrSeToYsIkaOTI7uypSE/RLERBS7VWWGGgLdqhSmiYBHSpB1JhXjzLDhILE+9yWfbd5ros=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsxpUceS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3BB0C4AF0D;
	Thu, 15 Aug 2024 15:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723736052;
	bh=AW4TlLRmEDZOFTUbLxWAekcWzjzmHFDWoVLpWKnxXiU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TsxpUceSqebY8Ix7Z9JgVs9pf85uwlRB8ovttnF17eUDkWoidXy+0TO9b14S2OoK2
	 KplYfgp1HQSAHIp2TUxi6HjNF0YaUL4hAv7fTLopvNp79ejA3r5XbViTh83xCR+nGA
	 A6Bdg7SrP8Y2vq6mDBbbXDGcUSwizF26oWtIVzMSTyi1GKMtV92+54XZTYseL4tjvG
	 wFKvFqR1sXdTgRHycp/ZXhWHcghQI7ZN28CZjicRV0tXykh0zTC1NhHDqbLn/KTWvF
	 rrp2/qfLRTdTOZhavrHXON4SABC4EVCLUbnC9OnO40HPpsdyc8Kgc7wsqYP1A1/i62
	 9BbDV0nXkh/CQ==
Date: Thu, 15 Aug 2024 09:34:11 -0600
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
Cc: Conor Dooley <conor.dooley@microchip.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240815-pending-sacrifice-f2569ed756fe@spud>
References: <20240815-shindig-bunny-fd42792d638a@spud>
 <20240815-pending-sacrifice-f2569ed756fe@spud>
Message-Id: <172373604945.1948429.11074973738435374630.robh@kernel.org>
Subject: Re: [RFC PATCH 06/11] dt-bindings: soc: microchip: document the
 two simple-mfd syscons on PolarFire SoC


On Thu, 15 Aug 2024 15:01:09 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> There are two syscons on PolarFire SoC that provide various functionality of
> use to the OS.
> 
> The first of these is the "control-scb" region, that contains the "tvs"
> temperature and voltage sensors and the control/status registers for the
> system controller's mailbox. The mailbox has a dedicated node, so
> there's no need for a child node describing it, looking the syscon up by
> compatible is sufficient.
> 
> The second, "mss-top-sysreg", contains clocks, pinctrl, resets, and
> interrupt controller and more. For this RFC, only the reset controller
> child is described as that's all that is described by the existing
> bindings. The clock controller already has a dedicated node, and will
> retain it as there are other clock regions, so like the mailbox,
> a compatible-based lookup of the syscon is sufficient to keep the clock
> driver working as before so no child is needed.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> (I'll split this in two later, it's just easier when I have the same
> questions about both...)
> 
> Are these things entitled to have child nodes for the reset and sensor
> nodes, or should the properties be in the parent and the OS probe the
> drivers for the functions? That's something that, despite supposedly
> being a maintainer, I do not understand the rules (of thumb?) for.
> 
> Secondly, is it okay to make the "pragmatic" decision to not have a
> child clock node and keep routing the clocks via the existing & retained
> clock node (and therefore not update the various clocks nodes in the
> consumers)? Doing so would require a lot more hocus pocus with the clock
> driver than this series does, as the same driver would no longer be
> suitable for the before/after bindings.
> ---
>  .../microchip/microchip,mpfs-control-scb.yaml | 54 +++++++++++++++++++
>  .../microchip,mpfs-mss-top-sysreg.yaml        | 53 ++++++++++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-mss-top-sysreg.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.example.dts:21.13-38: Warning (reg_format): /example-0/soc/syscon@37020000:reg: property has invalid length (8 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.example.dts:19.27-26.13: Warning (avoid_default_addr_size): /example-0/soc/syscon@37020000: Relying on default #address-cells value
Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.example.dts:19.27-26.13: Warning (avoid_default_addr_size): /example-0/soc/syscon@37020000: Relying on default #size-cells value
Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-control-scb.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240815-pending-sacrifice-f2569ed756fe@spud

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


