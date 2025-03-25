Return-Path: <linux-kernel+bounces-574692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43201A6E894
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 153777A4E44
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE71A1A0BCA;
	Tue, 25 Mar 2025 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWZn8iEO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140511A0BFA;
	Tue, 25 Mar 2025 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872508; cv=none; b=nDL/tOTencGmdbiYC7crObHviqjqu3dVXLTGLndniAgO2F0ihKWGNyBUD8QwZ6LGw5DGepXzXXZTW83GxIBarkcP/ubYJUIMD2/uVxOAKa/qFMAI6Sq9/ZalpdDQFRVwZ08o7JxpN5XYhMX5jE9YneEJCs7G//e/PJlddlIgrlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872508; c=relaxed/simple;
	bh=R9Cq6L9nli8/v8y4OcDM2MkjXo9olflGKcXng00UdDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHPxxpHK4YEfBwyGpZ/IWdcQm1sPb1SJWs6sujBq/TEKLG3/aBV4VVCCGNWFn66wL55sX2G7JU35Dgb+871KKxmQa/fWjNyh9doRmFQeAwS0ar4Ni+OPppqjt3EY8N/wYWewG3xTCn/BS39G5M1MJ6QNtQft/B94wuro7oCFV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWZn8iEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58865C4CEDD;
	Tue, 25 Mar 2025 03:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742872507;
	bh=R9Cq6L9nli8/v8y4OcDM2MkjXo9olflGKcXng00UdDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZWZn8iEORv6wxKRTmxPc+lehzSH5UROjTJgOwwvgkMDl/d9j5H0WbVyA8R/VHC2rg
	 1wq0/SE1HqAIG1pakgI7Le73oLt5g/mtLwoMsp3cXYOCEuaRxAGk1dqaNbhgrwg18m
	 23KwsZ/DAzcI/VXUPqSH1TcL85EAkPwA11niMt+TGMT9nd7Ied6DT6HitdZKCftHoY
	 Ci2fqsKn86wuifWorGycSFt5V9qmYF/xIYr1jNcD3M1xt4z4ETYhCvR7tTq6oNsLsQ
	 eWdCPZkDShhN8rMQjKUBaBXZg5g9Sm6SRrfi6MeCCMkz/UjrK1qin5haK6MLsFnUuV
	 1MRYiEvna2UYA==
Date: Mon, 24 Mar 2025 22:15:06 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] dt-bindings: pps: gpio: Correct indentation and style in
 DTS example
Message-ID: <174287250441.1621204.10637407827351914733.robh@kernel.org>
References: <20250324125122.81810-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324125122.81810-1-krzysztof.kozlowski@linaro.org>


On Mon, 24 Mar 2025 13:51:22 +0100, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces and
> aligned with opening '- |', so correct any differences like 3-spaces or
> mixtures 2- and 4-spaces in one binding.
> 
> No functional changes here, but saves some comments during reviews of
> new patches built on existing code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pps/pps-gpio.yaml     | 20 +++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 

Applied, thanks!


