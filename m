Return-Path: <linux-kernel+bounces-519331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A548A39BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FE83B781E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1B82417CD;
	Tue, 18 Feb 2025 12:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="sD/l5cBP"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E623ED64;
	Tue, 18 Feb 2025 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880032; cv=none; b=tbjY9jQAiz6rPyhaXXF9nGbVFQ1m6KJ+uzOhKYsUnadZR01DPwpMbvviMjdFu9wU0LRv6FKDhEjLvOh62ImQyTe42BC+7nTHA8IyigbmvCLzUllKFIKZDhyeW27HRQpilssJ3wibdq5YdjaCG7Wfxt3zYVZTKe3sOXjqxtUK49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880032; c=relaxed/simple;
	bh=Fb8o/JjXO+GSvdCQjjMVna3EhgcM1c73oJlmTKklGKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYH/tLdppmVNmvgKjnFgdRP187PsmdKf3RqqH8Fu5Ona6YUPxBmGNr6ORQvmgm9MERkyqg6GMnAc4tBkDdoWiqQSCu/CByOkDLojOi8tJPrsWJvnK9VhKiffJ8Vm3X79bvzURR+p+pUl6OTGsok7fqfW+z5/NUg8r6Nzh1dntgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=sD/l5cBP; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (31-10-206-125.static.upc.ch [31.10.206.125])
	by mail11.truemail.it (Postfix) with ESMTPA id 2892D1F901;
	Tue, 18 Feb 2025 13:00:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1739880027;
	bh=QTqky00lPhU7/+8sytiPJwGu7aJRpm3Cr8JwLkeqWdI=; h=From:To:Subject;
	b=sD/l5cBPRWfS/lFSKRexV/kShRYmknnmIHfAD12vejA3w9eA81xHuH7/dxgtJq+nd
	 GGOo6teBN3s+wyeCepfRbhjOsBHgb02PDGSSSwpy5njsgZG7mUpwakJvnZvQGb3io2
	 +7jzjiqSrrvj35LTBK/Sec0kX2EcWQoiTO9XqeCPBWhI/ZvVuxhf1DfbqcCw9ELEnM
	 HfR3/kDmuFVTspEytIqRK9rYtaBUan5D4olpx+qoAc7LUrU1BK9i/Sji/NqTO1rrr5
	 EvooKZ5eP5+8rExMnU7NvDUFpmZ8Lmw8rYDVVTBhW0menJd+OsGwqwNBcOikZxGSkk
	 Js5NvzhvAUaqA==
Date: Tue, 18 Feb 2025 13:00:25 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v1 2/2] arm64: dts: freescale: imx8mm-verdin-dahlia: add
 Microphone Jack to sound card
Message-ID: <20250218120025.GB15270@francesco-nb>
References: <20250217145744.179213-1-eichest@gmail.com>
 <20250217145744.179213-3-eichest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217145744.179213-3-eichest@gmail.com>

On Mon, Feb 17, 2025 at 03:56:41PM +0100, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> 
> The simple-audio-card's microphone widget currently connects to the
> headphone jack. Routing the microphone input to the microphone jack
> allows for independent operation of the microphone and headphones.
> 
> This resolves the following boot-time kernel log message, which
> indicated a conflict when the microphone and headphone functions were
> not separated:
>   debugfs: File 'Headphone Jack' in directory 'dapm' already present!
> 
> Fixes: 6a57f224f734 ("arm64: dts: freescale: add initial support for verdin imx8m mini")
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Cc:stable@vger.kernel.org
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>


