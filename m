Return-Path: <linux-kernel+bounces-377886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DADCF9AC817
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8240DB22507
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421BE1A08D7;
	Wed, 23 Oct 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="A4NdIEmR"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A5619CD08
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680042; cv=none; b=jsJpgH3AGTsaf+Up6Tf3I6FjEFUt76yl16uMqlPL0loMmtBzk+gTXPgyhesZdrP+M0AVeKVtzn2EC9AicUG0jW1xspiRQnSpNn26p3PTgxbtt7taATpA5t4uAz4xFmlcyly2ptNzt5oZaZSA/qqTYLFe2a1p/buDTxB7uYDwgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680042; c=relaxed/simple;
	bh=o50zMYvyJy94Jo4WMf29VGc2u3pKkDKne85GzsktI+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VRtNAu9tglYXlNdBCbi+oZftz7EEVpEQWE2P+Wbs5pBvM25CpysreQxKDuV4LejzRXUW4fzm6m1WmMzU5AT1BwVIMVZ/loCMnwgfjOrFrtvg1Q8CB68Cazf8w9UtpeskkpVX/0gAuy4qlzZqCf0tKmGYBIIbxWp6lG0WDBrXipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=A4NdIEmR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729680033;
	bh=o50zMYvyJy94Jo4WMf29VGc2u3pKkDKne85GzsktI+Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A4NdIEmREsvf6ijIpkWkHLbM0fdtVXxn1xmR1Lw51BoK2AgDxfEzUJu7H7bEHDO5T
	 XYEr7dRd8WIXjEdZ5UnB8yHS4oxXfK6/+ZhzoD8dOwpESty9yE9Y1sYoN6Adn6NpZm
	 vfhxKOVo83mtTCtPV6nBpYGFnrRgVOUB7FsJ9wjT05E1hOEwVMIvVVBvzxSzXcu/u2
	 xeKP7aYBqSecehjt234ecBWnKqwjmnj9iWNH/NtyB21Z1gEu+EhAc2YDXwUrY2lVlp
	 18qUM82u30evUOV1AoYDBcCKUSEAQApxJNjDLlU4IFc9jQPneo/ucXZkNiQhfZvVL0
	 u0RxpQVHb7uvg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 11C2917E14EA;
	Wed, 23 Oct 2024 12:40:33 +0200 (CEST)
Message-ID: <9b12aaec-504c-4e3a-a606-240341d8e0d3@collabora.com>
Date: Wed, 23 Oct 2024 12:40:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: mediatek-regulator-coupler: Fix comment
To: Fei Shao <fshao@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org
References: <20241023102059.512352-1-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241023102059.512352-1-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/10/24 12:19, Fei Shao ha scritto:
> Fix two minor issues in the comments.
> 
> 1. We balance VSRAM voltage based on the target VGPU voltage, so the
>     comment likely refers to VGPU.

Function `mediatek_regulator_balance_voltage()` refers, as stated in the comment
located at the top of its signature, to "GPU<->SRAM" voltages relationships.

So, we're taking into consideration only two regulators:
                   VGPU and VSRAM

The first comment says:
"If we're asked to set a voltage (implicit: to VGPU) less than VSRAM min_uV[...]"

...so, I think that you've misunderstood what the comment says :-)

> 2. .attach_regulator() returns 0 on success and 1 if the regulator is
>     not suitable. The context suggests a successful return value (0).

The comment is on top of a "refuse" or "error" case - one that wants to return 1
and not zero.

Besides, it clearly states:
"The regulator core will keep walking through the list of couplers when any
  .attach_regulator() callback returns 1"

...which is definitely true.

drivers/regulator/core.c
function `regulator_find_coupler()`:

	list_for_each_entry_reverse(coupler, &regulator_coupler_list, list) {
		err = coupler->attach_regulator(coupler, rdev);
		[.....]
		if (err < 0)
			return ERR_PTR(err);

		if (err == 1)
			continue;

		break;
	}

Is that clear now?

Cheers,
Angelo

> 
> Fixes: c200774a6df4 ("soc: mediatek: Introduce mediatek-regulator-coupler driver")
> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>   drivers/soc/mediatek/mtk-regulator-coupler.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-regulator-coupler.c b/drivers/soc/mediatek/mtk-regulator-coupler.c
> index 0b6a2884145e..16df12d1c2e0 100644
> --- a/drivers/soc/mediatek/mtk-regulator-coupler.c
> +++ b/drivers/soc/mediatek/mtk-regulator-coupler.c
> @@ -74,7 +74,7 @@ static int mediatek_regulator_balance_voltage(struct regulator_coupler *coupler,
>   		return ret;
>   
>   	/*
> -	 * If we're asked to set a voltage less than VSRAM min_uV, set
> +	 * If we're asked to set a voltage less than VGPU min_uV, set
>   	 * the minimum allowed voltage on VSRAM, as in this case it is
>   	 * safe to ignore the max_spread parameter.
>   	 */
> @@ -108,7 +108,7 @@ static int mediatek_regulator_attach(struct regulator_coupler *coupler,
>   	 * this means that this is surely not a GPU<->SRAM couple: in that
>   	 * case, we may want to use another coupler implementation, if any,
>   	 * or the generic one: the regulator core will keep walking through
> -	 * the list of couplers when any .attach_regulator() cb returns 1.
> +	 * the list of couplers when any .attach_regulator() cb returns 0.
>   	 */
>   	if (rdev->coupling_desc.n_coupled > 2)
>   		return 1;



