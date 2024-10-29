Return-Path: <linux-kernel+bounces-386427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920589B4354
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501132825F4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD17202F67;
	Tue, 29 Oct 2024 07:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez6nP3iq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFE718FDDF;
	Tue, 29 Oct 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730187688; cv=none; b=HFcFNj2isRqJyxAyPFjbC/tQB+D1EWIpCZcCSNYSWsG0nmRall98l2ljvs2F30QjqR4lkRdk+BQmcjNZmlor9bIogVJpIjhorRVCMogf0y+4OAlrFlLFh/3o3/yrt5CLAVjFikhPtSSiS4IceBr2Z8EW0Y3AuC3CbFhAW4dkzNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730187688; c=relaxed/simple;
	bh=dQdoHjYKix9NxkdsPSPIypxxVG1/H8SfWBxYkXryDjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTAg3qUYx96XBAPVPAbczj4jpL2WVYfIHeWkdY6SzuIQp763KDd8JLpKoP5uhV2rVDPGybVUgGS9Fcos/U0zzq8BCWUz4Ro3KggjpTIQsCBDEE/bDLoVvOPFFsqjg3//48L0p38TuZl6yWC5S948pvDraSzde5wendffWjn5z4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez6nP3iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1BAC4CECD;
	Tue, 29 Oct 2024 07:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730187687;
	bh=dQdoHjYKix9NxkdsPSPIypxxVG1/H8SfWBxYkXryDjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ez6nP3iqZQTsPf241ir7dtSE9lL1vmhYLvrdkYP+OCvwE3erGeV3qQ6ZU/zYjDd2M
	 jqN17iLPTy87YUwpgJdosY5TqlHxxXJKV8LW2+16UtkNl4p/bmMyKJxwm9ikEjH3Tu
	 U8OPnDoHEmL8bMgxAHQ+CjKd8lSFn2rSghtsEr3c51t9cNE8yllOahMCHi7UFXXFOa
	 Io0nCb9Io5dSOWYJIVX0BXDYbA9ztsmxl8OYBIOJzb2PXxO8arx9DdHWBNUVVxA8oe
	 Dv9YKpZ3XYwmLbfwXWantWblaQOZdaBaZsnTKGIJuei98V5QO29TfvHxP9SgWLyq85
	 b4Gxv3qclmd5w==
Date: Tue, 29 Oct 2024 08:41:23 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Nick Chan <towinchenmi@gmail.com>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH asahi-soc/dt 01/10] dt-bindings: arm: apple: apple,pmgr:
 Add A7-A11 compatibles
Message-ID: <wpwa22u5z5hamvme7za7dqe7kjl5bap2a254w32yyqrohz235g@hk3izcckbdqn>
References: <20241029010526.42052-1-towinchenmi@gmail.com>
 <20241029010526.42052-2-towinchenmi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241029010526.42052-2-towinchenmi@gmail.com>

On Tue, Oct 29, 2024 at 09:03:59AM +0800, Nick Chan wrote:
> The blocks found on Apple A7-A11 SoCs are compatible with the existing
> driver so add their per-SoC compatibles.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> index 673277a7a224..5001f4d5a0dc 100644
> --- a/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> +++ b/Documentation/devicetree/bindings/arm/apple/apple,pmgr.yaml
> @@ -22,6 +22,11 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - apple,s5l8960x-pmgr
> +          - apple,t7000-pmgr
> +          - apple,s8000-pmgr
> +          - apple,t8010-pmgr
> +          - apple,t8015-pmgr

Assuming you keep the existing order of entries in this file, which is
different than usually expected: alphanumeric.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


