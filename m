Return-Path: <linux-kernel+bounces-524744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100C3A3E68D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 22:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747E019C4711
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6B3264F86;
	Thu, 20 Feb 2025 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvPYGtJc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311DE264625;
	Thu, 20 Feb 2025 21:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086956; cv=none; b=SMXkuo0GL9IuR4/IhGvhNCvfiGNFo2yT+Sp2+an/9vwZSITfamIuGaH21mm2vdDRFadPHeXZVhhqJz0bhSAkvc9ntsg/H4mZuG0DLipPiZ6sehDlubJ6qV8VpqjZJtFj0zRhEZivApuu6Rf5pB3GdBDYpfrCpCljw451HTEHaYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086956; c=relaxed/simple;
	bh=gnBLsDZltrPeBxgUu4aUGcp7+4oRWM3WMYmqT+zK4Do=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=kTuzM5jejuJ8XF6fzkexN8Qqe1S4cSk4fXD8pAw/JZ9bhchJlbK9G1mpJnqsJ4Zoun+MerNwjseS4EmBjriL9L/IFvqKirO2lguberQVC8GMNx6ajY3/h3DDLCacSDIvmfxkir5Fo70DTTmYcO0yak56uDlyhzKUBFtK38tSgPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvPYGtJc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD27FC4CED1;
	Thu, 20 Feb 2025 21:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740086956;
	bh=gnBLsDZltrPeBxgUu4aUGcp7+4oRWM3WMYmqT+zK4Do=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=QvPYGtJcR7Jf2rmHtsFW7x1ACCYjOVVt7am9OK9mMkWRfRl8WPnTrg4UkeuiHuFNu
	 zMjB7Q8ZAsdj6ob8BntZO1SCScthUg4EIGcEiNcch7NQrQXS0OFdcenVQe9wqE2IFu
	 f+8svNdijLWBD3onEZUiiknhFgFVPFtZNlVaxztdptDZFhl+QlWwh0VyegC40Zc4Mx
	 NbOIn3XOdxUMynf7wdE7riVv89r55/bdTzCm0z0DWFhcO3ti3+A1CR+TpQVLdRf8oz
	 jmdbOOOde+sTlTx7RC95ennaqLH9070SK2oTtqmXxzRqcVO5+GEN1kJlIe1FMZBTsj
	 weuMeC3eQpJrQ==
Date: Thu, 20 Feb 2025 15:29:14 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: gregkh@linuxfoundation.org, linux-mediatek@lists.infradead.org, 
 devicetree@vger.kernel.org, matthias.bgg@gmail.com, pablo.sun@mediatek.com, 
 kernel@collabora.com, chunfeng.yun@mediatek.com, conor+dt@kernel.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, krzk+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
References: <20250220105514.43107-1-angelogioacchino.delregno@collabora.com>
Message-Id: <174008661614.4046678.816016771322742801.robh@kernel.org>
Subject: Re: [PATCH v3 0/3] MediaTek MT8188 MTU3 USB and Genio 510/700
 TypeC


On Thu, 20 Feb 2025 11:55:11 +0100, AngeloGioacchino Del Regno wrote:
> This series adds MTU3 nodes to the MT8188 base devicetree, fixes the
> Geralt Chromebooks to use it, and adds support for all of the USB
> ports, including TypeC Power Delivery, Alternate Modes, etc, found
> on the MediaTek Genio 510 and Genio 700 Evaluation Kits.
> 
> This also adds the missing SuperSpeed port to the mtk-xhci binding.
> 
> AngeloGioacchino Del Regno (3):
>   dt-bindings: usb: mediatek,mtk-xhci: Add port for SuperSpeed EP
>   arm64: dts: mediatek: mt8188: Add MTU3 nodes and correctly describe
>     USB
>   arm64: dts: mediatek: mt8390-genio-700: Add USB, TypeC Controller, MUX
> 
>  .../bindings/usb/mediatek,mtk-xhci.yaml       |   4 +
>  .../boot/dts/mediatek/mt8188-geralt.dtsi      |  18 +++
>  arch/arm64/boot/dts/mediatek/mt8188.dtsi      | 121 +++++++++-----
>  .../dts/mediatek/mt8390-genio-common.dtsi     | 151 +++++++++++++++++-
>  4 files changed, 251 insertions(+), 43 deletions(-)
> 
> --
> 2.48.1
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/mediatek/' for 20250220105514.43107-1-angelogioacchino.delregno@collabora.com:

arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dtb: rt1715@4e: 'vbus-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/richtek,rt1711h.yaml#
arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dtb: jpeg-decoder@1a040000: iommus: [[137, 685], [137, 686], [137, 690], [137, 691], [137, 692], [137, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: rt1715@4e: 'vbus-supply' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/usb/richtek,rt1711h.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: jpeg-decoder@1a040000: iommus: [[139, 685], [139, 686], [139, 690], [139, 691], [139, 692], [139, 693]] is too long
	from schema $id: http://devicetree.org/schemas/media/mediatek-jpeg-decoder.yaml#






