Return-Path: <linux-kernel+bounces-254445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E2B93334C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2A3A1F22386
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255F4768EC;
	Tue, 16 Jul 2024 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BHFgeeBg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C7155894;
	Tue, 16 Jul 2024 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721164356; cv=none; b=fULkyG2JSx3s3XJoVPgQHe5JfOGY4okIeMkGXlOT9gQZEMfV8UVaXVT+Afp0HejYAZEsbG0LKiHqtdlSGdmUdajJWUVIxI5wF4GREOFWdjN50QaTzqxJt4uj03zYAP/RzfWaZHxiHt30nfrSylKM9OOBsEdS5wfFSq+LUsThQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721164356; c=relaxed/simple;
	bh=zNjq8hlb8zQrX+gh4VlzfaIJdM0/MhlIUFLSP0DoTuI=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=twid6J7rAQfmQstjofv5lT5S4fHgVNjIdXy9YBpF2qp7ef/i0M1/+MpIgqJE9rwwzm+34zQQAOAWpBiDVq9DaayTrKnKXIUsNrOMunXoWtmKSIwFHsId0Jtya7NFLIXLoNzbSMKKwewiTOjC2lbT2UodcZ5hWlyfAV04owE862M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BHFgeeBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B189C116B1;
	Tue, 16 Jul 2024 21:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721164355;
	bh=zNjq8hlb8zQrX+gh4VlzfaIJdM0/MhlIUFLSP0DoTuI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=BHFgeeBgTQW/7S6epLIyhBqzTv6wDihpvNkouzSe3mZ36fbyG1TgRn6dtgfHmCrY6
	 ewi2Z6PRBXNRpkzmzKtgLj95BC+NUyia8SsC6Khkf9XW5dN0zRZixSn7AFhaDNo8+Q
	 zovQMmYGj/FPDwdMbLghyPDqy77esS9xdwbt90Sl1e57/2E3nOXDI2TiT0XUvB8Nf7
	 3krmbMPz7HE2xUlm8dXTcITNYttRXgqIyuDBcpBgBw7QtcgXf6UOrxHP/YzhiVGv41
	 0wYGEYin1qQbz/OcrN+UqMrMSvHOUWcRi5XzcBj8yvE+i1KqdmVmHOxgmAOKskPMfc
	 fjI5RRGHqTN5w==
Date: Tue, 16 Jul 2024 15:12:33 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christopher Wecht <cwecht@mailbox.org>
Cc: Shawn Guo <shawnguo@kernel.org>, imx@lists.linux.dev, 
 Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240716083635.626596-1-cwecht@mailbox.org>
References: <20240716083635.626596-1-cwecht@mailbox.org>
Message-Id: <172116301222.347257.7232211573130018569.robh@kernel.org>
Subject: Re: [PATCH] arm64: dts: freescale: imx8mp-phyboard-pollux-rdk: add
 HDMI support


On Tue, 16 Jul 2024 10:36:35 +0200, Christopher Wecht wrote:
> Enable the HDMI output on the phyBOARD Pollux, using the HDMI encoder
> present in the i.MX8MP SoC.
> 
> Please note that lcdif3 has not bee enabled. This is due the fact
> that as of now either HDMI or LVDS may be enabled. If both are
> enabled it won't worked. With this patch, however, HDMI can be
> enabled by turning ldcif3 on and ldcif2 off.
> 
> Signed-off-by: Christopher Wecht <cwecht@mailbox.org>
> ---
>  .../freescale/imx8mp-phyboard-pollux-rdk.dts  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
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


New warnings running 'make CHECK_DTBS=y freescale/imx8mp-phyboard-pollux-rdk.dtb' for 20240716083635.626596-1-cwecht@mailbox.org:

Error: arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts:149.17-153.12 syntax error
FATAL ERROR: Unable to parse input tree
make[3]: *** [scripts/Makefile.lib:442: arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb] Error 1
make[2]: *** [scripts/Makefile.build:485: arch/arm64/boot/dts/freescale] Error 2
make[2]: Target 'arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dtb' not remade because of errors.
make[1]: *** [/home/rob/proj/linux-dt-testing/Makefile:1381: freescale/imx8mp-phyboard-pollux-rdk.dtb] Error 2
make: *** [Makefile:224: __sub-make] Error 2
make: Target 'freescale/imx8mp-phyboard-pollux-rdk.dtb' not remade because of errors.






