Return-Path: <linux-kernel+bounces-380309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F919AEC2D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 18:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01861C233B4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699641F76CF;
	Thu, 24 Oct 2024 16:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvdA7kTJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59485FEED;
	Thu, 24 Oct 2024 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787590; cv=none; b=Sk0zxV05dUCxS4ejJBiBw3L8g4c8XbLEvf1eFVesE7ucLitRqC7m5o8bHNsdBVjs13qc+pjk0d+UnKhXgvrAN4dbx3d2BENvKnt13zztitHd9UO7/C+bOEVB6ouvah3gwhSqvOeqohywLQ5Jh6RXomR7DuuSixaB9Lv1yoqqf5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787590; c=relaxed/simple;
	bh=5kxJTQW4XLnjK4PI9EbjL4QCTIY5IkCswPV0X0kgjXA=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=u0K2hURtOunyBPyZLU9n5QWwekAkHftImSZwbDfH7GiEMCUKtm/GCSWqKN4tQSdWpsHpFpzbGmEPfChBGoYeazkbGbQlsHJTzhWH1gkkVNxE/d9UAe/oG2NS4W/tmOAtdwIkXpIYCgfKTCYWvhGfRKPJyl1kkFbphl3Lgw0DtKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvdA7kTJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327CDC4CEC7;
	Thu, 24 Oct 2024 16:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729787590;
	bh=5kxJTQW4XLnjK4PI9EbjL4QCTIY5IkCswPV0X0kgjXA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=MvdA7kTJDan+helwSfB+pBk7ZfNqZXOtLsXsfW6yzTl3vRPFL/XxcwerzuTOZ1puK
	 2Mg7bNCdbyAkDIN2peeWX546T1I5XGBdfJO6zug+2IC42QeTEkyaofRS+CS89X35Hg
	 irnmfq5fVkK9Rq9qxnApgL8+X2iKcRgaz92/h0xKoQav5+U4ReeaB7G7vQGY4wksdb
	 Z3IiQh6lMOZ/+HVeB5J8cXda3FLHWloMj2JXV9z4bh0p+vCKqJgL704IdjVhQwvbpV
	 pX0kRNuSeP23oIkjfTLhvteyu/BUstgRXsNFYe3o1nwSuQ3B/+VeZ4VMG+Ri51Go/s
	 kdFEMbWUrw1kQ==
Date: Thu, 24 Oct 2024 11:33:09 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: shawnguo2@yeah.net, conor+dt@kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, krzk+dt@kernel.org, 
 linux-arm-kernel@lists.infradead.org, festevam@gmail.com, 
 imx@lists.linux.dev, shawnguo@kernel.org, s.hauer@pengutronix.de, 
 kernel@pengutronix.de
In-Reply-To: <20241021163437.1007507-1-Frank.Li@nxp.com>
References: <20241021163437.1007507-1-Frank.Li@nxp.com>
Message-Id: <172978739353.623341.4645836929476354717.robh@kernel.org>
Subject: Re: [PATCH v2 1/6] arm64: dts: imx8qxp-mek: add bluetooth audio
 codec


On Mon, 21 Oct 2024 12:34:32 -0400, Frank Li wrote:
> Add bluetooth audio codec.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v1 to v2
> -none
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8qxp-mek.dtb' for 20241021163437.1007507-1-Frank.Li@nxp.com:

arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: esai@59010000: Unevaluated properties are not allowed ('power-domains' was unexpected)
	from schema $id: http://devicetree.org/schemas/sound/fsl,esai.yaml#
arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb: usbphy@5b100000: 'nxp,sim' is a required property
	from schema $id: http://devicetree.org/schemas/phy/fsl,mxs-usbphy.yaml#






