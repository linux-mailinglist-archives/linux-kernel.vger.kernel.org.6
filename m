Return-Path: <linux-kernel+bounces-247623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBCF92D219
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCDB1F21FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C26519246D;
	Wed, 10 Jul 2024 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BmPIou20"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27B1191F90;
	Wed, 10 Jul 2024 12:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616371; cv=none; b=X0buJIYQwk5sNquPFISpvT83mHwPT5r3Dja7253jhoBPI9oLp1lam0Uuwosqm+diCCt6lcyIrVWFzKZ9YG1ZftgBLqIdY1RLyZAWwOZ0p6HlgGwRa38eTupMp/TLMBbBUyLc7tuYaQ2G0vcIDhbTyZA4ruJy6cdd3oyvErslNkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616371; c=relaxed/simple;
	bh=VRHPKpwkycL0bwJgHfbOMhdmOr4tvIHjVAVo19p2i3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pofs71p/vDCH3gsiud4PFGzu2a8JuRobdLsK6lAbsR1mBQOkPCGqlL6A+i0KdL/YgY8QRgFVrYno+V/cV5iLHVL9cBaQBW6iVM7cQ8VRHzcXHZJ/Nt1sTvdYJslkCkBl4HzFonielU/0li/tDozqaBfFBwXYCQdEtHC/gUhuUjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BmPIou20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B50C32781;
	Wed, 10 Jul 2024 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720616370;
	bh=VRHPKpwkycL0bwJgHfbOMhdmOr4tvIHjVAVo19p2i3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BmPIou20C0jJoRbT9eMu3nbx20vswKyyrH0V/6c6+ZrYTAe656BY3ZE66pn6XfxnQ
	 Zz2855XjwXZ+E1Kd4AqpFYYsx9J2nGGZWdxXDjI682dhmIQZE71Wpjawawqzqe44wv
	 TpjiV7EwGQYKEVmCUVGmXs1jtRjYjtBNJp4nAz6c=
Date: Wed, 10 Jul 2024 14:59:27 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] samples: configfs: add missing MODULE_DESCRIPTION() macro
Message-ID: <2024071021-dares-schedule-9377@gregkh>
References: <20240601-md-samples-configfs-v1-1-83ef2d3c0088@quicinc.com>
 <1d5dc2bb-773c-4877-9660-fff5517c2df3@quicinc.com>
 <04bd39d0-9ed7-4c09-9e21-a0a61a0fc6ea@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04bd39d0-9ed7-4c09-9e21-a0a61a0fc6ea@quicinc.com>

On Tue, Jul 09, 2024 at 03:20:56PM -0700, Jeff Johnson wrote:
> On 6/20/2024 9:46 AM, Jeff Johnson wrote:
> > On 6/1/2024 5:12 PM, Jeff Johnson wrote:
> >> make allmodconfig && make W=1 C=1 reports:
> >> WARNING: modpost: missing MODULE_DESCRIPTION() in samples/configfs/configfs_sample.o
> >>
> >> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> >>
> >> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> >> ---
> >>  samples/configfs/configfs_sample.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/samples/configfs/configfs_sample.c b/samples/configfs/configfs_sample.c
> >> index 37a657b25d58..fd5d163828c5 100644
> >> --- a/samples/configfs/configfs_sample.c
> >> +++ b/samples/configfs/configfs_sample.c
> >> @@ -364,4 +364,5 @@ static void __exit configfs_example_exit(void)
> >>  
> >>  module_init(configfs_example_init);
> >>  module_exit(configfs_example_exit);
> >> +MODULE_DESCRIPTION("Sample configfs module");
> >>  MODULE_LICENSE("GPL");
> >>
> >> ---
> >> base-commit: b050496579632f86ee1ef7e7501906db579f3457
> >> change-id: 20240601-md-samples-configfs-946b278a9d47
> >>
> > 
> > I don't see this in linux-next yet so following up to see if anything else is
> > needed to get this merged.
> 
> I still don't see this in linux-next so adding Andrew & Greg to see if this
> should go through one of their misc trees. Hoping to have these cleaned up
> tree-wide in 6.11.

I'll take it, thanks.

greg k-h

