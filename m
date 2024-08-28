Return-Path: <linux-kernel+bounces-304265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34236961CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 05:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC97D1F25F40
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 03:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC9013E023;
	Wed, 28 Aug 2024 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="QuD6riFS"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC244C68;
	Wed, 28 Aug 2024 03:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724815025; cv=none; b=pW+Ui37fKJnQXESQ4wx1Y4EyYM2Wl4k36UDUXmSsr1m09NtJJLjQnJOGAIzXrwD0C/66bPNdQpFB2XPmy6zGaj2pqmbw5+P47vVRph+3zdHNRK4zSQX32Tofp4HK3yxT/XDjkkiJsPkHawXT5aA8tbk5a2UgLfa4R8HoYo1aHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724815025; c=relaxed/simple;
	bh=yjruTkH+iQYNYqAu7y8WfqDV7wkGwwFHk76trAp4yG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chprmAlzqQsI6VaP23Nb4tQev9kLm0c3oSTJ1yztqAIEE7K8GIlqKPoU+olb8KIdH1EhGI3SkPT/pWprsQxr/36DuMFoQkqOP2/BCnX+RcCyKXOHbpw7pif8Fde+bLjhgoAk29SOo9Sq6wWRy3SP+8aE0J9uzLBvzaYgpd2Jkq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=QuD6riFS; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=oNzLh8Gu+ggx9rZgIUozzmmC1mDe2Hles0hNfTp2uCU=;
	b=QuD6riFSacSMvqRhS3iT3p7DJE+jzi8cwLOj096cExBifQQbLczzcwxUznha/z
	kd1oIHXqqno96gIivTA3tS7HLhQq7stSynD9ChlA2243Ik1goIrfH2U2e7sUualM
	GOpk7JO6woxVjyBwKUR+CTCR7H+NHcq00c0/WfPhXEvyA=
Received: from dragon (unknown [114.216.210.89])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD390EGlM5mz1kOAA--.25186S3;
	Wed, 28 Aug 2024 11:05:44 +0800 (CST)
Date: Wed, 28 Aug 2024 11:05:42 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Daniel Baluta <daniel.baluta@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: layerscape: remove unused num-viewport
Message-ID: <Zs6UBgR/T1raECSi@dragon>
References: <20240810061812.155376-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810061812.155376-1-animeshagarwal28@gmail.com>
X-CM-TRANSID:Mc8vCgD390EGlM5mz1kOAA--.25186S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4UCr15GFykJw1UXw43KFg_yoW3XFbE9F
	47XF1kurWkAFsrWa4ayw4fGw1vk3y7J343tFyftFn3XFyIvayvya4S9wn3JFn8Gr4IgF9r
	Z3WYqFyrJa4FkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8-_-PUUUUU==
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiAgFJZWbOiGUy-gAAsm

On Sat, Aug 10, 2024 at 11:48:06AM +0530, Animesh Agarwal wrote:
> Remove unused property num-viewport to fix dtbs warnings.
> 
> arch/arm64/boot/dts/freescale/fsl-ls1012a-frwy.dtb: pcie@3400000: Unevaluated properties are not allowed ('num-viewport' was unexpected)
>     from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> arch/arm64/boot/dts/freescale/fsl-ls1012a-oxalis.dtb: pcie@3400000: Unevaluated properties are not allowed ('num-viewport' was unexpected)
>     from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#
> 
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

Applied, thanks!


