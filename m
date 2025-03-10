Return-Path: <linux-kernel+bounces-554962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF5AA5A3E5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635293AB42D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33D22318;
	Mon, 10 Mar 2025 19:38:50 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76051CAA60
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635530; cv=none; b=tF0KBZx5b/kBjdDMu4EVtVo8twP7kA2T3yFJq8VHD+eB6aPiDwpie+EK21IRuqlwQGf3E0sSOMs21bV2ldPthNIzqMcdhq9G+HTdr/IRj2/8dSTMB31ZsQrulegfebPtnC10XTWn2HvbVeFqKEqPJjdH+UR3Gg/qhEFxexf1UvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635530; c=relaxed/simple;
	bh=p9ZZKrEOoR40lH9EoVCJzDAUOL+2yCiU0S5R4LpxHp0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nqx8e/ZepOkwf0OpgNODbn+ddaSLaauDnmXg1U7AnfoCRpAJoUDC4Vvmswf46e84DxC8haf646QIS/oCKnBN523CL3x7RTuh7B20opJl0GfkQgFW9QhFMhYN/B5Y3SqakoZCU11q1ALPAyISw1+ENeY8Wd08O5xJnk7a1i2zbhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 32B38B996A;
	Mon, 10 Mar 2025 19:38:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf18.hostedemail.com (Postfix) with ESMTPA id 9EBD431;
	Mon, 10 Mar 2025 19:38:42 +0000 (UTC)
Message-ID: <95d462018382f51ac88471fb555653b2b6601100.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Describe --min-conf-desc-length
From: Joe Perches <joe@perches.com>
To: Philipp Hahn <phahn-oss@avm.de>, linux-kernel@vger.kernel.org, Andrew
 Morton <akpm@linux-foundation.org>
Cc: Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>,  Lukas Bulwahn <lukas.bulwahn@gmail.com>,
 Philipp Hahn <p.hahn@avm.de>
Date: Mon, 10 Mar 2025 12:38:22 -0700
In-Reply-To: <c71c170c90eba26265951e248adfedd3245fe575.1741605695.git.p.hahn@avm.de>
References: 
	<c71c170c90eba26265951e248adfedd3245fe575.1741605695.git.p.hahn@avm.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9EBD431
X-Rspamd-Server: rspamout04
X-Stat-Signature: 69wo6514spjedkfkcus61af416bw5t14
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/tNPfUa4XU0LdRXTnpDhVxdlgocjb15fE=
X-HE-Tag: 1741635522-117231
X-HE-Meta: U2FsdGVkX1/bKrUdrgefrTjIC1N0fubvYz2FZAImQzxXPLLPuOFB7ucSEg3mpEqKKLi4XM/iIThYmT1oMUczvS2rH9gJgOEuI/ppcCqcG6dgLQR1qj1VF/YdxCDNQnILABFJynvj/D6b4ER+KZko/3buXWQbnTddnI2Upsmt3S7gG+7GfnUBN5g4eywFyfdijdGEofZCIVc905BkQhuEEdjXAMuTlKkiCipPVftH6y62yZFUNzQkHrASoU15nB7xVa7F3lArfVMdPwLCuc1h4UDP2eyClBhU6R2OyRe+anQqYibM6NXL+O8JOiSImUkuawD4wEbvQL1VZc/YHhgYT7mBx2y6TTjBS1Lkdq4Mebrv0jU3ZeY2Ke8er95CnvYxNKzJ9uLFaWzEvFZkm0zr2F47Cvvx3HMsTv632h8hg4M56InpZs5KJMWe+THVkMC4btgJKfzTqtpFPqBnHAVZzg==

On Mon, 2025-03-10 at 12:22 +0100, Philipp Hahn wrote:
> Neither the warning nor the help message gives any hint on the unit for
> length: Could be meters, inches, bytes, characters or ... lines.

I've no objection to this.

>=20
> Extend the output of `--help` to name the unit "lines" and the default:
> -  --min-conf-desc-length=3Dn   set the min description length, if shorte=
r, warn
> +  --min-conf-desc-length=3Dn   set the minimum description length for co=
nfig symbols
> +                             in lines, if shorter, warn (default 4)
>=20
> Include the minimum number of lines as other error messages already do:
> - WARNING: please write a help paragraph that fully describes the config =
symbol
> + WARNING: please write a help paragraph that fully describes the config =
symbol with at least 4 lines
>=20
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Signed-off-by: Philipp Hahn <p.hahn@avm.de>
> ---
>  scripts/checkpatch.pl | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7b28ad331742..784912f570e9 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -113,7 +113,8 @@ Options:
>    --max-line-length=3Dn        set the maximum line length, (default $ma=
x_line_length)
>                               if exceeded, warn on patches
>                               requires --strict for use with --file
> -  --min-conf-desc-length=3Dn   set the min description length, if shorte=
r, warn
> +  --min-conf-desc-length=3Dn   set the minimum description length for co=
nfig symbols
> +                             in lines, if shorter, warn (default $min_co=
nf_desc_length)
>    --tab-size=3Dn               set the number of spaces for tab (default=
 $tabsize)
>    --root=3DPATH                PATH to the kernel tree root
>    --no-summary               suppress the per-file summary
> @@ -3645,7 +3646,7 @@ sub process {
>  			    $help_length < $min_conf_desc_length) {
>  				my $stat_real =3D get_stat_real($linenr, $ln - 1);
>  				WARN("CONFIG_DESCRIPTION",
> -				     "please write a help paragraph that fully describes the config =
symbol\n" . "$here\n$stat_real\n");
> +				     "please write a help paragraph that fully describes the config =
symbol with at least $min_conf_desc_length lines\n" . "$here\n$stat_real\n"=
);
>  			}
>  		}
> =20


