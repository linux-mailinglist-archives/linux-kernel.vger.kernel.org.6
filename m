Return-Path: <linux-kernel+bounces-572034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E75A6C5A6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 23:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E366189AC00
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 22:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41862230BEF;
	Fri, 21 Mar 2025 22:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8vFV4Qp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B11E9B34;
	Fri, 21 Mar 2025 22:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742595031; cv=none; b=QhK5//yTqGF1+t3XKjYeCdU/gLCEi2wqjHswvNPLKagluw2mSPhHL6iIlDqujVqS6dzShOYFwpD0trgM6TrnYhQm6Zckw3IDtKeb3Yl1tZhGZtLcsgZI/xGdptUocwNCNoicyttWaN3nuz1qlr7U6slGipfXej3ypdYpN9bIaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742595031; c=relaxed/simple;
	bh=jevJwzBthFWx4chDdHGMD3PxJP0Xgws+nOWK9APKAZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvvExdm2HXkq6sBHeyLVc09TY9FsM/TIJFdgdPOkeM5S0e5AWW8aCUKh47Rfp6vGhB1scURHtB0MAxhDb3KxYSyiMfUciQyuGjy/ArAUtPiWH4kADgDA003JgOauGJeWA2bjYQIvOOoTWKOcOmEJtAMZv9ET2xoJqWxKHfO/j3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8vFV4Qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985A8C4CEE7;
	Fri, 21 Mar 2025 22:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742595031;
	bh=jevJwzBthFWx4chDdHGMD3PxJP0Xgws+nOWK9APKAZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8vFV4QpBnq/FOen443UZpP+mR/GUiIyQG398ZXGhi++bF6TEHHtqvgcN1UP9l6gb
	 PY9RUU1YhHY2byT+nmXPrL+aiLy7K0MOe5ayrP6LXdxFj+ZRmG0kdHhb6AHjPjSGB3
	 82IfMaDgb8XHrLseatSul61V2N6TtPR5HqjxiuLFwiqeIvxtaG2lCSYFg+JctruNpp
	 kb09W/Z6z7PIjP38nezAM0AiTmMAonTOVIRR2CCf8j1nITboQlzB3iVVZhsw8w904c
	 L+UMJTBNj9RPTSV/ypXEXQP7qb5kDyUvNV2hy6Wx34IHFGLn1Zu1u5DLwCE4kQxQqk
	 HJVtEeR8VJ58Q==
Date: Fri, 21 Mar 2025 23:10:25 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Matthew Maurer <mmaurer@google.com>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	Tamir Duberstein <tamird@gmail.com>
Subject: Re: [PATCH v2 0/7] Additional methods for Vec
Message-ID: <Z93j0X_ycSf8E4RA@cassiopeiae>
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
 <Z91au1h1zhDT9IxQ@pollux>
 <D8LYWIFUVJOC.ZIPANZF9ONJJ@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D8LYWIFUVJOC.ZIPANZF9ONJJ@proton.me>

On Fri, Mar 21, 2025 at 01:10:43PM +0000, Benno Lossin wrote:
> On Fri Mar 21, 2025 at 1:25 PM CET, Danilo Krummrich wrote:
> > On Fri, Mar 21, 2025 at 12:09:55PM +0000, Alice Ryhl wrote:
> >> This adds various Vec methods. Some of them are needed by Rust Binder,
> >> and others are needed in other places. Each commit explains where it is
> >> needed.
> >> 
> >> I'm not sure what we concluded on the set_len / dec_len changes, so I
> >> don't depend on that series for now.
> >
> > So far I see no reason to assume otherwise, so it probably makes sense to
> > rebase. Unless Tamir is fine to rebase his changes onto this series.
> 
> I haven't yet taken a look at the reworked version of dec_len, so I'd
> wait until we have finished discussion on that.

What I mean is, everything looks like I'll pick them up eventually, so it makes
sense to base a subsequent version of this series onto Tramir's (even if the
current one of dec_len() is not the final one).

