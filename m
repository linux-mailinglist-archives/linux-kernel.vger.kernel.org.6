Return-Path: <linux-kernel+bounces-541242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7799AA4BA62
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4ED7188FF84
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DDC1F0E38;
	Mon,  3 Mar 2025 09:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJlE35KW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D911F09AF;
	Mon,  3 Mar 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993011; cv=none; b=PPYfgTQZMwzNm66rh88PzMHSmiUU1Tos1scHbiuuumoP75tG8nCDMAda27RuwzwIMZOynRx9MyncprGcnAOZWTK3RSVjZvakj06sYUj5nt8klFy/x6SH31/kANrYfMmiDdmtehj4GJeoZxb0TdfuysS9XOBqGpmqt68uDFPAM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993011; c=relaxed/simple;
	bh=mvjdZ/lyYpcBwKzTyiQtkMPeVbqIUESnYCo6v1Aq9L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltGwlT/R59HIWY2nz59+xog+0sMZItgYAGmHEvx/fexX0Qi5DT822jwBjRyKy1cgtPQNEB9JKnmTsItjax6anLqCS/7fcWSlBMOAqll9nGbkBD2BNajsegPWmnyDL1bYxPRqukdbEDwIC9Oqqp53RCLT5UtdivklMhjwqgxgkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJlE35KW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F5AC4CEE6;
	Mon,  3 Mar 2025 09:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740993010;
	bh=mvjdZ/lyYpcBwKzTyiQtkMPeVbqIUESnYCo6v1Aq9L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VJlE35KWKjYZmVR/CVYIZKbpZrEhSJtm7b6fxU3ZR2zcuuBmCm3WOS/I2B7+4EdOV
	 itvbrXAA4Vps9IyIw4hQyJnks8ds+AUtj7j5h0RA2sBxQYTI8flghhW/ZcJoAZQiad
	 Say6aRig0JR05SlooVdhcYQmTZpAXcbtUUe14xe8FzMJPcDM0jK2qzgwr6l9YvWZ5L
	 nBIdwYxeKSZzl7+E1xZFiaL1z78ZLfwYdXIWg0YftCYJ5XkxOeg7IQMaIaFk1Qcpjy
	 N4XPhJ2wt6TS2FdHvVdhdxR9RV3rrQX3K8t74vPHqVMcYxlf809lbQZjAuY4LDATWc
	 LUUJEo3dkt+vg==
Date: Mon, 3 Mar 2025 10:10:06 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] regulator: dt-bindings: add documentation for
 s2mpu05-pmic regulators
Message-ID: <20250303-archetypal-holistic-elephant-30cb3c@krzk-bin>
References: <20250301-exynos7870-pmic-regulators-v3-0-808d0b47a564@disroot.org>
 <20250301-exynos7870-pmic-regulators-v3-1-808d0b47a564@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250301-exynos7870-pmic-regulators-v3-1-808d0b47a564@disroot.org>

On Sat, Mar 01, 2025 at 01:07:12AM +0530, Kaustabh Chakraborty wrote:
> S2MPU05 is a PMIC found in Exynos7870 devices, which controls voltage
> regulators (21 LDOs and 5 BUCKs). Provide documentation for devicetree
> definitions, regulator naming patterns, etc.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
>  .../bindings/regulator/samsung,s2mpu05.yaml        | 47 ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


