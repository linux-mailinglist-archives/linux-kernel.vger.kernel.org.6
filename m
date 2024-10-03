Return-Path: <linux-kernel+bounces-349631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C0398F949
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487BC1C21BB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D551C4631;
	Thu,  3 Oct 2024 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGyNj7l3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012B1C174B;
	Thu,  3 Oct 2024 21:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992527; cv=none; b=MXBXW100QnOXeIcIA/5aisRit5LM0F9Kz9ZsNnt0GpNbBomzjhfvKrA7cGnnHnCIXsIjWMokR9UmhjC5WaoqqJDLnVa8UhCQipE3rL4FkBtO4RnEMlvLehPs90xtfnElkG7vDZRqgyeaCU4Ozki2GXPvm0RpGP8f0/wW0wmn+gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992527; c=relaxed/simple;
	bh=xOjdTn+0KHxGvPQv4VL8wLsownOXdNAg1fw1fwx8JjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTvLM0VhRMO+DZMX8lokKTS9C93hJAbnY8NrjarQDXpSAp/SYRSxlz18d8WaHOW8VGMw0J02JjHfmsnrNlOaS5wL0doWfL0wb5Vi9AcVcYmtHocWlMQy4bmMJXrg6CYylFH87RGjOrwoVoFejtu/9xZkhoX5TGQEhISnrcyF10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGyNj7l3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB67DC4CEC5;
	Thu,  3 Oct 2024 21:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727992526;
	bh=xOjdTn+0KHxGvPQv4VL8wLsownOXdNAg1fw1fwx8JjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DGyNj7l3Z5piZ/alfc6qwx1jeOwz0ISpn/6LF81xH7qlgh4I3MPwSWTnt8wrM9FJs
	 jBYLccNjffKy18r4GP9nXdCrZsjTYXaD0/6U42PWQWrt8nI1hXVJZ8Uf3rsG3Y9LgX
	 HEh0gMH76Qa9ihuw0ffMoLsWYM2SD6JU5HVKPmJ37rnIk916HyOfBqM8tqO5k3qFmg
	 egLyOkVY298GGyRtTNXge4+EKMSLGLGnZEW3XKjOKKpcYT7z80mCRVmF1kP9sKrfmC
	 vMZAETHke116oUvn8SdgmLdPOvJvSrsboibyq3HQPsnGXmPJK9bBCb5vKchuVmz4Zx
	 g2sMiU5hUJPvQ==
Message-ID: <a581ba08-11c1-4d0a-aa0e-0650b698355d@kernel.org>
Date: Thu, 3 Oct 2024 23:55:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] drm/nouveau/gsp: remove extraneous ; after mutex
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240917120856.1877733-1-colin.i.king@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20240917120856.1877733-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/24 2:08 PM, Colin Ian King wrote:
> The mutex field has two following semicolons, replace this with just
> one semicolon.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to drm-misc-fixes, thanks!

> ---
>   drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> index 9e6f39912368..a2055f2a014a 100644
> --- a/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> +++ b/drivers/gpu/drm/nouveau/include/nvkm/subdev/gsp.h
> @@ -210,7 +210,7 @@ struct nvkm_gsp {
>   	} *rm;
>   
>   	struct {
> -		struct mutex mutex;;
> +		struct mutex mutex;
>   		struct idr idr;
>   	} client_id;
>   


