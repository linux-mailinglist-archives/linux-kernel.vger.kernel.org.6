Return-Path: <linux-kernel+bounces-369447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B514A9A1D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 10:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBE51F265E1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 08:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A40E1D47CD;
	Thu, 17 Oct 2024 08:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhBaV9wI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48DE762EB;
	Thu, 17 Oct 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729154500; cv=none; b=Ie1N0ePXxhjNgWh0CKK2sgx76PMHjvEIzeFMsnr9u+eOpA23+R5W5Krft91ynhxrgjlAIX+Hrxz8vO8o6Xi47ELWt8ovwAVb27wh6HxxMQcjkJeLv127yloOV452CytqMZZZ+F8NZNjl6sHNbMO3ykX/jXN6cAgg38NamaZnudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729154500; c=relaxed/simple;
	bh=g9/kv6xeSFqE/QALNRxFzM2VSP+FUQgOMKtpGcah6io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2yjSh22n2wMlqbzwsYfUJmlLYelcmOc26AeCTz4SAlmBnZTcBzK8Gg6mkyWaeXR6xJHY6E5H9NTd2P2PMvaYvd9CsTtRa4+7tb96YlTN/4Vv+xnitcdIZH2phDkMzh1iFnDHMLg3FiiHM+ZavBI4+Wfwk+85eGxmj0mawODipU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhBaV9wI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D467C4CEC3;
	Thu, 17 Oct 2024 08:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729154500;
	bh=g9/kv6xeSFqE/QALNRxFzM2VSP+FUQgOMKtpGcah6io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MhBaV9wIqw+/LeE+MLM+heBXrKrZh7jVpOdo8AeG+R9edbMpDEye/y9EYh6pKm6/S
	 BnDJqV4N7CeYlOYSsv77hBcovT+XEQoh+TjvuttKHJ6N9wtRgrrqeFB+TEypDvIy53
	 ALNzSX+kqxe4/m4/+J7D8p1NNtjLmCRC3/d2XkCaGxGsc0bhGGpRzW5XuejOUHre8B
	 8yfp2ThJWCIkOODCbxgYAQF1gk2fDnawgCdrIe0oOxHm0LB2tdS13hzcNnHHKW3cYX
	 FQ3QS1WaRa0TidOdAo8c2g9dqsNZiMQrULFmHHKtilxo7mA2Z9exXFt5rkzW01xlRL
	 NoNtutezTmQRw==
Date: Thu, 17 Oct 2024 10:41:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kyle Deng <quic_chunkaid@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com, 
	quic_aiquny@quicinc.com, quic_sudeepgo@quicinc.com, quic_taozhan@quicinc.com, 
	quic_jiegan@quicinc.com
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: qcom,apcs-kpss-global:
 Document the qcs615 APSS
Message-ID: <al3lgna6k5f2y2hzbbe4q2upamfqi55csn4vaj23nls6vtgjtz@zt2w7dlwmvjd>
References: <20241017025313.2028120-1-quic_chunkaid@quicinc.com>
 <20241017025313.2028120-2-quic_chunkaid@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017025313.2028120-2-quic_chunkaid@quicinc.com>

On Thu, Oct 17, 2024 at 10:53:11AM +0800, Kyle Deng wrote:
> Add compatible for the Qualcomm qcs615 mailbox block.
> QCS615 mailbox is compatible with SDM845 use fallback for it.
> 
> Signed-off-by: Kyle Deng <quic_chunkaid@quicinc.com>
> ---
>  .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

allOf section is not really up2date, but that is existing issue I think.
Assuming you do not have any clocks.

I'll fix existing code so this is:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


