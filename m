Return-Path: <linux-kernel+bounces-304493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EA89620E9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EAF01C230EB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F8158D80;
	Wed, 28 Aug 2024 07:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJij+tqB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C26186A;
	Wed, 28 Aug 2024 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829832; cv=none; b=cO4i2hepa7CP8Mua1NkpHhe4qYG6/a0M7oNKQQHbW04Q24F5X+YmjbWPhEl81RTpSFozQbhN+s8p/E6aP4EEzxRONFMzmf03d7x5qI7dw1/B4FeWes11uqyEF4bkR/XrZ8+pl8gJgHULVsMTbi8fpDlPKfvwww9GBrS+njvxfVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829832; c=relaxed/simple;
	bh=UCr7MKnIOJmJtvkDJNzTvQRh6YGkN3zTzZM1N9T9eCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SmQzrnY+7bov5h+7Veyexf09kkeCgft/nlZrlqKcPEjWPtbIw6kApgUev4asOmkDGz6l9JIAlx6GxH6i1ugqHRQzBpHMAlfQuGQ78dZKIIJeI+zPZVmt4L2DJnBVOZJxF4pLBLc3rgEoJ8LkRH8oQZRGLSfH7+pUxeWQznnGtRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJij+tqB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A86BC4AF15;
	Wed, 28 Aug 2024 07:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724829832;
	bh=UCr7MKnIOJmJtvkDJNzTvQRh6YGkN3zTzZM1N9T9eCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iJij+tqBDLsfH/OgPswXXdqYHtqBCa+nzw5Y7Zgn/ylGxFM+qVZpnGRb4ONpEslMG
	 750DDGwgVVgGbaFKLrqI0c0wXw588f178jOlnW2aoYjoUHoxka4H1GjmXmdrVifPR7
	 sp9HxdHox3rwycHf1wX615rh3ySZROP0kJX/Y9rCrrWe8JFy8RwRuPeIb5yauqCxu0
	 5LEhX9h8fwxEd2nYcTkfOsZCXFQIVJol8vgPzRNTCoj95GZY3drMYsh5PDe2JGpKx7
	 /fJ1+bjJg3BKndwHeZzc/Po5cYqMttmxuxFSvCbq+ANe2NyaVirPWKwPOWWmtzhBKK
	 zf5vt1W0O4IFA==
Date: Wed, 28 Aug 2024 09:23:47 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jingyi Wang <quic_jingyw@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org, andersson@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mathieu.poirier@linaro.org, bartosz.golaszewski@linaro.or, quic_tingweiz@quicinc.com, 
	quic_aiquny@quicinc.com, quic_tengfan@quicinc.com, Xin Liu <quic_liuxin@quicinc.com>
Subject: Re: [PATCH 2/2] remoteproc: qcom: pas: Add QCS8300 remoteproc support
Message-ID: <t4mggn4xnzara7vaaybcknmpn527lbsjczcldce7rwhhvucmnk@22bwbuaflqw2>
References: <20240828030511.443605-1-quic_jingyw@quicinc.com>
 <20240828030511.443605-3-quic_jingyw@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828030511.443605-3-quic_jingyw@quicinc.com>

On Wed, Aug 28, 2024 at 11:05:11AM +0800, Jingyi Wang wrote:
> Add support for PIL loading on ADSP, CDSP and GPDSP on QCS8300
> platform.
> 
> Co-developed-by: Xin Liu <quic_liuxin@quicinc.com>
> Signed-off-by: Xin Liu <quic_liuxin@quicinc.com>
> Signed-off-by: Jingyi Wang <quic_jingyw@quicinc.com>
> ---
>  drivers/remoteproc/qcom_q6v5_pas.c | 55 ++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index ef82835e98a4..368aa9cc0051 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -857,6 +857,58 @@ static const struct adsp_data sdm845_adsp_resource_init = {
>  	.ssctl_id = 0x14,
>  };
>  
> +static const struct adsp_data qcs8300_adsp_resource = {
> +	.crash_reason_smem = 423,
> +	.firmware_name = "adsp.mdt",

Why this is mdt, not mbn?

Sorry, it is again some old driver :(

Best regards,
Krzysztof


