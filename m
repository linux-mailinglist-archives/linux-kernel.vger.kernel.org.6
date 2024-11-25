Return-Path: <linux-kernel+bounces-421587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3ED9D8D35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 21:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E2816B058
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BA61C1F13;
	Mon, 25 Nov 2024 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaV0lziH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F372500CC;
	Mon, 25 Nov 2024 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732565128; cv=none; b=FgzNlVwm6mDXhI1gmgkWeRVQzOKECZ36ycusDGWJuCvmyP1i1ltS1dhCDESHXVbi9AB1yIRMcpu8LFEjyt+wS2W+3kdDWZ7GbAU8SB3vp8D+P34bGXtd1w6O6rAlU8H3yZuyprxYw2MaCxd66MIapj2jtKB268y8PDycBtaGQLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732565128; c=relaxed/simple;
	bh=UxwyjtUe4HWULN/1UeddpcffuhI6GTXgMMa2lfXhhQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLTh03A8kmP6RNjNJ7jOA9FdnuGbFgAgb3q2928BFqYk6LLrJb3uPThSi5X5LWMTIlKYEmLrhxrCWoT0vP7yfAAth9F25yXnbnaHrL8nW3peU7XYhBYMj+Ved1f0xR16olKyor2DZ7eBSc10sp7eQJQPtS1Bh2Asg9KZDjvMJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaV0lziH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE8BC4CECE;
	Mon, 25 Nov 2024 20:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732565128;
	bh=UxwyjtUe4HWULN/1UeddpcffuhI6GTXgMMa2lfXhhQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LaV0lziHx176+R928kxhqpIFPcqXBCChMgroVh66rYDsH9j47uTZsPgAUy/DA/kW+
	 KIVGB3Vp+JThv3QDSpm7u+kruFWscK5kSOaYwfK6sMTATs548ynkq0d4Ns6APmfcdj
	 Emy0GPPb/PdjeEF6361mmP90L8+fDQKhk9pQyVy2xzMMXT5c80y7ZRcy28wPE6S0n1
	 z5YX7jPD+QXtbtGZyWkuIi8xaO3y1VC3wU5s884wt6PSYvdcsU2EvofnSm4ixve2kj
	 6fA4kc2E7yZBcvVLyAIBPbmwNZWeKd9y3hJQRTUQknQP/85nYZyrrRR54oWyAHDgmP
	 8/d213g9Ew3eg==
Date: Mon, 25 Nov 2024 21:05:05 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Kees Cook <kees@kernel.org>, 
	torvalds@linux-foundation.org, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Re: linus-next: improving functional testing for to-be-merged
 pull requests
Message-ID: <gwcovjajuiiyw4v57jafnfjquoxtnlw23kwyzn2nla42zia6pp@ic3eoqom2wwo>
References: <ZxZ8MStt4e8JXeJb@sashalap>
 <792F4759-EA33-48B8-9AD0-FA14FA69E86E@kernel.org>
 <ZxdKwtTd7LvpieLK@infradead.org>
 <ZyAUO0b3z_f_kVnj@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyAUO0b3z_f_kVnj@sashalap>

On Mon, Oct 28, 2024 at 06:46:19PM -0400, Sasha Levin wrote:
> On Mon, Oct 21, 2024 at 11:48:34PM -0700, Christoph Hellwig wrote:
> >On Mon, Oct 21, 2024 at 09:54:53PM -0700, Kees Cook wrote:
> >> For example, for a given PR, the bot can report:
> >>
> >> - Were the patches CCed to a mailing list?
> >> - A histogram of how long the patches were in next (to show bake times)
> >> - Are any patches associated with test failures? (0day and many other
> >> CIs are already running tests against -next; parse those reports)
> >>
> >> We could have a real pre-submit checker! :)
> >
> >That would be very useful.  Items 1 and 2 should be trivial, 3 would
> >require a bit of work but would still be very useful.
> 
> If you've been following so far, there is a bot that is capable of doing
> most of the above
> (https://git.kernel.org/pub/scm/linux/kernel/git/sashal/next-analysis.git/).
> 
> Here's a histogram that describes v6.12-rc4..v6.12-rc5 as far as how
> long commits spent in -next:
> 
> Days in linux-next:
> ----------------------------------------
>   0 | +++++++++++++++++++++++++++++++++++++++++++++++++ (89)
> <1 | +++++++++++ (21)
>   1 | +++++++++++ (21)
>   2 | +++++++++++++++++++++++++ (45)
>   3 | ++++++++++++++ (25)
>   4 | +++++ (10)
>   5 |
>   6 | + (2)
>   7 |
>   8 | + (3)
>   9 | ++ (4)
> 10 |
> 11 | +++ (6)
> 12 |
> 13 |
> 14+| ++++++++ (15)

I kept working on this for this release and ended up with something that answers
the question how much time has my PR been in linux-next. Not sure if it is
useful to anyone, but decided to share it just in case.

# The command
``` bash
./pr-hist.sh -d ./db --linux-next ~/src/linux-next --pr /tmp/pull_request.txt
```
* here [1] are the script sources
* pull_request.txt is a file that contains a PR created with the `git
  request-pull` command.

# The output

``` bash
                         Histogram of Counts by Date
120 +-------------------------------------------------------------------+
    |                                                     * *           |
100 |                                                     * *           |
    |                                                  ** * *           |
 80 |                                                * ** * *           |
 60 |                                        * *     * ** * *           |
    |                                    * * * *     * ** * *           |
 40 |                        * * *     * * * * *     * ** * *           |
    |           * * *    * * * * *     * * * * *     * ** * *           |
 20 |           * * *    * * * * *     * * * * *     * ** * *           |
    |           * * *    * * * * *     * * * * *     * ** * *           |
  0 +-------------------------------------------------------------------+
  1017          1024         1031          1107         1114          1121
                                    Date
```

# Command help
``` bash
  Usage: pr-hist.sh ARGS [OPTIONS]

  Lists the databases where the <commit_ids> are found

  Args: [-c <list> | -p <pr>] -d <db_dir>
    -c, --commit-ids <list>       Comma separated list of commits to query
    -p, --pr <pr>                 Pull request file (generated by request-pull)
    -d, --db <db_dir>             Database directory

  Options:
    -n, --linux-next <next_dir>   The linux-next directory
    -h, --help                    Display this help
```

Best

[1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/next-analysis.git/tree/pr-hist.sh?h=jag/master

-- 

Joel Granados

