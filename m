Return-Path: <linux-kernel+bounces-525371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D8A3EF2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6A8D702CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E193020127D;
	Fri, 21 Feb 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELrQVGRU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B84720124E;
	Fri, 21 Feb 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127899; cv=none; b=PUbCSpHdBWMmt+f53Lw645wLby6zukLgMUJikIOei9kBGc+G/l9V+sYDdp/7VjvZD89HMqJSTa8SaCgIpscnqvY4dm2prPu7ZjX/YfR58yWUbcg+UozLtQxeSRCDyQKTiVYZTgMd1+hw8fN5/c/dYsHTvXJy6b2A4/cfBaaHZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127899; c=relaxed/simple;
	bh=HRPaOfyt1hWwbxmZ/KhgRgx6as51nZnrdfLsa1K/2f4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZjhOI/WeTp/z3qGBc04I42L0I615tnpaR2Xy6gj7yZeGoMYTHE0tX/tXqtvYCDA5aDEGkWCz8F3Ce7kS0vuj5JmkKfRA1cUYivlRMKITyXXlS/LSu9Ss6HIwMnLOriX0laogVm7MvfRtgFcJwyU0WsAFCnsYuU+8So4OEjcA5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELrQVGRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02025C4CED6;
	Fri, 21 Feb 2025 08:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740127898;
	bh=HRPaOfyt1hWwbxmZ/KhgRgx6as51nZnrdfLsa1K/2f4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELrQVGRUnBceU/QKxQX4FRiuvV3EnBTn4zEKg8qPJvvGWg1FuEUcuCRD7eUl8prnP
	 hiVoltNSf7NyGoSd6yX34swKlj9vHJZZ/JZ8z+rxW9BACPWtvfgxu8C9QUuConnmnM
	 7dYXfpV2tasqDl3JWmt1rs3FyK6FMANuWbwDcHcYo3ZI5FOMPJTtH3jpzIy/xScXZc
	 yPH5srNXLrGQhRb4BwPsgdPenqvwhuPErO0L0tNNTZaP9qncZlMkswPBGSRpujJALV
	 SOFheJbfbc9ncHO6U91igI4u7AT80lGN+r2Fb/iZOBDoxMFpbZ3l2eUCpcwcEonIrr
	 Uk4pFi7WYFYYw==
Date: Fri, 21 Feb 2025 09:51:35 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Jessica Clarke <jrtc27@jrtc27.com>
Subject: Re: [PATCH v6 05/10] dt-bindings: arm-pmu: Add support for ARM
 Rainier PMU
Message-ID: <20250221-bipedal-cobalt-eagle-d31ac3@krzk-bin>
References: <20250220180427.3382482-1-vincenzo.frascino@arm.com>
 <20250220180427.3382482-6-vincenzo.frascino@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250220180427.3382482-6-vincenzo.frascino@arm.com>

On Thu, Feb 20, 2025 at 06:04:23PM +0000, Vincenzo Frascino wrote:
> Add support for the ARM Rainier CPU core PMU.
> 
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  Documentation/devicetree/bindings/arm/pmu.yaml | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


