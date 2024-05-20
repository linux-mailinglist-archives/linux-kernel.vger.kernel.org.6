Return-Path: <linux-kernel+bounces-183574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB04F8C9AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B5EDB20DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB8F482F4;
	Mon, 20 May 2024 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="vThg0w5G"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B824D9F6;
	Mon, 20 May 2024 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716199149; cv=none; b=rvfBm5P3rYuHjQBMbqKxRhyL5Po9/J+hZq0MgdJapuwyW9zvoYN13ahWGz3PV63PB9fpHjfN1TobEFq10Y2UBXadKpIdOps0D0zRYjllo4t8TtPCvI04hxmk0kkoFFXOL4KL3YjdbYFXIpBmXbuRWAoDOErwGVLEtXm8pZaK7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716199149; c=relaxed/simple;
	bh=YXr5OkApT26+XTrMA/rnWYnu5JA55GQIUti3yFLD6rE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P7x5RWzboN3a2pBf7qlYZu/AwnTfkx2uxsSNYg0etENZuBcJGk8DzD7bDIV7IJ7FwzriNLyi0zYpOMo4bShjdgSw3ojYGDmCkN9fWJqfJNvmKSqDaSZw+4pdX4jqec8QWudCc/vfDXuTlFYNA8l5pNeWu/oBMGll62rMt+TLEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=vThg0w5G; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716199146;
	bh=YXr5OkApT26+XTrMA/rnWYnu5JA55GQIUti3yFLD6rE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=vThg0w5GsICMH+h606V0YqDGp5cHx2istjfTQxTxSjOMhxyn8xYYhWoPKPswYI8qG
	 xTNGLq8cVs7WWpvnlXR5/sT+v7C65wnK2ZHNZ5HlZiG54vUVvo8vcCh1+e2UIxPPqa
	 e6RjOHpchfDDm9PLk9ICdPbrG0JsdB8lPa/6C15wQWYm/0K9jGzy+/p38i6/QVhy5Q
	 AFo0SG8OApHsJ1SgpG6hE9fZL2X5uHEHIyqeXTA2/Ug0oDB5aHD3jPSjEa3QvGVUw5
	 vku4tNZd+J0hYSwmrIYvOEOgqeFvXcu4ZRMGAsB7PrHtCRDQkiaEMdxijIj+jYKXC6
	 YD2B+9DSdhs2g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 05C1237820CD;
	Mon, 20 May 2024 09:59:05 +0000 (UTC)
Message-ID: <38422eed-cc98-488e-a3d7-a01b6f3ba1fb@collabora.com>
Date: Mon, 20 May 2024 11:59:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: mfd: mediatek,mt8195-scpsys: add
 mediatek,mt8365-scpsys
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 MandyJH Liu <mandyjh.liu@mediatek.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240518211159.142920-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 18/05/24 23:11, Krzysztof Kozlowski ha scritto:
> Add a new mediatek,mt8365-scpsys compatible, for the SCPSYS syscon block
> having power controller.  Previously the DTS was re-using SYSCFG
> compatible, but that does not seem right, because SYSCFG does not have
> children.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



