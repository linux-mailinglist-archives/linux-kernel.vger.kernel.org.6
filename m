Return-Path: <linux-kernel+bounces-274514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18F3947931
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8D91F22109
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 10:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A394513B599;
	Mon,  5 Aug 2024 10:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnTmbyAJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71E418040;
	Mon,  5 Aug 2024 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853037; cv=none; b=fsiYRa7TiZ4x3i5zhYDzjmsD8Vd6zvSZ0TJ7TCeJeMFl/Bkf/zv9QDksNllbVPJ4RJSKy447XIfxc/wd5rUO+7XIO7/8HaJSmuXgfr8SNvzPvLkB5DWDlm5tf65FpSr54CQmmxK2wv3zINcaaXlRQeEPJqCL5cMXaIPat4W5Wn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853037; c=relaxed/simple;
	bh=MHe9tTcbFgoOBRxEB6E0kr0JxBxZ7aKJJhgU6KNwnAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E2++06wcTZuclnE2GbXlCw2ar9dKf+TEnLkqpJkGi3m0/Pq9Ggie4IMDUrGWlVfc6oQG8rr6rzRctlaBf6lDo14lnJov7FXtp+UGbUCDSwSZSQ35jH0RWxjLiItQfo/iGlPx5I0gZAAbkmTL5K+jaqbmI3fYSTcc+LKzYwLCm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnTmbyAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8874AC4AF0D;
	Mon,  5 Aug 2024 10:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722853037;
	bh=MHe9tTcbFgoOBRxEB6E0kr0JxBxZ7aKJJhgU6KNwnAg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MnTmbyAJn13897HMv90r8yjwra5kgUzkXMT2HAjChMfDmU4TsSQRoyoPgH80dW01p
	 T1zHWgzcPTd/u1wsWyvlik4Po2YBZcgTVRB87LisoxGz0Iewi0ST1FWgDzHtZB4km3
	 j+284WcQ6LA61ntCkvteiP9lcScPbVtl2Hs+zFsIYtxFjIxpUmyfXNCySWid1/X0C+
	 ehYvKI+EtQkMa+6RWU8ShKgtGAn4Wg2BlCEvjN9hTrjFR1D0auzJM25qiTEQOEipSN
	 qiD2iUaVU03UpxU2HXjTDvhIMRMZ+07/TpbQ3CYtxrbvZS3aHjQ5WQ5GgTwrsLEL1k
	 FuhkMuP6cwujQ==
Message-ID: <8184a4fe-ddfb-4c38-be2f-e8d808ce777b@kernel.org>
Date: Mon, 5 Aug 2024 12:17:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RESEND PATCH v2] checkpatch: skip warnings for symbol links
Content-Language: en-GB
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
 Dwaipayan Ray <dwaipayanray1@gmail.com>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Geliang Tang <geliang@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev
References: <dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <dc502b1b45cb27fda48d72d73e3267a32db023d8.1717722648.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy, Joe, Dwaipayan, Lukas,

I'm sorry to bother you about that, but it looks like the following
patch from Geliang didn't get any review from your side. Do you mind
having a look at this non-urgent patch when you have a bit of free time
please?

Cheers,
Matt

On 07/06/2024 03:12, Geliang Tang wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> If there is a symbol link in the given patch, like the following one:
> 
> $ cat 0001-selftests-bpf-Add-mptcp-pm_nl_ctl-link.patch
> 
>  '''
>  # diff --git a/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c \
>  #            b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
>  # new file mode 120000
>  # index 000000000000..5a08c255b278
>  # --- /dev/null
>  # +++ b/tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c
>  # @@ -0,0 +1 @@
>  # +../net/mptcp/pm_nl_ctl.c
>  # \ No newline at end of file
>  '''
> 
> checkpatch.pl reports two inaccurate warnings:
> 
>  '''
>  WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
>  #65: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
>  +../net/mptcp/pm_nl_ctl.c
> 
>  WARNING: adding a line without newline at end of file
>  #65: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
>  +../net/mptcp/pm_nl_ctl.c
>  '''
> 
> And three checks if run it with strict option:
> 
>  '''
>  CHECK: spaces preferred around that '/' (ctx:VxV)
>  #65: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
>  +../net/mptcp/pm_nl_ctl.c
>    ^
> 
>  CHECK: spaces preferred around that '/' (ctx:VxV)
>  #65: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
>  +../net/mptcp/pm_nl_ctl.c
>        ^
> 
>  CHECK: spaces preferred around that '/' (ctx:VxV)
>  #65: FILE: tools/testing/selftests/bpf/mptcp_pm_nl_ctl.c:1:
>  +../net/mptcp/pm_nl_ctl.c
>  '''
> 
> This patch fixes this by adding a new variable $symbol_link in checkpatch
> script, set it if the new file mode is 120000. Skip "missing or malformed
> SPDX-License-Identifier tag", "adding a line without newline at end of
> file" and "spaces preferred around that '/'" checks if this variable is
> set.
> 
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
> v2:
>  - fix warnings with strict option too.
> ---
>  scripts/checkpatch.pl | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2b812210b412..1f3ce5ffe914 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2694,6 +2694,8 @@ sub process {
>  
>  	my $checklicenseline = 1;
>  
> +	my $symbol_link = 0;
> +
>  	sanitise_line_reset();
>  	my $line;
>  	foreach my $rawline (@rawlines) {
> @@ -3564,6 +3566,11 @@ sub process {
>  # ignore non-hunk lines and lines being removed
>  		next if (!$hunk_line || $line =~ /^-/);
>  
> +# Check for symbol links
> +		if ($line =~ /^new file mode 120000$/) {
> +			$symbol_link = 1;
> +		}
> +
>  #trailing whitespace
>  		if ($line =~ /^\+.*\015/) {
>  			my $herevet = "$here\n" . cat_vet($rawline) . "\n";
> @@ -3756,7 +3763,8 @@ sub process {
>  				}
>  
>  				if ($comment !~ /^$/ &&
> -				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @) {
> +				    $rawline !~ m@^\+\Q$comment\E SPDX-License-Identifier: @ &&
> +				    $symbol_link =~ 1) {
>  					WARN("SPDX_LICENSE_TAG",
>  					     "Missing or malformed SPDX-License-Identifier tag in line $checklicenseline\n" . $herecurr);
>  				} elsif ($rawline =~ /(SPDX-License-Identifier: .*)/) {
> @@ -3867,7 +3875,8 @@ sub process {
>  		}
>  
>  # check for adding lines without a newline.
> -		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/) {
> +		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/ &&
> +		    $symbol_link =~ 1) {
>  			if (WARN("MISSING_EOF_NEWLINE",
>  			         "adding a line without newline at end of file\n" . $herecurr) &&
>  			    $fix) {
> @@ -5293,7 +5302,7 @@ sub process {
>  					 $op eq '*' or $op eq '/' or
>  					 $op eq '%')
>  				{
> -					if ($check) {
> +					if ($check && $symbol_link =~ 1) {
>  						if (defined $fix_elements[$n + 2] && $ctx !~ /[EW]x[EW]/) {
>  							if (CHK("SPACING",
>  								"spaces preferred around that '$op' $at\n" . $hereptr)) {

-- 
Sponsored by the NGI0 Core fund.


