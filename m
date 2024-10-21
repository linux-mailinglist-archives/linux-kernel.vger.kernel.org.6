Return-Path: <linux-kernel+bounces-375189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA369A9237
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 23:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A76A52815B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A4C19923C;
	Mon, 21 Oct 2024 21:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLIt4oHR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF52D1FE115;
	Mon, 21 Oct 2024 21:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546918; cv=none; b=ngkqn9IscF78R4qhmhOA7mOMP4gT0C+I15CTyLGxHM3c55EFKm54Cb/K0nVhh5ZbbuOPpP7886poqCxj/9v9+Wbo/K0UBwnwVkrDnGM7CtrB5PYB6v0uIv7Wo7/Eb7PcYBwazArmuYIW9/mAXsyx+OLk9OhYU992fBHUhBVO/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546918; c=relaxed/simple;
	bh=fWDT7/tqiHFxu6jARFHgw792ZtaMGHZPjKiSd/GLY7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEXHFJhANm5j09HKmEx6bGswtGcqcRrfxQswiFutIZiuY+foWbeECzHXBqyfsTjIOCaFVqRA84JvhC6Kei3uAwe60cfWtNSvVQnN+4luSBMLDqcWJtnqCsJnOrSXQanTrcgctgQXekp1T+rDCnsKND3YjDTg9C7wx3LZQT/pGKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLIt4oHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5001DC4CEE5;
	Mon, 21 Oct 2024 21:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729546918;
	bh=fWDT7/tqiHFxu6jARFHgw792ZtaMGHZPjKiSd/GLY7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLIt4oHRnLa5HXop2Jx8cVADa0x3s35Bro9lKmzhSRDBkvrCcsqdeIZbxQ99w4tVD
	 +hB0WT6rRiTRUQC+se+DtPrteUwGcV1gX6VnwF6kW9EfMWLLzsVtutXRJn11LIkkZA
	 LieNytP4rUs3bxTiGzgPbyJpPlbnBp55qJHGk0m5TuxnV7D80fkqUhce5plxwhyPzW
	 2+HqmA3Cwv9eDrrvFtaID/feiBkze2Obxeqi3wSvps1BnvHCxi6nr1QS2olBxbJ7nr
	 wNXUrKDbNhU2FG9VOGoo3kjYtDdXhLqxjmukIC8w43AaxwJf7EE1JOInbbAyKvIvFe
	 gwyz2hpGaZXKw==
Date: Mon, 21 Oct 2024 22:41:54 +0100
From: Mark Brown <broonie@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: torvalds@linux-foundation.org, ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: linus-next: improving functional testing for to-be-merged pull
 requests
Message-ID: <6dbbc85e-5a87-4605-8db6-92b191878d97@sirena.org.uk>
References: <ZxZ8MStt4e8JXeJb@sashalap>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XVFzAHx1LlJYtmMS"
Content-Disposition: inline
In-Reply-To: <ZxZ8MStt4e8JXeJb@sashalap>
X-Cookie: Most people prefer certainty to truth.


--XVFzAHx1LlJYtmMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 12:07:13PM -0400, Sasha Levin wrote:

> During the Maintainer's Summit, Linus Torvalds expressed concerns about
> the quality of testing that code receives before he pulls it. The
> subsequent discussion side-tracked to the testability of linux-next, but
> we didn't directly address Linus's original concern about pre-pull
> testing quality.

> In an attempt to address the concerns, we're trying out a new "linus-next"
> tree is being created and maintained with the following characteristics:

> 	1. Composed of pull requests sent directly to Linus

> 	2. Contains branches destined for imminent inclusion by Linus

> 	3. Higher code quality expectation (these are pull requests that
> 	maintainers expect Linus to pull)

This feels kind of late for thorough testing, especially outside of the
merge window where it's mostly fixes.

> 	4. Continuous tree (not daily tags like in linux-next),
> 	facilitating easier bisection

Is this a pressing problem?  I routinely bisect -next, you have to base
things on Linus' tree (or pending-fixes) but otherwise it's not
especially problematic.  It is a bit helpful to remember commits that
you've run a given test on before to speed things up a bit but that's
not super essential.  The downside of not redoing the merge is that
once problematic stuff ends up in history it doesn't go away which can
itself be disruptive whenever there's multiple issues going on, you get
a window you have to skip through when bisecting.

> The linus-next tree aims to provide a more stable and testable
> integration point compared to linux-next, addressing the runtime issues
> that make testing linux-next challenging and focusing on code that's
> about to be pulled by Linus.

> linus-next is (expected to be) particularly effective before the merge
> window opens, as maintainers tend to send their pull requests early,
> allowing for more thorough testing of to-be-merged changes.

How many people send pull requests in advance, as opposed to getting
their tree stable, waiting for further testing, applying any fixes from
that testing and then sending a pull request after the merge window has
opened?

One big concern I have with this is that for non-fix changes the testing
coverage will be very heavily loaded to the end of the development cycle
and the merge window, with a lot of changes in flight at the same time.
That means it's going to be harder to effectively run more expensive
tests, and we'll potentially be a month or two on from when the changes
were landed by the time we actually get round to running whatever extra
tests get run here.

I do think it's useful to have coverage of specifically things actually
sent in pull requests, but I'm not sure we'd get much more thorough
testing than we already get via pending-fixes and -next.

> We also want to avoid altering the existing workflow. In particular:
>=20
> 	1. No increase in latency. If anything, the expectation is that
> 	the cadence of merges would be improved given that Linus will
> 	need to do less builds and tests.

For fixes we do routinely have things landing within hours of the pull
request being sent, that's pretty aggressive for CI.

> 	2. Require "sign up" for the tree like linux-next does. Instead,
> 	pull requests are monitored and grabbed directly from the
> 	mailing list.

Like I mentioned above what's the plan for handling bad changes?  If an
issue is found in linus-next (BTW, I forsee confusion being caused by
typos there).  If a problem is found and then fixed with an incremental
patch which is sent in another pull request then the fix will eventually
land but if the offending patch is rebased out or the pull request just
dropped entirely then presumably someone will have to do something
manual.  How will that happen, and on what sort of schedule?

I do wonder if it's worth splitting the -next merge further and having
another pending-fixes type split where maintainers can differentiate
between changes where they're reasonably happy with the testing and
those that are bleeding edge.  It is volunteering Stephen to do even
more merges, and it does rely on people identifying what's stable, so
I'm not sure how useful it'd be but seems like it would mesh well with
the flow where people are doing their own stabalisation prior to sending
pull requests.  That's a different thing to increasing the coverage of
PRs like you're proposing here but it's another angle on the "-next is
too unstable" issue.

--XVFzAHx1LlJYtmMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmcWyqEACgkQJNaLcl1U
h9CSLgf/YYiRGiitFXCegBQeROsMzJPCCZbMm/B1YzMU/4NTedpuKO7OnlVCgt82
bD888+EM7//qNX0t7/ja4ZIFhGLGecTTQ7hXAvC8aSAq7/mPzhQyI/P7gF8PJsGS
Dbzx7p4Xb83lNR81vWahFn3FVFfGOrrflxwTxUEdb+mvaJ5Mdif8rPIf6sFXCCxL
ctoHoXXS/WARlHnA7BKCiGfsKyuE9uzn488MfpGahHiqt7UBLfeb2a+R2K8db3Hp
7uoVre+ZmvQhru1+ayV+LSYgXXhjobv8e0GYrhxY4ewtRBMEmpV4TAGKUYwHRKAY
q5RN//LLG1H1LEvToGhsgqQ23zH0EA==
=c9we
-----END PGP SIGNATURE-----

--XVFzAHx1LlJYtmMS--

