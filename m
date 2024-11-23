Return-Path: <linux-kernel+bounces-419152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2379D6A09
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5178161770
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F94126BF1;
	Sat, 23 Nov 2024 16:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5hiMYu6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C763917C2;
	Sat, 23 Nov 2024 16:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732378930; cv=none; b=Sxh/mA1gxequI1gplVGtmvalDZgGlSHNY4ByzEoWY8Y/Dpj4AikYr2HWHsRSL4kL5jLdlM9O1Ttrnv6fXT7GXpHVSzarkSfNx4pq4vACr9/X+0pZm6r8DZgsC+Ak10pr+LohG/IQ7Xl5sjdJ3s+S7GtrRBqIY5OM5j8aotU7BCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732378930; c=relaxed/simple;
	bh=rqrZ3vjyZhrxtWn4EFzMu1EVgsI53q7sNaMFgE9p/0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=inz7Fk4UXbasBs1KOFhizYDseuhWUA/3nRRAaxh5PAM4Pr3CkEIqIAcar/5EzhYCZ62IPpV2mbZoAnYsH4sbOyaMjmsXTap7EA58F1vHq/WApy63a3YEGgUOCj4WE2207HaHB/2cZLQZIxh+ngFnw9BOGTOa7Tp4PoL2lPonwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5hiMYu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7ADC4CECD;
	Sat, 23 Nov 2024 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732378930;
	bh=rqrZ3vjyZhrxtWn4EFzMu1EVgsI53q7sNaMFgE9p/0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5hiMYu6E+Hf3BM+fN1iB3dHoPal/EV/V5lel/OfMXeL3mndSaoGXxkoiQmRNpVd0
	 ThMRz38hrfgwelJ9y74Pe8STfKB3mMj4RsLXrcFf4BoL+fvnbeCw0LPxKrpLFtoBLU
	 wx/1SLV39pofXw77R6KmJDqZacOCtI7SNv8L0+KrDVpuVJ0u3v9Qf1mzTdSf7OTRnN
	 2xVMJMDozrK+WlAg0AKb8lopUSocby4LzGnd3DfzXyCbLVr48CB09Y4YWL+h1c0OWI
	 uDf/jz/+qkWblxhPCiDG57hFpjJU6vK6oMxlXBQw+ep03CVOkL2c5fl+bmqCHbuZiI
	 CptND575uG3FQ==
Date: Sat, 23 Nov 2024 17:22:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>, 
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v6 2/5] dt-bindings: sound: Add Allwinner suniv F1C100s
 Audio Codec
Message-ID: <juzxtwlr5ayvjrrqem2hr3nbyem6oajwrvveio5brlzazdafov@r2aehknf4shv>
References: <20241123123900.2656837-1-csokas.bence@prolan.hu>
 <20241123123900.2656837-3-csokas.bence@prolan.hu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241123123900.2656837-3-csokas.bence@prolan.hu>

On Sat, Nov 23, 2024 at 01:39:00PM +0100, Cs=C3=B3k=C3=A1s, Bence wrote:
> Add compatible string for Allwinner suniv F1C100s audio codec.
>=20
> [ csokas.bence: Reimplement Mesih Kilinc's binding in YAML ]
> Signed-off-by: Cs=C3=B3k=C3=A1s, Bence <csokas.bence@prolan.hu>
> ---
>  .../sound/allwinner,sun4i-a10-codec.yaml      | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>

Missing changelog - what happened here? If no changes, why ignoring
received tag?

<form letter>
This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation: Please add
Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
or above your Signed-off-by tag. Tag is "received", when provided
in a message replied to you on the mailing list. Tools like b4 can help
here. However, there's no need to repost patches *only* to add the tags.
The upstream maintainer will do that for tags received on the version
they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/subm=
itting-patches.rst#L577

If a tag was not added on purpose, please state why and what changed.
</form letter>

Best regards,
Krzysztof


