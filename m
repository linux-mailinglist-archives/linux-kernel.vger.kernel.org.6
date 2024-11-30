Return-Path: <linux-kernel+bounces-426346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8089DF1F3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 17:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 108B1B21614
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9C91A070E;
	Sat, 30 Nov 2024 16:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gMW/Otyr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47E42AA4;
	Sat, 30 Nov 2024 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732983355; cv=none; b=mMAKh8WON5iCLKNta0Vcr0iZh7KBDh80pQ/szHLNyJDq2Xi9nxUxRwnh1rgAvRfvMy2mLXCDLL8Ib5ozhY/eAyCApQboI/ohMEtDtX/nqhh9tYB2GzhJxVPEMS+MfpKoj6BLHqN+1oPXO19qE7efhyW5YY5fpGoEyc1Cejehg8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732983355; c=relaxed/simple;
	bh=bg8lWr9apdFdWF0wmjnutBUncFRErFVt3yljpuByC54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKZNYF51rIyr3e9GmrZeaD8bvvKpOkn3l+5ZrCIQ1rB/tMEFIiB+Vyds3JTS/AdxMqoiQBmjF0ToP4IbCsODxwP5oUYGn9nAgsZyUEoaqXi/KtLJOpl/pqX8CX/0kvn61nLlGJkeeHzQtj36KgWR89fEFJmUCdS59+bXEbUKbNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gMW/Otyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3640EC4CED4;
	Sat, 30 Nov 2024 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732983354;
	bh=bg8lWr9apdFdWF0wmjnutBUncFRErFVt3yljpuByC54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gMW/Otyrc7FR5v2tiodeV/nnvbP9ogvC4+zpjQRmY+5C1Rc/LFvb3QLClKl0YknwU
	 4k77ffSvszEJ+eUJnfDCQMu4BS1z7ckehdIKsvt4KVqA82J6oOtS+2tB+uTv/uLlJ7
	 BP2BKGKztc7Ram9akyEhgPR9fXx7al30tzWKVg5o=
Date: Sat, 30 Nov 2024 17:15:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	Dave Penkler <dpenkler@gmail.com>
Subject: Re: [GIT PULL] Staging driver changes for 6.13-rc1
Message-ID: <2024113025-sly-footer-3462@gregkh>
References: <Z0lCyXBV06VyH96s@kroah.com>
 <f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f10e976e-7a04-4454-b38d-39cd18f142da@roeck-us.net>

On Sat, Nov 30, 2024 at 08:10:55AM -0800, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Nov 29, 2024 at 05:27:53AM +0100, Greg KH wrote:
> > The following changes since commit 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b:
> > 
> >   Linux 6.12-rc2 (2024-10-06 15:32:27 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.13-rc1
> > 
> > for you to fetch changes up to 114eae3c9fde35220cca623840817a740a2eb7b3:
> > 
> >   Staging: gpib: gpib_os.c - Remove unnecessary OOM message (2024-11-10 08:04:18 +0100)
> > 
> > ----------------------------------------------------------------
> [ ...]
> 
> > Dave Penkler (33):
> >       staging: gpib: Add common include files for GPIB drivers
> >       staging: gpib: Add user api include files
> >       staging: gpib: Add GPIB common core driver
> >       staging: gpib: Add tms9914 GPIB chip driver
> >       staging: gpib: Add nec7210 GPIB chip driver
> >       staging: gpib: Add HP/Agilent/Keysight 8235xx PCI GPIB driver
> >       staging: gpib: Add Agilent/Keysight 82357x USB GPIB driver
> >       staging: gpib: Add Computer Boards GPIB driver
> 
> I seem to be unable to find the patch introducing the problem (the link
> provided with the patch is invalid), so I report it here.
> 
> With i386 allmodconfig builds:
> 
> Building i386:allyesconfig ... failed
> --------------
> Error log:
> drivers/staging/gpib/cec/cec_gpib.c: In function 'cec_pci_attach':
> drivers/staging/gpib/cec/cec_gpib.c:300:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   300 |         nec_priv->iobase = (void *)(pci_resource_start(cec_priv->pci_device, 3));
>       |                            ^
> drivers/staging/gpib/ines/ines_gpib.c: In function 'ines_common_pci_attach':
> drivers/staging/gpib/ines/ines_gpib.c:783:28: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>   783 |         nec_priv->iobase = (void *)(pci_resource_start(ines_priv->pci_device,
>       |                            ^
> 
> pci_resource_start() returns resource_size_t, which is not a pointer, and thus
> can not be cast to one.

This is odd, why hasn't 0-day or any other build testing found this?
I'll dig into it on Monday, thanks for this.

greg k-h

