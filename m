Return-Path: <linux-kernel+bounces-313809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3A896AA1F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 636621F257C6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24555126BF4;
	Tue,  3 Sep 2024 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iL8+8llt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFEA1EC002
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725398928; cv=none; b=pIdy8f0hpab3dGDwHxo3PutOO31Y8OIW9H2W3K4kWApoH6QgZNOoxvh/9n5FTVUwaQSV4sRxv52qWHL/vL6nca6i2dtkqRF/a5TQHxCkuHy3qiNhLvgM6jXJKIjiyIKsc2fXYJOfyRjqwj5E+E1z2Hye82qX0sa0xPn+6/5k7ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725398928; c=relaxed/simple;
	bh=oYo7owdrnfin/sBqd7d7aNhH03aPOu6TESP3vci0CV8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ddSpszHh16UvTuB01nVpazbm/MSbr3yTPnhHh3Ryaomx00D/fn0iR/5G/n27LhdoXv1MHYFZorP59/m1I4RiDhPjogU8Y0MMT5If151jWJHwmPZAyOaaVxgAU7zxwnvxHSe5hOGm2hfdsOQxhw8Izc57n8z/MRy513EkqVbMHVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iL8+8llt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81160C4CEC4;
	Tue,  3 Sep 2024 21:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1725398927;
	bh=oYo7owdrnfin/sBqd7d7aNhH03aPOu6TESP3vci0CV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iL8+8lltBrR70/LOfusoFuTDL/SgxYToZjj4YnQ0nSTCGmQvEJ9MADo1o8uWFoedu
	 4s3UQx7qIYfRX0QlEPX5PMXg22xUo+CVxCiRChxgeu/UAcIGT7UogSGVic/yOl0Uv0
	 P+dAIyi2YjU5PuQS8CTFt2xLpbsFf4iA+fAPjasw=
Date: Tue, 3 Sep 2024 14:28:47 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim
 <minchan@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Kconfig: fixup zsmalloc configuration
Message-Id: <20240903142847.f03362654cac51bf4617fe18@linux-foundation.org>
In-Reply-To: <20240903175528.GA1190078@cmpxchg.org>
References: <20240903040143.1580705-1-senozhatsky@chromium.org>
	<20240903175528.GA1190078@cmpxchg.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Sep 2024 13:55:28 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Tue, Sep 03, 2024 at 01:00:22PM +0900, Sergey Senozhatsky wrote:
> > zsmalloc is not exclusive to zswap. Commit aa3ba6d72ce0
> > ("mm: Kconfig: fixup zsmalloc configuration") made CONFIG_ZSMALLOC
> > only visible when CONFIG_ZSWAP is selected, which makes it
> > impossible to menuconfig zsmalloc-specific features (stats,
> > chain-size, etc.) on systems that use ZRAM but don't have ZSWAP
> > enabled.
> > 
> > Make zsmalloc depend on both ZRAM and ZSWAP.
> > 
> > Fixes: Fixes: aa3ba6d72ce0 ("mm: Kconfig: fixup zsmalloc configuration")
> 
> I can't find this commit upstream.
> 
> It looks like this was actually broken by
> 
> commit b3fbd58fcbb10725a1314688e03b1af6827c42f9
> Author: Johannes Weiner <hannes@cmpxchg.org>
> Date:   Thu May 19 14:08:53 2022 -0700
> 
>     mm: Kconfig: simplify zswap configuration
> 
> instead?

Agree, I edited that into the changelog.

