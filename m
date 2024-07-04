Return-Path: <linux-kernel+bounces-241390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEC8927ACA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D2E1F23DC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 16:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC121B29B8;
	Thu,  4 Jul 2024 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j/sR22A3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B81AEFC1;
	Thu,  4 Jul 2024 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720108985; cv=none; b=Fs2CS3ZxbCqFXo3qJ2tMhTY/HQdvPCRdNeuLvX6zhdUnvqExH46XdguyRzHw5n4ZedAoMmFUvqugEKxqUPTnrnyzMTfmUcMThh8eNVpl77rV+03ljmj2w1qdo2JeQN1uhQLZ18QGxg2WQUhQbwNmWtpZ1HnUhYvEJDaJYWkS918=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720108985; c=relaxed/simple;
	bh=fWzclTWymnwqbl1dZdbeNzoyKUjrCfnp6EvesSA7FeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TdtmSa3euuEWHI5z5ELMH0M3bT9OYQQk4FYyB4iAEY4wXywKA3AROMI3ChB0yj6U8G7Ya3oBkSkp3eTcLjoeMQIIUvKgJDouaPlJ8T8Hj+oZ9CRjVeh3jC9XQRDH61B6tri/OUiRUC2iavzDSicZ1JfjYcM5hGZfNBSfFrEKepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j/sR22A3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFA8C3277B;
	Thu,  4 Jul 2024 16:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720108985;
	bh=fWzclTWymnwqbl1dZdbeNzoyKUjrCfnp6EvesSA7FeY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/sR22A3l1Oo1VLSCWou9JXWakcbWZu4t7QUuCAj2xjFqbSUWT7OkZngX37cnVFHk
	 /KxZ0M25wU1NMoFIqHm2B4XrIe3B8XNSz1zWr4n0XRD1mKpJAD9IGH/9JkB+zFg/GL
	 g8AkSxnCbww6zQenflNTxLQrBVljt0NMP2Lx+RoFreXFEWLfv5hHetcmeJPlSgX+FD
	 1MzWFAufcm8LnbXI+XElbJ13cGY/RWAOHGfjrXtOXgkqEmANqH8BMsLEZqIfllJe4X
	 rRxGgUsfM/JjABE0dpovKk+0Gw6UvHRzxRfsOBNsYP0La/HGOtmE+fmEufW96XBgJo
	 2rCIzHluigWfg==
Date: Thu, 4 Jul 2024 11:03:01 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] firmware: qcom: tzmem: blacklist more platforms for SHM
 Bridge
Message-ID: <jdfuvgaty44kg3xm63l765eueoy66qp7yngmf67nxqh5oifuzq@7gbzytqn5cj7>
References: <20240704-shmbridge-blacklist-v1-1-14b027b3b2dc@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704-shmbridge-blacklist-v1-1-14b027b3b2dc@linaro.org>

On Thu, Jul 04, 2024 at 02:12:46PM GMT, Dmitry Baryshkov wrote:
> The SHM bridge makes the Qualcomm RB3 and SM8150-HDK reset while probing
> the RMTFS (in qcom_scm_assign_mem()). Blacklist the SHM Bridge on
> corresponding platforms using SoC-level compat string. If later it's
> found that the bad behaviour is limited just to the particular boards
> rather than SoC, the compat strings can be adjusted.
> 
> Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> Fixes: f86c61498a57 ("firmware: qcom: tzmem: enable SHM Bridge support")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_tzmem.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/qcom_tzmem.c
> index 5d526753183d..c715729f071c 100644
> --- a/drivers/firmware/qcom/qcom_tzmem.c
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -78,6 +78,8 @@ static bool qcom_tzmem_using_shm_bridge;
>  /* List of machines that are known to not support SHM bridge correctly. */
>  static const char *const qcom_tzmem_blacklist[] = {
>  	"qcom,sc8180x",
> +	"qcom,sdm845", /* reset in rmtfs memory assignment */
> +	"qcom,sm8150", /* reset in rmtfs memory assignment */

What confidence do we have in that this list is now complete?

As Bartosz says, we booted RB3 successfully with an earlier version of
this series, what changed?

Regards,
Bjorn

>  	NULL
>  };
>  
> 
> ---
> base-commit: 82e4255305c554b0bb18b7ccf2db86041b4c8b6e
> change-id: 20240704-shmbridge-blacklist-021bd97b8a93
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

