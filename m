Return-Path: <linux-kernel+bounces-271510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C7B944F3C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 17:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74903B2698A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C081AED23;
	Thu,  1 Aug 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pXD4C236"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21A61B32D1;
	Thu,  1 Aug 2024 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526178; cv=none; b=q724LNNpBT1gVB5rJ/HfY+TqDPE4p4xvEdU2t9+YN59SR0nIsjdgk71fiT6o7+mbGF9SXUlK+UUlWCPIDcr5H82wOYsZsgIo0aNTVGDdCzzkaBShkYX6laMI6GNSumnLQhfdXup3XFDJ5bB9K23IOTgM+rtdzsYJhE7m9Z/Cl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526178; c=relaxed/simple;
	bh=puWdf7XOQ82xIwfbjQMYWSQLeyYJDxkHb/kNQjcEp+Y=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=GxvRR1PGQFZMPmWqsXv0bVhChCSCdK+OqaRoWAejBtrwT8DanDnI2M8T2KiK8z6zY58+A0GVmwBeWngPI72LLjQNfpZu0dMLKbHC6gQ5PGCUoHNy3KpNnjqXBa/pG2JtzAJT7lLrQ9QRj9tBT5ND3LmyrXiQl9jFLa9DEU5xpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pXD4C236; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68527C4AF09;
	Thu,  1 Aug 2024 15:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722526178;
	bh=puWdf7XOQ82xIwfbjQMYWSQLeyYJDxkHb/kNQjcEp+Y=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=pXD4C236Cpjg4MYKyaRBUvgRUGom3TDzHr6iNivPTt1wylzAwvUw1TLS0TjJ/QBsb
	 7J9ksz+RXLNUd+BMyb4qbkR8nOxPO/ZUFaxZKFFjDNcZKQvD7E9tvy9wmql40UNMFx
	 qvQiIR28Sjo1rB/WfBCKrgkH7aWoy7iyw59VcOFvR3kKdP0yHfz4vzBsiGr+B+EPpN
	 NAKwY14E21IdghQhSBqmS3PeQ5oTczopQuV32fxZZp7iriD+9XV4yiRrK2yzhYAGkl
	 apEzphqC3P+IamsxzIv304stODKH3BMTOCYrDbFkHqwG8wqgWFC5EWdLV+RmqlxCfW
	 HIVO410WcppEA==
Date: Thu, 01 Aug 2024 09:29:37 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
 devicetree@vger.kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Conor Dooley <conor+dt@kernel.org>, Naveen N Rao <naveen@kernel.org>, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240801051402.584652-1-paweldembicki@gmail.com>
References: <20240801051402.584652-1-paweldembicki@gmail.com>
Message-Id: <172252600854.120726.11435337505075430756.robh@kernel.org>
Subject: Re: [PATCH] powerpc: dtc: update P2020RDB dts


On Thu, 01 Aug 2024 07:14:01 +0200, Pawel Dembicki wrote:
> P2020RDB contains multiple peripherals, which isn't added to
> devicetree:
>   - Switch: Microchip VSC7385
>   - PMIC: Renesas ZL2006
>   - Temperature sensor: Analog Devices ADT7461
>   - Two eeproms: 24C256 and 24C01
>   - GPIO expander: NXP PCA9557
>   - reset gpios of Ethernet PHYs
> 
> This commit adds it.
> 
> Some refreshments was done:
>   - fixed link in ethernet-node
>   - platform drivers nodes names
>   - added 'gpio0' label in pq3-gpio-0.dtsi
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---
>  arch/powerpc/boot/dts/fsl/p2020rdb.dts    | 85 +++++++++++++++++++++--
>  arch/powerpc/boot/dts/fsl/pq3-gpio-0.dtsi |  2 +-
>  2 files changed, 81 insertions(+), 6 deletions(-)
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


New warnings running 'make CHECK_DTBS=y fsl/p2020rdb.dtb' for 20240801051402.584652-1-paweldembicki@gmail.com:

arch/powerpc/boot/dts/fsl/p2020rdb.dts:326.22-329.4: Warning (pci_bridge): /pcie@ffe08000: missing ranges for PCI bridge (or not a bridge)
arch/powerpc/boot/dts/fsl/p2020rdb.dtb: nor@0: $nodename:0: 'nor@0' does not match '^(flash|.*sram|nand)(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mtd/mtd-physmap.yaml#
arch/powerpc/boot/dts/fsl/p2020rdb.dtb: /localbus@ffe05000/nand@1: failed to match any schema with compatible: ['fsl,p2020-fcm-nand', 'fsl,elbc-fcm-nand']
arch/powerpc/boot/dts/fsl/p2020rdb.dtb: /localbus@ffe05000/nand@1: failed to match any schema with compatible: ['fsl,p2020-fcm-nand', 'fsl,elbc-fcm-nand']
arch/powerpc/boot/dts/fsl/p2020rdb.dtb: ethernet-switch@2: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/dsa/vitesse,vsc73xx.yaml#
arch/powerpc/boot/dts/fsl/p2020rdb.dtb: /soc@ffe00000/i2c@3100/pmic@11: failed to match any schema with compatible: ['zl2006']
arch/powerpc/boot/dts/fsl/p2020rdb.dtb: gpio@18: 'gpio-controller' is a required property
	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#
arch/powerpc/boot/dts/fsl/p2020rdb.dtb: gpio@18: '#gpio-cells' is a required property
	from schema $id: http://devicetree.org/schemas/gpio/gpio-pca95xx.yaml#






