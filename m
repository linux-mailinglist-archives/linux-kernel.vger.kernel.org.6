Return-Path: <linux-kernel+bounces-288804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E1D953EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 03:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C08B1F249DA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 01:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB091EB39;
	Fri, 16 Aug 2024 01:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ip4BUHA5"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE5372;
	Fri, 16 Aug 2024 01:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772264; cv=none; b=JSY6ZZcvCMs5wlEVTQhpaY4ETR3xSdiHp85HbOg0PwUIY76n0FW/2stP9BEKTYXnTd7PxghsyH6On+TMMEeELaonm8h3KmSfqyhW+/O2mQb3Zy47zefJC17qJ+ickpO9YbyaXDSIDmtN3dvHkM9CWEYSWDhc3B3YWHvYYaPQFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772264; c=relaxed/simple;
	bh=eSEX0L/kTyNNiKf5/CN+KF3pOWq1+Ywm15UUyqxPc4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gpJW8dQruuAxIrwhzkexu+vYF2jBy8PqZY1tlQMJ+o66W6WB0frSK+KDGUWRuTRjmdR8nPddl23Q8muQUFgNh8RM/eP5ouRjEkbGXjM5eAcctkzVqPbAyGBw0bZw//wBH32TsYyXRiJYmFFBOm0PJLuAzFdyuMoMYn3U0PHKAls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ip4BUHA5; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723772254; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ODIoDXtqIR9nG/u+Ap00gMwKchJFzCxYojA3PWyNLgk=;
	b=Ip4BUHA559Cp04zlZVKMK6/PnJrXQRbGxaAucppzmwLpHEhfW+N85WqmuWMsYeY7f9MUWrUewaaZPORia+zu48pznhm4GEEPWfg+LhiOGhLRbmXDKdL8hIA1y2GQXtlJ6xtbR3CZxlUT/N3hkm511S8eXl7f7qy+lLy8/AyUf3g=
Received: from 30.97.56.60(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCyBb01_1723772252)
          by smtp.aliyun-inc.com;
          Fri, 16 Aug 2024 09:37:33 +0800
Message-ID: <75f18fcb-4058-4c93-a012-09a7a62298e3@linux.alibaba.com>
Date: Fri, 16 Aug 2024 09:37:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: sprd: sp9860g-1h10: fix
 constant-charge-voltage-max-microvolt property
To: Stanislav Jakubek <stano.jakubek@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1723716331.git.stano.jakubek@gmail.com>
 <94f68d0a2b56c8a1dcd2a2f027eb6053c91f7796.1723716331.git.stano.jakubek@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <94f68d0a2b56c8a1dcd2a2f027eb6053c91f7796.1723716331.git.stano.jakubek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/15 18:12, Stanislav Jakubek wrote:
> This property has hyphens/dashes, not underscores.
> 
> Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>

Thanks for the fixing.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   arch/arm64/boot/dts/sprd/sp9860g-1h10.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> index 095b24a31313..cd8b1069e387 100644
> --- a/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> +++ b/arch/arm64/boot/dts/sprd/sp9860g-1h10.dts
> @@ -71,7 +71,7 @@ bat: battery {
>   		compatible = "simple-battery";
>   		charge-full-design-microamp-hours = <1900000>;
>   		charge-term-current-microamp = <120000>;
> -		constant_charge_voltage_max_microvolt = <4350000>;
> +		constant-charge-voltage-max-microvolt = <4350000>;
>   		internal-resistance-micro-ohms = <250000>;
>   		ocv-capacity-celsius = <20>;
>   		ocv-capacity-table-0 = <4185000 100>, <4113000 95>, <4066000 90>,

