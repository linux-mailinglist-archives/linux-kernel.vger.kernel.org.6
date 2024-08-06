Return-Path: <linux-kernel+bounces-276723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2463949792
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 20:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35E1AB24070
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF017E0F4;
	Tue,  6 Aug 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cAfd8qjd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136266F2E6;
	Tue,  6 Aug 2024 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722968919; cv=none; b=b/yjxCReubEWXA1OgQm5NnAAlE4xsZLCb85zSSZaGjGg3KTIoUnisTf+WumKXeXxw60rFQrUfCpHAour5G6WrgsWtubD9ifcDDl9dmaDDfAPPTV2XgagE4VYUcc8JiMcoIzdhCAa1mMRN+aeDI4BCY+46imB7Z9IyBn2XPID5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722968919; c=relaxed/simple;
	bh=RcyUbLmkg3x/ulEnE34/+p9Y9xgybXLeAECghUBIBCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blZFbSnYF5ugGxQLkGruYcXwWcsh5fdwbQdwP8moLxssCHP8LhXYuJPNmddfJqu9XwFAay2hVTeXVKVfpEaJz78yLLLC8PBusu4+bXKCzHcZEAtd2To6oOGfFAVjNrjDuuxgZeW73kbFK3nTKYgozKhjSs2MseIMGfvhm4XJGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cAfd8qjd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE84C32786;
	Tue,  6 Aug 2024 18:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722968918;
	bh=RcyUbLmkg3x/ulEnE34/+p9Y9xgybXLeAECghUBIBCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cAfd8qjdKq3DCfRyuOXffBVGhfLx3GlKu++u5b/qavxcg7qaJsO9ImhjxycrlqXi2
	 tnijsjH05oM6F6Rxo0bd6fWP5Fon1R2K6QSZeIsUocPWpFMGlb1iw/7V3WBTkgLXE5
	 PsUMmuvhdJynuPKJrCdxYBsh3PqytkWzGARSrX8F/5SrpHZBWX6IaxFJ/3VxKV2D7P
	 fTZVG5okIDrU3O5bmiv0eC91LpBXi+laSYR6zIAi/dvwbk4ca0FJ5wHN6+Fiw6yUgw
	 c9Lfvx7xAP30EEGMmj7RK9Fxdes6ghtxACF1QJCn5NbSS7jr7eQwLDPGEEzT/pYSn0
	 /2HeEXodIEeyg==
Date: Tue, 6 Aug 2024 12:28:37 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] dt-bindings: soc: fsl: add missed compatible
 string fsl,ls*-isc
Message-ID: <172296891618.2031313.14197833960690004919.robh@kernel.org>
References: <20240806162121.2996442-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806162121.2996442-1-Frank.Li@nxp.com>


On Tue, 06 Aug 2024 12:21:21 -0400, Frank Li wrote:
> Add compatible string, fsl,ls1088a-isc, fsl,ls2080a-isc, fsl,lx2160a-isc.
> Fix the below warning:
> arch/arm64/boot/dts/freescale/fsl-ls2080a-qds.dtb: /soc/syscon@1f70000: failed to match any schema with compatible: ['fsl,ls2080a-isc', 'syscon']
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - fixed typo lx2046a with lx2160a
> ---
>  .../devicetree/bindings/soc/fsl/fsl,layerscape-scfg.yaml       | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!


