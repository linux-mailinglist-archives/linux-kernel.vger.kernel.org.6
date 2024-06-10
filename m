Return-Path: <linux-kernel+bounces-208424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D83902506
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B6D1C22A7E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59972139578;
	Mon, 10 Jun 2024 15:10:21 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412C61E4A0;
	Mon, 10 Jun 2024 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032220; cv=none; b=cJCiZMKy8zKjFtLuYP7DEyYcTi4L+lwNFxHsQwDiInchbwsB1rPEf/Fs+mv63YlMTEuAj2EgkkZcQs0Q41nDSrlFuKmnKKd5XiD9/ZuTAWQGMSQ7T3YrQY8ONWfAZliSGl0uzkZiZWKVe3FhDV8xdff+PuSOmGHAszgebobVc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032220; c=relaxed/simple;
	bh=I8084Qz3wl6Sg3NijYzP71C3nEnhmZP4BG7TCRsix+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IEx8ir6tNt8XW4m2yWGt4KRrLbGL5f+b9Az8maopQNlGkKNEmNYV48ksEh81zNhJEWj46uShKuxiMb4QQhufChPCQTIfg2umlAH6/IvoJdzopn4U/lHkz26phtTDcmSdjiFfIq8f2U2yDn8GeAYFB6yqM4s17wbC/IDWeqgjNXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 0B7E11A1057;
	Mon, 10 Jun 2024 15:10:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 78A8D2F;
	Mon, 10 Jun 2024 15:10:07 +0000 (UTC)
Message-ID: <a38e45d210f07e47bfde70e366d23f9755290d25.camel@perches.com>
Subject: Re: [PATCH v4 RESEND] checkpatch: check for missing Fixes tags
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, Andy Whitcroft
 <apw@canonical.com>,  Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas
 Bulwahn <lukas.bulwahn@gmail.com>,  linux-kernel@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <keescook@chromium.org>, Sasha Levin <sashal@kernel.org>, Tom
 Gall <tom.gall@linaro.org>,  kernel-janitors@vger.kernel.org
Date: Mon, 10 Jun 2024 08:10:06 -0700
In-Reply-To: <Zmbf3AaZh4sbPhYB@moroto>
References: <Zmbf3AaZh4sbPhYB@moroto>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: 4iwd39bczr4jr5ztbqju7yyorjbyg9nb
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 78A8D2F
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/URrnG2JSDjWd0RUikCCbtm2oHEn5ydVs=
X-HE-Tag: 1718032207-742403
X-HE-Meta: U2FsdGVkX19MwJgcQLxo4qt7+AnP1so/ciY28kWy3vwL4tJBLJl3r1UMqaFxV0ty3xXRabPxx13rs0+4iRtAraGERowURFxYjhghoeuXEOrruzneU7DvTlpDJmuaE6UFWUJmy2FL3eUV4AC6/mioOnCY4q/RZV2G3sHikqNh+HNN/lpZhr3W24KOC9DLG4e4WqAGxyjX10c6hRdTbqu7AP2iLIsvMafc3XAOKamFg3kA9C8pYMQ2BQJKeuqXh/HeTEPYA6LguuDVUdmVpV7Pj6RUu0l8PeocJvdyBZWqQEqBJhVp4Ocd7eim2Tk3glluiYvEB4hSl1GmKPzrt0E4bAd1qEQsuhj65yrqjGUgbAn3CU5mI1YokyCl57oDAkVt

On Mon, 2024-06-10 at 14:13 +0300, Dan Carpenter wrote:
> This check looks for common words that probably indicate a patch
> is a fix.  For now the regex is:
>=20
> 	(?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller)/)
>=20
> Why are stable patches encouraged to have a fixes tag?  Some people mark
> their stable patches as "# 5.10" etc.  This is useful but a Fixes tag is
> still a good idea.  For example, the Fixes tag helps in review.  It
> helps people to not cherry-pick buggy patches without also
> cherry-picking the fix.
>=20
> Also if a bug affects the 5.7 kernel some people will round it up to
> 5.10+ because 5.7 is not supported on kernel.org.  It's possible the Bad
> Binder bug was caused by this sort of gap where companies outside of
> kernel.org are supporting different kernels from kernel.org.
>=20
> Should it be counted as a Fix when a patch just silences harmless
> WARN_ON() stack trace.  Yes.  Definitely.
>=20
> Is silencing compiler warnings a fix?  It seems unfair to the original
> authors, but we use -Werror now, and warnings break the build so let's
> just add Fixes tags.  I tell people that silencing static checker
> warnings is not a fix but the rules on this vary by subsystem.
>=20
> Is fixing a minor LTP issue (Linux Test Project) a fix?  Probably?  It's
> hard to know what to do if the LTP test has technically always been
> broken.
>=20
> One clear false positive from this check is when someone updated their
> debug output and included before and after Call Traces.  Or when crashes
> are introduced deliberately for testing.  In those cases, you should
> just ignore checkpatch.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +# These indicate a bug fix
> +		if (!$in_header_lines && !$is_patch &&
> +			$line =3D~ /^This reverts commit/) {
> +			$is_revert =3D 1;
> +		}
> +
> +		if (!$in_header_lines && !$is_patch &&
> +		    $line =3D~ /(?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller)=
/) {
> +			$needs_fixes_tag =3D 1;

Maybe use
		    $line =3D~ /((?:(?:BUG: K.|UB)SAN: |Call Trace:|stable\@|syzkaller))/=
) {
			$needs_fixes_tag =3D $1;

> @@ -7697,6 +7715,12 @@ sub process {
>  		ERROR("NOT_UNIFIED_DIFF",
>  		      "Does not appear to be a unified-diff format patch\n");
>  	}
> +	if ($is_patch && $has_commit_log && $chk_fixes_tag) {
> +		if ($needs_fixes_tag && !$is_revert && !$fixes_tag) {

and

+		if ($needs_fixes_tag ne "" && !$is_revert && !$fixes_tag) {

> +			WARN("MISSING_FIXES_TAG",
> +			     "This looks like a fix but there is no Fixes: tag\n");

and

			     "The commit message has '$needs_fixes_tag', perhaps it also needs a=
 'Fixes:' tag?\n");


