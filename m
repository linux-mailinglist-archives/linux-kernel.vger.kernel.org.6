Return-Path: <linux-kernel+bounces-372809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB7F9A4D96
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 13:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC41BB25C67
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 11:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28D1E0B8F;
	Sat, 19 Oct 2024 11:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Cnxhyzu7"
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764471E0B83;
	Sat, 19 Oct 2024 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729339140; cv=none; b=ptrEuah850zkgxM+KAZSdWJ/QsZbYkUBNFCwLNbkNnxqjqzpj0hZiTqPEr0kUT3I9tXfseOcWnN/lh81UtOZNSQ7DIcnN+2v4SE6/YNhwAhPNkgkhgv5GPd2C+cYHqOu7u+s+RX90JOZpepChPUmz56bX+faatt9Gf/kvO11Ur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729339140; c=relaxed/simple;
	bh=Rx2QSXIFvXzwubwtDo40/YkX5ETE3HN3I74n6hbnyZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvJ63hUBfJsNaEvChsNYrZuUpYSk4bbk9th/qXFEhz64gtOf7RgQCOgFiLQMUxeyZCPmloAQyKPqmIOi7714vQw03uGnlkWhBAQ49x+MKBazvDbu93DkBFit0CqAwPbtY6BHAVFJt9UTSIcF3+kvQLyeaIxF1QSd4YdxUGjy9rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Cnxhyzu7; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=20MYQxjL7WtkK1J1xglr5JfbDuyUPR3dOaf6k2YM+nw=; b=Cnxhyzu7JbApoynlotLJWnnDef
	9Y8/Q4pFLlxzYfjCn7H2cYyBN+f5AkGVtnLFQiEgff/3cT3h12FUmpfCQbMCFRTIhhEgnfHWlJ0uS
	z/4wx9ZEnv6bpax/0EKRDwKzWxZzvhLKojaTZNlg2foFLSoPeh33PSzN34IW+htfLHuhljmY94mxq
	IDK//sfMc5QkpM44IJpfgW3vXu7CiPkeizvOhBUg7fMtb4oz3Wp9TrIDRYPUDMzg3CEnwFdUVdoJu
	Q55xQj4wTNBzYOkKBCY0f8XLrqQ8JjRiTk1MZPorsBFDgkzW4QNsqe4WbcIY2efs4pSxzrpfB8uFR
	UyzSrHkA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1t286e-00AaPC-0f;
	Sat, 19 Oct 2024 19:58:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 19 Oct 2024 19:58:52 +0800
Date: Sat, 19 Oct 2024 19:58:52 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-crypto@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] crypto: crypto4xx_core: avoid explicit resource
Message-ID: <ZxOe_LN9iEhH3w6_@gondor.apana.org.au>
References: <20241010194821.18970-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010194821.18970-1-rosenp@gmail.com>

On Thu, Oct 10, 2024 at 12:48:20PM -0700, Rosen Penev wrote:
> There's no use for the resource struct. Just use
> devm_platform_ioremap_resource to simplify the code.
> 
> Avoids the need to iounmap manually.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/crypto/amcc/crypto4xx_core.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

