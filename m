Return-Path: <linux-kernel+bounces-533279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06466A457BB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F341887DBD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC78915B980;
	Wed, 26 Feb 2025 08:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FurhBs1L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3160C258CC5;
	Wed, 26 Feb 2025 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740557435; cv=none; b=RUauzrrHP2+B3/mM6ILCvZ/Fjm/j/XhJuoR6a+7KPV1jy2hasLzLvhPU6YeNrPjXGRqYiGC5o1UiNlvFb9sOgIU2U+ZxEtgawq9aF/+MMdub/vM9nkjrvUnuXaeowAsd4Rh8Ko1ZNotXPKvULrZigaVzRDpoL0laIqPsO+h0AlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740557435; c=relaxed/simple;
	bh=mRXVHLt3+c/dkoVlxybfaQwBghVyFhCODfcq5NHOb3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kM58BE3YtHluFoROLW/eZJRBwOOutiv9fstZvjNx9KW7vrUTnJH2IoItrXjcFnZ4J6uxaO/c6h+eQTIbwoVGuF09dW4kEgHWmZXCEpd2GtF6xbwpf5m7faO4vHBihao8c5w6VbqJP/ZxGBMTUNMX87KOsp4Y4gllan7SEhiq0HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FurhBs1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3515DC4CED6;
	Wed, 26 Feb 2025 08:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740557434;
	bh=mRXVHLt3+c/dkoVlxybfaQwBghVyFhCODfcq5NHOb3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FurhBs1LqpiZWB9pGkqCAPNiKL9fTSFwqXH7WvYgcCdD0lw8XM2ldaMb9jcRZ8ceE
	 lFzkh2k2+GhU+jUuJEt1IUcu5RokOOOA1miQCJkG19puSpERCEVNetsdWGqWbkeRpr
	 bXKokqFNcaoayOo8e6b6aHrIBhi0gzLzlCxVHFQ3zoPL3xu8s+MWsngdoEckXCrvO6
	 QdY7Z0Qxhp4obkncsZdm2PhDfxCR8ZRIQuQfBKrQqLNFBX1UnmSqj/XwD8yPMDIe3G
	 6LATjGPCz2WeJonvlnN3GM5dDFfGacFjHTV5xrwmKd8NoYmSI/N1zIiW4XDEcDJxc1
	 ghen7o8Zoih3g==
Date: Wed, 26 Feb 2025 09:10:31 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: extcon: Document Maxim MAX14526 MUIC
Message-ID: <20250226-free-mayfly-of-perfection-c4632f@krzk-bin>
References: <20250225090014.59067-1-clamor95@gmail.com>
 <20250225090014.59067-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225090014.59067-2-clamor95@gmail.com>

On Tue, Feb 25, 2025 at 11:00:13AM +0200, Svyatoslav Ryhel wrote:
> Add bindings for Maxim MAX14526 MicroUSB Integrated Circuit.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  .../bindings/extcon/maxim,max14526.yaml       | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max14526.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


