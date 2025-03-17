Return-Path: <linux-kernel+bounces-563657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD08A64637
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90058188FADC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0A0221F33;
	Mon, 17 Mar 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FPITYZqM"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44672206BA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201413; cv=none; b=Tr47G+VGTZrXrhZFJnmtUsdN8yArA6pHSOhm/+DrhoNd5uDFGCD5gS1IXqB/4sN+clP8zHoObE+1Y2s75i5nd40zfMmbR4Msm1UHpALch/Tb7DaNHeZjXGGWe7m1xSkdYFG6pAZj9i5WCHKZMpF/4Cl5xMegYC2npjMc490ITmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201413; c=relaxed/simple;
	bh=xPRG7e60Wh++Rc+1rnNarHDDzFlkv4gGvxJsAnyQKxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kdv1BKV5bb02I3uM5+GS2zmVZH111UAE/n8rg3DoLBlzEL0MrFz2CcNyVkvNNSB0v/ZYz1iltLvAIL9ndRQbIRocuxNqFeH8iprKXSuAv4YKc2ZXO4fAKoxBrRMZ4UhTx3f14jSCdLHgEouZjpmF34DFIbe3rYQ4xeUmgd/kOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FPITYZqM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742201410;
	bh=xPRG7e60Wh++Rc+1rnNarHDDzFlkv4gGvxJsAnyQKxo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FPITYZqMJZ/LYCF561Uaslt2ZGdpqCw9xW5RgjvvmQjXay9Mr7x5YlpR/UMmyXo3u
	 SlAvf2ecNAJvPOdsZvvO9S4OthGOOlEGJsul8CHtUvXQO9TC+reRX1dW50a8RM4AM8
	 a1Yb5vU9JJ6UEJBPpucZnRuDU/a6RWM5KPZ1blZ8vQa4n3I5wnCgjL4edSVofx3W44
	 7dshqu5PjWjhzPYeEgGLtuOqEWULBr66xxLdmp54Y/koXEWkxYnkm9BjCxMVSDix5A
	 FNEUsCju82X+XXGKmCKJSjJycfPdeXTUEroMYza703apj8X9w9pG0ktR6m5MokhLNO
	 LZa4+uOqV+gEQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3DABA17E0B12;
	Mon, 17 Mar 2025 09:50:09 +0100 (CET)
Message-ID: <1a98bd80-5ce9-4085-95d9-9faa93293647@collabora.com>
Date: Mon, 17 Mar 2025 09:50:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] drm/panfrost: Use GPU_MMU_FEATURES_VA_BITS/PA_BITS
 macros
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kernel@collabora.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 sjoerd@collabora.com
References: <20250314173858.212264-1-ariel.dalessandro@collabora.com>
 <20250314173858.212264-3-ariel.dalessandro@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250314173858.212264-3-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/03/25 18:38, Ariel D'Alessandro ha scritto:
> As done in panthor, define and use these GPU_MMU_FEATURES_* macros,
> which makes code easier to read and reuse.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



