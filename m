Return-Path: <linux-kernel+bounces-232148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DC091A418
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 12:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D21CC283EE1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB23C144D1D;
	Thu, 27 Jun 2024 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QDAkt0AM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BD517F3;
	Thu, 27 Jun 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719484783; cv=none; b=qbYnbLGNXiMsY4lBRleVpSq9zijJKlw53F3dNgsCX/PGDtvPFBYcF/A4ajQ5rx5g6eqiOUdinL9HwqcySqLMKxV1G9u73tXu2MLSxFKoAPpHxdrq+VWJUmLb0OclCc4HtUZPyxkBtG6G1y3ibJP962cuGcB5ejWozdE53dCVCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719484783; c=relaxed/simple;
	bh=1VPF/YzboKYqX8bLJxoG0opm44sq0rmDZqjgaBL4l1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FsdoKTzWeTTPwUwcOM9xp9ajaKdgDRZDCsTvVYLBucc7yO3l/yEGss4kWHI5Ycq6v0yeJO7rolASEWqadTmGxLn8MUHbuMcJBXdb9c9c/Df5HzfeONj6b5eqZavHEUj/oceXaA2sb4c3v7k/3+fpsQvUBAhdpbJ98FjZnZWncms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QDAkt0AM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719484779;
	bh=1VPF/YzboKYqX8bLJxoG0opm44sq0rmDZqjgaBL4l1s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QDAkt0AMBCV0fcJoXfoz4DoqVHH5hP16/piSVS/CPZKtRGUJT0mg7mWoQXIgjEFlz
	 /x4z4Vgx2wgQfSLyETU1nEKVj+Hd/ErWcUy66QmmuY6ZCit99+skhBLZMYNS/Xb3m6
	 KIUge3anDIPf9Zy5wsCsXvV/eKJt4pSBV//SQtyrASHkwMBLAzfhfpl3rVQvrDWWzw
	 J074x4DDINc6xxyj+6mvVqiVNQf1J/EAvwVeoHbctDwjnvQ/maco7pzLxijKvi4aVn
	 QJavJykwgHgziMBECh7s782cGnMjO1IvjySjxrni3sV0Md4Dsw6yQRBmM8qjKAacTG
	 i5UdZ9+M/icag==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6C4AD3782181;
	Thu, 27 Jun 2024 10:39:38 +0000 (UTC)
Message-ID: <3eb69629-888a-4a37-ac65-3aca07188cdd@collabora.com>
Date: Thu, 27 Jun 2024 12:39:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] dt-bindings: mfd: syscon: Drop hwlocks
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>,
 Khuong Dinh <khuong@os.amperecomputing.com>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chuanhua Lei <lchuanhua@maxlinear.com>,
 Rahul Tanwar <rtanwar@maxlinear.com>,
 Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com,
 Nishanth Menon <nm@ti.com>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240627-dt-bindings-mfd-syscon-split-v4-0-dc6699a9f3e4@linaro.org>
 <20240627-dt-bindings-mfd-syscon-split-v4-1-dc6699a9f3e4@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240627-dt-bindings-mfd-syscon-split-v4-1-dc6699a9f3e4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/06/24 12:32, Krzysztof Kozlowski ha scritto:
> Apparently there is no in-tree DTS syscon node having hwlocks, so drop
> the property to simplify the binding.
> 
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   Documentation/devicetree/bindings/mfd/syscon.yaml | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 993460c3cfe1..cc1e9fec5cc7 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -143,11 +143,6 @@ properties:
>     resets:
>       maxItems: 1
>   
> -  hwlocks:
> -    maxItems: 1
> -    description:
> -      Reference to a phandle of a hardware spinlock provider node.
> -
>   required:
>     - compatible
>     - reg
> 



