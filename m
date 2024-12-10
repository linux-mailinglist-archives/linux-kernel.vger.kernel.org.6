Return-Path: <linux-kernel+bounces-440348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D73E79EBC05
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 22:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 478AB188B133
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 21:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D4B23D408;
	Tue, 10 Dec 2024 21:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwdYw6fX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DA323A596;
	Tue, 10 Dec 2024 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733866928; cv=none; b=oN/eZSs48FJqbei580//5TZvb5oldxVv7anGAZsWO8Sefo+g/SPfw1rvoDEi/05C+3O5Yy8M4Y8w7vW8OUNN26bk6v3qjWvm61csdJmovckgVQmsxctQcbwtU9KZdFqhaN1lm4w0RoSklfgKItYBoScaJImNL9w/3WZy+igUDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733866928; c=relaxed/simple;
	bh=9qlaJJU5gDo5bAuPmvTR0FrAbcj50IZPIDpRze7PsRE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=PcxC1Dc6D+cyemSm751HIglhDTuOlJk8GpLkJlLk8285ZSfBphQlfUmE+9mkbRSfGFYOv4mSEbch3s7v8tfNfMM6rd1Ej0lthWuVy48mmXyh+3Mtscp3qcuVVsD2QeFXDqHD6bFS6CcKL6nkGgzYf5KyhxJWdntY9gjkxGQSZWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwdYw6fX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FD7C4CED6;
	Tue, 10 Dec 2024 21:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733866926;
	bh=9qlaJJU5gDo5bAuPmvTR0FrAbcj50IZPIDpRze7PsRE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=lwdYw6fX/UzDINS0WzcSNG4qwR4KxS518tnfSxkdS1wiU3HK2aTgUTVCIcxYckUwx
	 Nv+raN3nsb9s6DTvDNLhYni5Rmbn+lDrDQI+wwMux3kWkuS7cIyrbAjrHX9b/XAXFs
	 QLJWXCMGjpcJwuEaRKAo8fjwynI9JvtV6XIOS0sFR8/LJyDGCZAL0qVHBu9r0mE0/P
	 WyHB9D7luL16PhXsOVRuO9dFLAYT6LbyNFgyU7FIRScaDdhlzXF6ZjXaUa2rMTd/+O
	 8FmlimtO5sKqhDKgOLfbiyUbYJv4230M8+8cgvcg/aiNQ6QRtRzHJBk9nc4PF8zMdJ
	 1p6lND57gIEAQ==
Date: Tue, 10 Dec 2024 15:42:05 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-kernel@vger.kernel.org
To: Chen-Yu Tsai <wenst@chromium.org>
In-Reply-To: <20241210092614.3951748-1-wenst@chromium.org>
References: <20241210092614.3951748-1-wenst@chromium.org>
Message-Id: <173386568696.497617.3727087837255802552.robh@kernel.org>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: mt8173-elm: Fix MT6397 PMIC
 sub-node names


On Tue, 10 Dec 2024 17:26:12 +0800, Chen-Yu Tsai wrote:
> The MT6397 PMIC bindings specify exact names for its sub-nodes. The
> names used in the current dts don't match, causing a validation error.
> 
> Fix up the names. Also drop the label for the regulators node, since
> any reference should be against the individual regulator sub-nodes.
> 
> Fixes: 689b937bedde ("arm64: dts: mediatek: add mt8173 elm and hana board")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
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


New warnings running 'make CHECK_DTBS=y mediatek/mt8173-evb.dtb' for 20241210092614.3951748-1-wenst@chromium.org:

arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vpca15: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vpca7: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vsramca15: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vsramca7: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vcore: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vgpu: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vdrm: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: buck_vio18: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vtcxo: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_va28: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vio28: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vusb: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vcama: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vmc: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vmch: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vemc3v3: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp1: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp2: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp3: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp4: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp5: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vgp6: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#
arch/arm64/boot/dts/mediatek/mt8173-evb.dtb: regulators: ldo_vibr: Unevaluated properties are not allowed ('regulator-compatible' was unexpected)
	from schema $id: http://devicetree.org/schemas/regulator/mediatek,mt6397-regulator.yaml#






