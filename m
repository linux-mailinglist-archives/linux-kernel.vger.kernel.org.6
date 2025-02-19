Return-Path: <linux-kernel+bounces-520686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE61A3AD42
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 01:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B10933AF565
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C121D555;
	Wed, 19 Feb 2025 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muGefaYQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39B4155398;
	Wed, 19 Feb 2025 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739925741; cv=none; b=uZbdHQtFS91XskocOa8ejmnE6pDsancRzT1e/eRMDEcyDtIPRb3z7IMT3JprrIbTgcTdG7xrUnoPkkMysoX/g3QgQRXmWC8S0TatqOTeixVprDXtBGTJb77WkOfFE6v5Xfhi/RZQ2Mdn7hH/e+dZ9yaFlqz4HfEdN5MeDgffIH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739925741; c=relaxed/simple;
	bh=02Tesx/tnmO4sUGr6nhYrQU8H8jB+abH1mJP0cDsuII=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=akvocFZeq5x90lNhfl0GFZJp2G8MQwD0ARgppJwul21DSraLxnun97czCJoI+jGZ6V+M9oRGiRHydBn9/cUmFrHZ1jdJl8Xw3c8IiFcrHDTlcC0bIqxYSbYF4+flhAMoij3fzcK9rc4c6OlSzbfpSFTHuNPYPxBJ4MwTy0ZimAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muGefaYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DA4C4CEE2;
	Wed, 19 Feb 2025 00:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739925741;
	bh=02Tesx/tnmO4sUGr6nhYrQU8H8jB+abH1mJP0cDsuII=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=muGefaYQPYilDyUzERzYUgl8wn0lU0PrrmQ5XVqpHJn02KfLShDSo3hvYK/FhThCN
	 X0k+geeZWeqClqLh5mdQ7G1MrxJZJS92f7+LFB6nSD6h1UtjEhv1O3Xuoc1ICoIb1R
	 RX3IT+MK9hsvOlgV8E/U7roYVM8De2s6sCZYOl3aTg4GxR5xK7CvGzZcS8+E1upmiK
	 fE5xvyg6CFunOR006XeBi2UknqCRrT76Kuqk1wkKE9KJQUMCKO1+NkFcHljYJ4xlFo
	 7odRYME+YL3pgFHbMaYPTdW52zG0RkPNGc9sX8yqwLEjC3pXF4/kvTSNR5uUVnNMeb
	 jILXXGP2fv3xA==
Date: Tue, 18 Feb 2025 18:42:20 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, Sen Chu <sen.chu@mediatek.com>, 
 Bear Wang <bear.wang@mediatek.com>, Conor Dooley <conor+dt@kernel.org>, 
 Chris-qj chen <chris-qj.chen@mediatek.com>, linux-usb@vger.kernel.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Alexandre Mergnat <amergnat@baylibre.com>, 
 linux-arm-kernel@lists.infradead.org, Macpaul Lin <macpaul@gmail.com>, 
 Pablo Sun <pablo.sun@mediatek.com>
To: Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20250217113736.1867808-1-macpaul.lin@mediatek.com>
References: <20250217113736.1867808-1-macpaul.lin@mediatek.com>
Message-Id: <173992516365.2065360.13568840928707086513.robh@kernel.org>
Subject: Re: [PATCH v3] arm64: dts: mediatek: mt6359: fix dtbs_check error
 for audio-codec


On Mon, 17 Feb 2025 19:37:36 +0800, Macpaul Lin wrote:
> This change fixes these dtbs_check errors for audio-codec:
> 1. pmic: 'mt6359codec' does not match any of the regexes: 'pinctrl-[0-9]+'
>  - Replace device node name to generic 'audio-codec'
> 2. pmic: regulators: 'compatible' is a required property
>  - Add 'mediatek,mt6359-codec' to compatible.
> 
> Fixes: 3b7d143be4b7 ("arm64: dts: mt6359: add PMIC MT6359 related nodes")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt6359.dtsi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Changes for v2:
>  - No change. Because the 2/3 patch has been dropped from the v1 patch.
>    Hence the new patch set v2 needs to be updated.
> 
> Changes for v3:
>  - Add "Reviewed-by:" tag. Thanks!.
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


New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/mediatek/' for 20250217113736.1867808-1-macpaul.lin@mediatek.com:

arch/arm64/boot/dts/mediatek/mt8195-demo.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8395-genio-1200-evk.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku4.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8370-genio-510-evk.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku1.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8395-radxa-nio-12l.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-evb.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku7.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku3.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku6.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku0.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8192-evb.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-dojo-r1.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku2.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#
arch/arm64/boot/dts/mediatek/mt8188-geralt-ciri-sku5.dtb: pmic: '#sound-dai-cells', 'mt6359rtc' do not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/mfd/mediatek,mt6397.yaml#






