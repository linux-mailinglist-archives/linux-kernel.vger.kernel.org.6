Return-Path: <linux-kernel+bounces-200950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C713F8FB72B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 17:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82081286C09
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7764147C98;
	Tue,  4 Jun 2024 15:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUcn6va2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC97C1474BF;
	Tue,  4 Jun 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717514931; cv=none; b=PMANM2/oUTD9m3Juf/oivUWpDY/Ow9IW008VIARBrPS3mNaAVst16m2v7ZjhbutxaAcAG6/VmNRAeL+aoCNzL4OI/Kuhu8kBYlaPt2DwUzijCVbnHj3Sjb1h7hPKIkcaGp7UXv6uRL7pQsbgBrdlRfmCWvA/gId05k/0RzfhY1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717514931; c=relaxed/simple;
	bh=R1YRD2xWbJ4CKWMqqUw5zYxQzZsVAGnyTTQmzDLurbk=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=s/ubAnHJ3yQZdxNznzQNGQMu1kpnY2vxhVHQ+SWDr7ofdPx15c3OA3kObzbE479OXROrZZ4Q0g49tuPfKBOJDSyCp+/7EfMTP5fi2tbeA/0zoUGQRmpO65Ns9m0NW7yhtwxvQHJAEmrnRh0wU/SNJzS/PITyRqFLdZEXWkYDzNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUcn6va2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90147C2BBFC;
	Tue,  4 Jun 2024 15:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717514930;
	bh=R1YRD2xWbJ4CKWMqqUw5zYxQzZsVAGnyTTQmzDLurbk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hUcn6va2iO2Svgq2BjnHS2k7iJpLoBCgeIqURzrr3foQWSsbvm3qFmPoZr5y9cMIw
	 Q3TtZ1s23R3mRAbGvoharsyCtOKLx/WRtOC6mnCK+7cl+hPtXLDVzfOd0Hss44ty7E
	 ExDmlClfc4BRbqd73lIxKA2Ae/NfymL0urM8EreUFyolUMQDHP2X5JhYJ91skDzFaG
	 t4toNFuG9AlRxYCIbi61Zwcw6bkcuysdCRZdptyuRuFuLclBeUCVs2rpuic74ZYTaC
	 M4bHe5uuVSoRgA19XfVWK4RHFdCSld1E4mqvOEwzhZ30bZQ64goqkJAI5caXLk9Bkb
	 v6m4Otf9kYxYQ==
Date: Tue, 04 Jun 2024 10:28:48 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>
In-Reply-To: <20240602104021.387713-1-amadeus@jmu.edu.cn>
References: <20240602104021.387713-1-amadeus@jmu.edu.cn>
Message-Id: <171751454718.785691.9170634580021432127.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: mediatek: Add Bananapi BPI-R3
 mini


On Sun, 02 Jun 2024 18:40:20 +0800, Chukun Pan wrote:
> Add compatible for Bananapi BPI-R3 mini Router (Filogic 830).
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
>  1 file changed, 1 insertion(+)
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


New warnings running 'make CHECK_DTBS=y mediatek/mt7986a-bananapi-bpi-r3-mini.dtb' for 20240602104021.387713-1-amadeus@jmu.edu.cn:

arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-mini.dtb: crypto@10320000: interrupts: [[0, 116, 4], [0, 117, 4], [0, 118, 4], [0, 119, 4]] is too short
	from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-mini.dtb: crypto@10320000: interrupt-names: ['ring0', 'ring1', 'ring2', 'ring3'] is too short
	from schema $id: http://devicetree.org/schemas/crypto/inside-secure,safexcel.yaml#
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-mini.dtb: ethernet@15100000: mac@0: Unevaluated properties are not allowed ('phy-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/mediatek,net.yaml#
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-mini.dtb: ethernet@15100000: mac@1: Unevaluated properties are not allowed ('phy-supply' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/mediatek,net.yaml#
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-mini.dtb: rfkill: 'reset-gpios' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/net/rfkill-gpio.yaml#






