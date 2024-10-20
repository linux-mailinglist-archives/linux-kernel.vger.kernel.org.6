Return-Path: <linux-kernel+bounces-373489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FBB9A5757
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 00:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F8DB2258D
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 22:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF4A198A06;
	Sun, 20 Oct 2024 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh0N4c3i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AD420E31D;
	Sun, 20 Oct 2024 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729462865; cv=none; b=okqmVJvvz+EF3FFg5xQ66H4OrIHmlVFgFMAedAdP4WKODAvyzvvsnSGNPXMMkdtNwETA9nzZBHFXJ55KqcSpM+cCVYkNn+lH8XLuw2FG3/52HICvTqGmKPtaiSisKAXau61xirgDiWU9Gu/8ziPu5WeiQq8Deal09dS5POGkSiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729462865; c=relaxed/simple;
	bh=c0RD5aWPHcjvk8dz7LpAgGFrpVHOGZS40wi7nAmg4+w=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=mjzcLvGCbowYvRznuyEHiIKBTVmAbn2REXS8JPoKvIVdwcmKGRaBlKWbzVl2kaZlzfLukVykzBiqYoboCSrHRyRvFusme29pmLdkTsp+tSPOoq0K3juegj2eimtIh9hm7iPHIyqjzm/EluOpd0DmtWMEDyD0X2trsP+Bl3L107w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh0N4c3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82447C4CEC6;
	Sun, 20 Oct 2024 22:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729462865;
	bh=c0RD5aWPHcjvk8dz7LpAgGFrpVHOGZS40wi7nAmg4+w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=Hh0N4c3iYOTFd4ikgZL3NU2NcMnBQiZSPowyrbVPnGWkZOCd9/ZklhlZSdMhI8KK6
	 WfmAbiBcslabi9pC7FH3CrzAqyuTnDqc9qc4nKz5McVSp9c8SyQ2BcrXn1vedGsEHD
	 L+EhBIBpCD8FfzOVEap1sRV0ctd8CbR5RTGcL7kcNJAGJSd6/RP79YE/S+euMfCzbf
	 DgRCWT5rOYMjsqcHEoReYbUoJLXCjWkZdad23FIVbeSknrwV/VT4VVvNzSSp4iNfCy
	 Li+1aoBmpPHM9slvs4uIKrPzAyV2JTNuGwFpHdm56xdN3hR2XxFeXYaH0FkhjBcY9n
	 Z+Z3WaJbx7JGw==
Date: Sun, 20 Oct 2024 17:21:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dinguyen@kernel.org, s.trumtrar@pengutronix.de, krzk+dt@kernel.org, 
 marex@denx.de, conor+dt@kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241020194028.2272371-13-l.rubusch@gmail.com>
References: <20241020194028.2272371-1-l.rubusch@gmail.com>
 <20241020194028.2272371-13-l.rubusch@gmail.com>
Message-Id: <172945976879.2209098.12973837165878393589.robh@kernel.org>
Subject: Re: [PATCHv2 12/23] ARM: socfpga: dts: add a10 clock binding yaml


On Sun, 20 Oct 2024 19:40:17 +0000, Lothar Rubusch wrote:
> Convert content of the altera socfpga.txt to match clock bindings for
> the Arria10 SoC devicetrees. Currently all altr,* bindings appear as
> error at dtbs_check, since these bindings are only written in .txt
> format.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  .../bindings/clock/altr,socfpga-a10.yaml      | 107 ++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml: fixed-divider: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml: clk-gate: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml: div-reg: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml: clk-phase: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml: title: "Device Tree Clock bindings for Altera's SoCFPGA platform" should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/altr,socfpga-a10.yaml: properties:#clock-cells: 'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref', 'oneOf']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
Documentation/devicetree/bindings/clock/altr,socfpga-a10.example.dts:25.11-24: Warning (reg_format): /example-0/main_pll@40:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/clock/altr,socfpga-a10.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/altr,socfpga-a10.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/altr,socfpga-a10.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/altr,socfpga-a10.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/clock/altr,socfpga-a10.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/altr,socfpga-a10.example.dtb: main_pll@40: '#address-cells', '#size-cells', 'main_noc_base_clk' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/clock/altr,socfpga-a10.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241020194028.2272371-13-l.rubusch@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


