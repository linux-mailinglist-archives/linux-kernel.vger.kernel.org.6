Return-Path: <linux-kernel+bounces-394236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2319BAC3D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 06:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC831F236C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 05:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592018D626;
	Mon,  4 Nov 2024 05:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OioPP0zi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C2F18C039
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 05:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730699323; cv=none; b=g0aCY9ZbMlkqxrhv+vgLjYI3N3MvdETzi+ggBCXTmuWUrEupI6XkCcktZdloDz6xAKaJMrcRrSvdy3MOSaof5VQU5kV/OP7W6p/9Xhi1gDegdEhevA5HfbITMT+h0oSSzQLikncPW4fMU7NePFR5M+oqFfQ0pYeaO4Jlr6zIrAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730699323; c=relaxed/simple;
	bh=wAyPzvyusi75sGKuPvls1PsCSRlhQvbCpG1vQQEFI1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7nAJyTdTkfdKEa6GNFhpV3wEc8QhE+TFs59AjfmZJVbHCuWwFqy/9E40hGp6xcEu8tR3tBQMaSqiw+Ok89by4CdEcOGJ452vGF+1j+TYs4Ww+KHX+9Es3EESknq2/UDPnqf7KW1gdm575wQuJbBJblzH2p4onYMpvWmr5ssq1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OioPP0zi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C54C4CED0;
	Mon,  4 Nov 2024 05:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730699323;
	bh=wAyPzvyusi75sGKuPvls1PsCSRlhQvbCpG1vQQEFI1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OioPP0zi/0nBg+lUhuNBa7rxFW1Lzc3R36tLJ4BJWv067IjqUCKXhel4qWAIeLDqv
	 z2YJac0n3tzcHmI2qSntf/sMSEYOOeKM21YCTEsm1nkhzA2bkc9Vc82mrzUeR7D8e6
	 iUCK/zujDNl74HfEA1Ds76Q5+ZKUHoQp6Kg3X/vQ=
Date: Mon, 4 Nov 2024 01:43:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: linux-kernel@vger.kernel.org, git@amd.com, michal.simek@amd.com,
	Nipun.Gupta@amd.com, nikhil.agarwal@amd.com
Subject: Re: [PATCH 1/1] cdx: register shutdown callback for cdx controller
Message-ID: <2024110422-gambling-serve-0504@gregkh>
References: <20241017103216.316114-1-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017103216.316114-1-abhijit.gangurde@amd.com>

On Thu, Oct 17, 2024 at 04:02:16PM +0530, Abhijit Gangurde wrote:
> register shutdown callback for cdx controller platform device
> to handle graceful connection closure of rpmsg transport.
> Also, handle shutdown of cdx bus device by disabling the bus.

When you say "also" that implies it should be a separate patch, right?

And why send this to me and not to the cdx maintainers?

thanks,

greg k-h

