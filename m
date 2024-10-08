Return-Path: <linux-kernel+bounces-355133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B33799947C9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 13:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAF51F22783
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 11:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B751D3198;
	Tue,  8 Oct 2024 11:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="IvgaEkbV"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EB33FB1B
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 11:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388459; cv=none; b=r/CZ/hQ/gWuAQAalviEEDm+e0UnnX1d8ZjUsXIcZzGg4BXbpI0uUxFxOR0xUOe2QBz2GtDN7FQpxoPC5KjeMCGLpplZUZK7TzfpV+JhHaLDaVDnsA31qLdtTj2EFQB2+w9XkNBRKx0WyZ9JobhquOP+e7NYlIOtUsGsgFp1IIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388459; c=relaxed/simple;
	bh=nc+MQghnyWyZJRvqvPkCeTpAprctMbpI7KvLhPyLhv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JU0OWONzMuyvxPargdDWA1IZBEP/6NFX/YggPtl/56nX9BJF3PuyaqSgYwNgwpkT5L0vtTmDkFfG/nnXqXn8FEn02l4loSVZoGPK87rSnSA3arHGVrUCUbEYBTNW6jKT0ZtrSWLxKNTzlJ9SPF6O6Bat5dsrnCkeDwfDgyr7VRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=IvgaEkbV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1728388455;
	bh=nc+MQghnyWyZJRvqvPkCeTpAprctMbpI7KvLhPyLhv8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IvgaEkbVzoX+XJ3nL3RuiRCbIgObPK5O/gH13jaPjIpiCUeKp7QkLCWtycAbEvpHL
	 igmvTfkgan4NG/NsTZ4IZYL6ZQMYpz5QRDWyPnFxZQ3DgYFHlzLUYX53IF+em4vXw7
	 wU0LUdaeaFP2MIq11/Jq3xLTLsx7wOv3p3/wXho2fiCQeYo00TjQzD64dmVVRed0Bf
	 PRKcTKbASTKrB/qJkGi7+CIig5M2Hx9d7+PGgmpudY1rI4/CmSYMzxp7fIi3u5rH/I
	 Dxte+S1iV+toj7nEBd8zBPZSiUGT2dewBHH1rY8CndUm3GPR9bBjo7RC7gwRswMEj9
	 lVqD9eJmz2qBw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3C5C917E1411;
	Tue,  8 Oct 2024 13:54:15 +0200 (CEST)
Message-ID: <6b190912-90e8-49b3-aa0f-b8ef8f47e78d@collabora.com>
Date: Tue, 8 Oct 2024 13:54:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] soc: mediatek: mtk-cmdq-helper: Various cleanups
To: matthias.bgg@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com, linux-mediatek@lists.infradead.org
References: <20241008093220.39734-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241008093220.39734-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 08/10/24 11:32, AngeloGioacchino Del Regno ha scritto:
> Changes in v2:
>   - Dropped patch marking very likely/unlikely branches
>   - Removed useless .mask=0 assignment in patch 2/2.
> 
> This series performs various cleanups to the MediaTek CMDQ Helper lib,
> reducing code duplication and enhancing human readability.
> 
> This also avoids double initialization struct cmdq_instruction as,
> in some cases, it was stack-initialized to zero and then overwritten
> completely anyway a bit later.
> I'd expect compilers to be somehow smart about that, but still, while
> at it ... why not :-)
> 
> Tested on MT8192 Asurada, MT8195 Tomato Chromebooks.
> 

Matthias, just making you aware that I'll wait for your feedback before
replacing v1 with this one in the MTK soc tree.

No hurry, though.

Cheers

> AngeloGioacchino Del Regno (2):
>    soc: mediatek: mtk-cmdq: Move mask build and append to function
>    soc: mediatek: mtk-cmdq: Move cmdq_instruction init to declaration
> 
>   drivers/soc/mediatek/mtk-cmdq-helper.c | 230 ++++++++++++-------------
>   1 file changed, 106 insertions(+), 124 deletions(-)
> 


