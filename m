Return-Path: <linux-kernel+bounces-182140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFF88C8725
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 15:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A143A1C2130B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D78650A7E;
	Fri, 17 May 2024 13:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGeX7leM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E64F887;
	Fri, 17 May 2024 13:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715951845; cv=none; b=VmQA7YcPaLzme4kY+/r8hrEcf80JtADgWbttuUpg/A6EA2Zr6Iiy1LZpXcftZEXMsyvDhDheylkLlIVO6NQf01wbiBE+PxnZZGPEy4BPF5O3cmUksqeIFDS6a0zik+0Pqe9onM1Ed0VzMMU8cF9feEPXN/IVj2vIRaGctv59Zak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715951845; c=relaxed/simple;
	bh=+iDpRvaHBF67JDzZJTV4G+Mp9zFa9uxoX38eD+A5Neg=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=lI8b8zS+iTz/7u5/MQRxmj1h1wY0/m4wnss0fxuJfT1BY5v2bwfW/6Q/VZPYNnaZcfA+DFBborwL4pwJcXVnzlHe7flIE8aEIW5mXcGjuaGVScX/RLwFaDpsbBNVDTR3do8/iBZUyKbWMPJKDckF3upduxUwuaJmPS7pQXVOyko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGeX7leM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACD0C2BD10;
	Fri, 17 May 2024 13:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715951844;
	bh=+iDpRvaHBF67JDzZJTV4G+Mp9zFa9uxoX38eD+A5Neg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=TGeX7leMnfPr2iyTGvGBIWvcK5xTUXzvn22fNP6z+Jfci5PGEX6IeREvFFBGkBhaZ
	 v0Nz4wmvqcxP4lvsORj2PeyQFKJOv8l4AysmdI1UQDZc2W06xp0EcccZDtt1ZrtkQn
	 34NshspxVzBIG2WomEdCbWitDmbuh2rDU1tAvR2S2ZzF0J2UOvjbn8e6S6yQvS6AXi
	 rs0DJuzEvD7I6LwgpGFzBxIEn2iC3PXoXtj3xmYR4wnV8epRSUEF7EuVQUNPyh6VHs
	 oCBb2To3UsWCAoSKgn1tye83nitvUHYUAVyAge1+K44H9g7KYdqMrzZSJSENftK5LE
	 DSMK7kKwakLug==
Date: Fri, 17 May 2024 08:17:23 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20240516112355.200265-1-alexander.stein@ew.tq-group.com>
References: <20240516112355.200265-1-alexander.stein@ew.tq-group.com>
Message-Id: <171595174000.1651057.6767268550343039132.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: add MBa8MP-RAS314 SBC


On Thu, 16 May 2024 13:23:54 +0200, Alexander Stein wrote:
> MBa8MP-RAS314 is an SBC based on the embedded module TQMa8MPxL.
> All relevant interfaces integrated in the CPU have been implemented on
> the MBa8MP-RAS314 for (an) industrial usage. Due to the numerous interfaces
> and the small size of this SBC the use in different applications
> is possible without the need of a [special,custom] design.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-tqma8mpql-mba8mp-ras314.dtb' for 20240516112355.200265-1-alexander.stein@ew.tq-group.com:

arch/arm64/boot/dts/freescale/imx8mp-tqma8mpql-mba8mp-ras314.dtb: interrupt-controller@32fc2000: 'power-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/interrupt-controller/fsl,irqsteer.yaml#






