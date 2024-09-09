Return-Path: <linux-kernel+bounces-322100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF1972402
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990CF1C21ABA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F4A18B46D;
	Mon,  9 Sep 2024 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnWzYTxb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7373189F50;
	Mon,  9 Sep 2024 20:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915238; cv=none; b=MagZwVKOxD6oDq8hY0hjADnV340V+8jFSEZsJAWsn3Glwd5yuSzvEv2FOviyfnWKNdl4GvRIibpLWoqPAE0SgLjZt5uQsiWtcflmNyijpKet1X4fjuYsIXCf8KFXN+t6Nq5r/W1qIjeBxxCC2IsaqPmYhK6NloQg3z6OIImLWKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915238; c=relaxed/simple;
	bh=OZrQ5VHLk1tA7kiaeGofa3flE1g1BnftMlLoittxaRY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=cbVGADYbl5GxO6ticSS4EFvF07gf6GvCGhFPUZTY+gU5HACua5sjZnmH3cKxhDa/yXgZw0HIhu/hlra4hL9W+7qZkNn+KSDZqNHM2YPYFNwgNWfjFaYw565HIbw3nareJgmGDrQUfU7AIAcP0A9uFNrb94TuuBkIW6xFaJ/SwoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnWzYTxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF9BC4CEC5;
	Mon,  9 Sep 2024 20:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725915238;
	bh=OZrQ5VHLk1tA7kiaeGofa3flE1g1BnftMlLoittxaRY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=CnWzYTxb3ULUB5oKpi2o0X+AFl3YFhfqZj+cUBeuMgyr3rv3rIkwOj9yTmTVupqPR
	 UzSJ+Izh8+MJDvTWhumOp1ej67K1nR5qMxiIORNLzX24nXIvOIkLmIIUscMBncKitT
	 gRob3Qvvg5vWOkhYcbHQeJsj5QnpR9MV+yR6f+AgFGPJ8TRQ7BI98tYbP4fvdJNQSF
	 yFymuKDN83jz+UwO8oMJzmXT15mp/oU2Ekv8eCz5XcntQvYYblYhTYH4nVN+uF+kCY
	 TzidZjAWNAE4efHOOUoeZ3F0NszCj9e80+aGjO3+QFo+Xkhnb36QO2iSbM1Kuxp+LW
	 crwNROQK4p3Gw==
Message-ID: <702f0a6c2a7529eee53681239056ffef.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240909111535.528624-11-fshao@chromium.org>
References: <20240909111535.528624-1-fshao@chromium.org> <20240909111535.528624-11-fshao@chromium.org>
Subject: Re: [PATCH 10/13] dt-bindings: spmi: spmi-mtk-pmif: Add compatible for MT8188
From: Stephen Boyd <sboyd@kernel.org>
Cc: Fei Shao <fshao@chromium.org>, Conor Dooley <conor+dt@kernel.org>, Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Date: Mon, 09 Sep 2024 13:53:56 -0700
User-Agent: alot/0.10

Quoting Fei Shao (2024-09-09 04:14:23)
> Add compatible string for the SPMI block on MT8188 SoC, which is
> compatible with the one used on MT8195.
>=20
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

