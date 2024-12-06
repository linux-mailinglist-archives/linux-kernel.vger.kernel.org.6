Return-Path: <linux-kernel+bounces-434539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDAD9E6804
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 895CF1885A10
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 07:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B665C1DF274;
	Fri,  6 Dec 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSUiTVaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE851DBB3A;
	Fri,  6 Dec 2024 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733470564; cv=none; b=lja0CyVmYFpDbfkJD2xzTPnXTq4euucEmI2EOs4StUHvKhOyGQ285VAYU7Nn8wGRYiO1KPjmol5/sB7B7SY4lsJA0MhC8nPYVlWihA0jgX4takAawKKGSWRjNfW2NCv7R5R9FtEXnyYsWWlxha8kir+0alkdyd5U8Whktr9qa8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733470564; c=relaxed/simple;
	bh=GgZaIKYqwHFnub4K6lKDTb/cpONWd1rIk/cClD2yA2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDwWBFTnacaPdK64FOpgFCJEXcacfgXGbbnu5e6QJYy0Il9ZTcMlDfsQ6mvZd9eOWuQe+zOeJslJ2TPmtU9v6vfa9j9Q1RDlNQcFySqd9ynUAEEF1UUgO4mHD5VbB72o4SHmMs5lLafAJ/aS2YubWYLU8ZF0Iaqd/W1wyZf/9W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSUiTVaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5C0C4CED1;
	Fri,  6 Dec 2024 07:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733470563;
	bh=GgZaIKYqwHFnub4K6lKDTb/cpONWd1rIk/cClD2yA2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GSUiTVaX9Q54RW05rss5hrg4ujhMQyVWWb0IB1fW8VvuuxUEO+qbz47/qWV14dbAs
	 q67Od2tg+CAt9zgle/Nt4ETvW2Ordw6OBFmXdp75wIqEHMrZ+DKyxs+fNz5sw29IrZ
	 jYRARSgQ4XVnVT82eYDRMXI2r5wvisodODqYRblWQXnc4QP4hYT4MwKvF2eQSD90MW
	 Y32+Y8pXuPp1RTt800n9EBiya2kuGNh0+4RhHqMuikAkIkkT+yNt9pzTwHjPYY0091
	 2Wc/A2bp3cdLES1xyMvFjggl+7moDGL9GdYj2uZf3KF7QVT4x6N4Xp+VpgBKREPPf9
	 7PN/CDCF4Od5A==
Date: Fri, 6 Dec 2024 07:35:58 +0000
From: Lee Jones <lee@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v3 3/5] samples: rust: Provide example using the new Rust
 MiscDevice abstraction
Message-ID: <20241206073558.GH8882@google.com>
References: <20241205162531.1883859-1-lee@kernel.org>
 <20241205162531.1883859-4-lee@kernel.org>
 <2024120604-diffusive-reach-6c99@gregkh>
 <20241206071430.GC8882@google.com>
 <2024120610-jailbreak-preschool-ff45@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024120610-jailbreak-preschool-ff45@gregkh>

On Fri, 06 Dec 2024, Greg KH wrote:

> On Fri, Dec 06, 2024 at 07:14:30AM +0000, Lee Jones wrote:
> > On Fri, 06 Dec 2024, Greg KH wrote:
> > > > +    fn open() -> Result<KBox<Self>> {
> > > > +        pr_info!("Opening Rust Misc Device Sample\n");
> > > 
> > > I'd prefer this to be dev_info() to start with please.
> > 
> > This is not possible at the moment.  Please see the cover-letter.
> 
> Then why make the change to miscdevice.rs if that pointer provided there
> doesn't work for you here?

It's half the puzzle to get it working.  We're waiting on the other
(more complex) part from Alice before we can make use of it.  Would you
like me to remove it from the set until we have all of the pieces?

-- 
Lee Jones [李琼斯]

