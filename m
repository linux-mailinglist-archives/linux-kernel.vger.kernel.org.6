Return-Path: <linux-kernel+bounces-554273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D74A59595
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 14:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F5C168B80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD05227E96;
	Mon, 10 Mar 2025 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ItHs6/kJ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF817C91
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741611972; cv=none; b=Uo51NT5s/QykjnaTLNx9Jx5WVVXPbVLAHGC+cwzcGtKSRem4+TCgdpipita4Ld96frhKA4fkzEt+rLtpOK98H0ZKDtRS9ypGl475B8TSIlk9ecoit3znaE28ckrWTrNLXOszNPwHapu4jUmeCgQqguXplYNJqk8BfVO3t2nvj+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741611972; c=relaxed/simple;
	bh=TConZA4h3MGEat4fRP5rb7inM0iZmfBZr+fmrbt6mgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hN3BpQlCcZDHXPKhFPElgZh0Uq1N/e8Zb2auCc1DdYUfdj/MWaAzmF9VUrnU+s6qNBojT+hMVlZ67Y5Ft1w2f3cuuceUbHEuYWIbTO2wJE8tNTVP5GJ05D3DrxShDf54LtjOAA4fvYvdXXXT0fvZSndBXnHFOfNtccJJpGU4NFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ItHs6/kJ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741611968;
	bh=TConZA4h3MGEat4fRP5rb7inM0iZmfBZr+fmrbt6mgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ItHs6/kJh/VJL1tEPWVRwaYpEbI8VEgZxNzU/Ymp5lcuMRtc6nyK+4TdzfedOxzPq
	 IDe4lSwPFbR/NO9nW9Oyz95Xe/i2ZeKAY7hjIUD60FPFCNNwITXfK1HwiLCwN/+whU
	 BZdoYgJ8BIAVmWWxFA8UF80pDKUKuUhCMAXPmX7xLIE9I1WPSW194FEwQJxhFLXfuD
	 w8WWoTHvXI/U32h2zS9wjUNeVTh4IbYE5YBCwug0pX18I/XnmuyaXqAqDSkPDE3rnu
	 K3BEjJ3waSSbv5aFhb6zbuQ7rAtEE9L+FlNBVd+W0b1eK1syDpdzzCOSR1FLhVOP9b
	 ZQsuJc/YZ9TcA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DC0EC17E087E;
	Mon, 10 Mar 2025 14:06:07 +0100 (CET)
Message-ID: <6295bee6-326e-4eee-9636-1d3b41a59e30@collabora.com>
Date: Mon, 10 Mar 2025 14:06:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: mtk-smi: Add ostd setting for mt8192
To: Xueqi Zhang <xueqi.zhang@mediatek.com>, Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: Project_Global_Chrome_Upstream_Group@mediatek.com,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250307054515.23455-1-xueqi.zhang@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250307054515.23455-1-xueqi.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 07/03/25 06:45, Xueqi Zhang ha scritto:
> Add initial ostd setting for mt8192. All the settings come from DE.
> These settings help adjust Multimedia HW's bandwidth limits to achieve
> a balanced bandwidth requirement.
> Without this, the VENC HW work abnormal while stress testing.
> 
> Fixes: 02c02ddce427 ("memory: mtk-smi: Add mt8192 support")
> Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



