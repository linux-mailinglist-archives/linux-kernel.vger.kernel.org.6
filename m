Return-Path: <linux-kernel+bounces-312280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D493D96946F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 09:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48AD2B21017
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8111D54CD;
	Tue,  3 Sep 2024 06:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QE/aQmHJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50031D6182;
	Tue,  3 Sep 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725346769; cv=none; b=AFbyn2euJnSXxtjC0J066gK+MUqp65vKugEngnvG40ww1arPQPEOetLRdDpszLTY52VASu5FSexvhP7eY9fUOh653dy/0hknL+jHJfkk3n7d30E5QEpDxOVyTUKBONtHmlrvAHMbKFUO64uPZvin3uMRkRkJh6mB8tcjqjeIZls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725346769; c=relaxed/simple;
	bh=JNtXEBV6t/Ur+CoAftaJeKqF0v5X7Y8stmeb2ra32hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSFbYYAe2nQab4YcOOJr1LHbXA0liB+UF10i1C2hKaGjIscUzJqkCbrGYX1edQsx219FqjCMUGwfWUtKajHwnM8CrEYpMk/rxywA/640Hp+jCVlgR0NlmlvLuhQsHUr87iWKW2ByvCZ7punrnoZ/PT/snUgUlNWs/VoeIxW4clc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QE/aQmHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8F0C4CEC5;
	Tue,  3 Sep 2024 06:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725346769;
	bh=JNtXEBV6t/Ur+CoAftaJeKqF0v5X7Y8stmeb2ra32hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QE/aQmHJ+zVpDV5boPwwYuT63zREd59/h8vxKHTaTTq3W9Z7SLSfpkTbxUvuqXbvP
	 VJu5fLGtycdEbb90lD5X2JhzOtEfcSe1MvHL4kSd01cEw+Tq3s14zNOGPGxTT6VPvJ
	 2cAS8V9Gf/VzvVX9xBlK+dikTdTN6O7xu6RKxinEfP2jI6yc/KLDS4UdrJhbpXAby2
	 pPXwG2W/h7+k1fWMAlKxY63k38ceOknutaoNI0m+P1LeSMV3XQHKfBb1De/+v/z3rh
	 7RX/37leBziWWnY9CpkY1kmT9CaVSRBusAuDypA8aGI6CI4Zgss5Ou3S6TENeRtc1v
	 Pcb9LRjFdZZTA==
Date: Tue, 3 Sep 2024 08:59:25 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, knoxchiou@google.com, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta
 Chromebook
Message-ID: <a2jklrd7ozek6n3rhjby5pck5yho4g6ckxkii4toxf3s3k3pbi@mfvdaoz2ki6a>
References: <20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com>
 <20240903061603.3007289-2-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903061603.3007289-2-cengjianeng@huaqin.corp-partner.google.com>

On Tue, Sep 03, 2024 at 02:16:02PM +0800, Jianeng Ceng wrote:
> Add an entry for the MT8186 based Ponyta Chromebook (custom lable).
> 
> Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 1d4bb50fcd8d..410145976272 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -257,6 +257,17 @@ properties:
>            - const: google,steelix-sku393218
>            - const: google,steelix
>            - const: mediatek,mt8186
> +      - description: Google Ponyta (Custom lable)

lable? label? What is this?

> +        items:
> +          - const: google,ponyta-sku0
> +          - const: google,ponyta-sku2147483647

maxint? Really?

Best regards,
Krzysztof


