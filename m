Return-Path: <linux-kernel+bounces-319247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A16196F9AF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 19:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 244141C2186A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546B11D4607;
	Fri,  6 Sep 2024 17:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AjJkxMIP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D07B1D31A9;
	Fri,  6 Sep 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642060; cv=none; b=T5VuqpGzbEZJ6TtN2RYlDJm4D+2sIB8X+dwuk1TU4A6HjLtDQGMJ4632zLHIaitZvtbgLlqKQbQl80/Hb4dIjKQ4m5sKU+bHFQwD6pEeP2GcAhQl/wnj8YNolkJXOWKdlyouOcW1teZJwiiykHub1U0xT/HDlL1ofKVw5OllQIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642060; c=relaxed/simple;
	bh=simd4F4yqBI2iBVIilUana9NXDta14kO2KiZGPtWiZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQfoxL+NZUpKdkNmxOz39JGntzh6tbG3GZRDz/fBPgmcZH4cvHYYFwN9lqHqiKzB6jG5MxPn1rDZqKQCqSuTLBFdvY0gQruPQYWtxazP4HqQEZWi6nGsPo8UJshU/Zb/li93RiT1yysikQJEduJX+Mtb9f9xNIPle9vHNYhFZtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AjJkxMIP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78075C4CEC4;
	Fri,  6 Sep 2024 17:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725642060;
	bh=simd4F4yqBI2iBVIilUana9NXDta14kO2KiZGPtWiZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AjJkxMIPcmQdrgHo+94VqmOBbRGn/A55WQIFbO6ac609H9s2/KmD1jDJpLGN7y/oX
	 op2K1ub1FVlo+0EcEF/oPehRzt1FWPj4Od8TzXHheRkiFDAxd/KDPF56aNTLoeUcHE
	 lsLTiAVMh5z1p9og9BbTTdt++ab9aR25nP26pqXo=
Date: Fri, 6 Sep 2024 19:00:56 +0200
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
Message-ID: <2024090620-clause-unfrozen-f493@gregkh>
References: <20240906164543.2268973-1-paddymills@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906164543.2268973-1-paddymills@proton.me>

On Fri, Sep 06, 2024 at 04:45:49PM +0000, Patrick Miller wrote:
> Adds a check for documentation in rust file. Warns if certain known
> documentation headers are not plural.
> 
> Signed-off-by: Patrick Miller <paddymills@proton.me>
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1110
> 
> ---
>  scripts/checkpatch.pl | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 39032224d504..0e99d11eeb04 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3900,6 +3900,14 @@ sub process {
>  			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/core-api/asm-annotations.rst\n" . $herecurr);
>  		}
>  
> +# check that document section headers are plural in rust files
> +        if (   $realfile =~ /\.rs$/
> +            && $rawline =~ /^\+\s*\/\/\/\s+#+\s+(Example|Invariant)\s*$/ )
> +        {
> +            WARN( "RUST_DOC_HEADER",
> +                "Rust doc he
> aders should be plural\n" . $herecurr );

Something went wrong, your patch lost the tabs and it had a line wrap?

And why is Rust unique for plurals here?  What if there really is only
one example?

thanks,

greg k-h

