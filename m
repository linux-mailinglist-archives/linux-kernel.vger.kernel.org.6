Return-Path: <linux-kernel+bounces-555423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C2A5B72C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0F61892B1B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51381E9901;
	Tue, 11 Mar 2025 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="GG5GFchA"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0755E79CD;
	Tue, 11 Mar 2025 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741663085; cv=none; b=nitaBBG2yLivF0xjh1kc+FFK3blFMN1Rraymh73rWo10y3EwG2kfEXHWIefg04WCXy9gmKDNkudu6jZzONMdeItDy4GMVaAZeAiCdZcqrP/AnD73A9aUWVhG3cNCaPW5y9vOlblHOYWQWE0pczTEX8GLkb4rgg9qeTm6TGL0Y2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741663085; c=relaxed/simple;
	bh=ZCiXBTN1s3AS+r3AOui8T9WHCHy18ApE6M8Au11Pvi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxE5n9PtjUjVRMZuGFCnhovR3mnvCO9NrxVvwwu0VrJI2N3whK4c0kp3Hc/qwAFHRi43D9iyGKQJxhoZOAGK+TGQ6boVUqhJzueBs0le7wg5/M9JGEv8Gq4Ot52or15ZFI51ZDVBePFel/ZIPYt0sDlxuxy7JzMcS04U7uhRR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=GG5GFchA; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=Aq8SV11ktNKPubNSIy42XayO8ZwBJ4qz7bkyi8r6F2Q=;
	b=GG5GFchAxpAGPo82H5nUiF2ZbMql+rPtCfMG14RT6PpDA08JFfZvZ8YXfbX91T
	SQcOsDkTcV0GT3KaFF0tBLdC1GEruSaWpfA8NtYG2yGJ9mn00zIenoqdX7j7OQjG
	EMN1ggwZjC7VM/1o7BCBTqN+1Kv0Elzg7mDeoOJrrfNz0=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDXU9o_q89nCfS0AA--.943S3;
	Tue, 11 Mar 2025 11:17:20 +0800 (CST)
Date: Tue, 11 Mar 2025 11:17:18 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Stefan Agner <stefan@agner.ch>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/4] arm: fsl: drop usage of Toradex SOMs compatible
 alone
Message-ID: <Z8+rPvG177Csh2m1@dragon>
References: <20250228151352.91768-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228151352.91768-1-francesco@dolcini.it>
X-CM-TRANSID:Ms8vCgDXU9o_q89nCfS0AA--.943S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUcxpeUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiCxANZWfPo9QqJgAAsg

On Fri, Feb 28, 2025 at 04:13:48PM +0100, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> The Toradex SOMs cannot be used alone without a carrier board, so drop
> the usage of its compatible alone.
> 
> Francesco Dolcini (4):
>   dt-bindings: arm: fsl: drop usage of Toradex SOMs compatible alone
>   ARM: dts: imx6qdl-apalis/colibri: Remove compatible from SoM dtsi
>   arm64: dts: imx8qm-apalis: Remove compatible from SoM dtsi
>   ARM: dts: vf610-colibri: Remove compatible from SoM dtsi

Applied all, thanks!


