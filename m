Return-Path: <linux-kernel+bounces-328660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9EB978703
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 19:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3364E1C240C3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600DE823AF;
	Fri, 13 Sep 2024 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="l0DjuLxv"
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0B586131
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726249217; cv=none; b=IWcG0j1PMYqZFZv2lGDc0IWELpaT+IFkYEsTiLurvdI570g3bh5DqvmOHx8iKfMzhfezKCV5OPmvdbbbvn3DvoTsEAccdDL2fy3HMH/YJDPn4Bhqu5Vw2MIR9pcMzIaMAGX7s7z3bWQc2/agUdQ2RH2f0X81P5rdUC0obEuWeXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726249217; c=relaxed/simple;
	bh=SIqKamNHZz5/uNc+N5jXsYdWxrtaRfUiR9avW5BOBQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h2qXHfP7d/s5cIWR/jArLPT/CFkBP+7FLIgX1QrCA6ZFboYL9ryPUNeDOTqC41HDBVQK8ulx4AUGgvirNyoLioW26i04q+OWS2tq/qBHv+zxOev5h8K9iiklW6kKtfrRx78YskDEvQt9dyS3s1IDCKhCgmYiSHZfdTcW6VgVUHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=l0DjuLxv; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X51c70D3jzRtd;
	Fri, 13 Sep 2024 19:33:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726248790;
	bh=c91K7s1c/V3DYCglP+L8gIe2uMVDTi7QkMZAlfXi9Gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l0DjuLxvABVY9m3WW2eC4vaDwWmgh3xbrBbJAzDprHbTB7pegs6jjzZ/auBMoFUyc
	 M2OppqZZdnV+i9umQUhYcbGMsk3vIFM5fzXH+xIWXV9LDVn49fwZ8PA77NWCUBUcfH
	 1R/CPAvjYWAFRYhKyXKQjN76Cfq4ihGzj3z8vxaI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4X51c63h7jz5bq;
	Fri, 13 Sep 2024 19:33:09 +0200 (CEST)
Date: Fri, 13 Sep 2024 19:33:02 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Christian Brauner <brauner@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the landlock tree
Message-ID: <20240913.sohShem6yoh9@digikod.net>
References: <20240913180641.4a3152ec@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913180641.4a3152ec@canb.auug.org.au>
X-Infomaniak-Routing: alpha

Hi,

I minimized the commits required for my -next branch, I hope it will be
good enough now:
https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git/commit/?h=next&id=24dfe95e493086a99acf7df1ef23d9f21f8cdec7

Regards,
 Mickaël

On Fri, Sep 13, 2024 at 06:06:41PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commits are also in the vfs-brauner tree as different
> commits (but the same patches):
> 
>   45c6e98705e0 ("fs: remove f_version")
>   ce22e70a947f ("pipe: use f_pipe")
>   191021d73803 ("fs: add f_pipe")
>   a6e2141e0b77 ("ubifs: store cookie in private data")
>   3125ec2ef10b ("ufs: store cookie in private data")
>   905fcc3a4ec0 ("udf: store cookie in private data")
>   f2647a4fbe5e ("proc: store cookie in private data")
>   e2f00c032780 ("ocfs2: store cookie in private data")
> 
> These are commits
> 
>   11068e0b64cb ("fs: remove f_version")
>   5a957bbac3ab ("pipe: use f_pipe")
>   5e9b50dea970 ("fs: add f_pipe")
>   1146e5a69efc ("ubifs: store cookie in private data")
>   0bea8287df6c ("ufs: store cookie in private data")
>   3dd4624ffcd2 ("udf: store cookie in private data")
>   b4dba2efa810 ("proc: store cookie in private data")
>   ceaa5e80db7c ("ocfs2: store cookie in private data")
> 
> in the vfs-brauner tree.  There is a conflict between commit
> 
>   61be440b7cc6 ("input: remove f_version abuse")
> 
> from the landlock tree and commit
> 
>   7a7ce8b3ba66 ("input: remove f_version abuse")
> 
> from the vfs-brauner tree, so I used the latter version.
> 
> -- 
> Cheers,
> Stephen Rothwell



