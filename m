Return-Path: <linux-kernel+bounces-411037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C89CF20A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CF7F2963DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84641D63E8;
	Fri, 15 Nov 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PAokyNcS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2954C1D61A7;
	Fri, 15 Nov 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731689161; cv=none; b=IfOclForH+jKLuS+/6sOBpk25Hg8z6nsHPirAOBc5Fc//qaPNM80PQ/prCwMxxSS0hQ9weMnuLtGHZHUia1vbQPZ5Mv2ln8DZMxluS2ubYANjpl5DTXqC4rY1yjq7FtgXwMOjNcRdaQTBgDVnB2KkFON9PWzWarYCqcCEB3NnJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731689161; c=relaxed/simple;
	bh=2ICMZThVo15HL1UQVzn5RMDnL/YTlWwWLwW2x92jGjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XycY7Lx11fzV136Pok3ppbInrS7VSmBXHykQD3wvm6wqCxMQElyDF1T5MrHUp03/bNTlSKWCIp5iCLsRtwXdg/NB+xRVijLsooz28Vlc1ZsuWzEmvZYEftMwKCmsbhZvlpr4I6id2TgCz5MJ/b22qvcPUl7kmsf5iGQpcq2G1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PAokyNcS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C844C4CECF;
	Fri, 15 Nov 2024 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731689160;
	bh=2ICMZThVo15HL1UQVzn5RMDnL/YTlWwWLwW2x92jGjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PAokyNcSFnKtmgSLKMCl0KqIxF21hw5JZyk4VqiKOiCuAFChuGVWqwXNFL940CyUe
	 Q6uaLRw4kXZjWnC/YktuiJ7u5hFP0UuTb6W5KtKUz13Ap2oA7vP/6DlL1J51ZLeCSZ
	 xRNpG0trtr25M52T7a9nXTQdyP7cuElzvQnilvLM=
Date: Fri, 15 Nov 2024 17:45:29 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 6.13-rc1
Message-ID: <2024111520-turbine-slinging-a351@gregkh>
References: <ZzdTyegI_dodavrc@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzdTyegI_dodavrc@hovoldconsulting.com>

On Fri, Nov 15, 2024 at 02:59:37PM +0100, Johan Hovold wrote:
> The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:
> 
>   Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.13-rc1

Pulled and pushed out, thanks.

greg k-h

