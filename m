Return-Path: <linux-kernel+bounces-439103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E019EAAD2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCF1161446
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 08:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5092309A6;
	Tue, 10 Dec 2024 08:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IrCULZP7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0D81B6CE5;
	Tue, 10 Dec 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733819980; cv=none; b=VPKotDsq28GMJFYIqml3CDF/cAAyQzqAhAgEiJLkwTFHLnuy1eHK8GEr6Fk1a1m/tFRT5ny20WTY/LNMeK0k5mbjd77w/Zq28lRRDaH0/lfcmPbH7sJ3YfVFWoSKHr+ggoGjMtYiv88Sxf6l5LRA9e2AQV86i9WSUc3ZBQsD8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733819980; c=relaxed/simple;
	bh=sQWWPjqW9qZ0FOVV/QYr3voi+8AelmLLdsNParFMTts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYm6aAvIIaJE/wj2Pr5VwZg6tKHTlwsTb5qb+xmtSAfosKRgSg7HXM0e6kIKVqgGcufNGBZOFS4yMwZnv+fyjh2HJp9X0Xo8VDwlCAUeBufMIZg+/VxSxb758u1RRBvdZ19Ev9pYaODxyVziljay//P6SBqxdBJfVpb61Bt7Q84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IrCULZP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47081C4CED6;
	Tue, 10 Dec 2024 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733819979;
	bh=sQWWPjqW9qZ0FOVV/QYr3voi+8AelmLLdsNParFMTts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IrCULZP736306m/01c3UUZ26tq2+sXu++khH7xVvNdwKyNiyx7nE49oT1hlT6n9Ui
	 dK2wdhqiUKWILwMbO1BmQD4TJ3EUe9U6wjC/EClIHOfL0J7AOq85QK98+ZMhbC7vU9
	 OTvMRCIuxC6akhjTXoaqTfxQbRs6UVYr9Kozbfqg=
Date: Tue, 10 Dec 2024 09:39:03 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Dave Penkler <dpenkler@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: gpib: Fix i386 build issue
Message-ID: <2024121051-snowiness-sampling-2fe2@gregkh>
References: <20241204162128.25617-1-dpenkler@gmail.com>
 <CAMuHMdVUnr4iAZmuy8Z3S+sCYN4P26RdpPwXevwiJrh+KN025Q@mail.gmail.com>
 <ddc720b2-8bb4-4a07-8280-dadeb2de5b26@roeck-us.net>
 <CAMuHMdUb-tpmTiKV5BFopCWoY96D_HYNG60Kv+wVRKnDFF+COA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUb-tpmTiKV5BFopCWoY96D_HYNG60Kv+wVRKnDFF+COA@mail.gmail.com>

On Tue, Dec 10, 2024 at 08:52:08AM +0100, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Mon, Dec 9, 2024 at 5:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > The underlying problem is that the code uses a pointer to store the physical
> > address. That doesn't work if sizeof(pointer) < sizeof(physical address),
> > which affects systems with X86_PAE enabled. I have not seen the problem
> > anywhere else.
> 
> I could reproduce the build issue on ARM, with CONFIG_ARM_LPAE=y,
> which is not enabled by allmodconfig.

So does that mean this patch is incorrect?

confused,

greg k-h

