Return-Path: <linux-kernel+bounces-404690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 718EA9C46E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 21:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37642289AED
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 20:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0A21B6541;
	Mon, 11 Nov 2024 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMWfXXUN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88711AA78A;
	Mon, 11 Nov 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731357096; cv=none; b=Iw+XWtXkHINYEWpTQxiTk7gHmLS9zu/5n5Ng3lIocNqlX+4EQKHUfFfa8tGCuefsfkI0RY5dEpEebU6iqI4Tscrl6lSxXqDKXFYH9cfFAsC2fyv2Sl3hSs/BKf1jUA2Enp5OymrwCUpqbdnUW63W75T2u6bS35XmrIhFdaFjoPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731357096; c=relaxed/simple;
	bh=x9aXapsZuaqPnOXzfdDhI/RnimcdxYeMxnTT1TJaOFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INANpV/fI/SbsX7Ls0oqACRgA0SB8samFO9u7ZboZuLio+OroB6k8bPfuynvmdxJvLXZ7b3YHijmlO0E3CYqsLZwJGIRo/q4j1ElwLJW1zWPw1EiABpUx/Kqy8DxEgrQhmKIWBU7ru6NjYlQGAs9szRbj5CYgJtODAfj7Y4mDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMWfXXUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD95FC4CECF;
	Mon, 11 Nov 2024 20:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731357096;
	bh=x9aXapsZuaqPnOXzfdDhI/RnimcdxYeMxnTT1TJaOFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMWfXXUNORLhTI3cTOwE0A1ETqw8UqTMRqqc7Wc0Bkt653CuvRspCpYP7fc0Y36y6
	 U8WaealJUt2xHAtYBFe7eZDTV2jeYuHZvELjZas9GEzTFAMZhY9ZpEU3HteYQzDCsg
	 hYkUkXN0ydmkAUTk1BViQWHmDzMi0rPfRobRsB3dHgb7YKio9ls4wiN0KhCYPcdwPc
	 gFbE+AQGN/10ogmpEeLNejEXBa7K/y8IBOngyxuU+EeHnU+Xpd9ab7w+ZHA5lPMj/f
	 FbuMeh0dsk0ekGZ+MaZwgfb3g4QYNHQaOSW+3UWVMRt/nPXwsWmMdWphKd8IscJCLU
	 khb2nGadcHbcQ==
Date: Mon, 11 Nov 2024 20:31:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Icenowy Zheng <uwu@icenowy.me>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] dt-bindings: clk: sunxi-ng: add compatible for the
 A523 CCU
Message-ID: <20241111-deepness-escapable-0a3bac2b3505@spud>
References: <20241111004722.10130-1-andre.przywara@arm.com>
 <20241111004722.10130-5-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Asf0m3qumdcixdxJ"
Content-Disposition: inline
In-Reply-To: <20241111004722.10130-5-andre.przywara@arm.com>


--Asf0m3qumdcixdxJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 12:47:19AM +0000, Andre Przywara wrote:
> The Allwinner A523/T527 SoCs have four CCUs, this adds the binding for
> the main CCU.
>=20
> Add the new compatible string, along with the required input clock
> lists.
> Also add the DT binding headers, listing all the clocks with their ID
> numbers.
>=20
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--Asf0m3qumdcixdxJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZzJpowAKCRB4tDGHoIJi
0tv9AP4nwUN0sO11WBtf8cOH5uXB5Pv2Hk5WrGcCfONvtDz1IgD9EYWzRej9LYZ/
B8R9KRR9KHpIv6Sm0pXaJ7C7pqYOSAA=
=4MSE
-----END PGP SIGNATURE-----

--Asf0m3qumdcixdxJ--

