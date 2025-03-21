Return-Path: <linux-kernel+bounces-570835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B6CA6B52B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9D44660E5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021051E9B3B;
	Fri, 21 Mar 2025 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9hp0mxX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376A1EBFF8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542640; cv=none; b=Z6NhW0hFUNTVwP0aq+hKfh199Ga0dDaEqpG44bBS44JSIicsiiZWJYFM9GyXAp1G/pBN2TXPmT5gAlEHP4UyPF+BftbeunxH1nF1h6cc88T4xVLmVPuAiDUCwti6pPua6IYclpVpzNE7TWfyPMAntl810r3znduU/iy59k43Hgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542640; c=relaxed/simple;
	bh=0cbcAB8tjYHQKxom7Rd4sm8TgoDuyUY/TfNMTfm1U1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXL3HBbj4jdCl1m0h2mdDAzVBY+twIJYnr0y534AweIh3HrQ6EkfXtXSuEw0uceaZeWSZgf+hVOmbhMhmI/ZgfRObDSwTP0EuJU/QVG2VpFnDJ9gbCPkGRiBhbvAoJBPkNmT//xfLBUhGmuNj1SARvxUf5Oyw6XKQYvulMPOoOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9hp0mxX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB76C4CEE3;
	Fri, 21 Mar 2025 07:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742542639;
	bh=0cbcAB8tjYHQKxom7Rd4sm8TgoDuyUY/TfNMTfm1U1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j9hp0mxX6LBE7/oGIs84Cc9gV58lQOa2jexaW1letGWH5RGOYfynWSKDYrLIP/4s2
	 ui1ioDlgjtFd0GrPWoJsIoXnk5p57NT7pSf3W93FNYc+sBPIiY56jfjZeiZyGBSbpH
	 jWMpn69hJE7CFKboi6GXoFFNUTqNac/Qd1esgsnbQEVQXLfyu1f6uz+ZvUXfOB4L+x
	 g88OnoseEWYCJyi4Z04CLpYzGn9nxq5zQWYys+UCl+06yB7klKJBngTnu9n9NTqoVz
	 gXds9RWrDuPUqHXO5eXwDVwoiz/l2+KFahIgn7TMF20jtr1Lqg3J9pqFdah9AsGT1S
	 o+BTFMBUKL+AQ==
Date: Fri, 21 Mar 2025 08:37:16 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Michael Kelley <mhklinux@outlook.com>,
	"brgerst@gmail.com" <brgerst@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compile problems w/gcc 9.4.0 in linux-next
Message-ID: <Z90XLMUzB25HpGcb@gmail.com>
References: <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXH-awwT99FTaBJqyEbgBoxc20h4LfbzXMP00NQHBs03+A@mail.gmail.com>


* Ard Biesheuvel <ardb@kernel.org> wrote:

> > Interestingly, if DYNAMIC_BMI2 in 
> > lib/zstd/common/portability_macros.h is changed on line 61 to 
> > always be defined as 0, the compile problem in huf_compress.c goes 
> > away.
> 
> Without having looked at the crashing code, I suspect that the only 
> meaningful course of action here is to tweak the conditional logic 
> that defines DYNAMIC_BMI2 to only enable it for GCC >= 10.1 (assuming 
> those are unaffected) In any case, GCC 9.4 is not going to get fixed 
> in the field, so even if this gets fixed on the GCC side, we will 
> have to deal with it here.

Apparently all GCC < 11.0 versions are crashing.

Would something like the fix below work?

Thanks,

	Ingo

===============>

 lib/zstd/common/portability_macros.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/common/portability_macros.h b/lib/zstd/common/portability_macros.h
index 0e3b2c0a527d..0dde8bf56595 100644
--- a/lib/zstd/common/portability_macros.h
+++ b/lib/zstd/common/portability_macros.h
@@ -55,7 +55,7 @@
 #ifndef DYNAMIC_BMI2
   #if ((defined(__clang__) && __has_attribute(__target__)) \
       || (defined(__GNUC__) \
-          && (__GNUC__ >= 5 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 8)))) \
+          && (__GNUC__ >= 11))) \
       && (defined(__x86_64__) || defined(_M_X64)) \
       && !defined(__BMI2__)
   #  define DYNAMIC_BMI2 1

