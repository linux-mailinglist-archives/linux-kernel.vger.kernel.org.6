Return-Path: <linux-kernel+bounces-283770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FF594F889
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 22:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F2D7B20944
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 20:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B4A1991CD;
	Mon, 12 Aug 2024 20:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XswgXcFR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF26319149E;
	Mon, 12 Aug 2024 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495753; cv=none; b=XyOOXUvnUS5ZIuvKomVAZrIU4ffwOswjkAJ/PGY8BjaDVK4C7Ml/ofqRA4rn3vL1r+n/mZAnB7AG0LSUJn7vOGe216Ew76eM89MJagjyXBIXQdi/mBAhz0/gJpZvSX3X4xWaZXF+gKWW2y3n9H5mrghIu0+KFYlvJtRtdrnfQ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495753; c=relaxed/simple;
	bh=wol8FUScGGz0zEUfNMwrq5fMJjU5In0liJjcad3nmDQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JPmbZoO3DAI7vHV2PZaMiFU+RefvUcrJXGynku7JEfUNBIGYJ6bZw2lR2iPSOMZQcoHCT7S2jNFEXGj/mz0jy4+wctdiPGtrftWJ/+1Mrbuk52crfaPIB+wV2i5VCcMuBpp4ePRuN3qoT0kX+pJzcxdibJLALrGB56RDle9dLJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XswgXcFR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F705C32782;
	Mon, 12 Aug 2024 20:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723495753;
	bh=wol8FUScGGz0zEUfNMwrq5fMJjU5In0liJjcad3nmDQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=XswgXcFRRiyFIRxGpNM8I/pvxwK6kARK8SzFQx1ozX+RFGMWZCokQaN68uUZH2EQ1
	 e60ELPE2j8+fwT30vuWyMmmtTxTVAc6phUga7y5jhYnRO8uRV4UtxcqxN7bsOBmU7E
	 ejz36lcCAawT5xYKIjQGiz1xhD6S5Ors3kXIFKncdFfjZ81AoNpG5edn8l6lS26JB+
	 EuaOeF1MjP2b4jjKtL7Qmf8D1MYjGCrUISagoQOpYGnWtg9u2MKZPzzgiQE9xmZaqM
	 kGHJdedtWt6/0svhe9GjO4R7zKh8e3u90tvHyukJYxwj/APD6LuxyDa1gxcrWtrJXs
	 +YAJui0wbWixw==
Message-ID: <ac351d619b7a216bd8d197b026e6cb09.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240807-dt-mediatek-clk-v1-2-e8d568abfd48@kernel.org>
References: <20240807-dt-mediatek-clk-v1-0-e8d568abfd48@kernel.org> <20240807-dt-mediatek-clk-v1-2-e8d568abfd48@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: Move Mediatek clock controllers to "clock" directory
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Chun-Jie Chen <chun-jie.chen@mediatek.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring (Arm) <robh@kernel.org>
Date: Mon, 12 Aug 2024 13:49:11 -0700
User-Agent: alot/0.10

Quoting Rob Herring (Arm) (2024-08-07 09:58:54)
> The "arm" binding directory is for architecture specific and top-level
> board bindings. Move all the MediaTek bindings implementing clock
> providers from "arm/mediatek/" to "clock/" binding directories.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied to clk-next

