Return-Path: <linux-kernel+bounces-325198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 354C3975604
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 16:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673C51C26781
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953F11AAE3F;
	Wed, 11 Sep 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7H7aD0/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A3C8F6C;
	Wed, 11 Sep 2024 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066202; cv=none; b=YdVPvzN9d8iDzNFznXd/m40QNqN2yni9abSMNe1M8s36aXiyYtT5pwqNLJSeNM5964cM+cFMP0dplxeV0NoZ7VgUeOI/A1G9pTHOkT72Dw5y1IMi6ugsii/G+CExVoa0mKjGWysvLAFIS8oh1eK+Lf10OG9bv8jhOAZI2S5+0Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066202; c=relaxed/simple;
	bh=cB1B0m/qDw1LnDmVc7WFUJ6RzbWUKISTQB1rSlgyqKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVplKqKWzg00iD7Vok9mfL9y05gjGwFhvZXLI65cb0XLCpeRkWITUeMAzOFUjKqiDtx4OYRE5bTljBKwG4Usk3g03vjU7LNBvaM/QtJ9lV0L/GPjnYvcBMFC74FT+DScF1P9EgD1OUG/LGqJsNFp74mCEMzi+ddAsUiCgd9nUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7H7aD0/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1FA8C4CEC0;
	Wed, 11 Sep 2024 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726066201;
	bh=cB1B0m/qDw1LnDmVc7WFUJ6RzbWUKISTQB1rSlgyqKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7H7aD0/of8DxH8Ly5nlOkaVNyIvCPcMkWeHMmueIfANBXUIzbt/JGHxvAkCGV8e4
	 p7um75/VFdygCHjnPz+hVuvQLlb5OoOdRd2DNy31KGK3OOB6lLMci7j3esJkMaSTKa
	 ycRDUJB/AnG/uvYGl9GSbr3ENXhtLYMlda0fqScxxFtanyxjRvE3iLRtW+8RA5g1ce
	 +f5/a/JJd0o9ZOy4DJlgHhVjwdXK/b8ZCQyI5jcOM9fhXJNgulwppXgnIk498VM7Jh
	 IDEkiAFox5NWg99wZj+JPbKbmDawDQzbnTpuQfs2iDdjv8zf1KNBk3+JVbIBrzYV7+
	 8mFLzhLJ1R8aw==
Date: Wed, 11 Sep 2024 09:50:00 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] dt-bindings: memory-controllers: fsl,ifc: split
 child node differences
Message-ID: <172606619741.164780.12915573740224186957.robh@kernel.org>
References: <20240909165358.2384975-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909165358.2384975-1-Frank.Li@nxp.com>


On Mon, 09 Sep 2024 12:53:57 -0400, Frank Li wrote:
> ifc can connect nor, nand and fpag. Split "^.*@..." into "nand@..." and
> "(flash|fpga|board-control|cpld)@..." to better describe the child's node
> binding requirements.
> 
> Fix below warning:
> arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dtb: /soc/memory-controller@1530000/nand@1,0:
> 	failed to match any schema with compatible: ['fsl,ifc-nand']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
> - add pattern property for fpga.
> - fine tune commit message.
> Change from v2 to v3
> - add partition child node for nand
> - Only partition property is used at ppc
> Change from v1 to v2
> - add address-cells and size-cells
> ---
>  .../memory-controllers/fsl/fsl,ifc.yaml       | 32 ++++++++++++++++---
>  1 file changed, 27 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


