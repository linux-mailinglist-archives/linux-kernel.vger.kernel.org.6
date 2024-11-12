Return-Path: <linux-kernel+bounces-406195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282949C6037
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC5DB3483F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCB9C20124E;
	Tue, 12 Nov 2024 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPrgmNK1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D48220102D;
	Tue, 12 Nov 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731425704; cv=none; b=rvm7I8+lXmz8di131aIsEGpp3dDNebU7aVtruPefbnVHLEAlpaYLaieN8sOi3sqYeBjkwwzqsxgtpTsby99MHBD2a6T6O8A/PZa8Tx6P6fYOoVXzBvDktUpTNQFIe9rEkqN2G5WuvlF6Qv4v1fS7/feKWPoTUHfujjQgObIL4LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731425704; c=relaxed/simple;
	bh=mdCG+kWQHDbH45+i7pZkYDklgUWwXzoUXEe4UbhQaWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDRMvNtSNUM0uHKBvsnvOf18QfsLs5MbmEyS1Wp7Uljb1WJHVMLdXTgaJ9p1I0Ov1k/6AjHr7RjCXQLX+hnGocNZgYW/sn9o0Chhh1woIEpjEzVob/z7S31eeP+1MHLE7bILo/icIX22wJu+JMfKqamNQhXpUCDpLOmXE96y/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPrgmNK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852AFC4CECD;
	Tue, 12 Nov 2024 15:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731425703;
	bh=mdCG+kWQHDbH45+i7pZkYDklgUWwXzoUXEe4UbhQaWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPrgmNK1XnLgm/dFEGwMCptFUHd3DHoAMXY/0aFMdiRaN20DXGoD9b7uKZHPXYu37
	 uyi47esmgWUrd6L9vCcOKWQubpHRNi65BzytJ7JJncDxewmvTwisJ+28XIHt5Xgoz2
	 BQOKNAqQW1rI4ob5Jn4j8VBOZ2jkz8WtYcnNWv5mEYqxPBu7TvV9LBSssrANWMB1lO
	 1TAMkboXEeggb68ZELwjnzL4zI0DOYjHjKCfKncea1hrj3UMolFNdJDQIQSh9YCTcn
	 pliCwUAh27Ce1yc4c20X/iuJMX7hIheXyjKTxum0FUMQUUSnWUByd0zGDkIj8B1VMH
	 jm/gs9hpFOCCA==
Date: Tue, 12 Nov 2024 09:35:01 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wasim Nazir <quic_wasimn@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/5] dt-bindings: arm: qcom,ids: add SoC ID for QCS9075
Message-ID: <173142570122.950070.9518403480763071261.robh@kernel.org>
References: <20241110145339.3635437-1-quic_wasimn@quicinc.com>
 <20241110145339.3635437-2-quic_wasimn@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110145339.3635437-2-quic_wasimn@quicinc.com>


On Sun, 10 Nov 2024 20:23:35 +0530, Wasim Nazir wrote:
> Add the unique ID for Qualcomm QCS9075 SoC.
> This value is used to differentiate the SoC across qcom targets.
> 
> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
> ---
>  include/dt-bindings/arm/qcom,ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


