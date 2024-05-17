Return-Path: <linux-kernel+bounces-182141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD95C8C8727
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE9101C2239F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B05491D;
	Fri, 17 May 2024 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o66cIpoU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11705465D;
	Fri, 17 May 2024 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951846; cv=none; b=AADZx3FY351VibgJIi/oH2xu2SJct7r77aNYFFeNbDJqP7nFCnGihYCMT5lQNOd9Km+MQGEBBFs9J95UrT0GeTRPn9lluaS5VvWsONwu/UPZBSbxBfosD9l7u8jwybnqBO+KDdaD0AVk3aWpEDhPCBFphc6q8In5W3hNtBw07tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951846; c=relaxed/simple;
	bh=1J/lhvIiO6mwtuULpiIS2YMdfysBQ3rnQujL/6UQ5kI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=k4OrVZyE6eNc31ITLYfCPQcIBSRPV2VWUTxoTFNt6tr0EEnTHwiqrpyTZq/f5pqOwfSLjj4RgQaFjljAjzr7TLkgEG1mJgy/uy9YigzoBpyxzI9y7jE9pvQPTN8SNatXNhxaFLqsBKtQ5LF3JJuH4XJDrMT1UD58/OpnUUavjfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o66cIpoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386E1C4AF0A;
	Fri, 17 May 2024 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715951846;
	bh=1J/lhvIiO6mwtuULpiIS2YMdfysBQ3rnQujL/6UQ5kI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=o66cIpoUZQCRuv/oIPcPs1sa27U7rtqcrO0zBQa2fIoRbmfrAQ+RCxerlknIhTrDC
	 k2QOumLsaxeFbp/6HLo+9pz7QrglPqhFM59Sy2+b/dThfWkfW8O7kTmIe5NSzpb0vb
	 t6V9t7xBwsIgVUkV0XdikGnmiD5g2MBjldtly8uVs7LB0F1aDJkmHhCdzAJW/abUqT
	 uq3vCi7RCnLEuPzi993MfKSMgG+QrcMLln01zBTSGyM+zPtSVsQS40BhJRjdItOnEe
	 ps0p9ijecCVZn5BvU5o0VLQIJb4iqqmp6oTMOIzP48LHHK0flrYEh0jZ1OWhmm+JYL
	 ZQbk0ot6WlnSw==
Date: Fri, 17 May 2024 08:17:25 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
 linux-mediatek@lists.infradead.org, Daniel Golle <daniel@makrotopia.org>, 
 Frank Wunderlich <frank-w@public-files.de>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240516204847.171029-1-linux@fw-web.de>
References: <20240516204847.171029-1-linux@fw-web.de>
Message-Id: <171595174039.1651187.6331361441696662180.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: mt7622: fix switch probe on bananapi-r64


On Thu, 16 May 2024 22:48:47 +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> After commit 868ff5f4944a
> ("net: dsa: mt7530-mdio: read PHY address of switch from device tree")
> the mt7531 switch on Bananapi-R64 was not detected.
> 
> mt7530-mdio mdio-bus:00: reset timeout
> mt7530-mdio mdio-bus:00: probe with driver mt7530-mdio failed with error -110
> 
> Fix this by adding phy address in devicetree.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
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


New warnings running 'make CHECK_DTBS=y mediatek/mt7622-bananapi-bpi-r64.dtb' for 20240516204847.171029-1-linux@fw-web.de:

arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dtb: switch@1f: 'interrupts' is a dependency of 'interrupt-controller'
	from schema $id: http://devicetree.org/schemas/net/dsa/mediatek,mt7530.yaml#






