Return-Path: <linux-kernel+bounces-326139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085197639C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 09:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4051F224BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C42118FC89;
	Thu, 12 Sep 2024 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="P4RmSSJc";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="g+vgxaLm"
Received: from a7-42.smtp-out.eu-west-1.amazonses.com (a7-42.smtp-out.eu-west-1.amazonses.com [54.240.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43818A6A9;
	Thu, 12 Sep 2024 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726127745; cv=none; b=mFUD8VpkiURZWLxlj363DiogfBRGV51lMs+o8Mr2P/OjBSU7pPopn1AcH88WarBnJXvCYnfFBM73HZ6a5gZZLgigY2ESJHrPnjV/kIxj3FUL2gLhsyXa7rrvsNWmUgqsNvR9kbK8MqeN1qwcXftxQSgfiJBXHXLuuDJPOSahw1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726127745; c=relaxed/simple;
	bh=1m7M7RGWH/0IfXhPGV9mtNbCDn8qDXKZ4SD0dBzJTuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViesXM70Ag9DjRsItKmMtftvsb91ffgS//nRJzCBDM/yNTWy+/WDxxn0S/tDXUYNkf0qjznx8+Q/S/mc0fbre/LdSYXZd4OnplMyqKaqgXRHOviYHOvV0cbcr//PcP/zXUjGdLfC4Ab9+F709hk0hKdsnY00mXy7qoIvUXMwTi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=P4RmSSJc; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=g+vgxaLm; arc=none smtp.client-ip=54.240.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1726127741;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=1m7M7RGWH/0IfXhPGV9mtNbCDn8qDXKZ4SD0dBzJTuE=;
	b=P4RmSSJcyV9C35wg9iMZm2BMJ6mSVfYZGNmdQrSGKT/LgWWfXBI6QdWAmnl9keXF
	MC0oDUpT7AzRycQx0n55Pv0uBoVJFZ3HZi9trsRL/VSHop77YTayMRRqQ+wWNVq7W12
	ibEwBHCj3n/G3zId+jlAT1mMVax9ulrLbfOJAOW2rbxNWTeU8N8okVI/tA1siCJ165+
	f9pjljeL98uP7j4JSYYt3KMmOepKtcv2qRwlRPh9zhUSBMx4vfp+GrzcswTDNPv58vh
	DVH9Ax8lAaJabs78yXQ3yMirSQhvz8BmIhuhXwcFYnm5JfEymMgZi0ZwV209QnL6bqx
	HRxxKQRkAQ==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1726127741;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=1m7M7RGWH/0IfXhPGV9mtNbCDn8qDXKZ4SD0dBzJTuE=;
	b=g+vgxaLmyyk3btXWYDOGlViy8dC/odqJkrT93Dc+PQNXEBmp9gNTDjj+F5Yf38AG
	zMp7AgBTgfA9ST49lLyr4qSzwSwe5nFVPnkRz/f+Tfrk1ryBBw1uucNWMzb0qArPJ5f
	r2AtnS2tYtfJ5Q+kAkYp10hwt6RWaHaCJ6ep0GGU=
Message-ID: <01020191e53b1b5a-173497ca-00f1-4f81-be2e-0eed9ba7cd67-000000@eu-west-1.amazonses.com>
Date: Thu, 12 Sep 2024 07:55:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: mediatek: Remove redundant error message
To: Tang Bin <tangbin@cmss.chinamobile.com>, lgirdwood@gmail.com, 
	broonie@kernel.org, perex@perex.cz, tiwai@suse.com, 
	matthias.bgg@gmail.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
References: <20240911123751.2078-1-tangbin@cmss.chinamobile.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240911123751.2078-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.12-54.240.7.42

Il 11/09/24 14:37, Tang Bin ha scritto:
> In the function mt7986_afe_pcm_dev_probe, when get irq
> failed, the function platform_get_irq() logs an error
> message, so remove redundant one here.
> 
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Please clarify the commit titie, like
ASoC: mediatek: mt7986-afe-pcm: Remove redundant error message

After which,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



