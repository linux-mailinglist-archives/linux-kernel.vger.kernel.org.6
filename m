Return-Path: <linux-kernel+bounces-370448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91BF69A2CA7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560FF282CB8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5868C219C83;
	Thu, 17 Oct 2024 18:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye3sFAxY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFA21D86E4;
	Thu, 17 Oct 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729191150; cv=none; b=uPspz3M39DAHfjN90fZBwpw8in+OYwq4S8L/2CRRGR34jyFeZToBPthtmlIFkKGGJjGpAby8Ug6zay9vWF15yvF2ZR61ugZ92tia2NVA2jMMKbhqYE1XvLwXTb0N9ed7vIt5Skxu2AjW6H6fECVSGmeWuxnE11CgsuoD2XImRjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729191150; c=relaxed/simple;
	bh=3Yk0FkYnf/mdXg3L03V3+12sLe3DHxfltl/LJd9tNW8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=LubxbywKrZBla7VVLU+Q3ZyneDqEW2FVZB0Pl5kdkTsJJR4jPRspOkD/oQD7qQiN67USzeydzcdligQ2XjyXkfLLoQ5MTZ9V70qiMIvpqF9rKR2DYiOmh3tSTe60GTuGCwDfBRXBwOEVHfEBpelwtzDv8O7R1MNg9/qVT4r3GK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye3sFAxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DCAC4CEC3;
	Thu, 17 Oct 2024 18:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729191150;
	bh=3Yk0FkYnf/mdXg3L03V3+12sLe3DHxfltl/LJd9tNW8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Ye3sFAxYy0KkFJkBq8G1Wg613K9YQ7yRjm9me9GgkGbZHEaydkPKpHr+88lCAOS54
	 IX4Dz9mn60PmdUcX2QvIrb9TClCCK+uw+hjTlUkvvPzQjIfwxBQBpAGTlu6nPSWjEY
	 hKMqqM6rkgHetfWk2oRO7vVNloaNIoeAR0WZzZI0Dssx+/7bEH38pu7M3kYqzkpGVD
	 shSuRs1o2D00d/ZXKPaurALiEsBBSLMaiZ0TvyyX+jHe5HM5jb2cv7UDLLtKCEw4VU
	 9pgKAl83qAS9bUO1mPwdPlqBfDLHuze5TZcvvGZhenpvaRsrm285RAkOIdpipedIsc
	 XmstrKyrjccgw==
Message-ID: <eb451771c3d25ecd2eedb7c473c63f6d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241007-mbly-clk-v5-3-e9d8994269cb@bootlin.com>
References: <20241007-mbly-clk-v5-0-e9d8994269cb@bootlin.com> <20241007-mbly-clk-v5-3-e9d8994269cb@bootlin.com>
Subject: Re: [PATCH v5 3/4] clk: divider: Introduce CLK_DIVIDER_EVEN_INTEGERS flag
From: Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, =?utf-8?q?Gr=C3=A9gory?= Clement <gregory.clement@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
To: Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>, =?utf-8?q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>
Date: Thu, 17 Oct 2024 11:52:28 -0700
User-Agent: alot/0.10

Quoting Th=C3=A9o Lebrun (2024-10-07 06:49:18)
> Add CLK_DIVIDER_EVEN_INTEGERS flag to support divisor of 2, 4, 6, etc.
> The same divisor can be done using a table, which would be big and
> wasteful for a clock dividor of width 8 (256 entries).
>=20
> Require increasing flags size from u8 to u16 because
> CLK_DIVIDER_EVEN_INTEGERS is the eighth flag. u16 is used inside struct
> clk_divider; `unsigned long` is used for function arguments.
>=20
> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---

Applied to clk-next

