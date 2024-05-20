Return-Path: <linux-kernel+bounces-183663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C6D8C9C36
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 13:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501181C21E2B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 11:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B946453814;
	Mon, 20 May 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="am4X18Cj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E92535D9;
	Mon, 20 May 2024 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205199; cv=none; b=s3aii4+LtsYTDkxqwBeUcMSLErNiDiruZqCMm96QoVhTq2dR5DodU2OBjHvwq70nv0LWOwylLlwKOlqxnS9SQP6to0JpvJ6x6IODVF/RiamrgP59OsH8HijzVYG+nD5zW77pa52BR+OwYHrwAQ5FkrYxiT2HynrN89hjrcBqUeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205199; c=relaxed/simple;
	bh=8ZOc/2OFeOb0rPY6xFAdRugK8JAahDDQDL+694CbXp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rNx04W77Q3A99nvhUL7FbuIgdsQzYNo5Pxt43+GdNtd/1Jn0IVG2VxmvihuSr5ecDZTapdCNZRozXbFSjiX6m5lftSBBdww+yPeWudPmN0aZFzrdPMWozeQjy7SIVZ51Ts9Slhy2vTC8AEXAjYSGbpFVqQwPYV3Ln6tA5BMIRkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=am4X18Cj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4695C2BD10;
	Mon, 20 May 2024 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716205198;
	bh=8ZOc/2OFeOb0rPY6xFAdRugK8JAahDDQDL+694CbXp8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=am4X18CjsMmWvGFsurVX/qunsZMqhRSeaCRfN9AcKc0/uwZKAVcwtlCWP6wLKatr8
	 rwR9sgADSNHPAhRfJHlplOlstNMRuuOnPbXVkDVl/e764Oi/KhKr5VDxlGcWjD87Y5
	 mRdZ/GHyxbSOoPSeJubQ+txF0REw501N8qWO1+VIlKZ0WNGQqJVPRmznn1x7957tQ8
	 4MikbSA0ERkf9OCt/OdLcZuc5NtjycAxYOMfbxsAlproG23cIG5uBAWgd53tsY2/lN
	 jeVD31RZSt17zmCVGxbjucsE6Hqdofygja39i6cM2G/pivr3VzPiWADmpibPZRQj2h
	 0V+OBINHIl0UQ==
Message-ID: <5c6a018a-ba9e-41f5-aafc-5a08cd1c92e9@kernel.org>
Date: Mon, 20 May 2024 14:39:52 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] arm64: dts: ti: k3-am62: add dedicated wakeup
 controller compatible
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240518-dt-bindings-ti-soc-mfd-v1-0-b3952f104c9a@linaro.org>
 <20240518-dt-bindings-ti-soc-mfd-v1-3-b3952f104c9a@linaro.org>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240518-dt-bindings-ti-soc-mfd-v1-3-b3952f104c9a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 18/05/2024 23:07, Krzysztof Kozlowski wrote:
> Each syscon node must come with a dedicated/specific compatible, which
> is also reported by dtbs_check:
> 
>   k3-am62-lp-sk.dtb: syscon@43000000: compatible: ['syscon', 'simple-mfd'] is too short
> 
> Add one for the TI K3 AM62 wakeup system controller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

-- 
cheers,
-roger

