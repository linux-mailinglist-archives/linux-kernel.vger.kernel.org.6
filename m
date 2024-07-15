Return-Path: <linux-kernel+bounces-252348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4279311F0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 12:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72B32B21ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92943187336;
	Mon, 15 Jul 2024 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mI0GT16x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D4223BF;
	Mon, 15 Jul 2024 10:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721037869; cv=none; b=WircJ9X15Q3IH1oxuWYvPvGon+BiKh+W8W8qcVbVA2frfNMJcTPVsGMQOACsdHpYE8Rkpvo82TqJYleS5lva2wBn5EUTEw+CRl51zd/X5YdnEBsaOXJxZSUsNd6HGlEAj0LGnm5UZphzcEbjNGbdC0DkxQtrPU40hp8YCFKv21k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721037869; c=relaxed/simple;
	bh=FnXs1BF0qgDlNDE0EfkuvP0ybwPWpLm6dtpBtM0spJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RMnsjNmeICDAxPl4oM0ATKF15pOrav8jXMpFJwP0yLl7VICkzYwulvNh+7RjSwrKKn7wyuorh+ZeDuy2VcinmILhSDdrPbaAhPZx9cfx/8jm+6+rnIbDOa+gIqIsRg9TxoUi1Qp4urA5gnjUb8EgSQH4RgwrFVuUBn7O4U/lvag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mI0GT16x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E9EC32782;
	Mon, 15 Jul 2024 10:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721037869;
	bh=FnXs1BF0qgDlNDE0EfkuvP0ybwPWpLm6dtpBtM0spJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mI0GT16xxn2yVBlI4jmI4k4eCFsQ4rT+k5EfKaanMgJzOL5GCT4nzDhst81QXaVXQ
	 wtFuf8pmmh1CxyGuFfzSiuvP4HkJDmb55L81e0iFzhnWbV99yS+K8ZF7xe5K+02e/v
	 0Ll2VU1/Cwg6Tyf9X/DsQ9Mb/jCXwM9FXXNkLjQN7Em9WZoAYySxG0BgDfVTY7/p2b
	 IO9fXUMQQocZr+KEm0HNRU78FK3tPykdQhwNQqsu6HT1v1DTIsgUdDo/TB9NSR2y5q
	 B3GdxS2bvb3ME2a9ztN9fGSe5DDaI3QItxRoKqIby6VlLhIKJF7KAXmDPigsV2FnAc
	 wi+tBXcICyNfA==
Date: Mon, 15 Jul 2024 11:04:24 +0100
From: Will Deacon <will@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Jack D <wm2vdghq@duck.com>
Subject: Re: Boot error since 6.9: Initramfs unpacking failed: invalid magic
 at start of compressed archive
Message-ID: <20240715100424.GA18686@willie-the-truck>
References: <1a61d10f-7974-4fb5-ada6-f2c40c55f2f7@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a61d10f-7974-4fb5-ada6-f2c40c55f2f7@leemhuis.info>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jul 15, 2024 at 08:24:04AM +0200, Thorsten Leemhuis wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> I noticed a report about a regression in bugzilla.kernel.org that a user
> bisected to the main ARM64 merge commit from the 6.9 cycle. So the real
> issue might be somewhere else, but some help would be appreciated. To
> quote from https://bugzilla.kernel.org/show_bug.cgi?id=219014 :
> 
> > Hi.
> > 
> > I'm marking as arm64 since git bisect identifies the first problematic commit as:
> >   6d75c6f40a03c97e1ecd683ae54e249abb9d922b
> > 
> > git bisect log is attached.
> > 
> > Any kernel tagged v6.9x and later fails to boot with the following error:
> > 
> > [    0.420154] Initramfs unpacking failed: invalid magic at start of compressed archive

^^^

My guess (based on times I've seen this sort of thing in the past) is
that the kernel binary grew in size and the broken bootloader is loading
the kernel over the initramfs instead of parsing the 'image_size' field
in the boot header.

Will

