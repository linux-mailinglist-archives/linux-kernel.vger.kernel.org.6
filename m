Return-Path: <linux-kernel+bounces-346989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E5E98CBB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 05:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E41D1C2266E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6038397;
	Wed,  2 Oct 2024 03:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vE2hFBhL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125A26AFF;
	Wed,  2 Oct 2024 03:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841128; cv=none; b=eKnW1anMoJJS6qKvfWW9ZzVNkf/1E6Xvp7htuSNm5GJFYnUG0JQlCOqWOYV2wgAjMPYzxoC5jwEfCjTqWKw5NFV6Fyc1UGS/6Y+LFRPYF62SOq9aT27D06AOjOzYlUgABENgHOCjXEmDzF2KJoPYf4Sdw2yQgGN9DqubnKK2Tyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841128; c=relaxed/simple;
	bh=i9Ah+nbViZxx83+Y05mxW8gY2brIw35xyYsNcQQgtb4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=bhEvAZYLrpRM2ql6qgcRNYPrKaqmdqFC0JV51RDAmshGTS8oNueq6wzEv1kpRlZMgNELxFLDOKPsPy6SSgElcyekdnk9BBykLXpbcZ0z5BUXe/VMM28GX0ixCSOQ9O1UB2NqJyQ8B7i9aLWh+GbW8gXDyvlqLRo8mlBVFoaa9X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vE2hFBhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392C6C4CED0;
	Wed,  2 Oct 2024 03:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727841128;
	bh=i9Ah+nbViZxx83+Y05mxW8gY2brIw35xyYsNcQQgtb4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=vE2hFBhLmvEOIQwquJXSFnnuiwUAc/CZTafqSKHZhO17nVdMXGVbg2eeXuuMcgUNq
	 jE84LHyh0/qjq5ZxD0GZ2m3HES3Zk4ed/O/d/TW9uu7FAmAwOUxIIzQAETaxa1C0xK
	 YNhqtYYwvTEgaKEgs/Zx4xJ8uF84P+CpoSA8P2ZywYaJvJPOEXwv72iJc2y2Wp+BjL
	 cp1A2KOPPK6jP8FXME8+4UW8X+C2xIGq53NhxDXUrJLXZ7WiBTYiwBJHrsVRAGPmHN
	 usMbW7Fl/e8ihqn4llyr4V9QYFEQhXrewnExh3vuNjA+eJ06Xf0Iz5hapoP/yEVkNp
	 0aRM2XWg4K+iA==
Date: Tue, 01 Oct 2024 22:52:07 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Andrei Simion <andrei.simion@microchip.com>
Cc: claudiu.beznea@tuxon.dev, devicetree@vger.kernel.org, 
 alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com, 
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, krzk+dt@kernel.org
In-Reply-To: <20241001152541.91945-1-andrei.simion@microchip.com>
References: <20241001152541.91945-1-andrei.simion@microchip.com>
Message-Id: <172784025783.525907.17129777836190610908.robh@kernel.org>
Subject: Re: [PATCH v2 0/4] Cosmetic Work for ARM/Microchip (AT91)


On Tue, 01 Oct 2024 18:25:37 +0300, Andrei Simion wrote:
> This patch series updates node names and labels in the Microchip ARM DTS
> files to align with Device Tree specificatios
> 
> changelog:
> v1 -> v2:
> - drop patch : Rename the usb node
> - add patch : ARM: dts: microchip: aks-cdu: Add label for LED sub nodes
> 
> Andrei Simion (4):
>   ARM: dts: microchip: Rename the eeprom nodename
>   ARM: dts: microchip: Rename the pmic node
>   ARM: dts: microchip: Rename LED sub nodes name
>   ARM: dts: microchip: aks-cdu: Add label for LED sub nodes
> 
>  arch/arm/boot/dts/microchip/aks-cdu.dts              | 12 ++++++++----
>  arch/arm/boot/dts/microchip/animeo_ip.dts            |  8 ++++----
>  arch/arm/boot/dts/microchip/at91-kizbox2-common.dtsi |  2 +-
>  arch/arm/boot/dts/microchip/at91-sam9x60ek.dts       |  6 +++---
>  arch/arm/boot/dts/microchip/at91-sama5d27_som1.dtsi  |  2 +-
>  .../arm/boot/dts/microchip/at91-sama5d27_wlsom1.dtsi |  2 +-
>  .../boot/dts/microchip/at91-sama5d29_curiosity.dts   |  2 +-
>  arch/arm/boot/dts/microchip/at91-sama5d2_icp.dts     |  2 +-
>  arch/arm/boot/dts/microchip/at91-sama5d2_ptc_ek.dts  |  2 +-
>  .../arm/boot/dts/microchip/at91-sama5d2_xplained.dts |  2 +-
>  .../arm/boot/dts/microchip/at91-sama5d3_xplained.dts |  2 +-
>  arch/arm/boot/dts/microchip/at91-sama7g5ek.dts       |  2 +-
>  arch/arm/boot/dts/microchip/at91rm9200ek.dts         |  6 +++---
>  arch/arm/boot/dts/microchip/at91sam9260ek.dts        |  6 +++---
>  arch/arm/boot/dts/microchip/at91sam9261ek.dts        |  6 +++---
>  arch/arm/boot/dts/microchip/at91sam9263ek.dts        |  6 +++---
>  arch/arm/boot/dts/microchip/at91sam9g20ek.dts        |  4 ++--
>  .../arm/boot/dts/microchip/at91sam9g20ek_common.dtsi |  2 +-
>  arch/arm/boot/dts/microchip/sama5d34ek.dts           |  2 +-
>  arch/arm/boot/dts/microchip/sama5d3xcm_cmp.dtsi      |  2 +-
>  20 files changed, 41 insertions(+), 37 deletions(-)
> 
> 
> base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
> --
> 2.34.1
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


New warnings running 'make CHECK_DTBS=y microchip/aks-cdu.dtb microchip/animeo_ip.dtb microchip/at91-sam9x60ek.dtb microchip/at91-sama5d29_curiosity.dtb microchip/at91-sama5d2_icp.dtb microchip/at91-sama5d2_ptc_ek.dtb microchip/at91-sama5d2_xplained.dtb microchip/at91-sama5d3_xplained.dtb microchip/at91-sama7g5ek.dtb microchip/at91rm9200ek.dtb microchip/at91sam9260ek.dtb microchip/at91sam9261ek.dtb microchip/at91sam9263ek.dtb microchip/at91sam9g20ek.dtb microchip/sama5d34ek.dtb' for 20241001152541.91945-1-andrei.simion@microchip.com:

arch/arm/boot/dts/microchip/at91-sam9x60ek.dtb: /ahb/ebi@10000000/nand-controller: failed to match any schema with compatible: ['microchip,sam9x60-nand-controller']






