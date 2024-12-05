Return-Path: <linux-kernel+bounces-433230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0AF9E5560
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AB428240E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 12:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C287A21885C;
	Thu,  5 Dec 2024 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QQY1QRvJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C802185B3;
	Thu,  5 Dec 2024 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401604; cv=none; b=mBC8ekAgXlHHrnsAZTvLNAdbojgSdfPpo35e5BgmoT+tZq/wW+l3sX1p+jmSB3IXWzsaefIVGi26lARJ0AKWQN2id/RLNeYA659+ZOlca4aH/cLpAAQ652n+AFlp0oW/opk/hzbFlu/tQ0nrjXcTqGl+0whN0HYLWxtb+0DLByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401604; c=relaxed/simple;
	bh=yv6kXWoX6zCZnGgVmuBzAEHQVjf4DNee2d2sj9FyKf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KV2awK8vPy+TrvUxgEVxcyz+OVusCFZv2PuTfSgPT0lJ2ezofKlI+EJWAzlqF3qzD0cyGgeeqfQLR5Kw9CUuSLVapp/sL4b9taMXUHcpLMTSSJfwLXELgobtCWDT+/ozNLN0EEgO3j1s5uGXAjyGPCgyV8AdMwfXhBynS+V0azE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QQY1QRvJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733401600;
	bh=yv6kXWoX6zCZnGgVmuBzAEHQVjf4DNee2d2sj9FyKf8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QQY1QRvJt5UF4dXBbAbfdA2K8AfIS1pe4CFasRzlQx6+PGAeumT6imI2GiVswq6Fr
	 zQWzNdOUbi/FGBUPI1YIHJZrnlPoWfZZY4aKFqxkaV5psTrg9hCusoCF/K3B+WGpkG
	 pv5DqQsjRi1SMm3vbk7VLQJP//NThbQLEFdvTjm3fu7G6ewmTX2MKniPSi+Hw/Noq9
	 ZeBiiPa/XQwf0zG9dLTTr6jqOnxtqdPqxhlJ9fEMq+GIDWFrNimwH05+QiXyo9IPuq
	 93PWcIt3LhDAXuP4BFDysyszqcNqfZ9XI4JZsUUes2Jd1lgYVTfIFEtUKoGwcmzeND
	 duMYAOPR1LtKQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 32DA117E3684;
	Thu,  5 Dec 2024 13:26:40 +0100 (CET)
Message-ID: <1f2ce323-92ef-4386-a678-07e641f9a20c@collabora.com>
Date: Thu, 5 Dec 2024 13:26:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] arm64: dts: mediatek: mt8516: reserve 192 KiB for
 TF-A
To: Val Packett <val@packett.cool>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Fabien Parent <fparent@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20241204190524.21862-1-val@packett.cool>
 <20241204190524.21862-5-val@packett.cool>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241204190524.21862-5-val@packett.cool>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 04/12/24 20:05, Val Packett ha scritto:
> The Android DTB for the related MT8167 reserves 0x30000. This is likely
> correct for MT8516 Android devices as well, and there's never any harm
> in reserving 64KiB more.
> 
> Fixes: 5236347bde42 ("arm64: dts: mediatek: add dtsi for MT8516")
> Signed-off-by: Val Packett <val@packett.cool>

That has changed over time with new bootloaders, yes, so there's no harm
and it's actually a necessary change.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


