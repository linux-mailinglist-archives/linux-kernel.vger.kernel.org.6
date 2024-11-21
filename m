Return-Path: <linux-kernel+bounces-417253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A70A9D515E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 18:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC8D4B2B062
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 17:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799C7189F37;
	Thu, 21 Nov 2024 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WP9sL8ul"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A423119CC17
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 17:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732209012; cv=none; b=IARotPjD8ZSW+/zOGRGKyt9q6fjNNwLc17F95xE7HT8p79DVFkXtqsN0kQIftMU4B0pW0VCRrk7V+oNjVIVmXbb5TIpagaDqg2hap/5T6RAxck/OdNry4nZUz/W+GZWDU41OwS22rOHfjt+8lflNVc1zbBM6eoozMlaTt0CvvtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732209012; c=relaxed/simple;
	bh=ifGy85N6zsRmBCj+/GrsUjDoHFFPGaFFCSuC+J0QRbw=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=YxGlnTkOvoGg1wHzdyTJQlRqE8iin1Aelfnjq2I5MRocZFhW/Ry5vl/Vo7v+Ww5Sh/R9/FJhqCFSvOuFlQ0JENp07TzKYUv8lUnJZsGFq6YHxRPIjFUowo0NdVDNGniQJiK1p0cV92qnGT5apZ2YX01UTXduEInsulet1EgPYFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WP9sL8ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3AEC4CECC;
	Thu, 21 Nov 2024 17:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732209012;
	bh=ifGy85N6zsRmBCj+/GrsUjDoHFFPGaFFCSuC+J0QRbw=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=WP9sL8ulYMwC3FQFbVYYWyPa1wfsRv4VKTUaDxxYucM7Dw4HQB+5EuYqr/oA34n2h
	 upGSM+PlyJ/TP77/0CHQ3AUUO3dIHz3TIm6XjmdJ3d9Ep62qcQJnl9FGzFPyaGBEHn
	 9io3tGmTZnXkzvZuwYxhuoU54XZTucTDDPlxmZBmZKv5dVVs5yXmm+MyFji9DloZR7
	 vJpX9TYfP3vxsdJFGRMWUvY+28YAHhlkaBn7gDAOrqKpTK/olkIdH6og92lh4eaFLF
	 S1uRZXNw5rpOp+6tUb2FChwfzixL5iXxtGyJixAL1O7ubt1AMmeGwIuxDMpxGKwkpy
	 jRhEGkN+VVM1w==
Date: Thu, 21 Nov 2024 11:10:11 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, shawnku@chromium.org, 
 geoffrey_chien@pegatron.corp-partner.google.com, hsinyi@chromium.org
To: Herbert Wu <herbert1_wu@pegatron.corp-partner.google.com>
In-Reply-To: <20241121032619.16525-1-herbert1_wu@pegatron.corp-partner.google.com>
References: <20241121032619.16525-1-herbert1_wu@pegatron.corp-partner.google.com>
Message-Id: <173220890396.3692254.17416105987923248929.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: mt8186: Add mt8186-skitty


On Thu, 21 Nov 2024 11:26:19 +0800, Herbert Wu wrote:
> Add Skitty initial device tree.
> 
> Signed-off-by: Herbert Wu <herbert1_wu@pegatron.corp-partner.google.com>
> Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Geoffrey Chien <geoffrey_chien@pegatron.corp-partner.google.com>
> Reviewed-by: Shawn Ku <shawnku@chromium.org>
> Commit-Queue: Shawn Ku <shawnku@chromium.org>
> Tested-by: Geoffrey Chien <geoffrey_chien@pegatron.corp-partner.google.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile                |  1 +
>  .../boot/dts/mediatek/mt8186-corsola-skitty.dts      | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dts
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8186-corsola-skitty.dtb' for 20241121032619.16525-1-herbert1_wu@pegatron.corp-partner.google.com:

arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dtb: /: compatible: 'oneOf' conditional failed, one must be fixed:
	['google,skitty', 'google,corsola', 'mediatek,mt8186'] is too long
	['google,skitty', 'google,corsola', 'mediatek,mt8186'] is too short
	'google,skitty' is not one of ['mediatek,mt2701-evb']
	'google,skitty' is not one of ['mediatek,mt2712-evb']
	'google,skitty' is not one of ['mediatek,mt6580-evbp1']
	'google,skitty' is not one of ['prestigio,pmt5008-3g']
	'google,skitty' is not one of ['fairphone,fp1', 'mundoreader,bq-aquaris5']
	'google,skitty' is not one of ['mediatek,mt6592-evb']
	'google,skitty' is not one of ['mediatek,mt6755-evb']
	'google,skitty' is not one of ['mediatek,mt6765-evb']
	'google,skitty' is not one of ['mediatek,mt6779-evb']
	'google,skitty' is not one of ['mediatek,mt6795-evb', 'sony,xperia-m5']
	'google,skitty' is not one of ['archermind,mt6797-x20-dev', 'mediatek,mt6797-evb']
	'google,skitty' is not one of ['bananapi,bpi-r64', 'mediatek,mt7622-rfb1']
	'google,skitty' is not one of ['mediatek,mt7623a-rfb-emmc', 'mediatek,mt7623a-rfb-nand', 'mediatek,mt7623n-rfb-emmc', 'bananapi,bpi-r2']
	'google,skitty' is not one of ['mediatek,mt7629-rfb']
	'google,skitty' is not one of ['cudy,wr3000-v1', 'openwrt,one', 'xiaomi,ax3000t']
	'google,skitty' is not one of ['acelink,ew-7886cax', 'bananapi,bpi-r3', 'bananapi,bpi-r3mini', 'mediatek,mt7986a-rfb']
	'google,skitty' is not one of ['mediatek,mt7986b-rfb']
	'google,skitty' is not one of ['bananapi,bpi-r4']
	'google,skitty' is not one of ['mediatek,mt8127-moose']
	'google,skitty' is not one of ['mediatek,mt8135-evbp1']
	'google,skitty' is not one of ['mediatek,mt8167-pumpkin']
	'google,elm-rev8' was expected
	'google,hana-rev6' was expected
	'google,hana-rev7' was expected
	'google,skitty' is not one of ['mediatek,mt8173-evb']
	'google,burnet' was expected
	'google,cozmo' was expected
	'google,damu' was expected
	'google,skitty' is not one of ['google,fennel-sku0', 'google,fennel-sku1', 'google,fennel-sku2', 'google,fennel-sku6', 'google,fennel-sku7']
	'google,skitty' is not one of ['google,juniper-sku16', 'google,juniper-sku17']
	'google,kakadu-rev3' was expected
	'google,kakadu-rev3-sku22' was expected
	'google,kappa' was expected
	'google,skitty' is not one of ['google,katsu-sku32', 'google,katsu-sku38']
	'google,skitty' is not one of ['google,kodama-sku16', 'google,kodama-sku272', 'google,kodama-sku288', 'google,kodama-sku32']
	'google,skitty' is not one of ['google,krane-sku0', 'google,krane-sku176']
	'google,skitty' is not one of ['google,makomo-sku0', 'google,makomo-sku1']
	'google,skitty' is not one of ['google,pico-sku1', 'google,pico-sku2']
	'google,skitty' is not one of ['google,willow-sku0', 'google,willow-sku1']
	'google,skitty' is not one of ['mediatek,mt8183-evb']
	'google,skitty' is not one of ['mediatek,mt8183-pumpkin']
	'google,steelix-sku393219' was expected
	'google,steelix-sku393220' was expected
	'google,steelix-sku393221' was expected
	'google,steelix-sku196609' was expected
	'google,skitty' is not one of ['google,steelix-sku131072', 'google,steelix-sku131073']
	'google,tentacruel-sku262147' was expected
	'google,tentacruel-sku262151' was expected
	'google,tentacruel-sku327681' was expected
	'google,tentacruel-sku327683' was expected
	'google,skitty' is not one of ['google,voltorb-sku589824', 'google,voltorb-sku589825']
	'google,skitty' is not one of ['mediatek,mt8186-evb']
	'google,skitty' is not one of ['mediatek,mt8188-evb']
	'google,hayato-rev1' was expected
	'google,hayato-rev5-sku2' was expected
	'google,spherion-rev3' was expected
	'google,spherion-rev4' was expected
	'google,skitty' is not one of ['mediatek,mt8192-evb']
	'google,skitty' is not one of ['google,tomato-rev2', 'google,tomato-rev1']
	'google,tomato-rev4' was expected
	'google,dojo-sku7' was expected
	'google,skitty' is not one of ['mediatek,mt8195-demo', 'mediatek,mt8195-evb']
	'google,skitty' is not one of ['mediatek,mt8365-evk']
	'google,skitty' is not one of ['mediatek,mt8390-evk']
	'google,skitty' is not one of ['kontron,3-5-sbc-i1200', 'mediatek,mt8395-evk', 'radxa,nio-12l']
	'google,skitty' is not one of ['mediatek,mt8516-pumpkin']
	'mediatek,mt2701' was expected
	'mediatek,mt2712' was expected
	'mediatek,mt6580' was expected
	'mediatek,mt6582' was expected
	'mediatek,mt6589' was expected
	'mediatek,mt6592' was expected
	'mediatek,mt6755' was expected
	'mediatek,mt6765' was expected
	'mediatek,mt6779' was expected
	'mediatek,mt6795' was expected
	'mediatek,mt6797' was expected
	'mediatek,mt7622' was expected
	'mediatek,mt7623' was expected
	'mediatek,mt7629' was expected
	'mediatek,mt7981b' was expected
	'mediatek,mt7986a' was expected
	'mediatek,mt7986b' was expected
	'mediatek,mt7988a' was expected
	'mediatek,mt8127' was expected
	'mediatek,mt8135' was expected
	'mediatek,mt8167' was expected
	'google,elm-rev7' was expected
	'google,hana-rev5' was expected
	'mediatek,mt8173' was expected
	'mediatek,mt8183' was expected
	'google,fennel' was expected
	'google,juniper' was expected
	'google,kakadu-rev2' was expected
	'google,kakadu-rev2-sku22' was expected
	'google,katsu' was expected
	'google,kodama' was expected
	'google,krane' was expected
	'google,makomo' was expected
	'google,pico' was expected
	'google,willow' was expected
	'google,steelix-sku393216' was expected
	'google,steelix-sku393217' was expected
	'google,steelix-sku393218' was expected
	'google,steelix-sku196608' was expected
	'google,steelix' was expected
	'google,tentacruel-sku262146' was expected
	'google,tentacruel-sku262150' was expected
	'google,tentacruel' was expected
	'google,voltorb' was expected
	'mediatek,mt8186' was expected
	'mediatek,mt8188' was expected
	'google,hayato' was expected
	'google,hayato-sku2' was expected
	'google,spherion-rev2' was expected
	'google,spherion' was expected
	'mediatek,mt8192' was expected
	'google,tomato' was expected
	'google,tomato-rev3' was expected
	'google,dojo-sku5' was expected
	'mediatek,mt8195' was expected
	'mediatek,mt8365' was expected
	'mediatek,mt8390' was expected
	'mediatek,mt8395' was expected
	'mediatek,mt8516' was expected
	'google,elm-rev6' was expected
	'google,hana-rev4' was expected
	'google,kakadu' was expected
	'google,tentacruel-sku262145' was expected
	'google,tentacruel-sku262149' was expected
	'google,spherion-rev1' was expected
	'google,dojo-sku3' was expected
	from schema $id: http://devicetree.org/schemas/arm/mediatek.yaml#
arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dtb: /: failed to match any schema with compatible: ['google,skitty', 'google,corsola', 'mediatek,mt8186']
arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dtb: /: failed to match any schema with compatible: ['google,skitty', 'google,corsola', 'mediatek,mt8186']
arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dtb: pmic: 'codec' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dtb: dp-bridge@5c: 'extcon' is a required property
	from schema $id: http://devicetree.org/schemas/display/bridge/ite,it6505.yaml#
arch/arm64/boot/dts/mediatek/mt8186-corsola-skitty.dtb: sound: 'model' is a required property
	from schema $id: http://devicetree.org/schemas/sound/mt8186-mt6366-rt1019-rt5682s.yaml#






