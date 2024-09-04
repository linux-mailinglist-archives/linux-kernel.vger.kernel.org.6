Return-Path: <linux-kernel+bounces-315405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D82596C233
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF591C221C6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F241DEFC1;
	Wed,  4 Sep 2024 15:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sg8e/hb6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B424C1DC754;
	Wed,  4 Sep 2024 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463524; cv=none; b=SgfT7iRmKScaefpOqCulygr7c0m6YekqNIGGsIJvsg+39I3FkuJdm8tD9/QfsIV+Ja/ipd2Q4YbXInUXtg5usiQOv7lCgPJZaoY+ed9NaboTl38a5jwrbznAocryAEije6yp2WKY1OaqRO7fT+lc8cT7nOS9eVK3KQeWWrwikrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463524; c=relaxed/simple;
	bh=/pUv984IhiKK7uLBabAivPDZNjvchudFRmFo5PjiLuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWI9v8BkiOKVY+lNl/2JsrmV/idsL1Eu334ZN29e7jpqCImnIrOYrjoFfQwSJNI2wB7S/aSe66jpmO+J6QCfabqlA7SE6soHi1ql+1e4FltYLf4XyNjjPDBU2kPVHpejw2Q0PvJ5XMmh2gMFROjmN7/NY5GEj7Yj3/mwDYHvcLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sg8e/hb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0628CC4CEC2;
	Wed,  4 Sep 2024 15:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725463524;
	bh=/pUv984IhiKK7uLBabAivPDZNjvchudFRmFo5PjiLuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sg8e/hb6iy2z/VNvafzN1ZuqCFUdaQh7S2oEvHERXVG+5af+3iI8mXl7+GYYBo/ns
	 JJYf6GOyd4LEVbciYC46vXhcHAu2SZXKXmRDeSUkTR/j9meNWVydm4EZnEB8hj7pYq
	 lcTUddLF5XGz+eEyGlQcncyWK+0ZI4n2QYsXW9VcECZrfydYLQDfgWEBuJTH7Q4DJ9
	 XKGUDMa56pG1n4q8SZ9dfzOQ9cUniQWT7Mt4jhIJiOB5IL/FGig3hw9sXVez5idMxT
	 OBpYKnWHgLvPcuyN40wFrnXM3z0PoTLSvT8oOzJ9F8uMccz9sKeIMkknb3p0Yxx3Uz
	 TFdN6npit2JSg==
Date: Wed, 4 Sep 2024 10:25:23 -0500
From: Rob Herring <robh@kernel.org>
To: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, knoxchiou@google.com,
	hsinyi@google.com, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: mediatek: Add MT8186 Ponyta
 Chromebook
Message-ID: <20240904152523.GA2602479-robh@kernel.org>
References: <20240904081501.2060933-1-cengjianeng@huaqin.corp-partner.google.com>
 <20240904081501.2060933-2-cengjianeng@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904081501.2060933-2-cengjianeng@huaqin.corp-partner.google.com>

On Wed, Sep 04, 2024 at 04:15:00PM +0800, Jianeng Ceng wrote:
> Add an entry for the MT8186 based Ponyta Chromebook (custom lable).

Still a typo.

Would be helpful to define what 'custom label' means here.

> 
> Signed-off-by: Jianeng Ceng <cengjianeng@huaqin.corp-partner.google.com>
> ---
> Changes in v3:
> - PATCH 1/2: Modify lable to label.
> - Link to v2:https://lore.kernel.org/all/20240903061603.3007289-1-cengjianeng@huaqin.corp-partner.google.com/
> 
> Chage since V2:
> - No change.
> 
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
> +      - description: Google Ponyta (Custom label)
> +        items:
> +          - const: google,ponyta-sku0
> +          - const: google,ponyta-sku2147483647
> +          - const: google,ponyta
> +          - const: mediatek,mt8186
> +      - description: Google Ponyta (Custom label)
> +        items:
> +          - const: google,ponyta-sku1
> +          - const: google,ponyta
> +          - const: mediatek,mt8186
>        - description: Google Rusty (Lenovo 100e Chromebook Gen 4)
>          items:
>            - const: google,steelix-sku196609
> -- 
> 2.34.1
> 

