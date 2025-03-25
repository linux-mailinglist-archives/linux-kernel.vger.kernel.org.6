Return-Path: <linux-kernel+bounces-574693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AA9A6E896
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 04:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3486D171BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 03:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23961A2396;
	Tue, 25 Mar 2025 03:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAuTXIvI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EF24A18;
	Tue, 25 Mar 2025 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742872530; cv=none; b=UQ1NS9eJMnC5ZTN4wofjdKq+19I5d5XaeOWd7V5CLRRN0YOkkwZvGN6cKVmiCQepv/efDLGbmImVsA1SX/0G5J4tYECNHKZ/UXk4MuiKq79gDT7kZHhrbe1OUJsN5dYCOSW1V/NOyOF4BXdf4gBCy4MGeBWH+U8Aoc83PJC1cAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742872530; c=relaxed/simple;
	bh=gw0zXpVnD3erYQ89dc+5pAItrKsvx4FcMNB84KmYZZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnGBTRiWo6qsPeNPq4FgAGomGJbWv1nyWC9YHKiiZJB/NQ+KurRXRsYUAojIJYnjjzjWvXlXFnHbsCXuviKuKHjDF/EWRvfu23QGcNRLQ+eyAm52H2pOZExYxJbRqpg3f/lkKDU3Lb04oSR8auo6oPiZkCXQ4anBp8BoLmvkJhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAuTXIvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0A7C4CEDD;
	Tue, 25 Mar 2025 03:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742872529;
	bh=gw0zXpVnD3erYQ89dc+5pAItrKsvx4FcMNB84KmYZZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAuTXIvIhjqWi35A/SY2gBoRtuX5GipQDCs0VsLqOr/f/r8dsi6tmxHHn5IjjltdQ
	 hnOgUOWSX6kWh+n9MGJYH4Lwn9HeBsoAfwtAaqlZ7iFPGiOm+eOEwn+9HGQoLmbvow
	 kTnauol1kNRbIMtA+Zqaq1ivSI4sgrdJKK8yTJ9LAysEVTTkVz4yEu8ERCzpLuV9F0
	 txzkCaE94sNpswfqCwbNCnPXdAXZeltcuXR7SvWKd7Yn8zsWsJ5GJI2oh7vAd5YuGe
	 YMNpc+C5JeCrxC7w82fnV6qOXWAhPKEeSp5Ay7+Zb7y8J8yQf9kPAjWw4l8sgrRLNN
	 EaZXg67EFcgyg==
Date: Mon, 24 Mar 2025 22:15:28 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-sound@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Ryan Lee <ryans.lee@maximintegrated.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: maxim,max98925: Fix include placement
 in DTS example
Message-ID: <174287252819.1621730.12822338179414998311.robh@kernel.org>
References: <20250324125131.81867-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324125131.81867-1-krzysztof.kozlowski@linaro.org>


On Mon, 24 Mar 2025 13:51:31 +0100, Krzysztof Kozlowski wrote:
> Coding style and common logic dictates that headers should not be
> included in device nodes.  No functional impact.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/maxim,max98925.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


