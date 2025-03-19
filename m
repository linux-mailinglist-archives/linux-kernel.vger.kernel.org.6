Return-Path: <linux-kernel+bounces-567959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAB4A68C6D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9163B17DCDE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2212125525D;
	Wed, 19 Mar 2025 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kpv5dZ2X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0341DE898;
	Wed, 19 Mar 2025 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386175; cv=none; b=Mnx4Ubepps8p4kF3HzEKZJZl8xqGbXKnrWnL06qFMOJPuL+wd87Kl40MgXKBg/kB3yBiuozrAQ/Zuvvl1xoae6JTIRAApmKYmXTClzvk2cUrY21phG3BFD4jxa/2jjHBBWDDWrlJgDmXTiiwvSqaMc9vXM6EgpgvnZ4N0w0MVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386175; c=relaxed/simple;
	bh=5OumFdPxqei/mYuFbS8INHe10HrU5KI5NWKgRIG9/0Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=F8RpAu8mnQDsji8bV4/Y3yJw1sV3o+3odAA218Za6jk7NVA6mOUAdj0TJzs0a4+VfzKr4jGG0vkOKwAlm++2/1rGg40gCQyiNKrgaMTXNnhPTG5RDrN49B4L//vGPeCqW+YEEJ010P8Ns9Ikk5HH9Vf/eH39rp30KtDq4/Jy4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kpv5dZ2X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D475EC4CEE9;
	Wed, 19 Mar 2025 12:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742386174;
	bh=5OumFdPxqei/mYuFbS8INHe10HrU5KI5NWKgRIG9/0Y=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Kpv5dZ2XM4qyeFOsIpVFyyaQjsd+sIzvCL7Q5Zf9NUNJfayZg9TY/nY9N/HuXezT4
	 klXZvNC7XQPW+woXP3mhqpUm606uwt2uid9YDP3TOXpLQaWQ//xtLTnxWEKAkcFE6e
	 huNf1qYWkWRBKhJN9CMKgsDwhmBFjQAfa97Rt2mVnxrxPZ+cowJy9fpDMLZF7xu5Kd
	 XnCN/LeEBEs5UnQ70gnYERTt4FcnWCLYM3bOvdNvQAbaFkpT3JJwGaSrU5coGnAUzC
	 783aUWzmznb5OrZ+OBpoNXID8R13K0LOt0lGWjTP3XZ49v8SjgKwIucuPZeY+WaPPX
	 Tv3bJpi43w0eA==
Message-ID: <8a0b4a75-5527-4246-ac7e-353a2ff8c8c4@kernel.org>
Date: Wed, 19 Mar 2025 20:09:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] f2fs: remove redundant assignment to variable err
To: Colin Ian King <colin.i.king@gmail.com>, Jaegeuk Kim
 <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20250319113011.791319-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250319113011.791319-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 19:30, Colin Ian King wrote:
> The variable err is being assigned a value zero and then the following
> goto page_hit reassigns err a new value. The zero assignment is redundant
> and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

