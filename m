Return-Path: <linux-kernel+bounces-551743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB26A5702D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BDFC16F0AA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570D023F434;
	Fri,  7 Mar 2025 18:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9gXcsQO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B421F23E229
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741371057; cv=none; b=qEo74080Okq467YajgSA8LBE5gjvTaxnV7XrI/46jvpSgECa0hBi3XlWnqdeG5PG8c3qNVGT9tOL/eUj37ToTg0nWTERMTkgKRIdXF+Ucu+QVddHMbqOMGuoeDhClomXRtP1hFjzkWPtl09dPkTyVf9kCfSMR+ut3INdZNZKnNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741371057; c=relaxed/simple;
	bh=rsgVaSryA23Jr0XcgqAG14znT/gNWQguaNRK/HSoM2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkNgYEM+bGpOWXC3zOP4QR1oWAbppAlfgB8cUdY5ZCdhsqDrQrJJr7uw8HjTCfVFCbNl43T3z7LWuonjGLdGCSKvoyHoYRKyYqFH6cY2i0Q/O484ONWAgaq4TV93NWLmtKZcN2Ohf3JL+SPQWBo8Te0RFcnidV8cg/Zz6ZDrgAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9gXcsQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 050F0C4CED1;
	Fri,  7 Mar 2025 18:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741371056;
	bh=rsgVaSryA23Jr0XcgqAG14znT/gNWQguaNRK/HSoM2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T9gXcsQOqAUv0v+GnpZPswM8n+wx71RcC1ayl5S0P9swqsa2dmugS1PmbYweL+ENF
	 IqyaWbyaJgYODB/e036Uip4rIRqumTBAkRE0MZ/tdxv0xlNWQ6UWsoHblmhtkXwaVc
	 0arlCZ4U0YhCWf1Rmi+/sPjkhx8jWvR+oLdiTkVSwbMYY4Uj1BJD1CEQE9E11CmHUO
	 stOOJTgaZy7XgxYN3AsacueoPilGGS+iOG1VGgg1twImsU97d2CGJgcGifGaXZdXR7
	 bMzcDGyF7lfm8IaXiWADKcaOPP/SAbLUc3GJquree7eOCSBhPuhwgl4m7/noYlAM9E
	 Ru2G/bTkmU/pQ==
Date: Fri, 7 Mar 2025 18:10:54 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: disalbe nat_bits by default
Message-ID: <Z8s2rmqauwCGJb9v@google.com>
References: <20250307031838.19164-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307031838.19164-1-chao@kernel.org>

I meant let's support it conservatively if someone needs to enable
in other platform.

On 03/07, Chao Yu wrote:
> Let's disable nat_bits by default.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/node.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 56873c41436e..3148d9e44e7f 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -3286,6 +3286,9 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
>  	if (!nm_i->nat_bitmap)
>  		return -ENOMEM;
>  
> +	/* disable nat_bits feature by default */
> +	disable_nat_bits(sbi, true);
> +
>  	err = __get_nat_bitmaps(sbi);
>  	if (err)
>  		return err;
> -- 
> 2.40.1

