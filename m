Return-Path: <linux-kernel+bounces-395477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C62C09BBE77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 21:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6248AB2124C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5F01D319B;
	Mon,  4 Nov 2024 20:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b="PqhQXep5"
Received: from lichtman.org (lichtman.org [149.28.33.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086F718D63C;
	Mon,  4 Nov 2024 20:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.33.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730750617; cv=none; b=phHR86G5O+/vXLpekAQh6hv0I2J4+nTqLx8WGoaOuUh44lN2rvFv8DXl7HhxhEDfSxYupK4ordK8jifiXSLi6I5Gik+c9ko0bYUTonnu4nEx93piA1lea/TzwS9wcV+9nGCfYrqUdL9VPHcGBo16EQihG0fV089iseyfyKvOcZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730750617; c=relaxed/simple;
	bh=ONRTwPP3x9031bW4ZzBsSBfxi/8TkiMMujZwgDdscQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VS35EBvRAtFnlEdgSde5Ye8VNEdMyVFYvPzfXAM/NS5zWE1KyqBlb6EhoT6CQlBdbEwlunbmyJPdI3y31x9iwvI9ioFs+R2Lg85Oig3VK/36aIioRxg1l9W5wQBdjbXihhGz5x6TC7aqkTcZvoZYFXCXVG8fosy94GqccrRKPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org; spf=pass smtp.mailfrom=lichtman.org; dkim=pass (2048-bit key) header.d=lichtman.org header.i=@lichtman.org header.b=PqhQXep5; arc=none smtp.client-ip=149.28.33.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lichtman.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtman.org
Received: by lichtman.org (Postfix, from userid 1000)
	id E3CF51770E1; Mon,  4 Nov 2024 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lichtman.org; s=mail;
	t=1730750608; bh=ONRTwPP3x9031bW4ZzBsSBfxi/8TkiMMujZwgDdscQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PqhQXep5szQYj2eWWwPsxs/b3ovxUrdylls3fpV/8bXY8KnO8KdS4ytCv5YADoArL
	 DndsI6Rt18jTRE9zTkg5DCHnyNrSxmH+bt90fp5+Ws+Ab1drZl4JkYIPyXSJlkGtlc
	 odeX/5Xw5H4KJJIWiCvFnKXLbfmcfj4tmF7tFQ7nT2BRy39TsxvhvoCS2MxVvsxXGa
	 0nFhS4FIglizvHDc/JpGozpwnk2pREdsTZBCSHfKpLwo1tmx1ZZCNib4vwpdL1F/GT
	 HsoBsMHc9suYLfkhP5dxZrdiAPrPBp6eUeqbFf0+6wBoxwj+v88Jx+2a+fjxxq0jwG
	 BENqBFnf4OmYQ==
Date: Mon, 4 Nov 2024 20:03:28 +0000
From: Nir Lichtman <nir@lichtman.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Fix incorrect paths/magic in magic
 numbers rst
Message-ID: <20241104200328.GA73996@lichtman.org>
References: <20241025135128.GA879576@lichtman.org>
 <871pzq94hp.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pzq94hp.fsf@trenco.lwn.net>

On Mon, Nov 04, 2024 at 12:35:30PM -0700, Jonathan Corbet wrote:
> Nir Lichtman <nir@lichtman.org> writes:
> 
> > Fix some no longer true header/c file paths and correct the BAYCOM_MAGIC
> > value to be decimal as in the source instead of incorrectly hexadecimal
> >
> > Signed-off-by: Nir Lichtman <nir@lichtman.org>
> > ---
> >  Documentation/staging/magic-number.rst | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> I've applied this, thanks.  I do continue to wonder about the value of
> this file in general, though...

Agreed, it feels pretty much like abandoned book keeping that gives minimal
value since the chance of magics colliding is slim, but I think the general tip
before the table of magics is pretty good.

What is your opinion about integrating the tip in a different page and deleting
this page entirely?

Thanks,
Nir

> 
> jon

