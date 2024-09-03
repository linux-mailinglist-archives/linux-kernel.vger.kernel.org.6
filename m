Return-Path: <linux-kernel+bounces-312873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04AA969CCE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40591B23C9A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361CA1C9851;
	Tue,  3 Sep 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C73WGUft"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C01AD270;
	Tue,  3 Sep 2024 12:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364998; cv=none; b=icgKc2FwRHFfjSxelUYPoTi/vfAb+1t+2slqJID067Yf2bii3H6W7rgXkxCiDAGoASmrMRON+MVt0kmlxAgFf/zDvcQL95DWc38ZSYJMsBhcnlMcf05Z+POnSsFRNAA0DjgFNHGgIDg8mzCH2jFPNYXKAkiClR7+lkhS67uQPms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364998; c=relaxed/simple;
	bh=YPy+r4zg7f1az0PYCHCW/JeLrJV/ZbE3/iouVRE6qRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6wupsvQvZO5wh6xyYo6xQrab9g7VmRn9nqkRU+fu6s8x41H06Abo6q182uAp2QMxpHpTAX/PA4R7lB/cArrC62sTNbqRom0f9zDbY59cA4B4r6J37Qshm36ZnsfdIYyl4joBoZAYpcNjWd3B0noqS7VANS5Z8QVDRQlEf9nmv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C73WGUft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AEAEC4CEC4;
	Tue,  3 Sep 2024 12:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725364998;
	bh=YPy+r4zg7f1az0PYCHCW/JeLrJV/ZbE3/iouVRE6qRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C73WGUftiJpFzJsxwyW/z1QaAF6j4KZ4bmGrxlkYK09w3jde19Z+QSMUSjEX25IQI
	 QAfFvcWJbIhrU9K3cY0oHWhslkDOsGYx9O6Xur9hYfzkeEyfV+/IDdlNpsVdM74mDz
	 ds6H5kkGSSb0KwenCskfcm8lMoOnes/Bbvi1z3a9NwpBudWb2BtCg0JfMCOtjUT7t5
	 +cgzAZKIfezcQ5203MXGGSGGmSJL1745AuY0S7l0HrCfFZsKsUL7VlORib4m/YjFMH
	 yZvK7R0l3kEOyCgNVOAAZkC18T2CNaMkQyiA8Rp9ZKEnkvtVgW3QxkF7mrri4+wiG3
	 IvntVr4i37KXw==
Date: Tue, 3 Sep 2024 14:03:09 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 26/26] MAINTAINERS: add entry for the Rust `alloc`
 module
Message-ID: <Ztb6_XW3ccnHQDmw@pollux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-27-dakr@kernel.org>
 <20240831135712.0d7366b6.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831135712.0d7366b6.gary@garyguo.net>

On Sat, Aug 31, 2024 at 01:57:12PM +0100, Gary Guo wrote:
> On Fri, 16 Aug 2024 02:11:08 +0200
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > Add maintainers entry for the Rust `alloc` module.
> > 
> > Currently, this includes the `Allocator` API itself, `Allocator`
> > implementations, such as `Kmalloc` or `Vmalloc`, as well as the kernel's
> > implementation of the primary memory allocation data structures, `Box`
> > and `Vec`.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > ---
> >  MAINTAINERS | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 42decde38320..560516b3aaf4 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -19925,6 +19925,13 @@ F:	scripts/*rust*
> >  F:	tools/testing/selftests/rust/
> >  K:	\b(?i:rust)\b
> >  
> > +RUST [ALLOC]
> > +M:	Danilo Krummrich <dakr@kernel.org>
> > +L:	rust-for-linux@vger.kernel.org
> > +S:	Maintained
> > +F:	rust/kernel/alloc.rs
> > +F:	rust/kernel/alloc/
> 
> It feels like we should use `mod.rs`.

The same would be true for:

- rust/kernel/sync.rs
- rust/kernel/net.rs
- rust/kernel/init.rs
- rust/kernel/fs.rs
- ...

Do you propose to change it for all of them?

> 
> > +
> >  RXRPC SOCKETS (AF_RXRPC)
> >  M:	David Howells <dhowells@redhat.com>
> >  M:	Marc Dionne <marc.dionne@auristor.com>
> 

