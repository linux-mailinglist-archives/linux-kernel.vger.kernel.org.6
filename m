Return-Path: <linux-kernel+bounces-577342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39048A71BDE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 17:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6686C189475E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 16:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721BA1F63F5;
	Wed, 26 Mar 2025 16:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EU+wfLGY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA221FC102;
	Wed, 26 Mar 2025 16:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743006240; cv=none; b=lYIwBriWIjZ/JEFOuE0LvX0+/7OX0yh9soNE/eaGWSbFmfoyzCeRfAq0YNovGR8Z/H5kdK4AfDHB8/WAsJSoQYt2GeGGGehNcxsNad0kDRMh9wg5SkIhhaElrvf4EujFCJ9gC4J51HchF8Zzq7HM6kg9D1tJHWZASkw5z9A9qgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743006240; c=relaxed/simple;
	bh=GV/y8tsCl8u4IHkv+X6NQ5VR2Oo4PNlnCZdyU9Tbk3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bR/B2A6oejXvPE27EdFFdtsxGg3S1mekY/bYfUa2c6AIUrKa9BosmTPUb1uK1pmvuVpRp/eyb712x7b5SKyrDViJgd3jIr5evZCu5u0S6H3JsdgS6PFB9sJgDRzbB+FLaGX5FPzZG8ua0zq/dJ3pHTWQFJCI8weZTTaGlvQUY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EU+wfLGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 683ABC4CEEE;
	Wed, 26 Mar 2025 16:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743006240;
	bh=GV/y8tsCl8u4IHkv+X6NQ5VR2Oo4PNlnCZdyU9Tbk3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EU+wfLGY+hHERi+iH4We4P9cz0UMyZuJvRZcwuV3iwLu7+JrNY96trd1CH3mWSWxv
	 mRpw4HPg2ovMKW9VQ3Pmj7zOzRiXWtvhZTuOFvQmr2X5xepaPUtBkDxD1gfiGytbNQ
	 Kq4LQdQRNXsw1GT6AHXGHV3+yoDPQOnfLOmSAsrMzP68UoPEja9nllBDhzDQH5YuEA
	 GZmt9IJPLNSnfD81CIvXjLek8TbfYPfWJJN/wfgeG09iZ85VfPeXUKtWsNSwYqDvZd
	 Yotc+KHoVJQpISSSqOllfpFg0kB5t6aFdnTGaP0wFOruUA9YfEqqqlTAQuvdjACPKB
	 8IFeF6KartZWw==
Date: Wed, 26 Mar 2025 09:23:55 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] platform: cznic: fix function parameter names
Message-ID: <20250326162355.GA2072652@ax162>
References: <20250321085315.915808-1-arnd@kernel.org>
 <20250325155906.GA1886499@ax162>
 <l77cp7hlskzkauoohviwonal53upcyc74j7x57ycn7sdfkmu4f@fsm4tv2lbtn6>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <l77cp7hlskzkauoohviwonal53upcyc74j7x57ycn7sdfkmu4f@fsm4tv2lbtn6>

On Wed, Mar 26, 2025 at 10:38:47AM +0100, Marek Behún wrote:
> > 
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > 
> > You will be taking this I assume?
> 
> Arnd already took it into for-next:
>   https://web.git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/log/?h=for-next

Ah odd, it just showed up in -next even though it was applied a few days
ago:

$ git log --oneline next-20250325 -- drivers/platform/cznic/turris-signing-key.c
0b28b7080ef5 platform: cznic: Add keyctl helpers for Turris platform

$ git log --oneline next-20250326 -- drivers/platform/cznic/turris-signing-key.c
eece12237a13 platform: cznic: fix function parameter names
0b28b7080ef5 platform: cznic: Add keyctl helpers for Turris platform

Glad that it is resolved now though.

Cheers,
Nathan

