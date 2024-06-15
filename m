Return-Path: <linux-kernel+bounces-215789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBED9096FE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 10:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 653F2283B99
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4D51AAA5;
	Sat, 15 Jun 2024 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="TSYqt/kq"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E705EADB;
	Sat, 15 Jun 2024 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718440355; cv=none; b=miaSb73ujp28Ug1p71Ml687HKlYesbE2LcKA8WJBim8066zVCDMkYKo4pro4vcHZkZFtREnbyIMhT6UXV1OxedH7dczWxuaq7JgA5ObJQUws11eL/jlJGfF8KPLu/Wqn/4qO94cl+nxUvR0cvX/oUIBL1IJ4UH4fGhHGpF9wi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718440355; c=relaxed/simple;
	bh=1O9l+WUXKE/7FORWNlFh9h5ExlqFRP9ae5kLsgYWdWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pakp0JCnAhU2JiUTOHfLRttdK0rVKRqiqfkhI3VeDazKft9uH59edqSMDGhXWXEIGjnD5vFEDFXQ5JDaRC6mgGs0v1i2gHPNuFnSpcVF1frJtFqL7mnqKDuhAmz0b88T4qpbiu8g+rgue1fJcXf9TYu+SJAnMkczdn0WWhJ94DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=TSYqt/kq; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=esTPJsR34LfskVSAlsOexfightQ461XtSlwyYk+MWxQ=;
	b=TSYqt/kqp47452ig3pI/3LR78Yz3K6bdMfpRGm+/fIFvU/Svdea3zpKLtMus41
	c+jakGcFSFdGxPUMH6DQTgRjinSt60ZpeuBUeoWJT9NkZc6fKPPeuXpqIhxRgdH2
	iJVxwRNUL6UY27qOYmtbZFNZiLkhVnWK9T6ejKkI/oaww=
Received: from dragon (unknown [114.216.76.201])
	by smtp2 (Coremail) with SMTP id C1UQrAC3H_WNUW1moiG1CA--.29532S3;
	Sat, 15 Jun 2024 16:32:14 +0800 (CST)
Date: Sat, 15 Jun 2024 16:32:13 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 0/2] arm64: dts: freescale: ls1028a: cleanup some
 DTB_CHECK Warning
Message-ID: <Zm1RjYTRSWvoU9PL@dragon>
References: <20240520-ls_warning-v1-0-6851155356c6@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520-ls_warning-v1-0-6851155356c6@nxp.com>
X-CM-TRANSID:C1UQrAC3H_WNUW1moiG1CA--.29532S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxLvKUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiGBD+ZV6Nn4pWhwAAsE

On Mon, May 20, 2024 at 04:41:30PM -0400, Frank Li wrote:
> Clean up some ls1028a dtb check warning
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (2):
>       arm64: dts: freescale: ls1028a: Remove undocumented 'fsl,ls-pcie-ep'
>       arm64: dts: freescale: ls1028a: Reorder sai dma-names to fix warning

Applied both, thanks!


