Return-Path: <linux-kernel+bounces-377899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B2F9AC83C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E19C91F22A05
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD7A1A4F21;
	Wed, 23 Oct 2024 10:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JpIPPgFT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950DE19CC20;
	Wed, 23 Oct 2024 10:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729680657; cv=none; b=Hyh4l+F7sc2m1/zBriBeBVGH5t/1QPdPFUk2SWEkT10I3IWHV/Aa+Rh4kUYdBPszvDhMygXZmNkxh/vWuB+NuxXRKEgPZn7Jiu4cLsDoZ8i9kFA8h9DHmU1c0Gr1C2LAxUikVfLAMjGthwgiY8s3eFZt+GjQgv2BDgRLhjRcCOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729680657; c=relaxed/simple;
	bh=TKS5gWQ26WbrWvfcYUusjWgWA7QNyzv+IpkLuOaZ2XM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHy/Qn1/8VkjJKTbTJeNpiVTSwlpHBpryrZLu8U8DlZeqdBY+S8bZtG29/jMSoO+dltKgvIsoCPJjAgAlU0tIT1v9a489FN1erFWmuH9ChH3o71iraZuU2uUMensU1UJifddWZs11OPoHWaZLlOPfg17lLqRmUSD3YNR0MHWOkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JpIPPgFT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1729680653;
	bh=TKS5gWQ26WbrWvfcYUusjWgWA7QNyzv+IpkLuOaZ2XM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JpIPPgFT47+UQJUwrpF/2XGnCqZZH5LmYkAVCJm9BKSYFn6/jIWm9RTYOR0TrHzfE
	 cm5sdZHwRszoAgRgkBjjdg0H5JONHWJaGvQXomf/oqsAKd7b9B6yH2eTZiDBLU7AG4
	 +jkPkFULqsPph/RNB4DoOpLgw3aWRskXY68nxqaOZKoixA8PeY4elL+AC2mJsb2Ro3
	 FeprclnpbP/5KJhRsdg9eLEWfAa2MnnTlUiwJn3Gwf+LxKkwJSRVdrAkKrEzbfOmom
	 Swlmq2GShzTdp82YtS9yJVlo19QVwd2B9nIBYtjdjNBxPnWM2ufKRdBXfWEKo/GSUw
	 oDFCQL6jjLWSw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E3D4C17E1063;
	Wed, 23 Oct 2024 12:50:52 +0200 (CEST)
Message-ID: <b96beaf3-897a-4dc2-afa7-6e3e1f456783@collabora.com>
Date: Wed, 23 Oct 2024 12:50:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt8395-genio-1200-evk: add adc and
 led for mt6360
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Alexandre Mergnat <amergnat@baylibre.com>
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>,
 Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-usb@vger.kernel.org, Chris-qj chen <chris-qj.chen@mediatek.com>,
 Yu-wen Fang <yu-wen.fang@mediatek.com>, Simon Sun <simon.sun@yunjingtech.com>
References: <20241023085010.7524-1-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241023085010.7524-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 23/10/24 10:50, Macpaul Lin ha scritto:
> From: Yu-wen Fang <yu-wen.fang@mediatek.com>
> 
> Enable ADC and LED of MT6360 for MT8395 Genio-1200-EVK board.
> 
> Signed-off-by: Yu-wen Fang <yu-wen.fang@mediatek.com>
> Signed-off-by: Simon Sun <simon.sun@yunjingtech.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



