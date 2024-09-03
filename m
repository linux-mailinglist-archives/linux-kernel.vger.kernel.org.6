Return-Path: <linux-kernel+bounces-313163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B3096A137
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A99F1C23DD5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D917E155A47;
	Tue,  3 Sep 2024 14:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/hkWJic"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457682C6A3;
	Tue,  3 Sep 2024 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725375169; cv=none; b=MzQFDIeYaWwEtEnQxqFk6oOSvx4553/5EVc4wxTz4MqSwxmURfpAuUgmOq8lXGrgoD+DEWsUNls1kJPPUCaekSUNlQxMw7/jOQeMYTYW4ulBk4g7bLDLc3bvvU5oGGS4zKMhk4QsLib+PYxFLg82ylI1LNpWiIYF7E73x0/DVR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725375169; c=relaxed/simple;
	bh=r82WX5U3SVE11HWz1+1arg0msM0j6AfzMYQI/uAjjuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9MJVBcl5Kix+JyvV2iuMIWVCK7FK8Ug67iHHqv5aV54iG8GRIgb2gG4qD/mE+y0pq5WIasxEWI4/jnEHaqUAknBpLfB4BtrqpxgQNxXnwGf4zUNOKCdinUDlyzBytxkF8YjTWIvnVCRpOzGhf0Gb02Dauy9lnULS49phG9bYSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/hkWJic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87521C4CEC4;
	Tue,  3 Sep 2024 14:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725375168;
	bh=r82WX5U3SVE11HWz1+1arg0msM0j6AfzMYQI/uAjjuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G/hkWJiclG+CQTE+Kqwlpl+0RqKjlpnd7PZi8TZl1T7kz2yVllunOAVk+JdPKA37q
	 Y9x7wZ0thIbOKI16qn/8abaHCGEL35SxqNqhqJTeScZNby3s0htEXrqwaawbCRHzlS
	 iuy24U9g2Acl11Ep8gAc/rpo3oY1rsi4aiBlu7ApaYZd9A9qxcEb9BIDO3bTaXOESY
	 diUKMvy30PMbDSl1UWlhXySjpvDD52flG/RjqubuU1SdEkDMR/rIIRiWkOcKDOfJm8
	 /c+BU64CydMau32uh1UREh2O0zvYGCl2j4ipf6BPfxlV2JB8CC1q5iRdiU0TiOZ+rB
	 4YARsO8pp2Inw==
Date: Tue, 3 Sep 2024 09:52:47 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: linux-phy@lists.infradead.org, vkoul@kernel.org,
	fabrice.gasnier@foss.st.com, devicetree@vger.kernel.org,
	kishon@kernel.org, p.zabel@pengutronix.de, conor+dt@kernel.org,
	linux-kernel@vger.kernel.org, mcoquelin.stm32@gmail.com,
	linux-arm-kernel@lists.infradead.org, krzk+dt@kernel.org,
	alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 1/5] dt-bindings: phy: Add STM32MP25 COMBOPHY bindings
Message-ID: <172537516622.996858.7295101990196127870.robh@kernel.org>
References: <20240903121303.2953150-1-christian.bruel@foss.st.com>
 <20240903121303.2953150-2-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903121303.2953150-2-christian.bruel@foss.st.com>


On Tue, 03 Sep 2024 14:12:59 +0200, Christian Bruel wrote:
> Document the bindings for STM32 COMBOPHY interface, used to support
> the PCIe and USB3 stm32mp25 drivers.
> Following entries can be used to tune caracterisation parameters
>  - st,output-micro-ohms and st,output-vswing-microvolt bindings entries
> to tune the impedance and voltage swing using discrete simulation results
>  - st,rx-equalizer register to set the internal rx equalizer filter value.
> 
> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  .../bindings/phy/st,stm32mp25-combophy.yaml   | 119 ++++++++++++++++++
>  1 file changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/st,stm32mp25-combophy.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


