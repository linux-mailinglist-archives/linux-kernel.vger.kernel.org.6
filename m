Return-Path: <linux-kernel+bounces-522810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 651EEA3CEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 02:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CAE3189923A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 01:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A9819004A;
	Thu, 20 Feb 2025 01:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MMESd3X2"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8341C7F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740014932; cv=none; b=RKMgfBvCDX7SGxt60IAMxkmutVGVVw5e4j+47tR8IELyIr0CZipt6ImatZQkD4iByU4X8psu0z7o/uMKSKVHUgEddA8DUYXp50eBSKPR9Vbj+Ni3z7jZ9YgG5iSP1jJz1Qk6yCEKb42rBlnkqNMEXthg1a9uRqYWPfaZ/ULBiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740014932; c=relaxed/simple;
	bh=LJdxENxZpd6woHMrpY+JCXncfXl+eonrCnkoYGj7Hes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AKXTWbs8zZNrUAqPNAKih0HUxHvX0ucJD9mGDXsOUZ/VgO65sUwzWYE0lJ4AFx6yjHbJYx5Jscze8R6UJ8zgWr5czi9b3hlaaI0Zmi6CddDlgUmM9cMRXFmPCy1bX7+6JwWXa987QJBhuMvAcZ8aIzugAbEYeFwm7Yfs+aTIGGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MMESd3X2; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25782504-2d3c-4666-b72d-343371fe037c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740014927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqvqbehjGrCNe1roBGtpI6CdjxU06tpCNUUgl7lLOFI=;
	b=MMESd3X2iQtkaGVQRwL3xhqstdJuuAjyumoxl6XNw7VGJk7xkwNcaEtaXZK+0UsfydBE1+
	Yx3XyQjS5f50oUCs6UwuGBWAmmqY1ceR3a6B8FZ9RNRRwiyBfvxqBJgxoLykA/6Q0UCEp6
	A3k7AJIPZQHC/shqdMvbQutshltteto=
Date: Thu, 20 Feb 2025 09:28:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net V3] net: stmmac: dwmac-loongson: Add fix_soc_reset()
 callback
To: Qunqin Zhao <zhaoqunqin@loongson.cn>, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Cc: chenhuacai@kernel.org, fancer.lancer@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20250219020701.15139-1-zhaoqunqin@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <20250219020701.15139-1-zhaoqunqin@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2/19/25 10:07 AM, Qunqin Zhao 写道:
> Loongson's DWMAC device may take nearly two seconds to complete DMA reset,
> however, the default waiting time for reset is 200 milliseconds.
> Therefore, the following error message may appear:
>
> [14.427169] dwmac-loongson-pci 0000:00:03.2: Failed to reset the dma
>
> Fixes: 803fc61df261 ("net: stmmac: dwmac-loongson: Add Loongson Multi-channels GMAC support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Acked-by: Yanteng Si <si.yanteng@linux.dev>


Thanks,

Yanteng

> ---
> v3: Added "Cc: stable@vger.kernel.org" tag.
>      Added error message to commit message.
>
> v2: Added comments. Changed callback name to loongson_dwmac_fix_reset.
>
>   .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)

