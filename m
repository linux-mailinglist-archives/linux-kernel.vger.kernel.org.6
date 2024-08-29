Return-Path: <linux-kernel+bounces-306235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ABF963BB9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCD01F240A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 06:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FA2158A08;
	Thu, 29 Aug 2024 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y1mYvQev"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD144145341;
	Thu, 29 Aug 2024 06:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724913333; cv=none; b=CCmV8R8sqkLVq1KNE6piUkdomVgINTzgouDU1QGtb7fwKlKuJYECI9eFL9ZNtu1JrFBD5brW337qftoTsjE+tmGUgi/wKIQiJ/wNyR8Z+Xgx2U+nxOTkRD+OqyGewROhRjDbrki898PIh7alYS6PDNWDFRJmaB2hyu6kpwBJaW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724913333; c=relaxed/simple;
	bh=t90JfksRc0HI8cmA7zBIYjjycQs+kItSj0Ln5dk6f64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJ6KPd/vN4tzkA3Bde31UZJvhCdGLJGdbSz2BZ4v9Nw5ogCYq29+miMCxrNZ2QcybKPCWFtZpVgWXR7OPjxRoWKZCTp+TSDWdacTIbEyD73QnW7H5TOlcDzF8cxH7qDKJo0wYxuzHUVDD1UnYnjjx3DQ9ZwkoE0XfzlON9Chxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y1mYvQev; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEADDC4CEC1;
	Thu, 29 Aug 2024 06:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724913332;
	bh=t90JfksRc0HI8cmA7zBIYjjycQs+kItSj0Ln5dk6f64=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=y1mYvQevdIzvwgIWl6zzQjBN2dMtekoP47ZTDpia+eWyV9DRk74Uc3XucMHPkZAOS
	 8lBLRjC9EqvGSxHVlQJHnlyEVp+f2IP5YX6+WUiW3lm8fn6wycSFqOsAwRweHTPnJy
	 Ds7rC1I81k9BK8uwo6tIcvH3YSpC/rpoJfsuToJw=
Date: Thu, 29 Aug 2024 08:35:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] Retiring from the Rust for Linux project
Message-ID: <2024082923-unthawed-fracture-6e1b@gregkh>
References: <20240828211117.9422-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828211117.9422-1-wedsonaf@gmail.com>

On Wed, Aug 28, 2024 at 06:11:16PM -0300, Wedson Almeida Filho wrote:
> Hey folks,
> 
> This is as short a series as one can be: just removing myself as maintainer of
> the Rust for Linux project.
> 
> I am retiring from the project. After almost 4 years, I find myself lacking the
> energy and enthusiasm I once had to respond to some of the nontechnical
> nonsense, so it's best to leave it up to those who still have it in them.
> 
> To the Rust for Linux team: thank you, you are great. It was a pleasure working
> with you all; the times we spent discussing technical issues, finding ways to
> address soundness holes, etc. were something I always enjoyed and looked
> forward to. I count myself lucky to have collaborated with such a talended and
> friendly group.
> 
> I wish all the success to the project.
> 
> I truly believe the future of kernels is with memory-safe languages. I am no
> visionary but if Linux doesn't internalize this, I'm afraid some other kernel
> will do to it what it did to Unix.

Sad to see you go, we wouldn't have been able come this far without you.

But good news, now you have more time to actually write more code, we
all know maintainers don't get much time to do that!  :)

Again, thanks for all of the work and effort you have done here, it is
greatly appreciated.

> Lastly, I'll leave a small, 3min 30s, sample for context here:
> https://youtu.be/WiPp9YEBV0Q?t=1529 -- and to reiterate, no one is trying force
> anyone else to learn Rust nor prevent refactorings of C code.

No one sane ever thought that.

thanks again for all of your effort, I suggest adding an entry to the
CREDITS file for the work that you have done as is traditional for when
maintainers step down.

thanks,

greg k-h

