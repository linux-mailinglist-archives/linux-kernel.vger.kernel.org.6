Return-Path: <linux-kernel+bounces-563656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D3CA64628
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D73F16857E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FAB221D9C;
	Mon, 17 Mar 2025 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nNi68yju"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E008221D3F2
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 08:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742201412; cv=none; b=qS295WFZFY1HBbKDTGCUdXeTO3sT2g+7ZhcRkAcT7xRu9WzC2Zb77g/jtTAi2iNaJeh+DmfNfZNwoElxFfwd0Tp0ZMQ20jV6LG9cntXJOOBmbNfej56SGN6voodVp6VbzcpKFoJnBjJ4ea0sZOwxQBjhGKn0cDkt6Dn7zxpcEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742201412; c=relaxed/simple;
	bh=JFO3x58H2vM/4oYxfHn0uVx+Lm738F8ylj7182GHs7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LisIHLXjOiFJHzg2mS45iwK52GAiCgYBu8bf5mQjrZeb0Di7o1+BFsfWurIB0+62/I1H2qvT1oHaQt1gecC2T83bUgsckUuhjUIr4lahsVMjv/GkZbxUl4/YoAQPMgdO43bNsAga4ax+AFtVxAD1RhRFL4G0oTUAP5Xly7b669Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nNi68yju; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742201409;
	bh=JFO3x58H2vM/4oYxfHn0uVx+Lm738F8ylj7182GHs7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nNi68yjucDdRGQVG4KpqLveAnQuSX00lCksWcpTuQ7DlLWlLAmKA1L23hnn6yHJMj
	 nR6etxATWsofpqNMM8vgztnNIo1296SuYic2axInVC/80BoFqjEOxjiEfsNx2BPU9e
	 ODKvSLJ/3F7fBo7qeufZh87aGygIvnDKYcEyE7iJ4J2E4HvU0IaFijgafYGzHBcmNe
	 4BR/QCCUBpaVuV3zRFT4QlCRx0p2IZz+5J916iA4ECg6LO3RId4XDcHpOmWRLkdpie
	 GdMEDNnSxnqdtzoMXo1rU5UWtvYPIjZXCVj6tGT+MNlJxHcuFkzzgBBcTLabNezY1f
	 MfEz4KwQa9XQw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 49D1817E0987;
	Mon, 17 Mar 2025 09:50:08 +0100 (CET)
Message-ID: <d0a85b86-2876-4ab1-ba0d-92611f37b8fc@collabora.com>
Date: Mon, 17 Mar 2025 09:50:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] drm/panfrost: Set HW_FEATURE_AARCH64_MMU feature
 flag on Bifrost models
To: Ariel D'Alessandro <ariel.dalessandro@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, kernel@collabora.com,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 sjoerd@collabora.com
References: <20250314173858.212264-1-ariel.dalessandro@collabora.com>
 <20250314173858.212264-4-ariel.dalessandro@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250314173858.212264-4-ariel.dalessandro@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/03/25 18:38, Ariel D'Alessandro ha scritto:
> Set this feature flag on all Mali Bifrost platforms as the MMU supports
> AARCH64 4K page table format.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Reviewed-by: Steven Price <steven.price@arm.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



