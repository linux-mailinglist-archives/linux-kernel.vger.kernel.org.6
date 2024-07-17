Return-Path: <linux-kernel+bounces-255178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00E9933D25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 14:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098081C2315D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 12:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F1E17FADF;
	Wed, 17 Jul 2024 12:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="acmYZ2c+"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B34C38DC3;
	Wed, 17 Jul 2024 12:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721220691; cv=none; b=HqcdNEQ179QRog9DZB1VLCZvNIhsLbOYKJMjhVs6Cw61Y+PqjKOSdG/OwzbG1zHI3mQwOsy2LvX+fHpq79/4Fc1ClyEOANjBNDg0sy1XtKYstrm4juNx+M0zMEOWE5F/6FBzp6WrKv1cjYwYQVxmY2yc1fap2LPFWactVMMFXNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721220691; c=relaxed/simple;
	bh=gZwVFjzSRVTmALU1BmNQ8keVRNZSkGcSyT2qhAkCHmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKleTWe1Kvvb3gpjSMazDXNrDJWeT2H/7Sr96u8SJvQ6IgYMdC81rRiRn4OTFG+hhJ5I8kBRrKMc7WLe1mv8+97RIMX4L1+7MNDIJRf/gGTFRE9AnqFQA619A86fMgkju/1tjK0bKRfdCnr6oysu+ZMmxu3io1PrQAOxkDS7O9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=acmYZ2c+; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721220687;
	bh=gZwVFjzSRVTmALU1BmNQ8keVRNZSkGcSyT2qhAkCHmA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=acmYZ2c+SQF3vKCNlalGE51ieTweRpud/cjgYlzKVq+P7EKQcfAb6MvS33njm2IQl
	 CCU3Mq8ky4G1q3LB1B4/a9drmZ1zqEqjPZKUSJQqcpSlx9T8nbycVEY3xfdlkC9j0U
	 19oi4BnJM2lNJQjbBrWrwsgvaYiuLVKxKtKQL51HTtgILUSNFj778hfM7mP3haNMh7
	 wJzufg5YIowyAT4ocL60xMKqqXMulxJ7YItCv9vic+bR9WH+UOHtovIH31SKFVlELX
	 XVM7uzl2JU+blLyThS/PW8noqjFFSoVYrh5e71qsLy/itEQWUaBsccQBj7BBXFu1yZ
	 0Xm/HI2M7ffLA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 851A53780480;
	Wed, 17 Jul 2024 12:51:26 +0000 (UTC)
Message-ID: <10cd2114-e809-48a7-939f-75d95e68d9d9@collabora.com>
Date: Wed, 17 Jul 2024 14:51:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: mediatek: reset: Return regmap's error code
To: Fei Shao <fshao@chromium.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240717115919.975474-1-fshao@chromium.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240717115919.975474-1-fshao@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/07/24 13:58, Fei Shao ha scritto:
> device_node_to_regmap() can return different errors, and it's better
> practice to pass them to callers.
> 
> Clean up the hardcoded -EINVAL and use PTR_ERR(regmap) instead.
> 
> Signed-off-by: Fei Shao <fshao@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



