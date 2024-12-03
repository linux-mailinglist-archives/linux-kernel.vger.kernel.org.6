Return-Path: <linux-kernel+bounces-429155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66189E17FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21BD51616BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5C71E0E19;
	Tue,  3 Dec 2024 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HUWm0h12"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D51E04A1;
	Tue,  3 Dec 2024 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218845; cv=none; b=Pcn88Ucr0Xm+lXz9BAEx0uYO+7hkXFoIuUCzLhNtIj3gwdr+MeiEo3d2P2yfgYuxjl+2iuLdRXYMjhaxZvJMRj1uo4vNDQEql0jKoXrJPSo3YN5BuhXy5hmcvy6SvvhP/4lzYPgFEVQHrMoLpuJfl1bkAnCn32Z3dCYzm/lgBf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218845; c=relaxed/simple;
	bh=cuml/lyWq/tsezamLt04fwUzFmq8PP+5VXGFR2GMyMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D4GvhY2pr2CWeD6vQjr6pV4hwc8TWNsbyya14oC9FTf/7ckooEvbKa3rE2f4AwMMpqQIO1WDiairZs2NuOikPhxhr+9igk2EDLGq0d1Skr50EsbdAw/JnEbU7dxbsqcup+ryZ+O0KNNVsu1YH5SEcZqq99WGmyjVYiz5CFvZ254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HUWm0h12; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733218842;
	bh=cuml/lyWq/tsezamLt04fwUzFmq8PP+5VXGFR2GMyMo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HUWm0h12pGgiL/8lxd0bUBkyu+jfMDfgyJOmmhQkCZ6MdXi860AG4jiQBbukUv/Bw
	 1PZZlenb/Sy/hxVha2zoZx0p/PzEIX7U5Xr/4DuwqI9fsTAea2hlPgyijGY+T+4s9r
	 rIOD/o/K91AAHE0WqnQCF9p0V97Pwbc5LabwsxY4gIetQGD8DnY0/D/1c1ojym4MJA
	 kONaZgHGf04KJJSCJEMbHUppCRi1MOlOAj8knA9M9WAQk+tYrW5joze+AmSvdPRYP1
	 WUf5nBfaUv55effbna4uJWYnAkofoL0cHFcEg+rl7DgzS5QUtAKOO3uW/njzsMYTvF
	 hmJxeXAtJEL4Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C265617E35D0;
	Tue,  3 Dec 2024 10:40:41 +0100 (CET)
Message-ID: <8196dbf8-983b-406d-aa85-db51b5609293@collabora.com>
Date: Tue, 3 Dec 2024 10:40:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/18] arm64: dts: mediatek: mt7988: add
 operating-points
To: Frank Wunderlich <linux@fw-web.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20241202122602.30734-1-linux@fw-web.de>
 <20241202122602.30734-10-linux@fw-web.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241202122602.30734-10-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 02/12/24 13:25, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 

arm64: dts: mediatek: mt7988: Add CPU OPP table for clock scaling

> Add operating points defining frequency/voltages of cpu cores.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



