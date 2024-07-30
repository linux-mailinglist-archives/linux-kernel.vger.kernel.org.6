Return-Path: <linux-kernel+bounces-266927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB809409BE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 09:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B32B249CC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E38190663;
	Tue, 30 Jul 2024 07:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wuiHTLrV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BCE186289;
	Tue, 30 Jul 2024 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324249; cv=none; b=bShLtfKFKa76GKDhPIo4oCIfKGi/l+2mqIS2iXEQqkH9ttCTgcJc1YDWD3BbHLlOa2eNCTiwvE7DbKjrPceZtxHkVBGsDHxUcGGHvGgBQZFk97diebnoLVoA4ELHVjaDplBzuZyVWlu7IooXlGCNt1wcnMipSxtn+s6hI0naT2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324249; c=relaxed/simple;
	bh=0uhg3b9ZXm5z2xcfiFbaVZgWd444fs/d5FMpmvrgCn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz9X4pgZyTqN8TUABFqNzIcBjeyqnwXlcsw9rJ/lMwf6xxr5os8cSeMoVOBqQZ2GpyEXhdFGnFYn0XJb3mhcdSwG2nmgWM9ocSlX9lhU6Yx2Lp0q/S/AuNVeltvbv4ZECHJKnPCajbyJubEzwKlKoQCClZPJjBXajx5Jnwos6uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wuiHTLrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10ED8C4AF0C;
	Tue, 30 Jul 2024 07:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722324248;
	bh=0uhg3b9ZXm5z2xcfiFbaVZgWd444fs/d5FMpmvrgCn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wuiHTLrVRl7XIvHqX4aH0AoaOF2EPym0cPoHLzGTDNsmd78glkw73b/jk+jz49nRI
	 4U1VFDTARQ/QVHb4NmNS6fkm3PTA3W052RQYPcg7Z3AzukQtB+/hJj0rTIaSXrly5J
	 BIDZxYLMKwZ53VTMMDmU45VY+Kk51Nxh783i/b6I=
Date: Tue, 30 Jul 2024 09:24:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht, helen.koike@collabora.com
Subject: Re: [PATCH] staging: media: atomisp: remove trailing statement
Message-ID: <2024073041-aware-flavoring-d3c3@gregkh>
References: <20240730071808.35591-1-sskartheekadivi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730071808.35591-1-sskartheekadivi@gmail.com>

On Tue, Jul 30, 2024 at 07:18:08AM +0000, Sai Sree Kartheek Adivi wrote:
> this patch fixes the following checkpatch.pl error..
> ERROR: trailing statements should be on next line
> #48: FILE: drivers/staging/media/atomisp/pci/isp/kernels/anr/anr_1.0/ia_css_anr.host.c:48:
> +	if (!anr) return;
> 
> Signed-off-by: Sai Sree Kartheek Adivi <sskartheekadivi@gmail.com>
> ---
> Just started contributing to the kernel. please help me understand my
> mistakes if any.

Please use scripts/get_maintainer.pl to determine who to send this
change to (hint, you didn't catch the maintainers of this file...)

thanks,

greg k-h

