Return-Path: <linux-kernel+bounces-296830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E6295AF92
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804D71C20F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E16E1537D7;
	Thu, 22 Aug 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bikXQYIG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06E433EA;
	Thu, 22 Aug 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312760; cv=none; b=eJM32JVVXXq92LXPTM1U1KjNH9GQQ1mLlrgnqrS4ebs2ANMEBinBgVgL2a2Jf2bynvJrTpi9JllbCIO6RXJzGAhBFKjfAnBloSVPgBv5PuE2v8NDOrqNgwJ045DaXHcCavOIFej5bXYn172ZP+0AQt4kGQGoS4RJbYB162hZU+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312760; c=relaxed/simple;
	bh=EtGiTuipBV5M+b+mFE0QqokGSMKte7x9MZToYZftiFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGmElNNMoExp51MuBBDPzRTNS3Vf8hcZC1Qa6rwbvM+lHgI9kdk3DR0bTT41HaN/r673OGVazF5KC1XU2s1hiOvXu6EVHKwm2H5jecD2XK8wHEANA2K3UNYEDRn8HBAGR6hjP+Ng6cJqsGK0H/qrlD/bp3K3DaQRrCXquWastSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bikXQYIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE18C4AF0B;
	Thu, 22 Aug 2024 07:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724312759;
	bh=EtGiTuipBV5M+b+mFE0QqokGSMKte7x9MZToYZftiFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bikXQYIGkpyAGuOqvgohpcFyKGZrEnRLXfWMBayzFj9JSp83abbYKlL++25Q7sXPa
	 z5t9bivYtOokhwu31qYW86PbQ3pjFw8zwu9Zotn1eQCm2fJB4qN7mM8P7hSUl/azoz
	 oq1LReLK7MF8h/D8Z+5XYLlaVW/j7PSw0/t5HEvg=
Date: Thu, 22 Aug 2024 15:45:56 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hans Buss <hansbh123@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH] stagging: rtl8192e: fix alignment parenthesis
Message-ID: <2024082238-worshiper-graded-3db0@gregkh>
References: <20240822004939.153517-1-hansbh123@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822004939.153517-1-hansbh123@gmail.com>

On Wed, Aug 21, 2024 at 09:49:34PM -0300, Hans Buss wrote:
> 	Fix alignment parenthesis in _rtl92e_wx_set_encode_ext.
> 

Why the indentation here?

> CHECK: Alignment should match open parenthesis

Also, your subject line is mispelled :(

thanks,

greg k-h

