Return-Path: <linux-kernel+bounces-435354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8D09E7671
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5749286D05
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 16:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098971F63F5;
	Fri,  6 Dec 2024 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOy4snWv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD3206262;
	Fri,  6 Dec 2024 16:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503973; cv=none; b=RKxmMsJDg/EFXhWmTipFJydJhMdIgJ9BPk9oYGg9UYZsY5R24BIOP0I3nbaaCdKUuTc67HBdrz3mMiOjeodBvJycWqIj+4XLp9MAtSlKbhVqFC7KRiH5X6Zm08DybA+oHeaN5KhJSNV+8ceHH0/ozRJnEq0O2YQuumhP84/TRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503973; c=relaxed/simple;
	bh=sq7dQBficLSadbyGg1ToMr9fEj08H3sh3k8KpNn23aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPBI6vD53XT+laYRN/bDq5n/xmXDtXnbY0hYYSm8ovokdnCq4szgQYT2Jj5fWGz4+wXPMBkNb46HFTTrhn+zz61pyDjxHUc/qcVATGCIm5CQpOQfgDX2DyS2FcOKyNLTkQiv7n2kWtqX/IeuiB9mlGl5FM/iaOWZ8GCrZobJUiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOy4snWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A385C4CED1;
	Fri,  6 Dec 2024 16:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733503972;
	bh=sq7dQBficLSadbyGg1ToMr9fEj08H3sh3k8KpNn23aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOy4snWvS4vUEJ5vkEuZVku7kZ18NLUWIIhvcDv8E/k00XTb4+5L42fr3LXAhC+ju
	 52WeOo0Lg4Mvm0wQDES96OVxOMUZGxc1Y2/rV02BqV4DuavlUjEQyweFb4wR8CeybG
	 Hm12bA51/qiM4EZ9uTSm8ZNFGetL7XuQ2voxRc7KTydsRw2ebsqhSCwTQnzsyslte+
	 xwsbZVZ3R6aNkHqaebBzk/2zFJTyYafi/+xMzgqrp2TV1ShporV1m8ZBl7XBE6RGXD
	 RKQrhF9yEPWgPRxzgqQ9D2Ldt/iFrVji1wAo/NBcPqT3lsEWarY/Vvha3VpGbJ1qGV
	 w2HY+WrhmQEjw==
Date: Fri, 6 Dec 2024 16:52:48 +0000
From: Conor Dooley <conor@kernel.org>
To: amitsd@google.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Kyle Tso <kyletso@google.com>, RD Babiera <rdbabiera@google.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: connector: Add pd-revision property
Message-ID: <20241206-perch-elliptic-4e8a8170426e@spud>
References: <20241205-get_rev_upstream-v1-0-90158ee7d75f@google.com>
 <20241205-get_rev_upstream-v1-1-90158ee7d75f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pNSV/oThW7kFwOxz"
Content-Disposition: inline
In-Reply-To: <20241205-get_rev_upstream-v1-1-90158ee7d75f@google.com>


--pNSV/oThW7kFwOxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2024 at 11:46:08PM -0800, Amit Sunil Dhamne via B4 Relay wr=
ote:
> From: Amit Sunil Dhamne <amitsd@google.com>
>=20
> Add pd-revision property definition, to specify the maximum Power
> Delivery Revision and Version supported by the connector.
>=20
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> ---
>  Documentation/devicetree/bindings/connector/usb-connector.yaml | 6 ++++++
>  Documentation/devicetree/bindings/usb/maxim,max33359.yaml      | 1 +
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.ya=
ml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> index 67700440e23b5b7ca0db2c395c8a455bcf650864..341d2872e8d43450d219b7b72=
d48790051dc4e2b 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
> @@ -293,6 +293,12 @@ properties:
>        PD negotiation till BC1.2 detection completes.
>      default: 0
> =20
> +  pd-revision:
> +    description: Specifies the maximum USB PD revision and version suppo=
rted by
> +      the connector. This property is specified in the following order;
> +      <revision_major, revision_minor, version_major, version_minor>.
> +    $ref: /schemas/types.yaml#/definitions/uint8-array
> +
>  dependencies:
>    sink-vdos-v1: [ sink-vdos ]
>    sink-vdos: [ sink-vdos-v1 ]
> diff --git a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml b/=
Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> index 20b62228371bdedf2fe92767ffe443bec87babc5..350d39fbf2dcd4d99db07cb8f=
099467e6fc653ee 100644
> --- a/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> +++ b/Documentation/devicetree/bindings/usb/maxim,max33359.yaml
> @@ -70,6 +70,7 @@ examples:
>                                         PDO_FIXED_DUAL_ROLE)
>                                         PDO_FIXED(9000, 2000, 0)>;
>                  sink-bc12-completion-time-ms =3D <500>;
> +                pd-revision =3D /bits/ 8 <0x03 0x01 0x01 0x08>;

Why do you need this? Doesn't the compatible already give you this
information?

>              };
>          };
>      };
>=20
> --=20
> 2.47.0.338.g60cca15819-goog
>=20
>=20

--pNSV/oThW7kFwOxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZ1Mr4AAKCRB4tDGHoIJi
0n8rAQDOcuOF4z1yyHB5vS3KHL2iVJpdDPRUgaVgB/49RTnkmgD8CEZVAB9v0JqY
jgZOP7ZJdQNGphOiKh47LLIMMteXBAk=
=kNCV
-----END PGP SIGNATURE-----

--pNSV/oThW7kFwOxz--

