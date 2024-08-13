Return-Path: <linux-kernel+bounces-284380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0494E950059
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B968E286861
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 08:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A7C170A24;
	Tue, 13 Aug 2024 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="dhILZjdZ"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B4013B797;
	Tue, 13 Aug 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723539035; cv=none; b=IzyxKy3aE8UeQRG5AOWOHjtXWPwfyn56mHvKyRQ3egngmnOR9dMsiLC8QF/V/yNfp3FF0zpQLVBzyYDlSb5Jp7A9sOfvqFDJ0J4aruXF/9LixoMvt1Zs95BKpkDyo7YT8veMTeQVF1oGE/ec5JJtPsAwJXAUXr5G9KeG/3K0/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723539035; c=relaxed/simple;
	bh=V5f2/mX2TjYFDKHk6f2LngDd0CghKPZbUuFv6a+lFLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+dzCGyCKSFeRMtkvKOn1VXdPb61o+BH2ladIvitWRYmJwprEFIqiY7DELanoptlczqUPoF3Fk2V0rra/f/Gq2XaScpgya2U8Ml56eVagGS0HIoTHYqzko4IL5wtTu6DlDZRAvd6TjcRt/i8m4+KhAYHIE6DruNH1cDkR/XuUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=dhILZjdZ; arc=none smtp.client-ip=220.197.32.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=wHFCBUPgrhC5PGF9916rmNvU+re2mY1CKErE9Zc2vKg=;
	b=dhILZjdZb16nHX8i/kZc9nWwniKg2nXw7aFgtueg5cN8n6bXLNYd/fSzh6iTSW
	ZKDFTlPkLi8sI5f94D/HQCkPWiyap7T/aTCcqWikD9aMdgRLPIp+jb3QUsV4BJtp
	5PipmbzyQYUexN8uyfEKrvNI5OtVUMTcwyxwx7uoF+AMA=
Received: from dragon (unknown [117.62.10.86])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCXXY80Hrtmz6BiAg--.40026S3;
	Tue, 13 Aug 2024 16:49:58 +0800 (CST)
Date: Tue, 13 Aug 2024 16:49:56 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Teresa Remmet <t.remmet@phytec.de>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v3] arm64: dts: freescale: imx8mp-phyboard-pollux: Add
 and enable TPM
Message-ID: <ZrseNLMfIO7jxxkT@dragon>
References: <20240809-imx8mp-tpm-v3-1-c1cd80deff16@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809-imx8mp-tpm-v3-1-c1cd80deff16@phytec.de>
X-CM-TRANSID:Ms8vCgCXXY80Hrtmz6BiAg--.40026S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVco2UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiERg6ZWa7DgU1MQAAsE

On Fri, Aug 09, 2024 at 11:02:31AM +0200, Benjamin Hahn wrote:
> Add support for TPM for phyBOARD Pollux.
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Applied, thanks!


