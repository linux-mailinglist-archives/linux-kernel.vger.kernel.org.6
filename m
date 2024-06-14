Return-Path: <linux-kernel+bounces-214665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B2E9087E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA93D1F2827D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F11192B98;
	Fri, 14 Jun 2024 09:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmqhawaF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02100192B67;
	Fri, 14 Jun 2024 09:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718358336; cv=none; b=Osu3gZzb54Gf9gGoNVe3s4VXbQmY0G+a+93P1V5+dmbtDl4ia22H3IGa58zjMpt5o1RWrVcm1/84dWf/4iRChSlQ6eYgNJA+Byp/V/KlOAloV9U9aTtOEuU7DuF3X+V6xg34f92kfs9bVJUJTmhetJLNneyxE7NzKC9jJ3hDOyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718358336; c=relaxed/simple;
	bh=ma8GU7MHPypBW4O1GGpVS7tnrPMOY44CBhzQ/ShJm00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRvjSkmccnBl2EIAkXJOVsrjI6eXzdHtrEUopx1mRwYbr2EFfxn3xMss91GjiJsXBtq95nDqS8yxxt1RQDy9fmoM9w4q4sGOCopo7RTzdFViXN5IVG0l/cvylWeJ3LuV5lr8VVqrVxHAWAl95sGQI/bzhXIoNJ4a1tBAyJFuSng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmqhawaF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F51C2BD10;
	Fri, 14 Jun 2024 09:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718358335;
	bh=ma8GU7MHPypBW4O1GGpVS7tnrPMOY44CBhzQ/ShJm00=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DmqhawaF8hH3fMHweuXSH5Z7wBj0mri5fvtDTBpxZta6I8pgnQWpZjJglqRagwahD
	 aSXmRKsOm9j4/MeM3KBsAUqCsFxPD3ONGFm4LOBq4vHGFJotGs292Gqdalo/XJIbEX
	 P/OHioukBq4v5D4qHO0OkyrPU1kokOpV5sqg2nklMZXH4MJ8XFDk1vWiKU0MzNFK2O
	 gYJ+9w4Z6l2LwSEDjcj1nM4hwNKdnNCUNYWACtkgXVpbWu5uewUpEmPfQj1YbS1eYt
	 c/WsDqjZi0RnR8AhIfU/x82hdX1DpJN7AERMtFfsf/lNBPd1gD4M2kit+vt/DI6lVQ
	 JO9FgGHaInKDw==
Message-ID: <de9764bf-ab00-4380-90ad-f137e2fbf5c3@kernel.org>
Date: Fri, 14 Jun 2024 12:45:29 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] arm64: dts: ti: am62p: Rename am62p-{}.dtsi to
 am62p-j722s-common-{}.dtsi
To: Siddharth Vadapalli <s-vadapalli@ti.com>, nm@ti.com, vigneshr@ti.com,
 afd@ti.com, kristo@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, u-kumar1@ti.com, danishanwar@ti.com,
 srk@ti.com
References: <20240612132409.2477888-1-s-vadapalli@ti.com>
 <20240612132409.2477888-2-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240612132409.2477888-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/06/2024 16:24, Siddharth Vadapalli wrote:
> The AM62P and J722S SoCs share most of the peripherals. With the aim of
> reusing the existing k3-am62p-{mcu,main,thermal,wakeup}.dtsi files for
> J722S SoC, rename them to indicate that they are shared with the J722S SoC.
> 
> The peripherals that are not shared will be moved in the upcoming patches
> to the respective k3-{soc}-{mcu,main,wakeup}.dtsi files without "common" in
> the filename, emphasizing that they are not shared.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Acked-by: Andrew Davis <afd@ti.com>

Acked-by: Roger Quadros <rogerq@kernel.org>

