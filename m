Return-Path: <linux-kernel+bounces-367443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD069A026E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D428C1C2625A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276C51B395F;
	Wed, 16 Oct 2024 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qjeUi238"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBFB1B0F3E;
	Wed, 16 Oct 2024 07:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063425; cv=none; b=uY+KAmnk8nkjkY+4u6aRhdam65rzxaADAeGJmmDkPXlql0wVCOhJ4/O42dwyAdMB9gR4zJerUU5Pn9ny5oGspVBCYH+RhIPYeliSCG5b0SNNm4ohg7TCHESntsZoN7TVcociPrkbDOU1PJqDt+gG6KchnAxJm9NJMzxUSObifSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063425; c=relaxed/simple;
	bh=LUeb2SKQJR0n6dTUezlJNS57bki8wJKroOxh+PGIkbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HNhmu1prvF8Cszgfb0qTYoKauUXIr3w+6sHm5Ugy/q7I/qjTejws5wECNBxK99fSvwT3uo2gxr0mDpsdyH70/PGpCgExLBaIjuhnFAc6r4jhjp3m5CydEVnDeiTQ1bqXaLogIuilej8eC9HQM4JckQxKThd+gTlkOx96Skj4Mlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qjeUi238; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901EBC4CEC5;
	Wed, 16 Oct 2024 07:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729063425;
	bh=LUeb2SKQJR0n6dTUezlJNS57bki8wJKroOxh+PGIkbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qjeUi238qRNIAPJ4zSi8jfApPfs44wdjQxsvfcg80qZ7QETRTRXXjMQryWEUm9J74
	 RXsmxGJNsZfN+B5rLbgoh9pVgfGU/pdr6qR/9DUESta1I5bie6Z0RJbJXvybJ6EPRh
	 LG680LHnw/lY+/GBP56EaTMlYLFqVybdszJh9psM=
Date: Wed, 16 Oct 2024 09:23:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rohit Chavan <roheetchavan@gmail.com>
Cc: Dave Penkler <dpenkler@gmail.com>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Remove unneeded semicolon.
Message-ID: <2024101657-osmosis-fading-4380@gregkh>
References: <20241016071941.1615135-1-roheetchavan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016071941.1615135-1-roheetchavan@gmail.com>

On Wed, Oct 16, 2024 at 12:49:41PM +0530, Rohit Chavan wrote:
> This patch cleans up the GPIB driver code by removing
> unneeded semicolons.

Nit, you can use all 72 columns.

> 
> Files modified:
> drivers/staging/gpib/tms9914/tms9914.c
> drivers/staging/gpib/tnt4882/mite.c

Why are these lines needed?  We know what files are modified by looking
at the diff :)

Please fix up and send a v2.

thanks,

greg k-

