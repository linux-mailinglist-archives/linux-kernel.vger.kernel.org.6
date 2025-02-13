Return-Path: <linux-kernel+bounces-513280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0501A3485B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 16:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731AC16A3F8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3CD31DDC23;
	Thu, 13 Feb 2025 15:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hGUBjiAF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE8194080;
	Thu, 13 Feb 2025 15:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461178; cv=none; b=Dz4YZKPorIHSq8RcMR0H9LCVyT370Mvv2HkTQQIOwtPfqtre5Jx1D0kh5hd8W7/erVfQg6ki1D8oEq0qyARlirtCu5xqc5LlH67P7JtJwOvlDO3cNgSqZWqQvPXDvXRVqyirsM2R9e+IA3a4adE4/s4436lV3L9fxDSzhI7z6v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461178; c=relaxed/simple;
	bh=JXYBC5XLn+VlNOg2gO8y1rGAg15IXnahHcUZ8lHEyac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2InBvuPQaqhdWdw0OXfRgl5C/ZSHthjZ9JStggQMG7d5bc7/vVFO6NLEmBlzGf8UVfJV31g6TYYei0Lex8G/WEItO/p2Dmsyyj2B/s3KgFa1urW1CxmHHlfve/p2P2D+y9RiIlywUhTn5sc5lRKg8QJZEmdUqHUCnAGyOK3lxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hGUBjiAF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61867C4CED1;
	Thu, 13 Feb 2025 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739461177;
	bh=JXYBC5XLn+VlNOg2gO8y1rGAg15IXnahHcUZ8lHEyac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hGUBjiAFAzuFRDsefj9jqv0T0miETVgXqkAfNjLka8gfUdE4CBVrAlgnT9FAq1I4c
	 pxdHFk153wOWryPRP8KPSRPlwvzhNf6XPNkswpaPlyR35cWhSDxajJ3rI8ibvzPcvY
	 /z9Dl9TB9JRr1nNyDETAoU+T+DBEy06UqhAd8Tns=
Date: Thu, 13 Feb 2025 15:41:10 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial device ids for 6.14-rc3
Message-ID: <2025021303-lumber-lushness-f839@gregkh>
References: <Z64AhiS7ENsTHAPb@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z64AhiS7ENsTHAPb@hovoldconsulting.com>

On Thu, Feb 13, 2025 at 03:24:06PM +0100, Johan Hovold wrote:
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.14-rc3

Pulled and pushed out, thanks.

greg k-h

