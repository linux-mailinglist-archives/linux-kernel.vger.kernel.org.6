Return-Path: <linux-kernel+bounces-335268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B297E347
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 22:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912471C20B41
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 20:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145B5B5D6;
	Sun, 22 Sep 2024 20:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTwVt5JH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EB32AEFC;
	Sun, 22 Sep 2024 20:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727037691; cv=none; b=F54Cj6wPw2eSlgVgEBFJfcLVNCgRsTTMaOJgZ/XsLweET6oAmIP6wuLCvYNPRMvgE4zfS/d58JKM9sxG5SRH2OOHUVaVBxXu2m5/iyAZo6fZGJSn8Vas00zJCMBe82+//4tTrprk/wE8X75oaEMu8jZQY9n8qGxbPCMgiPzThDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727037691; c=relaxed/simple;
	bh=TkUxFG1M5+wekJl8pvU0XXiK2GmJAhCAiAC/2sJes8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fb+nKqR0JkinXXY0cZD/RDC1Bm9pnpsBbt7zCqg2zDC6QJGPmugxR2KpWjx0W2ae7rE1L/xU9yusPKPo1N2apG8zUBnn7N6zUnnm2VWPbCYwZVekisoMquGe1GQYPS4/TzX+PaTT1yQV4bKar+owVoeAy4Idhn9iiaXaux8Prx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTwVt5JH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F386BC4CEC3;
	Sun, 22 Sep 2024 20:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727037690;
	bh=TkUxFG1M5+wekJl8pvU0XXiK2GmJAhCAiAC/2sJes8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RTwVt5JHcfQMMSdTaK+TixFFSGAjfPL9P4RFz8+A22jlWfEQEViYyGVIiSiC0wYzI
	 r8nXv2x5f0QE8EjULVjwEnhzcQA9TzlxmoU8k/yueofUs+8Gpb/sJpWbwiD+XcKxzM
	 1dERKmfs+MMT7ZQQ0D5FPU+3ULnQIyAH107Oaz4uw029s6JM2nTwXNoT06/iJ8264Q
	 0PbNWZgHygVmx7xdeixS8JAla8eY8nHq5va9s65gn4qH9hDXsRWIQrAifj6nXQduPJ
	 iZGWAUBMycMZgStv+R4ePcjTgIJex9np1H8zSTTBS8VUxVipIdeoNJjDl5K4795qud
	 7HIvnXhCsNTyg==
Date: Sun, 22 Sep 2024 22:41:27 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Liu Ying <victor.liu@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] dt-bindings: reset: add schema for imx8ulp SIM
 reset
Message-ID: <axvgokxy2cq2hgi4nkiosbrhvxmmy7wvebm37ryl42r6lkkk42@vtuhb2nt5en7>
References: <20240922174225.75948-1-laurentiumihalcea111@gmail.com>
 <20240922174225.75948-2-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240922174225.75948-2-laurentiumihalcea111@gmail.com>

On Sun, Sep 22, 2024 at 01:42:23PM -0400, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> 
> Add schema for imx8ulp's SIM reset controller.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> ---
>  .../reset/nxp,imx8ulp-avd-sim-reset.yaml      | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/nxp,imx8ulp-avd-sim-reset.yaml

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


