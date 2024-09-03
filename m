Return-Path: <linux-kernel+bounces-312263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47C969433
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 08:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92E9DB2165F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 06:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127881D6182;
	Tue,  3 Sep 2024 06:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="jB8aALZ4"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD781CE6EA;
	Tue,  3 Sep 2024 06:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346442; cv=none; b=Xpw0Tr3LTvhXSfVVSkK5MIrY5aRVxYtoc5Hs046O9yYOr+PoBdBTl1sV3EaRlNiO9pBPkb1nVTKm0jWR/qFnTEqPIAEEFxhczH80VdBsOBLn+n4FsLkj5u1LcG5atIYfFHfo9JdhKEm321qdQJuhsiscsfmHrvx0V3ikN/e8ACI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346442; c=relaxed/simple;
	bh=vzZGRJnHnnJ4nF6fvhg0LVh342nnaIM+KnZaREPRBKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBUlo1iOHa2AWm+JNgqynY3+wCOmcw6sChz1vpX1coY32TEPRrrB+hhFYNJKLCWUWA3irb6wu0OPHHpxVIY72WXLOkOK+zdrC3Joa6wBpT9AnVxO07IOfs8IllxT+h9RkqRqmiKjhi6DsTlDueAcdwajk+5tl9Ky+2JzTwDlt+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=jB8aALZ4; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=icX4wz1ptS03WIHyVcJpL+Se5k/G0BoefYPCKikMY9E=;
	b=jB8aALZ4eizjTYEq0uTnUB3l3EnAnv0uCx9vw1/3pJcP9SClioWaoZQJMl7iOB
	kEmcefrDZk7r/h/Hl2r2TVes+hPQREciprF3MwHmfKqC7HuoRPeh09up9i/5NLrX
	1zu67BtbVcPoBwFA4yeDtaVlyg9f+3RuBz0dMU8Hfp3rU=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgD3_z9lstZmu1xcAA--.50689S3;
	Tue, 03 Sep 2024 14:53:27 +0800 (CST)
Date: Tue, 3 Sep 2024 14:53:25 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mm-var-som: drop unused top-level
 compatible
Message-ID: <ZtayZbxeZXbRcufU@dragon>
References: <20240902075220.27971-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902075220.27971-1-krzysztof.kozlowski@linaro.org>
X-CM-TRANSID:Ms8vCgD3_z9lstZmu1xcAA--.50689S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4Xo2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgVPZWbWfMaooQAAsu

On Mon, Sep 02, 2024 at 09:52:19AM +0200, Krzysztof Kozlowski wrote:
> The Variscite VAR-SOM-MX8MM System-on-Module cannot be used alone
> without motherboard, so drop the top-level compatible field to avoid any
> false impression that such usage is possible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!


