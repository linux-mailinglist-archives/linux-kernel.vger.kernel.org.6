Return-Path: <linux-kernel+bounces-244605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC28B92A6BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8392283C50
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB51144D29;
	Mon,  8 Jul 2024 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv64vPdr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1578C99;
	Mon,  8 Jul 2024 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454664; cv=none; b=RlgdY8Z7MdzdAXUjLYuo1ptLldTPOqwCDvspPgcOygABn1gU7roPTwFKRUyGtpVlhFdCMciEwJNEQh2C9/dk0ZFm0p8RmEEpL0sB2AIaFEQp40V59q92FHJ65/xCfOni8azsQzEwrRbfyvlb6veazbWLGXiZUa0qRtwvW5LqjEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454664; c=relaxed/simple;
	bh=B+wgdQOGBCJumVIrWn6svGrdoWlDkgcqo510Z+SmmF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEcW1APp1N85J3w6IEONwPokSEufidb0KZA+x2aFgmMcjzMByHuw5reOW5hg2V8zg+O4p6qwy6vwZEkyrrueSp+rc7SvXHYmRXXDdaZT0rPCYRVQnYYmU980R3QcQbHpA9qQ9dcvW+901gxFa84nQJc6RrQl7Ul1isydv7q5368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv64vPdr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D915C116B1;
	Mon,  8 Jul 2024 16:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454663;
	bh=B+wgdQOGBCJumVIrWn6svGrdoWlDkgcqo510Z+SmmF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zv64vPdrwmX3RZ/8XTQyyyazgJhxqmXoVpgxynC7Ym2Gx2kfPGByiTvjznRhIyWjU
	 Yw78ddCOk9aQNqKbk9ErcZh6E36/AQGcPsKsDtRRXic4NuJ41yirYE3ij0OOsXHIh6
	 G2FbBQxAbTdHadfYYJQ0mZIyxKKiGkzM2HTOWFL9swaxQkpu+2lwT5q3BIjH9q/JcR
	 sBm7fdCCoXdZqX74/js6i58mE6060hAT8ZgCR2UCqHMLvZByzZeqQ8jQsD+U0g/xJf
	 MSb0oFXcaEgbirQZKm8hvDmNRFCjwN1xom6zl/mNfI26he0kUX0p5ZWhphdZKirnAv
	 2zDpv6wAZBEcw==
Date: Mon, 8 Jul 2024 10:04:21 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: fsl: cpm_qe: convert to yaml format
Message-ID: <172045465945.3262448.18446369145755550940.robh@kernel.org>
References: <20240703-ls_qe_warning-v1-0-7fe4af5b0bb0@nxp.com>
 <20240703-ls_qe_warning-v1-1-7fe4af5b0bb0@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703-ls_qe_warning-v1-1-7fe4af5b0bb0@nxp.com>


On Wed, 03 Jul 2024 12:49:39 -0400, Frank Li wrote:
> Convert binding doc qe.txt to yaml format. Split it to
> fsl,qe-firmware.yaml, fsl,qe-ic.yaml, fsl,qe-muram.yaml, fsl,qe-si.yaml
> fsl,qe-siram.yaml, fsl,qe.yaml.
> 
> Additional Changes:
> - Fix error in example.
> - Change to low case for hex value.
> - Remove fsl,qe-num-riscs and fsl,qe-snums from required list.
> - Add #address-cell and #size-cell.
> - Add interrupts description for qe-ic.
> - Add compatible string fsl,ls1043-qe-si for fsl,qe-si.yaml
> - Add compatible string fsl,ls1043-qe-siram for fsl,qe-siram.yaml
> - Add child node for fsl,qe.yaml
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/uqe@2400000/muram@10000: failed to match any schema with compatible: ['fsl,qe-muram', 'fsl,cpm-muram']
> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/uqe@2400000/muram@10000: failed to match any schema with compatible: ['fsl,qe-muram', 'fsl,cpm-muram']
> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/uqe@2400000/muram@10000/data-only@0: failed to match any schema with compatible: ['fsl,qe-muram-data', 'fsl,cpm-muram-data']
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/uqe@2400000: failed to match any schema with compatible: ['fsl,qe', 'simple-bus']
> arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: /soc/uqe@2400000/muram@10000/data-only@0: failed to match any schema with compatible: ['fsl,qe-muram-data', 'fsl,cpm-muram-data']
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/uqe@2400000/qeic@80: failed to match any schema with compatible: ['fsl,qe-ic']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../bindings/soc/fsl/cpm_qe/fsl,qe-firmware.yaml   |  48 ++++++
>  .../bindings/soc/fsl/cpm_qe/fsl,qe-ic.yaml         |  47 ++++++
>  .../bindings/soc/fsl/cpm_qe/fsl,qe-muram.yaml      |  71 ++++++++
>  .../bindings/soc/fsl/cpm_qe/fsl,qe-si.yaml         |  40 +++++
>  .../bindings/soc/fsl/cpm_qe/fsl,qe-siram.yaml      |  39 +++++
>  .../devicetree/bindings/soc/fsl/cpm_qe/fsl,qe.yaml | 148 +++++++++++++++++
>  .../devicetree/bindings/soc/fsl/cpm_qe/qe.txt      | 178 ---------------------
>  7 files changed, 393 insertions(+), 178 deletions(-)
> 

Applied, thanks!


