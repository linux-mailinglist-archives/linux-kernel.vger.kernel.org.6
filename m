Return-Path: <linux-kernel+bounces-367515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BA49A0348
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B561287BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5EC1D1E65;
	Wed, 16 Oct 2024 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/Pt+akR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32DB1B2193;
	Wed, 16 Oct 2024 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729065314; cv=none; b=Pq/sNBokee9rXmuZNq7ssSII394oLrK+2sG6mLiL1gmJU/DvSSjTzaUvaa16Wl+/NcPlJulRvrrTP+215nrH9ydk7m692GrKiAWgsQDLlMGMOnI1O0HWmVz/gtKDVd0RJlwnO2mjW6EfsyvJd5rtEa/RP+2m2+YcQFV5zgs/rQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729065314; c=relaxed/simple;
	bh=brAsTdn7C7KHcMxE1e6vxSmsli6F8gtG8xq9FmDaz/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcti3umYNXfoGPuM2uAgb9BsqjjtDt7juztyhNujQRul1QCPk0exkjRlkuxwSnFhP6wuTUc7aRYRj5ZXgPqSWhPRxrM0MSM6fh1s27Za6D5dh2XIqqmbNejFV/9pYRXsZolmNWQUYq2evAxCo7RTVWZaz3Ga6GFZCYn9k/tOeBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/Pt+akR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6EDC4CECE;
	Wed, 16 Oct 2024 07:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729065314;
	bh=brAsTdn7C7KHcMxE1e6vxSmsli6F8gtG8xq9FmDaz/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/Pt+akRym6xgfKLh6NHDhVZJSxYlh71uZMA7vkW93aAcYbBIY4p9W8o6n4SRsJES
	 zidEIbeRaE+2mmZg/BHSZUl1tEP2jWfvbAihJqA/IQJK5/NQFAu6S9vTqLCSpJwG3Q
	 x6KE840yEI3ArnwH8xjY6GtB5JjFaI24H830PRlLeMZ3bJHrWr9O+mR3ic+wFCVfXl
	 FCEEokNu+BVqwNEjRlB3oCnbfIruiMFkg+iWq2OILXhXlB//HnHvzHta4/uXFmjHp/
	 NULe+/vXEIN6Ja57sqJtn3s6EYKsy68cbj2Qgd+iTlp0Dpe4GKqBGlS7qdlymBvC8s
	 a/drQDUpvmjxg==
Date: Wed, 16 Oct 2024 08:55:10 +0100
From: Lee Jones <lee@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the regulator tree
Message-ID: <20241016075510.GL8348@google.com>
References: <20241016135943.24e1fab0@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241016135943.24e1fab0@canb.auug.org.au>

On Wed, 16 Oct 2024, Stephen Rothwell wrote:

> Hi all,
> 
> The following commits are also in the mfd tree as different commits
> (but the same patches):
> 
>   d7a5f27342a8 ("mfd: sec-core: add s2dos05 support")
>   ef9690c04f3b ("dt-bindings: mfd: add samsung,s2dos05")

And these ones do not follow the style expected by the subsystem.

Mark can you please remove these without reverting and further dirtying
MFD's history please?  One little rebase isn't going to hurt in the long
run. :)

> These are commits
> 
>   59d9022639ed ("mfd: sec-core: Add support for the Samsung s2dos05")
>   1d6e7612a129 ("dt-bindings: mfd: Add support for the samsung,s2dos05")
> 
> in the mfd tree.
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
Lee Jones [李琼斯]

