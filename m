Return-Path: <linux-kernel+bounces-537886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398D3A4921A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 695C916BF16
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 07:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3A51C701D;
	Fri, 28 Feb 2025 07:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E26xzOUZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04E276D12;
	Fri, 28 Feb 2025 07:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727423; cv=none; b=ILrZg73MsuzBn1gh46e0LAWFzwQGfKl7F/RL9gQDcMiilKU5ouddQvtYozEFyGUoD20Y+aWdoDUTjI4s8gSSQaDIn7DXKH4+5NrVT9jzpvG9vGH8aMi9XTY2cvoXbFQ/eI8soHRKEldmCvGObdOcf6u/Esuj1CeomNdzGGM2z8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727423; c=relaxed/simple;
	bh=uITozB3t5RbjP4wjORLIFy/Pq+qHbI4vAfez1H/n5jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NH9YXPL3UrfnxeEvEsbTUm2iVeFpsZrQpaMKRNBOUy5lp6/4z+D5ujHjKWoiRMCnnm3UhZGGNYBWEdKi9Lvlolkv52CEGW9L1TF+wICYAPUCdaQh95aeG0DfdzhQgkxCUuikBj0D+gbcC83Jq1ND0vNCod6aTg95Tg0fkpyOZYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E26xzOUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54E7C4CED6;
	Fri, 28 Feb 2025 07:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740727422;
	bh=uITozB3t5RbjP4wjORLIFy/Pq+qHbI4vAfez1H/n5jo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E26xzOUZRtMyr8btqRB+0o8ftdVUUy3bD/84Zy0yZ11+/ZP+RGcicEE+kKRjrLVpy
	 5Iae0586G5aM0EozTcBtk2hqXb7giI+PBU6G7ueptjFkZWFzH3W1POq64LDvDEpqX4
	 4jtFNbJqT7oxAPnvl/ojyWPJEGL15wI72QN5FXXRpA07eFI2v1I2tcn1w52hkN3B79
	 8DXZ/tdndbWo/Amq273erVVhZbRpj18bTAk3hhLyyBOe2lHzMLwChm57QXRwCuxz1M
	 47a2yW0RKTdo4nTr2XCg+6XH05FI7IzG5zYUUreobdQ/kV15V+EcxJq5JKNXyo83d7
	 GTOxqlm4VCBCw==
Date: Fri, 28 Feb 2025 08:23:36 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Peter Chen <peter.chen@cixtech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	cix-kernel-upstream@cixtech.com, marcin@juszkiewicz.com.pl, Fugang Duan <fugang.duan@cixtech.com>
Subject: Re: [PATCH v3 5/6] arm64: defconfig: Enable CIX SoC
Message-ID: <20250228-piquant-spry-ibex-7efbe4@krzk-bin>
References: <20250227120619.1741431-1-peter.chen@cixtech.com>
 <20250227120619.1741431-6-peter.chen@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250227120619.1741431-6-peter.chen@cixtech.com>

On Thu, Feb 27, 2025 at 08:06:18PM +0800, Peter Chen wrote:
> Enable CIX SoC support at ARM64 defconfig
> 
> Acked-by: Fugang Duan <fugang.duan@cixtech.com>
> Signed-off-by: Peter Chen <peter.chen@cixtech.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


