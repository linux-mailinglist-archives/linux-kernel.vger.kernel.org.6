Return-Path: <linux-kernel+bounces-527772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBD3A40F49
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 15:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43121188B9CA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 14:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5ECF2080D4;
	Sun, 23 Feb 2025 14:35:41 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED971DB548;
	Sun, 23 Feb 2025 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740321341; cv=none; b=rHFGFOq5QieKLSmkZbQdJ7KcsPeQp251iRKfF5a509KecwtKK5CyW4rBk0+niFsZdhwC23inRI9FkNOwOZZxq0RXQOfo0ogkjHgN1/9k4ddsGmrCrAQI22bGU9NEOp03VnVILCRSCUM9AlnI4bBmVB0q0yMEHTrl9jqmZzY6yRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740321341; c=relaxed/simple;
	bh=S/4W+YLqPBFiEMJLqaBlV8vLZnmayjH5UEE/GmTDXs8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o80eMAaOTnLvVvuPRzH1dKbtA51A+hDJJUn5HPwMibineACgoJTfXk7VTDOPNzcjqtLtbHkTgs59ivuRlaueRKwdmR1T1xn+A/geFZmeQWGIz7KPrrA9CApGrprBJajYjxbu1sz4OZZhdfy90NHXFKSZ4qASxxRa1SdMP7TWmto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 85DA2B81D9;
	Sun, 23 Feb 2025 14:34:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 06E672F;
	Sun, 23 Feb 2025 14:34:35 +0000 (UTC)
Message-ID: <3ccc3d3e756e82af53b4f75c4ab9cc99e555da1a.camel@perches.com>
Subject: Re: [PATCH V5 2/2] checkpatch: throw error for malformed arrays
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
Date: Sun, 23 Feb 2025 06:34:35 -0800
In-Reply-To: <20250223002119.2432-3-trintaeoitogc@gmail.com>
References: <20250223002119.2432-1-trintaeoitogc@gmail.com>
	 <20250223002119.2432-3-trintaeoitogc@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: h7z75neheimcbby7aqpuc9hsqhew13ss
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 06E672F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Uyv2/o6G5DO6f9Ko/Le6bwc4zAd8K2bA=
X-HE-Tag: 1740321275-503264
X-HE-Meta: U2FsdGVkX1/56NPq0mWbL0T1zCvh170oWjpbgD9WjUhsFmy+assQ+cqrGuankm2LejnpLxfbjYLpVQGO9S414dH/kNy6WEcC67zyyzeDsqdbtSrdzpZiq9Po4QjKGu6ruBo9isdoUpidFucXaoYOTKzGRldT9eFA/F7lAhkPmzeqJdrBddM/acCYgODZuVQRRzUOVbjDyOmpmj3wYyCmPNaLqJ5VaIXHkAupcfzh6U5pLlTcz72hi7eTspERHmFVc2ev/iGZ+XYUJXZLoyMBUyLIpgX552+o84RfiDD6x6RnqHbqyNrTjE4E2I8q13KM

On Sat, 2025-02-22 at 21:21 -0300, Guilherme Giacomo Simoes wrote:
> Implement a check to ensure that the author, firmware, and alias fields
> of the module! macro are properly formatted.

Poor email subject.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3567,6 +3570,46 @@ sub process {
>  # ignore non-hunk lines and lines being removed
>  		next if (!$hunk_line || $line =3D~ /^-/);
> =20
> +# check if the field is about author, firmware or alias from module! mac=
ro and find malformed arrays
> +		my $inline =3D 0;
> +		my $key =3D "";
> +		my $add_line =3D $line =3D~ /^\+/;
> +
> +		if ($line =3D~ /\b(authors|alias|firmware)\s*:\s*\[/) {
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
> +				     "Prefer each array element on a separate line\n". $herevet);
> +			} elsif ($inline && $line !~ /\]/ && $line !~ /,/ && $line =3D~ /"/) =
{
> +				WARN("ARRAY_MODULE_MACRO",
> +				     "Prefer declare ] on the same line\n$herevet");

Convert all the messages.  Use consistent style.

> +			} elsif (!$inline && $line =3D~ /\]/ && $line =3D~ /\"/) {
> +				WARN("ARRAY_MODULE_MACRO",
> +				     "Prefer a new line after the last value and before ]\n" . $here=
vet);
> +			} elsif ($inline && $line =3D~ /,/ && $line !~ /\]/) {
> +				WARN("ARRAY_MODULE_MACRO",
> +				     "Prefer a new line after [\n$herevet");

twice.


