Return-Path: <linux-kernel+bounces-437166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60B89E8FDE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8654164F47
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 10:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DDB216E18;
	Mon,  9 Dec 2024 10:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SbUTaKLP"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224742165E4;
	Mon,  9 Dec 2024 10:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739275; cv=none; b=ILxXBlcO94SqS7WwpS8lMs64eWu+FJJjiu0Kso12sDTuhynyqbe1ZPZrShs9vj2GVd5+c5TErdfJ45q1yQ3enclJOtbGw2ioB2UcjrS+LO1uRfn1bU0dO/jq8horrNyvMn4Kw7P36xs+uFzlbHLRMZkkqCa6PKMbyNX2K+ARWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739275; c=relaxed/simple;
	bh=w80pNd53yPsn010J40RXAr/XNrgFhv+WCFz/O/1B7ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwnDR/sgxbDGLpSPRO7jXDUocEp/nf+rmViz8w1ZRiOssTOxl7KXW3mr0obhuyZKjDdjeuvH47shLGcBN7VfDp4VlRFi5b+rsZ+jZP6z4H+D9SkIlqJ8JE981/ypZqXjrCa1gApjfaiUrPtJTejHC8bCZ2ZhvHJscMlS0/wuc7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SbUTaKLP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733739270;
	bh=w80pNd53yPsn010J40RXAr/XNrgFhv+WCFz/O/1B7ZE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SbUTaKLPqjKvX6zH5JWq+odhN0SexrqORW4cc5MIs0amwO7eZWvRZ1U4xsqCi7GKc
	 93OMB5oQrQ/CSQI06eqpcA2lu6aVmk8Z9as77CAbNN/vdRn7vP/+47eVDVajPAV/94
	 lksISSV8yvK5Qbd1soNLRmfsxXHc46OB2mhvBY/oM/N6TrpW+WngR/u5GgSRDvOcVQ
	 A87neH6WDVNlQ0hX4NIwtiTelub5jDgJinQIVi3oONsn8Vf7dDkzsnTB66/rBNlAfG
	 OMpwRsqN7uemXixwkdtu6GKUJxXu6hpPn9X8MhqV9KnzDva79nXZfWjMTi64W9T9af
	 xKcMsayQNYfWQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7AC2D17E14D5;
	Mon,  9 Dec 2024 11:14:29 +0100 (CET)
Message-ID: <456b8050-7a7c-4f5e-8ace-5e88e02e86ba@collabora.com>
Date: Mon, 9 Dec 2024 11:14:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: Document compatibles that
 need two register ranges
To: Chen-Yu Tsai <wenst@chromium.org>,
 Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Wenbin Mei <wenbin.mei@mediatek.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, Frank Wunderlich <frank-w@public-files.de>,
 Andy-ld Lu <andy-ld.lu@mediatek.com>
References: <20241204092855.1365638-1-wenst@chromium.org>
 <20241204092855.1365638-2-wenst@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241204092855.1365638-2-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/12/24 10:28, Chen-Yu Tsai ha scritto:
> Besides the MT8183's MMC controller and all its compatible derivatives,
> the recently added MT7986 and MT8196 also require two register ranges.
> This is based on the actual device trees.
> 
> Properly enforce this in the binding.
> 
> Fixes: 4a8bd2b07d88 ("dt-bindings: mmc: mtk-sd: Add mt7988 SoC")
> Fixes: 58927c9dc4ab ("dt-bindings: mmc: mtk-sd: Add support for MT8196")
> Cc: Frank Wunderlich <frank-w@public-files.de>
> Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



