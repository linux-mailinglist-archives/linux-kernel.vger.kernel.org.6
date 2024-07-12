Return-Path: <linux-kernel+bounces-251092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE94930083
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 20:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4CA1C2122E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EED71DA21;
	Fri, 12 Jul 2024 18:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HK4+iWcw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7B817BBF;
	Fri, 12 Jul 2024 18:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720809564; cv=none; b=S28Gvv1xwIS0xNkTqLq/lARKiK0bTsK7yDzmasrXq8tGVsN+oft48U7P5w0udeQNQqF6ZxWcwBmtc3hBTkGTQWxqfyTUNDV7V/5PPjzAUDLErFC3UDmfNsFK0uE3AU2FJwHfWU8DUHt9Qd1NWJ4uJcSvvT84lTIVCXtUwLITs38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720809564; c=relaxed/simple;
	bh=uAtuGSq/imfAYFWMSqAI9v13fXsZh3z6n7NkYOD+u1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZT2vVTRN+oACcW/jxKrugBwvQTw4JuwlkH8fEmAr6rE1WqNHMwz9oRZXFXroF8a6NRDFNBADG6pPuNsMYo613zt5p1rEVw5Q8u0P0OVqOGd6iZ6bqMxbhvIORra3TsmANUeKMoW6GbBodlIUjBLNk/O7Xs70Hj/N+5PEFALElZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HK4+iWcw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5A8C4AF07;
	Fri, 12 Jul 2024 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720809564;
	bh=uAtuGSq/imfAYFWMSqAI9v13fXsZh3z6n7NkYOD+u1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HK4+iWcwd6JRKIuUO1eYdYnpFGqrSAVCPqsjEFPut3mM5J1czVbzH+ioV8gdSTiIy
	 OimjGcmdW4TFlDXY4lQ9VxqO6NPeiD60AC5aucfI/liCqZLy+Lqta5pkVVeb+VtAE6
	 umYgY6GazodpWSeAr3xlRHC3gzkQfc8SR7xH7XSVo+wxL/q5q7HnRFfo9zUIP/Nf/+
	 DDj4zKAxkE2wYlcNwqFfFvF/VSYQ+FcHx2LOPY04QXyEMMiSE84OrnfoLwq2WSaFCY
	 v4E5keub1ZbSpocRR1fKr6SADmg/d9FRdfheYHxj2mIHNz8v51BQXDuIjsy7Lod3D8
	 EazO5anKG0RAw==
Date: Fri, 12 Jul 2024 12:39:22 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marek Vasut <marex@denx.de>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: incomplete-devices: document devices
 without bindings
Message-ID: <172080781462.1404657.13880263626115458163.robh@kernel.org>
References: <20240712121146.90942-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712121146.90942-1-krzysztof.kozlowski@linaro.org>


On Fri, 12 Jul 2024 14:11:46 +0200, Krzysztof Kozlowski wrote:
> There are devices in the wild with non-updatable firmware coming with
> ACPI tables with rejected compatibles, e.g. "ltr,ltrf216a".  Linux
> kernel still supports this device via ACPI PRP0001, however the
> compatible was never accepted to bindings.
> 
> There are also several early PowerPC or SPARC platforms using
> compatibles for their OpenFirmware, but without in-tree DTS.  Often the
> legacy compatible is not correct in terms of current Devicetree
> specification, e.g. missing vendor prefix.
> 
> Finally there are also Linux-specific tools and test code with
> compatibles.
> 
> Add a schema covering above cases purely to satisfy the DT schema and
> scripts/checkpatch.pl checks for undocumented compatibles.  For
> ltr,ltrf216a this also documents the consensus: compatible is allowed
> only via ACPI PRP0001, but not bindings.
> 
> Link: https://lore.kernel.org/all/20240705095047.90558-1-marex@denx.de/
> Link: https://lore.kernel.org/lkml/20220731173446.7400bfa8@jic23-huawei/T/#me55be502302d70424a85368c2645c89f860b7b40
> Cc: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Sebastian Reichel <sebastian.reichel@collabora.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v3:
> 1. Incorrect->Legacy
> 2. Drop ohci-littledian
> 3. Drop unittest
> 
> Changes in v2:
> 1. Rename to incomplete-devices.yaml
> 2. Add many compatibles based on Rob's feedback, rewrite descriptions in
>    the schema.
> ---
>  .../bindings/incomplete-devices.yaml          | 137 ++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/incomplete-devices.yaml
> 

Applied, thanks!


