Return-Path: <linux-kernel+bounces-319296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C5896FA38
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F5C1F259B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3802C1D5CDD;
	Fri,  6 Sep 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mcHV9JlZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF621D61A9;
	Fri,  6 Sep 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725645418; cv=none; b=hT/0RGtETgA6YoHrVE6V/b+NYuOLNAgijdTPwIqzclmfXggzywhngeI5D6AymeyiqHU7A8SCli5ewdT+d6RzIlZUAgGgWSXfdAtYnSGZJejCqlA0FBOKCiOiWsyr5RlKmkrXFRVLl2KdXppvrZ7AlhS+xHROSotIZIHucV9Dris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725645418; c=relaxed/simple;
	bh=WdOBW6mYXpA8iYMY4tnBdje0XASTr6rM3Glk9ZgrOoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S015h2meWykCHkgINByLxXoNIkdbknKweld3uQdF+xLQ31+Cigs78S34vnOUGsflameWP8F07jGjxanCXBrVYxMnlU4U9Y2ha0Cex3p8qbV4l1Ujcp5pcvJlQbxU4xbinaX1cLTbUB9ncMapF9UuWtmj1ZTHrbWSfGsV34AG3Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mcHV9JlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74F5EC4CEC4;
	Fri,  6 Sep 2024 17:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725645418;
	bh=WdOBW6mYXpA8iYMY4tnBdje0XASTr6rM3Glk9ZgrOoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mcHV9JlZrx9op16OrBN5ycOyaQ9NpHZRQ9nrzB0l7C7u7ylVzikp19bG2KKtlOlzB
	 b+4WkK/GEGRQe/oWgIy6n4TIymySIsB6hZ+XQFZMgGBdp9SVWs2J3d/lSuMZs/hBdm
	 5tDOqy7IFDjEUPNdyAhK5S0oReY4hDYDVb8n/hyc=
Date: Fri, 6 Sep 2024 19:56:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Patrick Miller <paddymills@proton.me>
Cc: a.hindborg@samsung.com, alex.gaynor@gmail.com, aliceryhl@google.com,
	apw@canonical.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, dwaipayanray1@gmail.com, gary@garyguo.net,
	joe@perches.com, linux-kernel@vger.kernel.org,
	lukas.bulwahn@gmail.com, ojeda@kernel.org,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu,
	wedsonaf@gmail.com
Subject: Re: [PATCH 2/2] checkpatch: warn on known non-plural rust doc headers
Message-ID: <2024090628-bankable-refusal-5f20@gregkh>
References: <20240906164543.2268973-1-paddymills@proton.me>
 <2024090620-clause-unfrozen-f493@gregkh>
 <SP3tXoSxg14Ga_W2X_E6G3HpeqZjRVwWUhlMCcUMgDvvJOageFJiaQ1OLnZ0mxKuyueW4z10jZZgGankXKf8ezLTTEbyo_pF7vTbjrt0pZU=@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SP3tXoSxg14Ga_W2X_E6G3HpeqZjRVwWUhlMCcUMgDvvJOageFJiaQ1OLnZ0mxKuyueW4z10jZZgGankXKf8ezLTTEbyo_pF7vTbjrt0pZU=@proton.me>

On Fri, Sep 06, 2024 at 05:29:28PM +0000, Patrick Miller wrote:
> 
> 
> 
> 
> 
> On Friday, September 6th, 2024 at 1:00 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > 
> 
> > 
> 
> > On Fri, Sep 06, 2024 at 04:45:49PM +0000, Patrick Miller wrote:
> > 
> 
> > > Adds a check for documentation in rust file. Warns if certain known
> > > documentation headers are not plural.
> > > 
> 
> > > Signed-off-by: Patrick Miller paddymills@proton.me
> > > Suggested-by: Miguel Ojeda ojeda@kernel.org
> > > Link: https://github.com/Rust-for-Linux/linux/issues/1110
> > > 
> 
> > > ---
> > > scripts/checkpatch.pl | 8 ++++++++
> > > 1 file changed, 8 insertions(+)
> > > 
> 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 39032224d504..0e99d11eeb04 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -3900,6 +3900,14 @@ sub process {
> > > "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-annotations.rst\n" . $herecurr);
> > > }
> > > 
> 
> > > +# check that document section headers are plural in rust files
> > > + if ( $realfile =~ /\.rs$/
> > > + && $rawline =~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant)\s*$/ )
> > > + {
> > > + WARN( "RUST_DOC_HEADER",
> > > + "Rust doc he
> > > aders should be plural\n" . $herecurr );
> > 
> 
> > 
> 
> > Something went wrong, your patch lost the tabs and it had a line wrap?
> My bad! Editor settings strikes again.
> 
> > 
> 
> > And why is Rust unique for plurals here? What if there really is only
> > one example?
> Per Miguel Ojeda (who suggested the issue): "We prefer plurals when writing code documentation sections: # Examples, # Invariants, # Guarantees and # Panics, so that it is consistent and so that one can add more examples without having to change the section name."
> > 
> 
> > thanks,
> > 
> 
> > greg k-h
> 
> I apologize, first time submitting. Do I submit a new email or add the fixed patch to this one?

As this one can't apply, you need to send a whole new one :)


thanks,

greg k-h

