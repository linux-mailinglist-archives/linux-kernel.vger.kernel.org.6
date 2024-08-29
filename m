Return-Path: <linux-kernel+bounces-307628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E34965096
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 22:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93EC1F22701
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 20:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C974C1BAED3;
	Thu, 29 Aug 2024 20:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/2iEdVJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F501B653D;
	Thu, 29 Aug 2024 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962534; cv=none; b=IMotTApsPHlpOU6BPYgiY95WBudIo2hVk5Z0dZ2UCSstwyvXbZ0kuPNhN8+Lcfo9Qqv0pWUObJ4+CsyOfunt9uM13+Nhl8xhpc8HWzDaHntKzuMAdcov+6NV/+uPR3aU5uOSbqvYN6nxOb3pT2rS93sllHSF2xsu1eVlJ1udDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962534; c=relaxed/simple;
	bh=Ct9CPYDZs1D52/P92RNJ8V1FCpwTi5S3g6iSiVFbCWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8yEsZIYtZE3vJNJwHSJhyQhCRlk4U7p9hGbGaKD586NbCbJd6+ieZGXoLn3G5sRFQl+y5NTFOtWXClykBdP2hgGR0P4TlNacXbVVNgv+OJuvZMS/sqe0l/H0aQELb5ThzHt+ABybQsbA4sijOfeixcctZCskQdfqRUqCBtG5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/2iEdVJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485E8C4CEC1;
	Thu, 29 Aug 2024 20:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724962533;
	bh=Ct9CPYDZs1D52/P92RNJ8V1FCpwTi5S3g6iSiVFbCWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/2iEdVJEgmRS1BE1cy9xYNLFAHmZBCjY21XDby7JgvIY0OgdMxFtAVxszBJDX3z+
	 +gHKb34cHcpHyWFT5m/4KWT1cWMMislOdnvIkdcrnK/YodbmBiZiL6KF2mgqaVrRN0
	 GG+Lmq1NsyqnjDQomP+t78HWgB64jPw18X51nBSQSvU8Rrzqke7xGZ7EjTfLrzDNZC
	 fwcyVpWC53EzrIQm9XiwkK1kIlO0oBix8u9EBcuhSRWuRJX1+C+Beex4XOI0D3Wx3z
	 9GiJdXa2C6w4qKEX3PkNoT3CD8fMzfefSaEdorZyrCvwzAvtNsK2ia9tj1DZPedzdO
	 wC9/5kTlardNA==
Date: Thu, 29 Aug 2024 15:15:31 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: imx@lists.linux.dev, jdelvare@suse.com, linux-kernel@vger.kernel.org,
	lgirdwood@gmail.com, linux@roeck-us.net, broonie@kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	linux-hwmon@vger.kernel.org, Frank.li@nxp.com, krzk+dt@kernel.org
Subject: Re: [PATCH v5 1/1] dt-bindings: hwmon: Convert ltc2978.txt to yaml
Message-ID: <172496253089.1134105.2312367634217065989.robh@kernel.org>
References: <20240829150641.1307906-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829150641.1307906-1-Frank.Li@nxp.com>


On Thu, 29 Aug 2024 11:06:41 -0400, Frank Li wrote:
> Convert binding doc ltc2978.txt to yaml format.
> Additional change:
> - add i2c node.
> - basic it is regulator according to example, move it under regulator.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dtb: /soc/i2c@2000000/i2c-mux@77/i2c@2/regulator@5c:
> 	failed to match any schema with compatible: ['lltc,ltc3882']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v4 to v5
> - rename to lltc,ltc2978.yaml
> Change from v3 to v4
> - keep under hwmon directory.
> Change from v2 to v3
> - put my name into maintainers.
> change from v1 to v2
> - maintainer change to Mark Brown <broonie@kernel.org> (regulator maintainer)
> - update title to (from ltc2978 data sheet).
> octal, digital power-supply monitor, supervisor, sequencer, and margin controller.
> ---
>  .../bindings/hwmon/lltc,ltc2978.yaml          | 94 +++++++++++++++++++
>  .../devicetree/bindings/hwmon/ltc2978.txt     | 62 ------------
>  2 files changed, 94 insertions(+), 62 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lltc,ltc2978.yaml
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/ltc2978.txt
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


