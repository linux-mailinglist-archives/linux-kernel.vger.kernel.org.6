Return-Path: <linux-kernel+bounces-296844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F273195AFB0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3144D1C21745
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF59415F3F0;
	Thu, 22 Aug 2024 07:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fOyJ+Q1T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F201531D2;
	Thu, 22 Aug 2024 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313293; cv=none; b=SXSoPir4IlmI6WJwrHymidabhIEtyKKy7RaasLg3k/5EalUxwVsCN+p4v7PNYtSPVDhb0xB53FzwtwO4IFGa8DLxsceZvYwxiV7BnWeBI08yG7YiTCYtPEI7XgckndP9AJjqnPOt3phk9hTruFE1AMP9NGSV2VcWjAgTb68KHEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313293; c=relaxed/simple;
	bh=IlqsuZ6hZibTkQ0QrRoDCjfhPE1xkMTE176u4XyjfD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRe7ErLcKtqb9TO86rz8GStCobHz2nh/PDfdPdXTKcyrfxp2zJ/E33BRNrQePJHNZXhKgl0BLv5MnGQ4FQzuLarn2XUAzkggz8Z0heTeIflCb4OruIydh1Qm3NfwywX4ZMEdz8R1Bc0j0DEz4gxZEUFRvBUBW4CxBAvXVIZh0KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fOyJ+Q1T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260B4C4AF09;
	Thu, 22 Aug 2024 07:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724313292;
	bh=IlqsuZ6hZibTkQ0QrRoDCjfhPE1xkMTE176u4XyjfD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOyJ+Q1TZsuePJhmNLeq6pJTFrmuYvALVdWM8POsIlBNS1DJO4JTmXyPFUtR+CIYd
	 GlRAAAiAQM0OSX2a+6+kMG9ePTtQoQavtZlUXEuUTiVBzkFKaMiicr+2QE7OMCpjmG
	 8x1qXCZN0AN5tff2SjBuiOaDjZm56cFaDwNmbWBc=
Date: Thu, 22 Aug 2024 15:54:50 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gustavo Montenari Pechta <mrpechta@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] staging: rtl8192e: Fix camel case
Message-ID: <2024082207-backroom-botany-30ae@gregkh>
References: <20240822002733.27609-1-mrpechta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822002733.27609-1-mrpechta@gmail.com>

On Wed, Aug 21, 2024 at 09:27:30PM -0300, Gustavo Montenari Pechta wrote:
> Fix camel case on variable name to match style convention
> 
> Signed-off-by: Gustavo Montenari Pechta <mrpechta@gmail.com>
> ---
>  .../staging/rtl8192e/rtl8192e/r8192E_dev.c    | 32 +++++++++----------
>  1 file changed, 16 insertions(+), 16 deletions(-)

This doesn't apply due to it conflicting with another change that
someone else in this "group" just submitted for this file and function
that came in before yours.  Please rebase your tree on the latest
staging-next branch and resend it.

thanks,

greg k-h

