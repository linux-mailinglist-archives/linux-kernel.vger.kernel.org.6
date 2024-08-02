Return-Path: <linux-kernel+bounces-272846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C859461C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCCB1C222E7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A41537BA;
	Fri,  2 Aug 2024 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="BZqsoHBI"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A40136353;
	Fri,  2 Aug 2024 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615511; cv=none; b=HoGJRSGAxciU1xAH64GD83a9loVLAnNb9+5oDzggtKRExJaKMNRElC7Bcl/lMX0BvEh0mmK8Lo81DSZ7dx8aZYgmQ+MO3HL9RZFgQmb8AvXc6sz9aXH7kpOww2SXcK1e/I1eaD7PMm4GABUawWCNgCSdfg9718qU539HJZDp3Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615511; c=relaxed/simple;
	bh=B6093h/f0IFgZTWz47Ax7xxeRmvkMTn6zUVT/yPQKJQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=GoMBCWT6Eh0E7PBHFeY/kVSaq6QmvnD1fvIb3b312ZeCd58q+r7Lft8ZEGfxcwTCiztZemFQT4zv3W/3KpqqbqCIgbeRCAbKuc8vTnmNvVSTxUvRbuVSPavIcbfhxWH8QsxucBP59J0NsXdwtXwE1S0JEQ9lRISJzfIJAtYOXZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=BZqsoHBI; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1722615504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwALHsOKRKAS3Q1tdMqb1vHKsQ35qPwKEHl6XuAlFNU=;
	b=BZqsoHBImBeptoUEiWjy9id6NcBboizB2l8st96pwdi7ktecNNpPc0L8UtYTKw6DXkDCbz
	15syKXtIoHJaOialwoSLCpwP5BXIva2OvVIisdynejIi2KqfIwtdNggTr7aOpczJd1BMAc
	3P31KP1MLxqhLVKTS42QnxLD+K3y+N77rTiynPSCiMAcOKU1J79gmtEu0Yz/XBQxKdeNme
	+AeT/4w/UWOoD5JpMCUVJWGQLrZk8EzADA5Pcp7IEIqGYeGAyxQJXRzX0GA6I0e8K4VLNZ
	gxSGfDB42xebeH+MO8UAcbR8piIHETIKK4UwkBwvQ+e5WNB3uTfrnoQ1VpTPwA==
Date: Fri, 02 Aug 2024 18:18:24 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, krzk+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add Cool Pi CM5
 GenBook
In-Reply-To: <20240730102433.540260-2-andyshrk@163.com>
References: <20240730102433.540260-1-andyshrk@163.com>
 <20240730102433.540260-2-andyshrk@163.com>
Message-ID: <940a46cb471e8b561c393caf2bf3453d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Andy,

On 2024-07-30 12:24, Andy Yan wrote:
> Add Cool Pi CM5 GenBook, a laptop powered by RK3588.
> 
> Cool Pi GenBook works with a carrier board connect with CM5.
> 
> Signed-off-by: Andy Yan <andyshrk@163.com>

Looking good to me, thanks for the v3.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> 
> Changes in v3:
> - Wrap commit message by a maximum 75 chars per line
> - Remove the superfluous blank line
> - Use "coolpi,pi-cm5-genbook" instead of "coolpi,genbook"
> 
> Changes in v2:
> - Descripte it as Cool Pi CM5 GenBook
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 2ad835f4068e..18ea4160e3e2 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -96,6 +96,13 @@ properties:
>            - const: coolpi,pi-cm5
>            - const: rockchip,rk3588
> 
> +      - description: Cool Pi CM5 GenBook
> +        items:
> +          - enum:
> +              - coolpi,pi-cm5-genbook
> +          - const: coolpi,pi-cm5
> +          - const: rockchip,rk3588
> +
>        - description: Cool Pi 4 Model B
>          items:
>            - const: coolpi,pi-4b

