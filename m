Return-Path: <linux-kernel+bounces-377092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A97539AB9B8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 624632848C5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16541CDFD1;
	Tue, 22 Oct 2024 22:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8pj8vO3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138D91CDFC3
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729637745; cv=none; b=o0S6YgFup4bRKzg8W+yav/0gLw7aW567x4Dpc1t4cVqjUTs0KGGfixb2/H8bAvpFzZ3DoX4c90aKoyyY9ikA2vEcaw0taVCNZBSGYh00C4UT5m7jSgNwxN+r8/BHoEILJ3uxwuQuUvBeGmxoNhopwEHK6W1Rcdn/DP5pLOMKBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729637745; c=relaxed/simple;
	bh=oPztmLxrp5ojz2O4rB0sjPGRTCEUclDpS9pNxsljbqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMp3Q+n2ms76JdPtBbwu6qaqWv+4rRx3j3pNhdmWQihZ7Q7SIGCFIQ7iFBKqw6qsx1FmzlAAFU/chWCNzxVR9LBVXplseKgXEbbzWPJuEnZRtqNTvgWsWjPdAi1FB7cOiDatdrU++5cQC86VaahOVu6h05yJGSaGeHSrrrBxGFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8pj8vO3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C46EFC4CEC3;
	Tue, 22 Oct 2024 22:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729637744;
	bh=oPztmLxrp5ojz2O4rB0sjPGRTCEUclDpS9pNxsljbqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J8pj8vO35o+dZ+pH4ca8NDPUC590xKNIuoxn96yfj72hnYwtDxgTj2vP0b2gFi9+a
	 +htXd+n/EoxcR3B4953DRHkMgxvKUpyVKJLlG/b+A3lrQlxP6BgAnxgfZoDDMExdci
	 Nq9xtsyA3LMokx+DWvs+udSUEiPuCGV536KH7nbhFXGcb20POZTLLiH6E6r38siTO8
	 IrvajvEdI/Z3gXaaheqjkvzN2suXLrR91577NkvjF65d+Ms8xderM2577TFphtxVT2
	 Wj2OskTF99WtnZifrgdwEdLV7ufFV6TIQoniC4mPKHE0Z3TpDSq23Qgik5anUcozMo
	 yFpQV6N6g5whw==
Date: Tue, 22 Oct 2024 23:55:41 +0100
From: Conor Dooley <conor@kernel.org>
To: Paul Moore <paul@paul-moore.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: Commit 6e90b675cf94 ("MAINTAINERS: Remove some entries due to
 various compliance requirements.")
Message-ID: <20241022-avid-ardently-a761decc48ce@spud>
References: <CAHC9VhT5P_FgPr=k6y91HjTMM1GCQH_kcPR=p2Ux-coTYYR_EA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tVPVzVWbdlSrFvu6"
Content-Disposition: inline
In-Reply-To: <CAHC9VhT5P_FgPr=k6y91HjTMM1GCQH_kcPR=p2Ux-coTYYR_EA@mail.gmail.com>


--tVPVzVWbdlSrFvu6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 22, 2024 at 06:40:11PM -0400, Paul Moore wrote:
> If we as a community are going to drop subsystems/individuals from
> MAINTAINERS due to "compliance requirements", can we at least
> explicitly list those requirements in the commit description?

And do more than the bare minimum of posting it to patches@lists.linux.dev
and applying it only minutes after it has been posted.
Comes across as underhand or sneaky, even if that was not the author's
intention.

Cheers,
Conor.

--tVPVzVWbdlSrFvu6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxgtbQAKCRB4tDGHoIJi
0pLrAQCPDA4PJ/YZ+3jiawN9jbis9UXb1Lv1cdpSe0L40mTc5gEAhtvZIquvzYiR
91cCmBngBy3oI8L6JlM64Pns41A14g0=
=9hhQ
-----END PGP SIGNATURE-----

--tVPVzVWbdlSrFvu6--

