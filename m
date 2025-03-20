Return-Path: <linux-kernel+bounces-569341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D96FCA6A1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A33B5180000
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5B121D59B;
	Thu, 20 Mar 2025 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dz5FSb8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C51519BE;
	Thu, 20 Mar 2025 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742460210; cv=none; b=YHwZBRvdbuUwUkuTAZ/vh1KHp+PXBJsOBJB3sqa7Ia118d99OQJjzFXwpqrUbnLxv9eywZSBAPGW9qx+derJ5uTPw/jzp0drvTYHYUUbAjP7HgAgEcvA5wdqTi0InXFCKOkwxTfhjd9CgV6a4NcYEwPhpqhz+uoMPfQSAmJOOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742460210; c=relaxed/simple;
	bh=++ufMctDs5fNv0l9AGYckpDf5fUM9DVkKKr3peSlS7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ak/TWECdGWsK/3kr/CiRkxfBqnVDpAJoHO4fITxGkZ0RRRT6yO6uOdsIes5afDtHH3f/y5na+Qg2C7Orlr/DPBuBCw770mAuueyQOofQsaGY0DP/AYeUFXbaTCZ6NaXHM+HVj5uxNSlpHWG1F38ZSB40LtKpvvUdWneA1Jl1ki4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dz5FSb8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CB2C4CEEC;
	Thu, 20 Mar 2025 08:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742460209;
	bh=++ufMctDs5fNv0l9AGYckpDf5fUM9DVkKKr3peSlS7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dz5FSb8W7/Bp64JHqa+HpEpsHm/PogrI99GQB1HCh2qK8arY1nNZtjn2O0bdks16w
	 AuLvlCTtPaRQ2YtNe/x4xaS09BSw3KEribOX5tcFfNJfhJPxvZNwh/GJ/1oiUC8fPz
	 taXcGsNJSN9eYvsdDvW4dExOJTVrTWbcfQjfuGEjuL6Hr9nUA2jJdujDz83d5uU6Ch
	 ju43SjIL5QbXNIw76iQ2SuQ396UoZsdlP00lsREGuyx+RJKEq/0E4kSCxKaBhorxRr
	 3qAiv3bxkBK5At8NOTAHoPcH4pSA0wI6WqIF/20CN+JG4Szl4MBOlpNFpFqyG+o6MN
	 eL3fG1zUssGdA==
Date: Thu, 20 Mar 2025 09:43:25 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, patches@opensource.cirrus.com, 
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v4 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <20250320-lyrical-jaybird-of-security-f5ffd8@krzk-bin>
References: <20250319142059.46692-1-francesco@dolcini.it>
 <20250319142059.46692-4-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250319142059.46692-4-francesco@dolcini.it>

On Wed, Mar 19, 2025 at 03:20:57PM +0100, Francesco Dolcini wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Add two properties to select the IN1L/DMICDAT1 and IN2R/DMICDAT2
> functionality:
> - wlf,in1l-as-dmicdat1
> - wlf,in1r-as-dmicdat2
> 
> Add a property to describe the GPIO configuration registers, that can be
> used to set the four multifunction pins:
> - wlf,gpio-cfg
> 
> Add a property to describe the mic bias control registers:
> - wlf,micbias-cfg
> 
> Add two properties to describe the Dynamic Range Controller (DRC),
> allowing multiple named configurations where each config sets the 4 DRC
> registers (R40-R43):
> - wlf,drc-cfg-regs
> - wlf,drc-cfg-names

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


