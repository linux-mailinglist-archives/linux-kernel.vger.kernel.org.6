Return-Path: <linux-kernel+bounces-354103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2C99937D1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 22:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CFB1C23567
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 20:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F401DE890;
	Mon,  7 Oct 2024 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTEJZphu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98731DE4ED;
	Mon,  7 Oct 2024 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331172; cv=none; b=ib/PsECqNEtdSOY/KtXJ0fR1CNyGGA7Bs4e1RTUI5xjJRWFfds+3wp7/XiwIDc+RiipGbxtHhf7oSWZ6sO70UUkrSE/Uq7O5UF5WmWFuFIOyvIoKxebxZ40XUMbCwQ50Mqw+AgPUnfeE55WhjE8Wdx2QEgK62bC9OQifrbqQnRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331172; c=relaxed/simple;
	bh=kuatBlysKSTgiUPXupQbaL2UIbwsfXdXsP0rFDt7UPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KppuJFh1clJqWCZz9FbhVWqYq0M3YSdEabxYPTcxaYg1Ef8SySCWmK3Tdh4+8Vr+OFtWH+Bpm+nDx2oIN/iEZrgqa/Bd0xXJhdfRYHuws9H8W4e+A2TDwASej51B5oJY/Efaxf3f+Sp59mhbH4NHi7qCxLVsMYnc48qYBNxSsms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTEJZphu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF4FC4CEC6;
	Mon,  7 Oct 2024 19:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728331171;
	bh=kuatBlysKSTgiUPXupQbaL2UIbwsfXdXsP0rFDt7UPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QTEJZphuxmsydfB+jMpN/fSoDqJ/sGcLd+qex+rn6BZS2me2A2pDhGbkC87gXuBUG
	 GafHKW9rLKRH3GHjUllfm5iZe32b6SZDGT2OuFlTnoWyYaTvfm7FTbdnOkkkhp1WMn
	 pEvrZxeuBeH1Wtuo5a7owTVyUQV9HcjsSlHn89JZPJhLvMc7Pr8qUL9YTJ+oKYaXGT
	 +uTC0kiIGdMFzR1Z7nyaq5bVl1pzFSy5paRtHhKJ9k2Tc2Ly28/OcPIvhOid/Yu5of
	 5LkfqcrWx6zr7k0VAoECHqpiCeV63CfGUKfTCZrUYSHr4SBZitTkaYy539SQxd9Pb/
	 BhlyESjJp6DiQ==
Date: Mon, 7 Oct 2024 14:59:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: document mmc-slot
Message-ID: <172833117019.2301548.16704641563450010551.robh@kernel.org>
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
 <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-2-ad4eb22c2a8d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-2-ad4eb22c2a8d@linaro.org>


On Mon, 07 Oct 2024 16:03:38 +0200, Neil Armstrong wrote:
> Document the mmc-slot, which is a subnode of a multi-slot
> MMC controller, each slot is represented as a full MMC controller,
> the top node handling all the shared resources and slot mux.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/mmc/mmc-slot.yaml          | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


