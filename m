Return-Path: <linux-kernel+bounces-351609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F535991398
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 02:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6180FB20EA7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE00F9DA;
	Sat,  5 Oct 2024 00:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFWQXzAJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39329AD23;
	Sat,  5 Oct 2024 00:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728089148; cv=none; b=BtN9tUQX92HjUbJjFz8WCUbgmc8hf+3F0xcKecm5AQo7i99pwcCn/4sGHskiuq3u/1obScLohvXgP99MSG1kL+iGE0gGC+jY0ZSHQJ2ESz9RXYIl5YckbeLPZGDjWHuP+3bS2U7IN/SuiAysL4fgOAONvTzFVsNpImm1g44j0PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728089148; c=relaxed/simple;
	bh=ePOfYLaXDNecQRHLOzd0PbOll1bLcK9K9CPGfInU1uk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=jnpDWPQc+oFobtbbh4cU1aiuI9Z47pbSWCAN/B6Hy8Q/hzvhbMmply9MPt/HYl/PG1eCV7eVAcEsVrkmbzD5JiijVoE/E0tGQtgpex1O+a0ls+yul7L6D3DWLWYKLmKF0WIO/fbqZML3hX65z8PQCc2cRmEmcxsmrNVKACEJU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFWQXzAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845A7C4CEC7;
	Sat,  5 Oct 2024 00:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728089147;
	bh=ePOfYLaXDNecQRHLOzd0PbOll1bLcK9K9CPGfInU1uk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=sFWQXzAJ9B3KEprWAbmv5C1lHh9zarQmEUDKHM2UJj+jQS/0pVg//aBK5VdqoIUaz
	 Jql14KePe5tKtHxUwu+9UK4L+lG3vg7Owe3Qf4mtzLT1qXu7t5a/Bf6j4ryH3lzVep
	 nUrC+A3u1J4mTkwewPOtIMeMV8JSN5whO30lJ+ebZV4ZKX2Q1qb6lHDmVs/AsiYr4Q
	 tNKjtdUoHtm3JXC4dq/W8xqjbIIL6iiFWz2b+57bv9pNVwWDAmv1gP7bsJXJixD0SW
	 LZKkVyxUa9szYgrM8iSzqck+tv8z83wKIECaHVfmefduyB0lobqfLhOQVMlpqYHQHC
	 p0SYjuv9Gg/Hw==
Date: Fri, 04 Oct 2024 19:45:46 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 William Zhang <william.zhang@broadcom.com>, devicetree@vger.kernel.org, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Sam Edwards <CFSworks@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 linux-kernel@vger.kernel.org, Kursad Oney <kursad.oney@broadcom.com>, 
 Anand Gore <anand.gore@broadcom.com>
In-Reply-To: <20241003220820.1345048-1-CFSworks@gmail.com>
References: <20241003220820.1345048-1-CFSworks@gmail.com>
Message-Id: <172808887840.121596.11205114990341820307.robh@kernel.org>
Subject: Re: [PATCH 0/2] Add support for Zyxel EX3510-B


On Thu, 03 Oct 2024 15:08:18 -0700, Sam Edwards wrote:
> Hello BCMBCA maintainers,
> 
> This pair of patches adds an initial DT for the Zyxel EX3510-B "series" based
> on BCM4906, encompassing the EX3510-B0 and EX3510-B1. As I am not aware of any
> software-affecting difference between these two, I am calling the "series" one
> model.
> 
> I found the BCM4906/8 support in Linux to be in need of a lot of TLC, and have
> just sent a few patches necessary to get Linux to boot without crashing on this
> platform. At a minimum, you will want to apply [1] to resolve a panic related
> to xHCI not initializing. If you are booting through CFE and want to use the
> secondary CPU, you will have to apply [2] as well.
> 
> There are more patches to come. An issue with the switch driver is preventing
> the WAN port from operating, for example. I have worked around this locally so
> I can confirm that the DT I am submitting here is correct, but I will need to
> clean up my remaining local fixes before they can be sent.
> 
> As always, thank you very much for your continued efforts and for your time
> reviewing these patches.
> 
> Best regards,
> Sam
> 
> [1]: https://lore.kernel.org/lkml/20241003211720.1339468-1-CFSworks@gmail.com/T/
> [2]: https://lore.kernel.org/lkml/20241003213007.1339811-1-CFSworks@gmail.com/T/
> 
> Sam Edwards (2):
>   dt-bindings: arm64: bcmbca: Add Zyxel EX3510-B based on BCM4906
>   arm64: dts: broadcom: bcmbca: bcm4908: Add DT for Zyxel EX3510-B
> 
>  .../bindings/arm/bcm/brcm,bcmbca.yaml         |   1 +
>  arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |   1 +
>  .../broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts | 197 ++++++++++++++++++
>  3 files changed, 199 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dts
> 
> --
> 2.44.2
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


New warnings running 'make CHECK_DTBS=y broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb' for 20241003220820.1345048-1-CFSworks@gmail.com:

arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions: 'oneOf' conditional failed, one must be fixed:
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: 'pinctrl-[0-9]+'
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-[0-9a-z]+$', 'pinctrl-[0-9]+'
	'fis-index-block' is a required property
	'partitions-table-offset' is a required property
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-.*$', 'pinctrl-[0-9]+'
	False schema does not allow 1
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions:compatible: 'oneOf' conditional failed, one must be fixed:
		['brcm,bcm4908-partitions'] is too short
		'fixed-partitions' was expected
		'sercomm,sc-partitions' was expected
	'arm,arm-firmware-suite' was expected
	'brcm,bcm947xx-cfe-partitions' was expected
	'linksys,ns-partitions' was expected
	'qcom,smem-part' was expected
	'redboot-fis' was expected
	'tplink,safeloader-partitions' was expected
	Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'mac@106a0', 'ranges' were unexpected)
	['nvmem-cells'] is too short
	'brcm,bcm4908-firmware' was expected
	'linksys,ns-firmware' was expected
	Unevaluated properties are not allowed ('compatible' was unexpected)
	['brcm,bcm4908-firmware'] is too short
	from schema $id: http://devicetree.org/schemas/mtd/brcm,brcmnand.yaml#
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'nand-ecc-strength', 'partitions' were unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/brcm,brcmnand.yaml#
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions: 'oneOf' conditional failed, one must be fixed:
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: 'pinctrl-[0-9]+'
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-[0-9a-z]+$', 'pinctrl-[0-9]+'
	'fis-index-block' is a required property
	'partitions-table-offset' is a required property
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-.*$', 'pinctrl-[0-9]+'
	False schema does not allow 1
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions:compatible: 'oneOf' conditional failed, one must be fixed:
		['brcm,bcm4908-partitions'] is too short
		'fixed-partitions' was expected
		'sercomm,sc-partitions' was expected
	'arm,arm-firmware-suite' was expected
	'brcm,bcm947xx-cfe-partitions' was expected
	'linksys,ns-partitions' was expected
	'qcom,smem-part' was expected
	'redboot-fis' was expected
	'tplink,safeloader-partitions' was expected
	Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'mac@106a0', 'ranges' were unexpected)
	['nvmem-cells'] is too short
	'brcm,bcm4908-firmware' was expected
	'linksys,ns-firmware' was expected
	Unevaluated properties are not allowed ('compatible' was unexpected)
	['brcm,bcm4908-firmware'] is too short
	from schema $id: http://devicetree.org/schemas/mtd/brcm,brcmnand.yaml#
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/brcm,brcmnand.yaml#
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions: 'oneOf' conditional failed, one must be fixed:
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: 'pinctrl-[0-9]+'
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-[0-9a-z]+$', 'pinctrl-[0-9]+'
	'fis-index-block' is a required property
	'partitions-table-offset' is a required property
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-.*$', 'pinctrl-[0-9]+'
	False schema does not allow 1
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand-controller@1800: nand@0:partitions:compatible: 'oneOf' conditional failed, one must be fixed:
		['brcm,bcm4908-partitions'] is too short
		'fixed-partitions' was expected
		'sercomm,sc-partitions' was expected
	'arm,arm-firmware-suite' was expected
	'brcm,bcm947xx-cfe-partitions' was expected
	'linksys,ns-partitions' was expected
	'qcom,smem-part' was expected
	'redboot-fis' was expected
	'tplink,safeloader-partitions' was expected
	Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'mac@106a0', 'ranges' were unexpected)
	['nvmem-cells'] is too short
	'brcm,bcm4908-firmware' was expected
	'linksys,ns-firmware' was expected
	Unevaluated properties are not allowed ('compatible' was unexpected)
	['brcm,bcm4908-firmware'] is too short
	from schema $id: http://devicetree.org/schemas/mtd/nand-controller.yaml#
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand@0: partitions: 'oneOf' conditional failed, one must be fixed:
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: 'pinctrl-[0-9]+'
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-[0-9a-z]+$', 'pinctrl-[0-9]+'
	'fis-index-block' is a required property
	'partitions-table-offset' is a required property
	'#address-cells', '#size-cells', 'partition@0', 'partition@100000', 'partition@6080000' do not match any of the regexes: '^partition-.*$', 'pinctrl-[0-9]+'
	False schema does not allow 1
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: nand@0: partitions:compatible: 'oneOf' conditional failed, one must be fixed:
		['brcm,bcm4908-partitions'] is too short
		'fixed-partitions' was expected
		'sercomm,sc-partitions' was expected
	'arm,arm-firmware-suite' was expected
	'brcm,bcm947xx-cfe-partitions' was expected
	'linksys,ns-partitions' was expected
	'qcom,smem-part' was expected
	'redboot-fis' was expected
	'tplink,safeloader-partitions' was expected
	Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'mac@106a0', 'ranges' were unexpected)
	['nvmem-cells'] is too short
	'brcm,bcm4908-firmware' was expected
	'linksys,ns-firmware' was expected
	Unevaluated properties are not allowed ('compatible' was unexpected)
	['brcm,bcm4908-firmware'] is too short
	from schema $id: http://devicetree.org/schemas/mtd/raw-nand-chip.yaml#
arch/arm64/boot/dts/broadcom/bcmbca/bcm4906-zyxel-ex3510b.dtb: partition@0: Unevaluated properties are not allowed ('ranges' was unexpected)
	from schema $id: http://devicetree.org/schemas/mtd/partitions/nvmem-cells.yaml#






