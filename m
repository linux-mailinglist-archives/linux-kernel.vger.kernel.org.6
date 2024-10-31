Return-Path: <linux-kernel+bounces-390089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0AF9B7555
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 08:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8474E1F21579
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EDE1494CE;
	Thu, 31 Oct 2024 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6AzanjS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5F1494B2
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730359633; cv=none; b=jFAYH+/4iDENjfamnAabDpO1magZDgX91rEQMB3AikPgNes6N5lj7tGElujxbGp69ZfefviRhjmgBnHy5yCd1g1Hshwz9RR6xlp+Y4XVHWl3NipxhKrNsjGvFrr1yhueL+UdPYZux/Ak5kf5wR6HzNucnXIFmoptfuxvISA03hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730359633; c=relaxed/simple;
	bh=yazdEVDGHebAAg62eHSOa9TUi07+6ts74x3ynp+4AIQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Nq9kFaGn7rFzpTI0dftnpTcVyRCiSeWZsrp4Yl0Yxw/FQ7WWyw2w2B4frQl/aphjq2DeE7VT+g+8P3Sh/oByTtiMtkzFy0QiEMn1Cb4Yvnm+8vfc/pheqnQr9UhmWtGmUt5NsUug2Vywdb/fXIOVpVRq007ZwPL3s/KyaLwbzuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6AzanjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7629BC4CEC3;
	Thu, 31 Oct 2024 07:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730359633;
	bh=yazdEVDGHebAAg62eHSOa9TUi07+6ts74x3ynp+4AIQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=s6AzanjS6STfkhFqy+gdX2pANds+P2znn0onvayIFmLz94zgFM/sRItdY3Mbvtaqq
	 2NU7t6H1A38DEOxFDNSgAmZyRLi7hDZIkhrmujRsvBC3cPWrRRYbSwSBuVvtnB2tl6
	 T55Srgv17VW0s0VJxLEgcGKJ1d+mtF5kZu6GAru2YvPrK//TYlJ2iafrucChiSkhyF
	 7K4cDc4ZRIgwws1lM3FoPB5e04GAxiGHIxuyyOrv8oDXXlw62kAfhMlLadEF7sy/xs
	 ZYCe9xOgKkTQLoUemwdCYhzSrF/8gl5Sv3jyvcI2zetWKCS4e9UHAy1LDLF7gmxuMp
	 an8EfVTYbTI7A==
Message-ID: <cf81df94-3ff3-44b8-97ad-e68b6315fcdc@kernel.org>
Date: Thu, 31 Oct 2024 15:27:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, sunyibuaa@gmail.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com
Subject: Re: [PATCH v2 3/5] f2fs: add parameter @len to
 f2fs_invalidate_internal_cache()
To: Yi Sun <yi.sun@unisoc.com>, jaegeuk@kernel.org
References: <20241030103136.2874140-1-yi.sun@unisoc.com>
 <20241030103136.2874140-4-yi.sun@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241030103136.2874140-4-yi.sun@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/10/30 18:31, Yi Sun wrote:
> New function can process some consecutive blocks at a time.
> 
> Signed-off-by: Yi Sun <yi.sun@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

