Return-Path: <linux-kernel+bounces-514605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8992FA3593A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE8D3AE280
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 08:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401A3227EB7;
	Fri, 14 Feb 2025 08:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSTVaqbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91730227BA6;
	Fri, 14 Feb 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739522659; cv=none; b=JY2a264IQ7heaWdD2mJNZPTd1A//7EmcBSn8K98kf8fUt2ldd/zArRjnWMdq4dXth7IV2HuJPuQkh335o8k0eMp9R95RAb4ZQsWKclyhmDjX1/Ok5j7XC/OIeRulx03AM/eFrq2Bd0cJlVe2rUdip3n4HXCQrTWLjeM8DSaiffA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739522659; c=relaxed/simple;
	bh=7gfINN8kDkIR+LxuMwzS9gewbf4Nld53s1tPLRkZoJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JY71syzfubPkIRo+dKNXK5XlIKXAEYCM+yQtiYUQB4AJLXO8fGhXM1MuWWU4754PsQZBsaqfsDNH+kYPL+A+7ebMcEYS74E378JnHTmGbxOpyiPQbCKXWsh6tdnIQ347ImwO9KpuV1O8mAl9nxipKp2iB5b+JGJFmdlZ0Vo94lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSTVaqbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8275DC4CEDF;
	Fri, 14 Feb 2025 08:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739522658;
	bh=7gfINN8kDkIR+LxuMwzS9gewbf4Nld53s1tPLRkZoJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NSTVaqbc5lt2H1/bowO2xwmlWhFxCfE45GZ6Y8bacWj54C9g82zAePQnR6IkOrav6
	 tC0MmY10hqfbRVXlkuXnQfNMFN+zU3QxNdbWgGdjTxgAY7XqP/OQYB4xhDxiG/1xAL
	 PZNHL6JK67YELMSepVp4N95IXTAXNBihwgzNw6erBvgwIRzRkE5FgYnMQazs9TDM3S
	 TwJ2eHryA790+QNub9x/1JXT6fngKtvxxC7ScHSldsQQfz1rrlcdxIxxvlbLY05MuF
	 UT55S8XpstGt8q7t3/D0rcFwC1zzUU3c4pkjlRrkNEiVQJxXnvvMM7OhdCKkFkWr9n
	 2e3qTY9aL98oA==
Date: Fri, 14 Feb 2025 09:44:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: crypto: qcom-qce: Document the X1E80100
 crypto engine
Message-ID: <20250214-nocturnal-rough-finch-8002a0@krzk-bin>
References: <20250213-dt-bindings-qcom-qce-x1e80100-v1-1-d17ef73a1c12@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250213-dt-bindings-qcom-qce-x1e80100-v1-1-d17ef73a1c12@linaro.org>

On Thu, Feb 13, 2025 at 02:37:05PM +0200, Abel Vesa wrote:
> Document the crypto engine on the X1E80100 Platform.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


