Return-Path: <linux-kernel+bounces-527071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 253EDA406FE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47BE470552B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCF720765F;
	Sat, 22 Feb 2025 09:38:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D865D2EB10;
	Sat, 22 Feb 2025 09:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217124; cv=none; b=V8q858M4SWLQhbSKH06D0HDFGaa8dIztncVYou+yDSdrv9GBx/4k5PTWgF00sZk7IywgNf4O/CtQUdGIoq/UgN//kATTUwA01YmFV9311T4NmfZINOgou+r6NBaJA08ZK0Di0XgHSwfAHLqSlVDaJiY0JH9yjvhAvAOT6l2Zi/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217124; c=relaxed/simple;
	bh=81CwVnRJvu2Y6GtE2WQ0m4RNHkh/EveDRR9Sbo9ev/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pz7H09KwmjOjotYsM8DBO/LH3ZGv6LHKMmUiVYW7GEoDrAIYfhrqufuVF6bC0PvLu0eywFCfEjXXqOnTJoHwVzXrwtOB3q9p/vCiUX7MijVhR/fulDZrs5JJ4hbJqdsrE+mq8yB/UpeT8/l6LMx9O7y/c+EyDgR36r5v6/YAuaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 7D103A182F;
	Sat, 22 Feb 2025 09:22:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id C58862001E;
	Sat, 22 Feb 2025 09:22:26 +0000 (UTC)
Message-ID: <b150157b266b0aa78e26b1feb5a6b3d7735a2293.camel@perches.com>
Subject: Re: [PATCH V4 2/2] checkpatch: throw error for malformed arrays
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
Date: Sat, 22 Feb 2025 01:22:25 -0800
In-Reply-To: <20250221182142.42134-3-trintaeoitogc@gmail.com>
References: <20250221182142.42134-1-trintaeoitogc@gmail.com>
	 <20250221182142.42134-3-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C58862001E
X-Rspamd-Server: rspamout04
X-Stat-Signature: ceodgnphax6zihedizaiuejbxzgktzqm
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/JuRLbGDBosttEi24RL7kERqCF7/JjNck=
X-HE-Tag: 1740216146-8395
X-HE-Meta: U2FsdGVkX18VQpffAksbecyNjxDW4K/EgWafRPAJEoDjBNi0WOoqTMEVATPqrujp8ACtOUEaXuVfh7A1XcKv62947xPMUVGhZJ4m/Z+Nyo7MDn8rg8Oc+jpZWyCnLf6bkWOkOEyk2/VFxFku9qQSF5ISpYOagXsdvvrlenz4REbPMYmQS9XJxm1O6bQqkGI863gvgclJq0yY8p7uyMHjJ7kNgtJHM50nT26SUtJtjf5/SITwYOKtUMVPsvWrWDCDg330tPY9ugvRBiI+8fd25T3dDbcjCx+YtCtAy1CQxuYqiQpknJkFtONog75EZJbJ

On Fri, 2025-02-21 at 15:21 -0300, Guilherme Giacomo Simoes wrote:
> Implement a check to ensure these fields are correctly formatted. If a
> line contains one of these keys that should be of type Vec<String>, use
> a regex to verify whether the array holds multiple values.
> * If the array contains more than one value, enforce vertical formatting
> * If the array has only one value, it can remain on the same line

Malformed arrays of what type?

[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2775,6 +2775,9 @@ sub process {
>  	$realcnt =3D 0;
>  	$linenr =3D 0;
>  	$fixlinenr =3D -1;
> +
> +	my %array_parse_module;
> +
>  	foreach my $line (@lines) {
>  		$linenr++;
>  		$fixlinenr++;
> @@ -3567,6 +3570,46 @@ sub process {
>  # ignore non-hunk lines and lines being removed
>  		next if (!$hunk_line || $line =3D~ /^-/);
> =20
> +# check if arrays has more than one value in the same line

check if what kind of array otherwise this comment is very poor.
Arrays commonly have more than one value assigned on a single line like

	int foo[] =3D { 1, 2, 3 };

> +		my $inline =3D 0;
> +		my $key =3D "";
> +		my $add_line =3D $line =3D~ /^\+/;
> +
> +		if ($line =3D~ /\s*.*\b(authors|alias|firmware)\s*:\s*\[/) {

The initial "\s*.*" portion of this regex isn't necessary
and can be removed
=3D
> +			$inline =3D 1;
> +			$array_parse_module{$1} =3D 1;
> +		}
> +
> +		my @keys =3D keys %array_parse_module;
> +		if (@keys) {
> +			$key =3D $keys[0];
> +		}
> +
> +		if ($add_line && $key) {
> +			my $herevet =3D "$here\n" . cat_vet($rawline) . "\n";
> +
> +			my $counter =3D () =3D $line =3D~ /"/g;
> +			my $more_than_one =3D $counter > 2;
> +			if ($more_than_one) {
> +				WARN("ARRAY_MODULE_MACRO",
> +				"Prefer each array element on a separate line\n$herevet");

As I wrote in an earlier submission, please align to open parenthesis
and use the common form for the message with $herevet

				WARN("ARRAY_MODULE_MACRO",
				     "Prefer each array element on a separate line\n" . $herevet);

> +			} elsif ($inline && $line !~ /\]/ && $line !~ /,/ && $line =3D~ /"/) =
{
> +				WARN("ARRAY_MODULE_MACRO",
> +				"Prefer declare ] on the same line\n$herevet");

etc...


