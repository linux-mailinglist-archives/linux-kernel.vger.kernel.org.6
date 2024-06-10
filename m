Return-Path: <linux-kernel+bounces-207722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD6A901ADA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B037282BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3A5117BAA;
	Mon, 10 Jun 2024 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0Ra5EcI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11002171D2
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717999723; cv=none; b=WVJvcupjRiAXS3B882u+ibF9iMNeo0PX04dWBVd/qiO/MsL3r+7FseWM8ieLI+ZVaqgDcvl+NdRq3HxJ5IzF8QLWXMYDoxsB25ylt0SJhCLb9oGEQ+j2f+V90REYJ/hLLjwxnpl9tdjL6Nkif/BNrbDl7xaoDZ1/+q71GgRwBUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717999723; c=relaxed/simple;
	bh=ydU3TIHzs/gqixC34SQ/HlD8nJN2Njc1bqn94VBCax0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ng0XnvmrqCXMKsJZ0NB3e11DND5dK7n0toznA+qVp3JH8HaVJi2DtAain1BVc5Xrn69Y70JnNEBSVm0DUOEKjxzYF2P9B/3vzABu+qnJLObtY1yiw2WooFV4bwT13n9Qx3vxxNu/Ljn6acyP1LpUDTew0l0ODSfhrG00ttjju/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0Ra5EcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A06CC2BBFC;
	Mon, 10 Jun 2024 06:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717999722;
	bh=ydU3TIHzs/gqixC34SQ/HlD8nJN2Njc1bqn94VBCax0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0Ra5EcIeboqGZAuts2bhl2iJ4p1IlqLcdNh3qNs87zOoIaH5ldNi9pwIS+l8aU9C
	 WlkzxmCZXpqK65yajDYqFaSJ3VtUkB01x29ploDFSPS+ZduVnL4MaTTtIaXtSCL5G9
	 ttRmi9kxGw2/pMOD+lefA1e1YHzj75KKzCP7zBurp0vOJ5k5qpj2oVMTtNVE2wn98P
	 gXGFSpHR0dKRCFlP4/gdM4bRgoWwx13WnDeqsPvSmDt/oVcfIF3uyPTy8CA3yqFl50
	 WL8VJZ8oxUvtdSGsudL+my7hZgeBrvwMwCnUQkZAUCbZEvfdUZ2wipjNvLSyBuSmIO
	 crKV8N+8sPYVQ==
Date: Mon, 10 Jun 2024 09:06:37 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Leesoo Ahn <lsahn@wewakecorp.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: sparse: clarify a variable name and its value
Message-ID: <ZmaX7cnUiWla9FCf@kernel.org>
References: <20240608152114.867961-1-lsahn@wewakecorp.com>
 <20240609140341.14ba3a1c62029771d60059ed@linux-foundation.org>
 <CANTT7qjthRWX+7m749mU_CmGUO1UEvY6O9yKsStm165Lz=tqAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANTT7qjthRWX+7m749mU_CmGUO1UEvY6O9yKsStm165Lz=tqAQ@mail.gmail.com>

On Mon, Jun 10, 2024 at 12:39:28PM +0900, Leesoo Ahn wrote:
> 2024년 6월 10일 (월) 오전 6:03, Andrew Morton <akpm@linux-foundation.org>님이 작성:
> >
> > On Sun,  9 Jun 2024 00:21:14 +0900 Leesoo Ahn <lsahn@ooseel.net> wrote:
> >
> > > Setting 'limit' variable to 0 might seem like it means "no limit". But
> > > in the memblock API, 0 actually means the 'MEMBLOCK_ALLOC_ACCESSIBLE'
> > > enum, which limits the physical address range based on
> > > 'memblock.current_limit'. This can be confusing.
> >
> > Does it?  From my reading, this meaning applies to the range end
> > address, in memblock_find_in_range_node()?  If your interpretation is
> > correct, this should be documented in the relevant memblock kerneldoc.

It is :-P
 
> IMO, regardless of memblock documentation, it better uses
> MEMBLOCK_ALLOC_ACCESSIBLE enum instead of 0 as a value for the variable.

Using MEMBLOCK_ALLOC_ACCESSIBLE is a slight improvement, but renaming the
variable is not, IMO.
 
> Best regards,
> Leesoo

-- 
Sincerely yours,
Mike.

