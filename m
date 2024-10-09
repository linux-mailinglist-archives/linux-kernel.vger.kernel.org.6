Return-Path: <linux-kernel+bounces-358001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7401C997915
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CC0283D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 23:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2DF1E3DFC;
	Wed,  9 Oct 2024 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glHVVIm+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AE8169397;
	Wed,  9 Oct 2024 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516189; cv=none; b=TSOTOHff1MgSzl8pfMZCtHl/LV5cM+wLgkIV+B+hTY9cscXzWFrbC4Z7Uc2ey4OvMalhjCFehEP4a25hvdOVUUVgS0BCo4L56bdsh6L/E1tfDN0FxbTwKJIthesCcDyKud+PIf8l/jyTSwV9aRLtDl7VNmBvE1W5wB0sGa4KC0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516189; c=relaxed/simple;
	bh=60OTD2MYzHbySQtVtLI9W8x5SUpoFaHcLB1gvcDRzsI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=U6ChtMO0s9HCD+HImHhOWqJOVNhgIQgLu62DI58trwE+3aHw79ETI+sEoZX7e0Au9A/uTfWVGgh8BvDjRUIqfPjLIJK/8irJUoZhSbV+Vu+ObCgKPC5pwQpOgRJrpdsFCTbWPYfG/FhyjDHH3eZeFYU+Qc8MbImD1cBd773QXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glHVVIm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5D3C4CEC3;
	Wed,  9 Oct 2024 23:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728516188;
	bh=60OTD2MYzHbySQtVtLI9W8x5SUpoFaHcLB1gvcDRzsI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=glHVVIm+v5m1Mo48+bDF583js/Yh11lgt/F3vjMAhGAdUExGqhHslSe4HoCoqDd3K
	 O4OZDd8bHshGgG+HdBvmHsDo23Q7NffX2FNkrH0l3/Q12nZnQwGBJk5X+H22AzUl2n
	 p12cQNAp53ZUL5ABDG7toWNyyeSfNYQa+FbSeengoRFIVvsDeaWk2H6+DDEnU4e5JL
	 f0sXW9NLonyh0VKGprfNZ9LeIdniKAQSjkS5/z6SsKADGXLdTYaRCuENzPVHtwBc8p
	 q6Q68Nz9ZimcebK1oM6gTRjAw8NBqm30EKS+OMMf2zOKwQrYBJ1oLjjwbPqggARnAI
	 LAKJe18SNn/8A==
Message-ID: <1b9e1d9fb4f803dcbed9abb75e56a0dd.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240927092232.386511-1-lukas.bulwahn@redhat.com>
References: <20240927092232.386511-1-lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] clk: mediatek: drop two dead config options
From: Stephen Boyd <sboyd@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>, Lukas Bulwahn <lbulwahn@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>, Michael Turquette <mturquette@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org
Date: Wed, 09 Oct 2024 16:23:06 -0700
User-Agent: alot/0.10

Quoting Lukas Bulwahn (2024-09-27 02:22:32)
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>=20
> Commit 0f471d31e5e8 ("clk: mediatek: Split MT8195 clock drivers and allow
> module build") adds a number of new COMMON_CLK_MT8195_* config options.
> Among those, the config options COMMON_CLK_MT8195_AUDSYS and
> COMMON_CLK_MT8195_MSDC have no reference in the source tree and are not
> used in the Makefile to include a specific file.
>=20
> Drop the dead config options COMMON_CLK_MT8195_AUDSYS and
> COMMON_CLK_MT8195_MSDC.
>=20
> Fixes: 0f471d31e5e8 ("clk: mediatek: Split MT8195 clock drivers and allow=
 module build")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---

Applied to clk-next

