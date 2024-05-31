Return-Path: <linux-kernel+bounces-197024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CE28D6548
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 17:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA465B23B41
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444A46F30C;
	Fri, 31 May 2024 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyDhaIvv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852FC7483;
	Fri, 31 May 2024 15:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717167820; cv=none; b=dONnlUDyYfWObxVvxVn4m7DUR4JIvYjJQk7kRb9BPwbS+EUGAO/0pGJYIIdwfj8qs1qXDThGcY6gtM6vlQv56g48+6Bd2OFX/fLCPXet52otQd7BKDrcANJkQf9MX6WgHiL+cXkpvvwtNF7+SUSyQMPg3O2m9r/tfF+72R5ltj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717167820; c=relaxed/simple;
	bh=kzwdmdMivwWbu5Pb/8+YQ58BObGKh4rKu+UvlJwfFUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZFqLcl3zmTju6bXWxVnzgLxB2Aq01RHHCbcwQL9uXJNBvUfpeJLnX26zeEjTjwXGPOJKCtZYrIQGWMsoSU6v4B/3d8I8CrdJRWOayZNl5KBIGmI0FfNon5C/OJXpGqxNYtstVgeAxXFMso+LPwnoBaoReATZk8cs3dmCHBhrMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyDhaIvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB00C116B1;
	Fri, 31 May 2024 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717167820;
	bh=kzwdmdMivwWbu5Pb/8+YQ58BObGKh4rKu+UvlJwfFUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JyDhaIvvHsmyO+DgChXw9qUEqUvOzPG6r93W6GoRT5W7YUEKR0Br6mZJCujvfLrx7
	 IIgezlL3LbNOfC3tQxupOvBrr2f8mLyaCsLqEkSNgpgnG5YI+4SYAuvi/EhcJiBIrc
	 zG7sKPheoWI6D6wFafreEztoE71IAs1AhlyyCYZOW2vIPwryj5SI6DLpmaFPEp2RbY
	 HoZOuxrO9C4nHuUL09pTewJQke5e3HDWyy0NygwAuyaQpNIQJjvAFSzVXZFssZXGwf
	 G0CUsLPpoNxhVv/pabmJBP4Z+fW7E9hTRkdtJ0DSfmW2vxV5V7X4jWTXW8zp8mosvC
	 zAP8kZz+O5urA==
Date: Fri, 31 May 2024 16:03:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Guo Ren <guoren@kernel.org>
Cc: Inochi Amaoto <inochiama@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>, Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: dts: thead: th1520: Add PMU event node
Message-ID: <20240531-reseal-sabbath-4994673eb98c@spud>
References: <IA1PR20MB4953BA3638A0839FCB0EF86BBBF32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAJF2gTRu8WUkjOOzH4MZvinZv=0cgF988c7HyzP5jw0p3w+MWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hFbzC4Jn/xKf+UkR"
Content-Disposition: inline
In-Reply-To: <CAJF2gTRu8WUkjOOzH4MZvinZv=0cgF988c7HyzP5jw0p3w+MWQ@mail.gmail.com>


--hFbzC4Jn/xKf+UkR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 31, 2024 at 09:43:00AM +0800, Guo Ren wrote:
> LGTM! Reviewed-by: Guo Ren <guoren@kernel.org>

Please provide tags on a new line so that tooling picks them up.
I had to amend this commit cos I forgot a signoff, so I added it.

Thanks,
Conor.

--hFbzC4Jn/xKf+UkR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZlnmxwAKCRB4tDGHoIJi
0mWyAQCtRDjlV2EDCpIRC6SNrAMNrikM8qQS5Cv/TvuW/ikVBwEA1f58SB+mNN9k
pDLsbVdZhVH4q91F16Bt0AnC24yHAQw=
=JZ98
-----END PGP SIGNATURE-----

--hFbzC4Jn/xKf+UkR--

