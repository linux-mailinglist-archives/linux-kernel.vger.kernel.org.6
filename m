Return-Path: <linux-kernel+bounces-256188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B81934A69
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99CE289A1F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B9F80C13;
	Thu, 18 Jul 2024 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="NLMbc8N1"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC138061C;
	Thu, 18 Jul 2024 08:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292550; cv=none; b=ouIe5xDZ0yswvT00dZDkeqLXdquXjCfTBi/U0m8DjrSh/kLjRVV4mHnx0gshqOxzELkJZTCAgKMTexdi6J1zxjQd2bYx8L7TrHX6pdiJp0C+RbmNAsJ6AOd6iAmG1vFGHTplKN5Gtbk72OO5u0Jsnty3amdXA9C/7OXB/2zvg+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292550; c=relaxed/simple;
	bh=r1BrVyCSetRxR0OtEvnBHXoqroPyPZAvYUkmZTCmXvw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PYl8owKeGsoprlk3++rq0HGyTgGdVqEgmeBQJZl/xH0K6luU/osVaNGrFPxs6MZb+R5C5W7EDlv62Cukr5JzihVr2hSD1h+JqzC6gNRpBxhXXtNhONyKvdU3piiatAClPtEiyg5q/ZcWRBWvUIeRiu2QS+PliLZtWG7M+o4iVZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=NLMbc8N1; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1721292546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SALkvY/QibAL7upDWk5lu22M6tm/3Rix8LvRtINb1hk=;
	b=NLMbc8N1+pWcWgTzBjFB/1Goj8gSX2Quy7kTbfHEY/UMDlew7MRKpgnAox9NnyMuCX6bBJ
	CuJdLX5YBHgJzuqBmep+pLztFl/x1GSBArIEvGUZTSpUrT9bxFBAwdlU00bZZ0C34mC+Ad
	/dczLmf4anWWmLPN7qmM0rVuEjBajwnZFO5re7J5g1xD188j5cD3/XTpszjRxpFO8zUpgw
	jWttxSEYbZG3eDkfI45SyVdeOa0pq/KP9rYgjXPd7Q766EWlyOXaQYExU0phXL8A2D7njH
	24iJnetp80fk4csdZcJUpbBWB8W4zNkvJKAj8U3mk3tJe10x5DRADQDyCRheLQ==
Date: Thu, 18 Jul 2024 10:49:05 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, Kever Yang
 <kever.yang@rock-chips.com>, Collabora Kernel Mailing List
 <kernel@collabora.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: arm: rockchip: Add Firefly
 Core-PX30-JD4 on baseboard
In-Reply-To: <20240718-rockchip-px30-firefly-v3-1-3835cdd22eae@collabora.com>
References: <20240718-rockchip-px30-firefly-v3-0-3835cdd22eae@collabora.com>
 <20240718-rockchip-px30-firefly-v3-1-3835cdd22eae@collabora.com>
Message-ID: <742974effd418ca210c435b0effc99b9@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Christopher,

Thanks for the v2.

On 2024-07-18 10:40, Christopher Obbard wrote:
> Add binding for the Firefly Core-PX30-JD4 SoM when used in conjunction
> with the MB-JD4-PX30 baseboard.
> 
> Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml
> b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 1ef09fbfdfaf5..2ad835f4068e2 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -148,6 +148,12 @@ properties:
>            - const: engicam,px30-core
>            - const: rockchip,px30
> 
> +      - description: Firefly Core-PX30-JD4 on MB-JD4-PX30 baseboard
> +        items:
> +          - const: firefly,px30-jd4-core-mb
> +          - const: firefly,px30-jd4-core
> +          - const: rockchip,px30
> +
>        - description: Firefly Firefly-RK3288
>          items:
>            - enum:

