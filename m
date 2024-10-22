Return-Path: <linux-kernel+bounces-376681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C029AB4D1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A4CF2851C9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BBF1BCA12;
	Tue, 22 Oct 2024 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="bsfdJYXd"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097CD4438B;
	Tue, 22 Oct 2024 17:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617389; cv=none; b=LuFeCmnoV3Jjx3TcdlvMr0Fa4818piwU5pPS48QwD69HW71H/gh5+Cog0ujGG+oKQpAsVNVqDMwAk91ZuGuzvWMhwT0N/I8dSrw6Wwfc7KwndQZsvT1Qch2s7jSK0qkARELYo1sDj3h0A1u4A3hBz3CPTwiqP3cMWL3y0s+b4Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617389; c=relaxed/simple;
	bh=lMxhVUL8QcioR8QStO8yoHWsojdAWhc6MwdJWkMWZU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7/pdA6cHZkRqlFuTEe0tbbyDhu9GehHmysvmRIsdLO8bm4KWA1vaQfDd/77uUxM8xcn6AWxTUI3++sKWTT9n01XEVUKGKpmZaBgZg+OmQkJ9kIZ6TDyLoYwHLorvXzXMdE58rAKys8TdRI3PP+IURMVvOlskZ7JEUb8dAWgA7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=bsfdJYXd; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 81B681F9B6;
	Tue, 22 Oct 2024 19:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1729617385;
	bh=kpepVEbWAcNZtN//yj3scYliR7FFdifKdw/IM/nj/II=; h=From:To:Subject;
	b=bsfdJYXdq8wQz9TZMQtiTjo5QRA8PeAvsyYHofTwe9c/FHRWiuk2odYGUW/ydg6Xl
	 GhEsHMM2b5zt+jiox3RX8URmBPJQC9IWh77Sgz/HRjdWvtBsXKZRdWog4rqu4JzZrM
	 JbtM6BcucOXt8sC5Dcmmgg4BQxAh4hLF7mU8gYuHJbQXHVer0YWltklPjEPFzkgTGH
	 AcM3bw7VZxhmeZ7lXF41ZeSJnxQL6rlBrkMC9ogrvTVs7ma20jN0j+eZWHTKfjqdLO
	 IVujgfz/Zst1G5Fw96IhZV9nwCR0uBb19fJctxH/0EI8uphP/+T+ZWcFcxovo6S/g5
	 gK2opMKSz1BEw==
Date: Tue, 22 Oct 2024 19:16:20 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Frank Li <Frank.Li@nxp.com>
Cc: shawnguo2@yeah.net, conor+dt@kernel.org, devicetree@vger.kernel.org,
	festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v2 3/6] arm64: dts: imx8qxp-mek: enable jpeg encode and
 decode
Message-ID: <20241022171620.GA69574@francesco-nb>
References: <20241021163437.1007507-1-Frank.Li@nxp.com>
 <20241021163437.1007507-3-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163437.1007507-3-Frank.Li@nxp.com>

On Mon, Oct 21, 2024 at 12:34:34PM -0400, Frank Li wrote:
> Enable jpeg encode and decode.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> change from v1 to v2
> - fix typo deconde
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> index da8ceffdc7212..0d14b0def19d4 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> @@ -337,6 +337,14 @@ &cm40_intmux {
>  	status = "okay";
>  };
>  
> +&jpegdec {
> +	status = "okay";
> +};
> +
> +&jpegenc {
> +	status = "okay";
> +};
> +

Just wondering, what's the reason to not enable those in the SOC dtsi?

Francesco


