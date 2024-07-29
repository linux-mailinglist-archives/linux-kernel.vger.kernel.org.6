Return-Path: <linux-kernel+bounces-266554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3694018E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 01:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A04581F231AE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 23:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B679118EFFB;
	Mon, 29 Jul 2024 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZsjA2Z9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB1D18A948;
	Mon, 29 Jul 2024 23:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722294698; cv=none; b=sTVjHUtUjmX2rQBTrO0ySKFWwLDsAk8fEu+86WGBMvtQ3qR4RLLxveEbDN1tnBLFCsJ2KsEOLdQDVlBEMG+9KpLd22DTH4BvNznYpK6Ti9Mo+uizTj7tb4BD0jnTVcgDR1FrYJYbo8puKBsqtpzmlCp+NmT+dmyibWs9IpeVzk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722294698; c=relaxed/simple;
	bh=zRWYUsOVWmCW1ARRgFXXssRkqPSAfDAPe8/80wD4ars=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=JrAJDBy0qQf3mZ4GE5WOx/0eFlRoClhf1rpvtJz7c+pxPWFmNUQilGniApfOSL+yjqpYlxTmyzu4d0PMl5LZnA+eQjeiDgT31tnwVQ17jqsucFBnsZB/NpSIfspuFa88ID83LQvfdlFmA2h42TGtVah68zJXBwg+HQqz5BnUxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZsjA2Z9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6D5C32786;
	Mon, 29 Jul 2024 23:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722294697;
	bh=zRWYUsOVWmCW1ARRgFXXssRkqPSAfDAPe8/80wD4ars=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=FZsjA2Z9icRNAfDBcYD+obscw/zmL9iQkCsVmgzoFdUzkNzMhqpiA594H2Kr/zcpe
	 jSkJMnG6O17tWP8VmOhpIYjKBxeZ731Wvu9KAWl6yjI84gYTF/A6cFc5N9bSVx1iyG
	 EJAyohZSWzi227B8Dc2USOkWzqfMZ458az4ThNe0f2BYcj1Uk118NEmHW2l6hXvlua
	 3BWicbIwwzKOtA8q32lJGrp9EgAxnzRroSK0BFooJ5f1lhOcXjD3x7CiZ2OxNAyE3T
	 sOGR/rfzVBleTDRE4dvrdagVZS43Kn6GBkiXhJOLigGe+V7vlUV/vHr8n0e3K1gGHY
	 ZApXXKdQlH9mg==
Message-ID: <076d5370a9b163f46170a6f581088246.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240718082528.220750-1-angelogioacchino.delregno@collabora.com>
References: <20240718082528.220750-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] clk: mediatek: reset: Remove unused mtk_register_reset_controller()
From: Stephen Boyd <sboyd@kernel.org>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, mturquette@baylibre.com, p.zabel@pengutronix.de, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Date: Mon, 29 Jul 2024 16:11:35 -0700
User-Agent: alot/0.10

Quoting AngeloGioacchino Del Regno (2024-07-18 01:25:28)
> Now that all clock controllers have been migrated to the new
> mtk_register_reset_controller_with_dev() function, the one taking
> struct device node is now unused: remove it.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next

