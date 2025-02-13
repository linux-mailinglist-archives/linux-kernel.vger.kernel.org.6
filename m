Return-Path: <linux-kernel+bounces-513679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EFB7A34D55
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3A5163799
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB88245017;
	Thu, 13 Feb 2025 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwMa+Q92"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C31C24292F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739470622; cv=none; b=i99FLkR5cLThAfF6zqMwoKeJVBEC+a9frT0rtGVA/E8/EGxpqq7yp0A4nvT0XSdHAF5aporieRXKXr6H2EiWxezMXyod9AY8hmCQ26QxxdfOHjf2Ym+bFB/o/EHKv5acwMuSBM2GIdg7SIyvpwEYJ8oVVcCzAQKb1A3Nuvupiv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739470622; c=relaxed/simple;
	bh=X0tuFPSSvJzxU+wZ2FKDaowZmVGUnx3nAlQffQt0rM8=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JPpuTb2S3n3XF7qIyRwIarbRxs1f9I6PSbNSOtMQsYzPhClH77gaazjGWNw1ZP0fyIxIeREJRAXKBOzs9nAFOZZlmweUfpD1xPa4fpEhdZKIboKRZSqB8CyAjG/rnBBswr6lUs60Tam4cEl1bvjgaVx1P9/Hv2cW32eWpLGDW/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwMa+Q92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD530C4CEE4;
	Thu, 13 Feb 2025 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739470622;
	bh=X0tuFPSSvJzxU+wZ2FKDaowZmVGUnx3nAlQffQt0rM8=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=iwMa+Q92QMTk7s31jZAyZg2gtnxmb2Y6zinOhcjqOtHE26bvHTU8Vn7aE4feGe53B
	 9ZvJ8pkFvXEaqDclLL0gmrqIIvOJWkOG2k5YqskYa/QX7RQ7xuGYBWpjChWuP/fX1a
	 Gx+tndumEyTSE1gwq2Xj8PwhXUdNthD/U3s70tARLtA1t3MOP+ZX06r+pDfFfv27Sx
	 k4pozEB0Ua5iWao8sv+dEagOwLeHTNBoA/IxUWbnhe9sKUDsT1LfMokJAPWNASme9o
	 iL5RfK/AbWxzh4Mi9gfsB/JtP8VPnnb8ynCF48jYFTC985SU0yuAnrTVC4aYY8SFWi
	 ryF57InQ/neBw==
From: Vinod Koul <vkoul@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250111185407.183855-1-krzysztof.kozlowski@linaro.org>
References: <20250111185407.183855-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] phy: stih407-usb: Use
 syscon_regmap_lookup_by_phandle_args
Message-Id: <173947062030.294083.9746743441329264653.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 23:47:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 11 Jan 2025 19:54:07 +0100, Krzysztof Kozlowski wrote:
> Use syscon_regmap_lookup_by_phandle_args() which is a wrapper over
> syscon_regmap_lookup_by_phandle() combined with getting the syscon
> argument.  Except simpler code this annotates within one line that given
> phandle has arguments, so grepping for code would be easier.
> 
> There is also no real benefit in printing errors on missing syscon
> argument, because this is done just too late: runtime check on
> static/build-time data.  Dtschema and Devicetree bindings offer the
> static/build-time check for this already.
> 
> [...]

Applied, thanks!

[1/1] phy: stih407-usb: Use syscon_regmap_lookup_by_phandle_args
      commit: 13c1eb1b4bd169f820188c62acaa1f96677284b1

Best regards,
-- 
~Vinod



