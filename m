Return-Path: <linux-kernel+bounces-568763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529DAA69A38
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 21:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2062468234
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4782A215076;
	Wed, 19 Mar 2025 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jZYorn2C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5242214A92;
	Wed, 19 Mar 2025 20:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742416303; cv=none; b=Qfcp6m76yvckxsSqCfhpp630d8ttLQGvo1tlZVbJVDh1DTLaSGyxMWgy9loeJpU6gOGkKSkRbbkkdKWRxSeLsPSg6Wu9SPTfg8tXpogblGYFW5f/3f/9Ygmreizc8ufcMKz/8Vm4dJ/qpUuiicMk8Cmd3uq1CsrPgUCqQESvkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742416303; c=relaxed/simple;
	bh=2UFIZXkD+qWE9W/PWMkF4tSHKIJ/WUElt9x4oj57DRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdPs6Q1sCiLTKRfCrbZJx1VUJYUKH/+zG6er8GrKA5pgFhSFpRSbtvFiEHuWsotVOXZVt/+ja4bKul/IUvzyJQJ7UxKhLlpDTqlkKM6W6/HDVJD69W44tyVJZ3mjO0d2EO6NU+ub2fhw6hQPVYjakoqhfobEpWvuWJJHlRm0wqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jZYorn2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80492C4CEE4;
	Wed, 19 Mar 2025 20:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742416303;
	bh=2UFIZXkD+qWE9W/PWMkF4tSHKIJ/WUElt9x4oj57DRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jZYorn2CPy7FBhyA14dGfVlB7eZmDphH/ZTHjFn3IsmtLG8klQQSXajl8xHsCkN7E
	 g/pz3DOaiXz07Y2bLo3LU2N+MRFVxF1iIUsBPOg/vuD7fIHpgl6jAL9fPMS6Xw6Pd+
	 jBiIYemk1ZobnJg5vzPtUJC0qiVBmfcC1obKSwTveznSBdj/oTYNtoz+lUNfbMZ6YR
	 i0VqwFkusI/gIhvnRoxkUBLXSCYwVUXzBg+JU0yCN4hxMVvMzjNQAHgk93tJLo8Rpy
	 t3QbKvYy0XGVDdaNBMI9hdtxxTQq8UbHvK7iQ2Cac5NQJuft3v9Dz2gsm7Bk/y1rBc
	 7xoU2mPgZPmKA==
Date: Wed, 19 Mar 2025 21:31:39 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
	Rae Moar <rmoar@google.com>,
	Sergio =?iso-8859-1?Q?Gonz=E1lez?= Collado <sergio.collado@gmail.com>,
	David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH] x86/tools: Drop unlikely definition from
 insn_decoder_test
Message-ID: <Z9spq9OccwK7vKj7@gmail.com>
References: <20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-x86-decoder-test-fix-unlikely-redef-v1-1-74c84a7bf05b@kernel.org>


* Nathan Chancellor <nathan@kernel.org> wrote:

> After commit c104c16073b7 ("Kunit to check the longest symbol length"),
> there is a warning when building with clang because there is now a
> definition of unlikely from compiler.h in tools/include/linux, which
> conflicts with the one in the instruction decoder selftest.
> 
>   arch/x86/tools/insn_decoder_test.c:15:9: warning: 'unlikely' macro redefined [-Wmacro-redefined]
>      15 | #define unlikely(cond) (cond)
>         |         ^
>   tools/include/linux/compiler.h:128:10: note: previous definition is here
>     128 | # define unlikely(x)            __builtin_expect(!!(x), 0)
>         |          ^
>   1 warning generated.
> 
> Remove the second unlikely definition, as it is no longer necessary,
> clearing up the warning.
> 
> Fixes: c104c16073b7 ("Kunit to check the longest symbol length")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  arch/x86/tools/insn_decoder_test.c | 2 --
>  1 file changed, 2 deletions(-)

I suppose this should be merged into the Kunit tree? The c104c16073b7 
commit is in -next currently.

Anyway:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

