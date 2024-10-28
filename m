Return-Path: <linux-kernel+bounces-385544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F159B3873
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07ED9283421
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D776E1DF753;
	Mon, 28 Oct 2024 17:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIfUXmIZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770E1DF729;
	Mon, 28 Oct 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730138380; cv=none; b=IlYQWyn2MPMHWqVdzhMty1dUDtcHUf3pfsI7M6Jo/fZya+j2vfX6/+PTWI7q8ZrDXCeM7OegaWqPSzcIFXi2ICOBWHaklolHykiec4yelK9rzFStheLP2S3nOwWnxB6aW7JwRHBOGDdg/AodSfrymYtcQIi8TyeTKc5ZEkBG8oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730138380; c=relaxed/simple;
	bh=NNDZK1DgsTBU9hMvDjvluvD+vh7E84vISaTdisCl6nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKtEMpJnweEcT2XO4oIJyztAeQ+VVfrXMjjVBYQokvdWqtDcUsMeJV/KICvYNjNvfCVUo2DdCxs5olz1PRLANtcLabvrWnLPuZv3A5ZLOZlsnnvOuDpykfHO5fpDcA2gz1X4Uy79dv8RI2d5FGdcUkpYU3dbZkeFsMZpFtm8W6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIfUXmIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7AAC4CEC3;
	Mon, 28 Oct 2024 17:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730138379;
	bh=NNDZK1DgsTBU9hMvDjvluvD+vh7E84vISaTdisCl6nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MIfUXmIZON3MDXg7HzGZZEbagXo3naflrdv/a5QCLfR3SAQgye1gIQfWy9rMCx/j1
	 XFa+DRZu9qPSYbHQlxL9lABTEyegZ52vV9WrRieuJll7AKnWYqu7BX12760tEAEL3a
	 WchfUDjnOHSrRA3nHelHfE+VUQDtRb8imaxPpotVX4ZSjDKNm/kCKKFhoLy1iGlOZp
	 GSHM2S5YXJPlHKcOpuEV5BkP9XugoATtLthXOqiaL5AWuusSE5PjffvlzXW2Yv+4eF
	 PMaceQ13QRslMZcipJ1R82DfuMNWL2znqPlR8vM6ZjMxAww9HZReCPPjSBnBPcVLpu
	 bHQeudYdO47jg==
Date: Mon, 28 Oct 2024 12:59:37 -0500
From: Rob Herring <robh@kernel.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] dt-bindings: cache: qcom,llcc: Fix X1E80100 reg entries
Message-ID: <20241028175937.GA1065786-robh@kernel.org>
References: <20241018-qcom-llcc-bindings-reg-ranges-fix-v1-1-88693cb7723b@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241018-qcom-llcc-bindings-reg-ranges-fix-v1-1-88693cb7723b@linaro.org>

On Fri, Oct 18, 2024 at 04:13:47PM +0300, Abel Vesa wrote:
> Document the missing Broadcast_AND region for x1e80100.
> 
> Fixes: e9ceb595c2d3 ("dt-bindings: cache: qcom,llcc: Add X1E80100 compatible")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410181235.L7MF7z48-lkp@intel.com/
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/cache/qcom,llcc.yaml       | 36 ++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)

Applied, thanks.

Rob


