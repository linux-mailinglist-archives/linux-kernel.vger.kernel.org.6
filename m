Return-Path: <linux-kernel+bounces-371461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EA19A3B61
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679791C23EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E92038B0;
	Fri, 18 Oct 2024 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SkQtzmtv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A9202F8F;
	Fri, 18 Oct 2024 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246865; cv=none; b=OCLVn7QnqS9JtX9mK0jyedCW7m+zc/JLfGxY1Bmike5wRfE84FXyT1Alq2WS7DFuUGn2MrC4F4vqDnD9V8d0ZP2x1RDiE0Q9fTn8gI6E7EEBH8PDaUZPNRx0tQWVcc+qwislqOf9DtNcr9S8l6giheFUG4qfgqMu8xxWgCoVGIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246865; c=relaxed/simple;
	bh=Uaq/N6Jb5Yt870xVMZTOdaTZp4Ggv8FJSAnseWbhAdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeSHnlN8P5u9/Z5Bb1YocjxEsd204ggC/KJByZi4fHMN5Bexl62LW9zvFiDeH46qUXoaUF0SRlNxpTHDdn4t5W3ZmOzCGyQVke0cCu9X/3SN6x+RmKXJVzA2ofZTbKOaFcDUYJKTV0PTtXbDxJ1824d0DwSVNKauDT9q6e7xqi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SkQtzmtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F3EC4CEC6;
	Fri, 18 Oct 2024 10:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729246864;
	bh=Uaq/N6Jb5Yt870xVMZTOdaTZp4Ggv8FJSAnseWbhAdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SkQtzmtv9e7ERzCKSTCe6kJMaZLOlJny6nJKg2FtvFRr6gkHNSW6mcW1EXlMW3iH6
	 T+e/RZ/wFuXd5G53vCy7Lw/wKjg9373WX9neyCNvt43op7c0fsT9QdtVsy2Eo9DIeg
	 Ahyh+TwKxk+6eXXDJYcveFOL3e2+/J3FyumaMNw4=
Date: Fri, 18 Oct 2024 12:21:01 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device ids for 6.12-rc4
Message-ID: <2024101853-mosaic-failing-6f12@gregkh>
References: <ZxIzE4E8iwpVvpFj@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxIzE4E8iwpVvpFj@hovoldconsulting.com>

On Fri, Oct 18, 2024 at 12:06:11PM +0200, Johan Hovold wrote:
> The following changes since commit 8e929cb546ee42c9a61d24fae60605e9e3192354:
> 
>   Linux 6.12-rc3 (2024-10-13 14:33:32 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.12-rc4

Pulled and pushed out, thanks.

greg k-h

