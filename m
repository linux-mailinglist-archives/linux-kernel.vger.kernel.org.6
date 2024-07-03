Return-Path: <linux-kernel+bounces-239563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F112D926227
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 15:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC4728529C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 13:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3161817BB2F;
	Wed,  3 Jul 2024 13:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AGj3r5lk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F817B4F7;
	Wed,  3 Jul 2024 13:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014432; cv=none; b=XhWCkmV6byex+/dffTf6tthtqOg4Qzynf/7krP+wO2wEUiCWvMgWgauchrUk/6CJ2oBDLlf/RtCf75mjLlsg0ZtTPsfU2Zrqi+5SDaATtRkxypfQF5t0tibE3M2GCI+MZDtT3TZBKT3TOqh5dmJh3J/Uw0hKdFhWrIkooD8j2Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014432; c=relaxed/simple;
	bh=8ZnzcfNK3UH+1XPyWcjQwMJ96TI+DcIZPyiqo3RE3Yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+v0xzYFCNJLm2gj4T143Iz8DvNfb+sSr6vJZeekAq7V85fmC96urnhi82MkZI8fMI5o+3Ls1WThXMa9JQHcjPSj0O5jF7Drp9heJKy845kD5ItZhxmaD1kvC2FYSXCmS2QdWeg0qsHNi02lBPNQTAAwpKdf5Mae7Yumcm90N/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AGj3r5lk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F89FC32781;
	Wed,  3 Jul 2024 13:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720014432;
	bh=8ZnzcfNK3UH+1XPyWcjQwMJ96TI+DcIZPyiqo3RE3Yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AGj3r5lkZvD0O7EyMDg1fMtmzOiYAVveGLRNLlohNSQwmKJiq4VaH1A6Omrtpm3vv
	 FdG9UCQlAvq6FH5p37xcLKjKl8sjnDDUjcq8Y+pHwfTKo0rMXDoo6UkapK+TAX0fgB
	 CvabU+ra8V7amwLKOxKR+SUyYXbzgtsiso5VgV7c=
Date: Wed, 3 Jul 2024 15:47:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device ids for 6.10-rc6
Message-ID: <2024070301-shaping-degraded-869d@gregkh>
References: <Zn6F8mJteD81GsMV@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn6F8mJteD81GsMV@hovoldconsulting.com>

On Fri, Jun 28, 2024 at 11:44:18AM +0200, Johan Hovold wrote:
> The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:
> 
>   Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.10-rc6

Pulled and pushed out, thnaks.

greg k-h

