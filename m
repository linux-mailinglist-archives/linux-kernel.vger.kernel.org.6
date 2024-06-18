Return-Path: <linux-kernel+bounces-220040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A83C090DBD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE4D1C226F2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B593615ECCD;
	Tue, 18 Jun 2024 18:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q1PRAli5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC02139C6;
	Tue, 18 Jun 2024 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718736177; cv=none; b=bFMg5kXuWhN0CoeDhwZUGi+a29B2V/gOPy5jpxQ2TrmihFC1JElCdOLoDGFp+uhGAEsKD2FboeDbEIpWcqzTLB8OIYI4nyivEIGKRk6LJacTymuszyxBzhZ6gM5OgpKwSxK4pUgij557/05xiAjY9eAQpR/l68/h8dn5o7fSLOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718736177; c=relaxed/simple;
	bh=nuDL896Rh8IWkg5KWCttBumtWgDs7+nzHP/nmSuQfok=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AHXHpC296U7Pzr2KeOZHmLoUvLKzjDYYFJSKq9fDEqFpgasWHg+hSj6/x8AmnEArEW3usFtMeG5KLdshvt2SlqLJNpvPbUsVFL039+VG0+X0mOqV8r31H6LqE6TFJeZlU2XCQTCJChlXRTofu+wmQ4iCOcXheT11E8mcLYfWV50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q1PRAli5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8909CC3277B;
	Tue, 18 Jun 2024 18:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718736177;
	bh=nuDL896Rh8IWkg5KWCttBumtWgDs7+nzHP/nmSuQfok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q1PRAli5A9nX45Y6kn04Af4ikKbEF0svjM18iw+VG7SWmToMNTZYFHzRo/O1/mKO/
	 f61lKcZBin/mipTDH5RMCEyGyRtFBu9bGMij5ug2J+BvQBrqJ0M/Qt2cyrs4e1zUpi
	 uF3coNwz59VhQuBlgiHjQVNPpWRXCdUMAyAMuO0s=
Date: Tue, 18 Jun 2024 11:42:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
 lkft-triage@lists.linaro.org, Linux Regressions
 <regressions@lists.linux.dev>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, David
 Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter
 <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: mm/slub.c:1163:17: error: implicit declaration of function
 '__memset'; did you mean '__memset64'?
 [-Werror=implicit-function-declaration]
Message-Id: <20240618114256.81b30ab4e6de18acd4903c9b@linux-foundation.org>
In-Reply-To: <CA+G9fYvULzMHHQo3OKkcFYU+Tiw1fFU6LKbt3zHfX-E-ozcsdA@mail.gmail.com>
References: <CA+G9fYvULzMHHQo3OKkcFYU+Tiw1fFU6LKbt3zHfX-E-ozcsdA@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Jun 2024 16:09:38 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> The Following build failures have been noticed on Powerpc, mips and arc on the
> Linux next-20240617 tag.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Regressions found on mips:
>   - gcc-12-bcm47xx_defconfig
>   - gcc-12-cavium_octeon_defconfig
>   - gcc-8-malta_defconfig
>   - gcc-12-malta_defconfig
>   - gcc-12-allnoconfig
>   - gcc-8-bcm47xx_defconfig
>   - gcc-8-allnoconfig
>   - gcc-8-cavium_octeon_defconfig
>   - clang-18-allnoconfig
>   - clang-nightly-allnoconfig
> 
> 
> Regressions found on arc:
>   - gcc-9-allnoconfig
>   - gcc-9-defconfig
> 
> Regressions found on powerpc:
>   - clang-18-maple_defconfig
>   - gcc-13-ppc6xx_defconfig
>   - clang-18-allnoconfig
>   - clang-18-defconfig
>   - clang-18-ppc64e_defconfig
>   - gcc-13-defconfig
> 
> Build log:
> --------
> mm/slub.c: In function 'init_object':
> mm/slub.c:1163:17: error: implicit declaration of function '__memset';
> did you mean '__memset64'? [-Werror=implicit-function-declaration]
>  1163 |                 __memset(p - s->red_left_pad, val, s->red_left_pad);
>       |                 ^~~~~~~~
>       |                 __memset64
> 
> The commit id:
>   ad5dde7da5f9 kmsan: support SLAB_POISON

Thanks.  I was hoping for at least a temporary workaround for this, but
nothing is happening.  I'll disable that patch for now.

