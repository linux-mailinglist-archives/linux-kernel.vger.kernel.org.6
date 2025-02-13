Return-Path: <linux-kernel+bounces-512856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13850A33E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A562616A114
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CF521D3D9;
	Thu, 13 Feb 2025 11:53:39 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B4211A06;
	Thu, 13 Feb 2025 11:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739447619; cv=none; b=Ytcw50O8voywwWjuRgOH6fj9VrYKeQzPXyveReHlbJkUbVZpEVZ4TuWPTscXl2mHYcX6n+Bi3zMBY4scCT60rKCiW0HXiFbZu2kT2iMIQojF8pHcMdfJzv9+Z5/BsI064Lrj4XVEqleYjYGwkQ68I31ywHBRB5EuuSaet7mxJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739447619; c=relaxed/simple;
	bh=1m0OGVvYiMzyU/Al+rHj9xfSMxsEdfHNWdimWID281g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qGNH4GEmbq39iYl0vMnEhqh/U5yD+9FRI/j+Dca/XygToYmsiwdIK9Mk52WYRTyExidXAhLjLARP5g62OIzu15NC46tG+fUll6TPQ9XLDQ24lG/wkzD4ko+WUmXNqEBIHceBIHl315omKEWgkgYRrwMsuy4NJVWyZwUVQ9XZdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id CBE93160C95;
	Thu, 13 Feb 2025 11:17:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 2846C20024;
	Thu, 13 Feb 2025 11:17:10 +0000 (UTC)
Message-ID: <3a6b43bad48592887d4e67ca854eef2728464b1c.camel@perches.com>
Subject: Re: [PATCH 3/3] checkpatch: throw error in malformed arrays
From: Joe Perches <joe@perches.com>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>,
 a.hindborg@kernel.org, 	alex.gaynor@gmail.com, aliceryhl@google.com,
 apw@canonical.com, arnd@arndb.de, 	aswinunni01@gmail.com, axboe@kernel.dk,
 benno.lossin@proton.me, 	bhelgaas@google.com, bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com, 	dakr@kernel.org, dwaipayanray1@gmail.com,
 ethan.twardy@gmail.com, 	fujita.tomonori@gmail.com, gary@garyguo.net,
 gregkh@linuxfoundation.org, 	lukas.bulwahn@gmail.com, ojeda@kernel.org,
 pbonzini@redhat.com, tmgross@umich.edu, 	walmeida@microsoft.com
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 13 Feb 2025 03:17:09 -0800
In-Reply-To: <20250212194857.192057-2-trintaeoitogc@gmail.com>
References: <20250212194857.192057-1-trintaeoitogc@gmail.com>
		 <20250212194857.192057-2-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 2846C20024
X-Stat-Signature: e96gph4aujxetmny1csqx8nicmteb6q7
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18H8+KsScZnw537mEqSkVKamgRYHz6HC0g=
X-HE-Tag: 1739445430-615866
X-HE-Meta: U2FsdGVkX18gOCee0rqLeEKBX9xiZX2lYSDmNX3ywTtEr4285ESqEpiNK9y1ltxdBVEnTg1/mu60UvNitBUAyEuQm0XiNvWn4nK9aK4KGi6tD7AgsMDSeiwhQ7JoSwZNi3Hx7EscCFJ4eNq5nmm1XwXf4d2ZqFfyMADFb2fIGMCeBCUz6vLYpreDf4hRBBSaMAtLrfrVsQMjHuAOGh//ytT5e1MKjKD/sDZg1014RMV/cAPf30OxE3bBvWe1/rXZIT2X2wMGBnxMGEHnBwC9w5fPj3RnDR+jgJUlC6CXULaZFO4/ShGXiXGKv5kX2kb4

On Wed, 2025-02-12 at 16:48 -0300, Guilherme Giacomo Simoes wrote:
> In module! macro, some fields have a string array type, and we need a
> check for guarantee a good formatation.

Isn't this is a style desire not a parsing limitation?

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2775,6 +2775,9 @@ sub process {
>  	$realcnt =3D 0;
>  	$linenr =3D 0;
>  	$fixlinenr =3D -1;
> +
> +	my %parse_module_arr;

Probably not useful to add hungarian style naming.

> @@ -3567,6 +3570,71 @@ sub process {
>  # ignore non-hunk lines and lines being removed
>  		next if (!$hunk_line || $line =3D~ /^-/);
> =20
> +# check if arrays has more than one value in the same line
> +		my $inline =3D 0;
> +		if ($line =3D~ /^\+\s*.*\b(author|alias|firmware)\s*:\s*\[/) {

\s*.* could be just .*

> +			$inline =3D 1;
> +
> +			if ($line =3D~ /author/) {
> +				$parse_module_arr{'author'} =3D 1;
> +			}
> +
> +			if ($line =3D~ /alias/) {
> +				$parse_module_arr{'alias'} =3D 1;
> +			}
> +
> +			if ($line =3D~ /firmware/) {
> +				$parse_module_arr{'firmware'} =3D 1;
> +			}

$parse_module_arr{$1} =3D 1;

> +		}
> +
> +		if (keys %parse_module_arr) {
> +			my @keys =3D keys %parse_module_arr;
> +			my $key =3D $keys[0];
> +
> +			my $more_than_one_vl =3D qr/".+",\s*".+"/;
> +
> +			if ($line =3D~ $more_than_one_vl) {
> +					ERROR("ERR_ARRAY_MODULE_MACRO",
> +						"the key $key have more than one values in same line\n$here\n". ca=
t_vet($rawline));

"Prefer one value per line\n"

ERR_ error prefixes are not useful.
These seem more like a WARN than an ERROR
Bad indentation
And please use a $herevet temporary


> +			}
> +			elsif ($inline && $line !~ /\]/ && $line =3D~ /\["/) {
> +					ERROR("ERR_ARRAY_MODULE_MACRO",
> +						qq~the key $key need a new line after declare the key\n$here\n~ . =
cat_vet($rawline) . qq~\nFor example:

Use } elsif

"Prefer declaring keys on separate lines"

Are quote characters allowed in keys?
If not, this seems unnecessarily complicated.

$herevet

I think the qq is unnecessary and the for example
should refer to some style documentation and not
be explicit in checkpatch.


