Return-Path: <linux-kernel+bounces-244790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975EC92A996
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC444280D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2452714D717;
	Mon,  8 Jul 2024 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFXOJpe2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAC814D443;
	Mon,  8 Jul 2024 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720465691; cv=none; b=iEICYY/kikRPTyB4gB8+c8cbAaSmY5FfQgjPfc24jOi/Y9pamrMalVDhO4MN+hM00DHnjSNM3VIO9MWSsnRWSUu/Lf+KT828qxiHyp/S8v55pGpUKHSzeig1HfJ+7e4kBvwNx6WcLmEPJoAxFHLOKMRVK10InkSDlDqij1xJ8a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720465691; c=relaxed/simple;
	bh=R8/Nus0e7IW0C9Eu5Ta/MA+sKFXKraYblzR3qp2a6xQ=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=CHJ6INeyHauHnYb+FDQzH5J17/ivhmQ7rzaUEbmkF4zdqHoIJCk+0BxcgbBd7ioVdp2YtVuYqpXRWnFwkdIvlsolANggtxK30Ja2TBBXgiVH12I8qMHfyb6ktgET3omty4NcCeBdBV/GklQd146eAduMAgTW6gsB2t+22ashxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFXOJpe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB86AC116B1;
	Mon,  8 Jul 2024 19:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720465691;
	bh=R8/Nus0e7IW0C9Eu5Ta/MA+sKFXKraYblzR3qp2a6xQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=PFXOJpe2b/wv9Zp0SpgMXqF9oWbgwtMxtkPM1PeuY+BSmzW/zKQ8CNgfAUtdErEAx
	 mxUr+N5w/7hG58fL75t3pPed3kDt+SXKjs/g8qK6H0ZooD6/XcBY26p1ZvyYN97mUA
	 yIF8Qe0Ue6fn49rFbtExg9jHNcRMIsr/ZCSDP/GnqPvEOgrjbjJPwDz+MQ00+7HAuQ
	 1m+iNacvsTFg0Ocn9bbjT5n1AlQbHDHg1S26nrBrs/WzVr6Uui7dvTLef/IbFKZQrL
	 WLFR+H687vPdmjsojDlaw518Rnyy9qblJmsd8GEgVmksYCa5cAtk8ldOI9FIvvJH4P
	 yhbPvOZCHgBBw==
Message-ID: <c43d0d221df30fe1a215dab07da10245.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240619085322.66716-2-angelogioacchino.delregno@collabora.com>
References: <20240619085322.66716-1-angelogioacchino.delregno@collabora.com> <20240619085322.66716-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/3] dt-bindings: clock: mediatek: Document reset cells for MT8188 sys
From: Stephen Boyd <sboyd@kernel.org>
Cc: mturquette@baylibre.com, robh@kernel.org, conor+dt@kernel.org, matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, jassisinghbrar@gmail.com, garmin.chang@mediatek.com, houlong.wei@mediatek.com, Jason-ch.Chen@mediatek.com, amergnat@baylibre.com, Elvis.Wang@mediatek.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, kernel@collabora.com
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, krzk+dt@kernel.org
Date: Mon, 08 Jul 2024 12:08:08 -0700
User-Agent: alot/0.10

Quoting AngeloGioacchino Del Regno (2024-06-19 01:53:21)
> The MT8188 sys clocks embed a reset controller: add #reset-cells
> to the binding to allow using resets.
>=20
> Fixes: 1086a5310f9c ("dt-bindings: clock: mediatek: Add new MT8188 clock")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next

