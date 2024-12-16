Return-Path: <linux-kernel+bounces-447952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C899F391F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C0F1886109
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DBD207662;
	Mon, 16 Dec 2024 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noqQ2PZ3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6706843AA9;
	Mon, 16 Dec 2024 18:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734374354; cv=none; b=XIbG001U9RrkvI9bwtZOBzHfJNAzDPwAHgjGgoCxPWwphxj4vAoO5rZRER/wtW/EA/Xknr4SfkpH2Vi/oLGT4UXm6knpyQFSX77wg1TiAgCOzISdzvks8CzJSD3to0qXzstNXw+IXBJj1vTDG8BcJ9Pkvs01pw43Mkh//qcIk/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734374354; c=relaxed/simple;
	bh=wt7CBCKr35JUII+2VgDBmGe3AYQcBB0lstrcQq65w/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Woi7Z2EboizYrAUioGgEY2mJZ1KhK38hPKCfk2PQEfS943jwJltV2pXV/lU/fc4u3GhmFEqFN4FhMc+RtyRAPeNVpCvmcVfpH9D19vuvIwu8pgi2aAYCzmfSE0kLLJ1oWwe0pz4qorDAZvhKe+cQ9uWYFVABGoi1E+izckfSMbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noqQ2PZ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C45C4CED0;
	Mon, 16 Dec 2024 18:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734374353;
	bh=wt7CBCKr35JUII+2VgDBmGe3AYQcBB0lstrcQq65w/E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=noqQ2PZ3n6Wq/92q3ApzYg6lJcyQqRmxWtay4160LkII/PuUtZ3qn8x3H3obYM3/c
	 WVA8yyHyPgFWDtz8IpSfY1TAzxOJYltnWuRuZDIcq/qxxFQAHl+13KpPc1zN3pvplG
	 g0iPBnbbf7B6/HKAKijREjUeOGyB7O1ntuX6ouCcqxC9QmxwQkf0RRwyYiKn87pYyM
	 L7Zn/tlPNAQBkJo6+HJP5JEVYBXb5xyXxY2igZcgLxqVqm23HikZkNaZMmvugsaauM
	 oOJ7oEHUa+S5OPE1OPprlWVcCFjd4644E5Wv/iwdUGSaxHPh/N+kqwqeZjldt1nMhL
	 WoUoyfQjieKNg==
Date: Mon, 16 Dec 2024 18:39:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dt-bindings: mfd: sprd,sc2731: reference
 sprd,sc2731-efuse bindings
Message-ID: <20241216-bobbed-lend-abf4b2b5323c@spud>
References: <Z1_9ROiI2ZHKsbAD@standask-GA-A55M-S2HP>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9yJ2t1+TN4irjy8i"
Content-Disposition: inline
In-Reply-To: <Z1_9ROiI2ZHKsbAD@standask-GA-A55M-S2HP>


--9yJ2t1+TN4irjy8i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 11:13:24AM +0100, Stanislav Jakubek wrote:
> Directly reference the sc2731-efuse bindings to simplify the schema.
> Remove the duplicate example from the efuse bindings.
> While at it, add the "pmic_adc" label that was missed during the
> initial YAML conversion.
>=20
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> ---
> Changes in V4:
> - rebase on next-20241216
> - drop patch 1 (already applied)
> - add the pmic_adc label that was initially missed
>=20
> Changes in V3:
> - new patch due to a missing dependency in the MFD tree=20
>=20
> Link to V3: https://lore.kernel.org/lkml/cd8cc95b59c31418b174bba521dd2599=
a7929fda.1730709384.git.stano.jakubek@gmail.com/
> Link to V2: https://lore.kernel.org/lkml/ZyExK01iprBHhGm6@standask-GA-A55=
M-S2HP/
> Link to V1: https://lore.kernel.org/lkml/Zr3X1RoQs7ElTnlJ@standask-GA-A55=
M-S2HP/
>=20
>  .../devicetree/bindings/mfd/sprd,sc2731.yaml  | 12 ++------
>  .../bindings/nvmem/sprd,sc2731-efuse.yaml     | 29 -------------------
>  2 files changed, 2 insertions(+), 39 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml b/Doc=
umentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> index 8beec7e8e4c6..b023e1ef8d3c 100644
> --- a/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> +++ b/Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml
> @@ -67,15 +67,7 @@ patternProperties:
> =20
>    "^efuse@[0-9a-f]+$":
>      type: object
> -    additionalProperties: true
> -    properties:
> -      compatible:
> -        enum:
> -          - sprd,sc2720-efuse
> -          - sprd,sc2721-efuse
> -          - sprd,sc2723-efuse
> -          - sprd,sc2730-efuse
> -          - sprd,sc2731-efuse
> +    $ref: /schemas/nvmem/sprd,sc2731-efuse.yaml#
> =20
>    "^fuel-gauge@[0-9a-f]+$":
>      type: object
> @@ -199,7 +191,7 @@ examples:
>            };
>          };
> =20
> -        adc@480 {
> +        pmic_adc: adc@480 {

I don't understand the point of this hunk, nothing ever references it.
Examples aren't supposed to contain unused labels.

--9yJ2t1+TN4irjy8i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ2BzzQAKCRB4tDGHoIJi
0jXNAP4+YDR/wPjihZkxPHmgSN0U4kNpVRWuhHsICmKeHS1w5QD/a2UmcIXrya9p
w+h4nEfPOnWgUx8CRjBysvnL+kB4OwE=
=5vN5
-----END PGP SIGNATURE-----

--9yJ2t1+TN4irjy8i--

