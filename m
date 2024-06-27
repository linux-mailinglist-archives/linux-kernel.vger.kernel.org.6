Return-Path: <linux-kernel+bounces-232934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 813B091B020
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EA51C21B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF9919D06D;
	Thu, 27 Jun 2024 20:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XW8SUNtv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B4145BE4;
	Thu, 27 Jun 2024 20:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719519004; cv=none; b=W5XXGkzlDjySZRr0EjlkMnJopgAv7JDQUpbKiZBGLYyDVipkXra+pB1XhDS0MZ7BYJq2MhUOk4Z2ATU/llPasLr/KHj0n1mfWzvc+cxgBXt1ato1B9kdyQDN6DhRxFXweeEKHZJmiGkTgW/KV/NLEWcI8OOU3dIq7QgnWlm0vGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719519004; c=relaxed/simple;
	bh=byVO7bSjc2B50u+ghIN9MhH9E2GcieHSkOgjwGtHUxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JykGQKP+X8xPMYZt1X3AfzTXewyu0y5AEUJYaWOHld8dLKvt2w6NdMVfDJAVhWcb5GOggDSptkalMyXomtluSI0wVD33rIJYF4lNM+yEXUlFHsxoIb3q1CsxJ6spEsQgYtTtdgtPfoqngI3uJK6kMhgRtWUinsq7UvRDSPnW62M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XW8SUNtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63115C2BBFC;
	Thu, 27 Jun 2024 20:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719519003;
	bh=byVO7bSjc2B50u+ghIN9MhH9E2GcieHSkOgjwGtHUxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XW8SUNtvcIiI8nmRrA1S02VstVj/lK+gigPyPlLjuSeN1O5s2NnKa0kZMrGmCCVFU
	 i1O4LPPNgbVbhwVwSbtUA7aanH1yg3ptcOzXd9IUnWQAzQHYzKNB4QeKokNmYQfu7x
	 c4zd/7M6RROnFN+0GZ3Fp4X2cBgQ/MexNgP/c5/k+rwkKm7e+Dz1jkYLBKz1pD1k1a
	 VmRNxmy/n/0MPLLkcdARaIRXfxkZhORhh6+745cBM+Og349VFGOcd9vRPVN89tLNDu
	 3HQB+6YWpGkUF63M+94VibmVCt3/SGCeIu/O/zJ2F+6hz0jEgcjlkkF+7BNCiJzpYN
	 OinbBIIXP8Gow==
Date: Thu, 27 Jun 2024 14:10:02 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, stuyoder@gmail.com,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	laurentiu.tudor@nxp.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: misc: fsl,qoriq-mc: convert to yaml
 format
Message-ID: <171951899762.452992.8697118777293539475.robh@kernel.org>
References: <20240617170934.813321-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617170934.813321-1-Frank.Li@nxp.com>


On Mon, 17 Jun 2024 13:09:34 -0400, Frank Li wrote:
> Convert fsl,qoriq-mc from txt to yaml format.
> 
> Addition changes:
> - Child node name allow 'ethernet'.
> - Use 32bit address in example.
> - Fixed missed ';' in example.
> - Allow dma-coherent.
> - Remove smmu, its part in example.
> - Change child node name as 'ethernet'
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> 
> ---
> Change from v1 to v2
> - fixed warning find by make refcheckdocs
> - Change child node name as 'ethernet'
> - move range after reg in example
> 
> Pass dt_binding_check
> ake ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,qoriq-mc.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   CHKDT   Documentation/devicetree/bindings
>   LINT    Documentation/devicetree/bindings
>   DTEX    Documentation/devicetree/bindings/misc/fsl,qoriq-mc.example.dts
>   DTC_CHK Documentation/devicetree/bindings/misc/fsl,qoriq-mc.example.dtb
> ---
>  .../devicetree/bindings/misc/fsl,qoriq-mc.txt | 196 ------------------
>  .../bindings/misc/fsl,qoriq-mc.yaml           | 187 +++++++++++++++++
>  .../ethernet/freescale/dpaa2/overview.rst     |   2 +-
>  3 files changed, 188 insertions(+), 197 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
>  create mode 100644 Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
> 

Applied, thanks!


