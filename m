Return-Path: <linux-kernel+bounces-374214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A66E59A66F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 13:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68B21280A76
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EADB1E7C05;
	Mon, 21 Oct 2024 11:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCqAiQA3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F2878C76;
	Mon, 21 Oct 2024 11:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729511239; cv=none; b=dJuez5tpUwp7R+eQyrJkGafiR2rzGiGq1zajkfgdpzspiJtOK408YGGnyRTgS5jaYlXEMrh8MCwBworoVWvwaSkBfyezNmN6QOyonbgp0/T6TNsrECDUlrPPpm/5H0v7fL75KmiR54z/ELX5Bo776OzhNXUA4CKfWAQ4CmFWZ7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729511239; c=relaxed/simple;
	bh=SXo874iUZY1qTHS67hISCSIP2GgNeOT1VdQgd8SFo8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpcborEA1Qb7V9cWo5ZJGBrKJVaPcYQjgZ7PQpTV/2bgIi5lsCb7y3v67Xz+TZy+D7lB+ejv5mQ+QYbYD7jYrFGMWzTDcq0cTiA+v6Z0oPOgANW9+WL3cPMZk4mzDRjw6P9bj2wzGbGOLsv4nMxgffursGvCVNv12YJEdSLkPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCqAiQA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B59EC4CEC3;
	Mon, 21 Oct 2024 11:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729511239;
	bh=SXo874iUZY1qTHS67hISCSIP2GgNeOT1VdQgd8SFo8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCqAiQA31YwfTuq7OBtCqgamo7NDWlUP7+/ImOl6cI7baX/WszUsxFnnJFAWtp60a
	 I8DZ8b9AIUYj1TcZhGz/YAidCpFQBEVhRH8iJydLLg4bR62lZkotpP0gpUecPcgUjy
	 +3hmWZKFIIwey6AqBRS19JbMicIU5KaBA0/DclGCuQOxJSPgy9e/zCZK65a/Q+ejlb
	 WTgXFsz2Mxe6Dd7OHZinviOj8jrtzap9mavZhYhtusFjGiFDMxvFkyKsokr79IivCk
	 dHtDrNEmk53BdBlKh4nX/oqg131q2TmgJiB6gi5OFeZARSyFE3PXE39UhUaf+EYN6I
	 ToA/rwEE+ov2g==
Date: Mon, 21 Oct 2024 12:47:14 +0100
From: Conor Dooley <conor@kernel.org>
To: Tianling Shen <cnsztl@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Jonas Karlman <jonas@kwiboo.se>, Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@edgeble.ai>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: rockchip: Add FriendlyARM NanoPi
 R3S
Message-ID: <20241021-sister-reclaim-520ef28f2760@spud>
References: <20241020173946.225960-1-cnsztl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phjnla4IpWi58uM+"
Content-Disposition: inline
In-Reply-To: <20241020173946.225960-1-cnsztl@gmail.com>


--phjnla4IpWi58uM+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 01:39:45AM +0800, Tianling Shen wrote:
> Add devicetree binding for FriendlyARM NanoPi R3S.
>=20
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--phjnla4IpWi58uM+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxY/QgAKCRB4tDGHoIJi
0pllAP46YOE+E7hC6IkiBbqRUKf+rCtzttoxmSet3njN+PmWqwD+NwCxv0beg4q2
yr2IRCvgoWu+AggsnzS3uPOVktgi6AM=
=WRFS
-----END PGP SIGNATURE-----

--phjnla4IpWi58uM+--

