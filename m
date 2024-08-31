Return-Path: <linux-kernel+bounces-309839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC60A9670F4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55070B221C6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6101917C222;
	Sat, 31 Aug 2024 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iWSOQxHJ"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171DC1BDDB
	for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2024 10:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725101341; cv=none; b=MlCJ1+RYwNYryGs+i2XNOgYI4/Rr3BO5NAjSIoVcitW8eTa8FXUrAVEvzpmd1LFKacO4CfWzIUMJ5RcSEmbP1kfNW6gli+DbEjujuxMMyFz6b2ekIOyEgHwhvQrRg9ikAwXlvvwu7dJYUHmbsf3AUyOKvLSrVqVgG9qFwMsju6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725101341; c=relaxed/simple;
	bh=kXD1W98erynzmVVn9auXPsEFqW3820MtCLgbm09vh08=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oDwkWXY9lZ7+9egaY1uuywvD9OOh/Z+yP9blV5TWtHTFrZcuCowR+7zQkoD0KyWai+zLJmMKz+cmam49Ev8nqSKIaGhZh16JEJeB/O5BnACsg10Aa/RXHG8LUt8y+HMokPPlJGGOgiTgR9Zv3SxqB/VcEr2KJu8Zsd100RRsS7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iWSOQxHJ; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id kLewsd95c6mdlkLews593w; Sat, 31 Aug 2024 12:48:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1725101330;
	bh=jWhl45GhCInF4jIxORGfZyY2AMGshnhXMxuMEz4hBUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=iWSOQxHJoDSMbOQzbXx6fpKqvOzFo6iD/jctkMfqp68dsOu1gg3To2GoWL3P/GyGq
	 wwlJjHCPf5qLNRlmVunnvjtHHkg43rmVJuc03g7KGqW1u998TRKAXrW+L0JdnuI8qC
	 0f1xr8MEG1ILdl2FPjrmSsnVXkDEbv4uCEupgRqNPwkWn6s2WfQqg3J1O3qVycsVQN
	 CyWWt2x5cBrDGT1Xik0t+HeBZ/8/W3WqXtRhDb2+2JuaUx090szYr6gTRv4jCdHX4x
	 EoILVoQ1Sgm4BcJdlBj7zGLQYRMp1cnba4ESwccdMOXIxRTDTHDVG7l+b0KdPT5W4Q
	 7BLzdhvpflg5w==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 31 Aug 2024 12:48:50 +0200
X-ME-IP: 90.11.132.44
Message-ID: <74dfe952-2055-4152-90c6-ac9cc42fcad9@wanadoo.fr>
Date: Sat, 31 Aug 2024 12:48:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] drm/imagination: Use memdup_user() helper
To: Jinjie Ruan <ruanjinjie@huawei.com>, frank.binns@imgtec.com,
 matt.coster@imgtec.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240831103047.99499-1-ruanjinjie@huawei.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240831103047.99499-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 31/08/2024 à 12:30, Jinjie Ruan a écrit :
> Switching to memdup_user(), which combines kmalloc() and copy_from_user(),
> and it can simplfy code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>   drivers/gpu/drm/imagination/pvr_context.c | 22 +++++++---------------
>   1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/imagination/pvr_context.c b/drivers/gpu/drm/imagination/pvr_context.c
> index eded5e955cc0..e75fd50a4d9f 100644
> --- a/drivers/gpu/drm/imagination/pvr_context.c
> +++ b/drivers/gpu/drm/imagination/pvr_context.c
> @@ -69,27 +69,19 @@ process_static_context_state(struct pvr_device *pvr_dev, const struct pvr_stream
>   	void *stream;
>   	int err;
>   
> -	stream = kzalloc(stream_size, GFP_KERNEL);
> -	if (!stream)
> -		return -ENOMEM;
> -
> -	if (copy_from_user(stream, u64_to_user_ptr(stream_user_ptr), stream_size)) {
> -		err = -EFAULT;
> -		goto err_free;
> -	}
> +	stream = memdup_user(u64_to_user_ptr(stream_user_ptr), stream_size);
> +	if (IS_ERR(stream))
> +		return PTR_ERR(stream);
>   
>   	err = pvr_stream_process(pvr_dev, cmd_defs, stream, stream_size, dest);
> -	if (err)
> -		goto err_free;
> +	if (err) {
> +		kfree(stream);
> +		return err;
> +	}
>   
>   	kfree(stream);
>   
>   	return 0;
> -
> -err_free:
> -	kfree(stream);
> -
> -	return err;
>   }

It could also be:
  	err = pvr_stream_process(...);

  	kfree(stream);

  	return err;

as you did for drivers/gpu/drm/imagination/pvr_job.c.

CJ

>   
>   static int init_render_fw_objs(struct pvr_context *ctx,


