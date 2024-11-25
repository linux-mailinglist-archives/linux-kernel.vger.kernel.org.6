Return-Path: <linux-kernel+bounces-421483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2249D8BDD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4671615CC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 18:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D561B6CFB;
	Mon, 25 Nov 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b="CGh1kUmZ"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A6C17548
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 18:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732557794; cv=none; b=Bi79FgytcB4DsXESs+GmzYzweKiDrZlY3za3yR1VgIrhGjx1W4Kqn2yAlNA/PR5vUbiOAFL51CrvX9tuB1G449J2fX7ot2vomQKKM3YBTNsV4sW79eaxASbLaRe/hZse58xsDVI9RPi22H05gyfkgM/lHZgRhGzxCSav1o1fQow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732557794; c=relaxed/simple;
	bh=IGJPop+ydU5HQOi9ZgsxuYCWVsHxlvcHzgc5aBrlwzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k2AlAe+yEocZKTsRwkse9q2CM7YO4hcQPCrScWb84c3hSf4Zg+9EluCx+4L5Ajyd3/zpJKQNpzpcewjA9Gta/Io97V/FeCCmK8rgKZaS7x36kx/7otDJGaU3LbByI4dVZSEoNZFHw22muAEGgWUqByIlsLKm35kFjMIZx3uPhys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com; spf=pass smtp.mailfrom=linumiz.com; dkim=pass (2048-bit key) header.d=linumiz.com header.i=@linumiz.com header.b=CGh1kUmZ; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linumiz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linumiz.com
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
	by cmsmtp with ESMTPS
	id Fa8etnbvmnNFGFdQQt17Gt; Mon, 25 Nov 2024 18:03:06 +0000
Received: from md-in-79.webhostbox.net ([43.225.55.182])
	by cmsmtp with ESMTPS
	id FdQNtcuU3cEKuFdQOtNGgC; Mon, 25 Nov 2024 18:03:05 +0000
X-Authority-Analysis: v=2.4 cv=Z7YnH2RA c=1 sm=1 tr=0 ts=6744bbd9
 a=LfuyaZh/8e9VOkaVZk0aRw==:117 a=kofhyyBXuK/oEhdxNjf66Q==:17
 a=IkcTkHD0fZMA:10 a=VlfZXiiP6vEA:10 a=-pn6D5nKLtMA:10 a=VwQbUJbxAAAA:8
 a=r_1tXGB3AAAA:8 a=nPvSCjySrd4d4ErWsagA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22 a=ZCPYImcxYIQFgLOT52_G:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bCm9UlTWdb2qxa5v8L9Bnq+ht/sjL8QD4mAYIorGyD8=; b=CGh1kUmZpUQbUji4nDSybieovg
	o4XMODgtlsf2z8f8vlURoA5TVD4//npaijouwsq5Jjnj1VX8S1fyttt0d1filEqhpaLM/YevPUV4Z
	PGKFgWlDBlU0PfaXLmHAcS/bw7P4KBF4uj/NHggAmR8fHddHqMHFwlAPyXxLpjog/8tM3ykHJ6peV
	t526+K77tY9SEiPoPIsORnDN89pKx6hBJtLZEIBKuhrZmNLrh1W+kuwxRbSD84KWc85kfqm/VpVhy
	ykfUG1DIy3Gk3aNRk66c8Dep/M9ru0cIA2nqlgS2NDsxLCKfVXEiWpttjaSKcbnzxSUfk86q17Grv
	rAL0s7SA==;
Received: from [122.165.245.213] (port=55390 helo=[192.168.1.5])
	by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <parthiban@linumiz.com>)
	id 1tFdQG-002YwW-2Y;
	Mon, 25 Nov 2024 23:32:56 +0530
Message-ID: <e9cbcc6f-67f5-43ac-a1ab-4222305087c3@linumiz.com>
Date: Mon, 25 Nov 2024 23:32:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/21] dt-bindings: gpu: img: Further constrain clocks
To: Matt Coster <matt.coster@imgtec.com>, Frank Binns
 <frank.binns@imgtec.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Randolph Sapp <rs@ti.com>, Darren Etheridge <detheridge@ti.com>,
 parthiban@linumiz.com
References: <20241118-sets-bxs-4-64-patch-v1-v2-0-3fd45d9fb0cf@imgtec.com>
 <20241118-sets-bxs-4-64-patch-v1-v2-2-3fd45d9fb0cf@imgtec.com>
Content-Language: en-US
From: Parthiban <parthiban@linumiz.com>
Organization: Linumiz
In-Reply-To: <20241118-sets-bxs-4-64-patch-v1-v2-2-3fd45d9fb0cf@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 122.165.245.213
X-Source-L: No
X-Exim-ID: 1tFdQG-002YwW-2Y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.5]) [122.165.245.213]:55390
X-Source-Auth: parthiban@linumiz.com
X-Email-Count: 4
X-Org: HG=dishared_whb_net_legacy;ORG=directi;
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfEsFRo2IBo0uAQUlbN+Cyk5K5Nxy4aOZAhUWdNdctBM7sruKcgWpqLj6IGCQbxxE9lz2hJeMHiYtmMA3melnjMe4+pieAle0IoBU1Mr6J0vWE0mCq7Tm
 8iqTY3qAaOJxCIWV8nb1RgjMN2APCngcArUcWp+gzlgcrVlWBQsfZZpszBnkNzdemyEd9toPnP8TujXusUTyLlg6APDNbTdYj3c=

On 11/18/24 6:31 PM, Matt Coster wrote:
> All Imagination GPUs use three clocks: core, mem and sys. All reasonably
> modern Imagination GPUs also support a single-clock mode where the SoC
> only hooks up core and the other two are derived internally. On GPUs which
> support this mode, it is the default and most commonly used integration.
> 
> Codify this "1 or 3" constraint in our bindings and hang the specifics off
> the vendor compatible string to mirror the integration-time choice.
> 
> Signed-off-by: Matt Coster <matt.coster@imgtec.com>
> ---
> Changes in v2:
> - Simplified clocks constraints (P2)
> - Link to v1: https://lore.kernel.org/r/20241105-sets-bxs-4-64-patch-v1-v1-2-4ed30e865892@imgtec.com
> ---
>  .../devicetree/bindings/gpu/img,powervr-rogue.yaml   | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> index ef7070daf213277d0190fe319e202fdc597337d4..3b5a5b966585ac29ad104c7aef19881eca73ce80 100644
> --- a/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> +++ b/Documentation/devicetree/bindings/gpu/img,powervr-rogue.yaml
> @@ -29,16 +29,16 @@ properties:
>    reg:
>      maxItems: 1
>  
> -  clocks:
> -    minItems: 1
> -    maxItems: 3
> +  clocks: true
>  
>    clock-names:
> -    items:
> -      - const: core
> -      - const: mem
> -      - const: sys
> -    minItems: 1
> +    oneOf:
> +      - items:
> +          - const: core
> +      - items:
> +          - const: core
> +          - const: mem
> +          - const: sys
Clock for GE8300 in Allwinner A133 is organized with core, bus and additional pll as
input. Where "bus" controlled as gate clock and optionally using pll.

If am not wrong, GE8300 also comes under rogue architecture without mem and sys clocks.
Does this needs to be considered into separate bindings?

Thanks,
Parthiban

>  
>    interrupts:
>      maxItems: 1
> @@ -56,11 +56,13 @@ required:
>  additionalProperties: false
>  
>  allOf:
> +  # Vendor integrations using a single clock domain
>    - if:
>        properties:
>          compatible:
>            contains:
> -            const: ti,am62-gpu
> +            anyOf:
> +              - const: ti,am62-gpu
>      then:
>        properties:
>          clocks:
> 


