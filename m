Return-Path: <linux-kernel+bounces-354100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E3E9937C8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 21:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63BB71F22C38
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 19:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062141DE3A0;
	Mon,  7 Oct 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzqYqRe8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D01DE2B5;
	Mon,  7 Oct 2024 19:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728331140; cv=none; b=Z5Km+PJqAftewqSPpxTlXp7ZSp3/QTOsyXm1O3R03O95ft3kln9ilBeasrMySrVkESC4CV9+mSv+fROGDu4TVG2EEdLWbwWCiwlRJSHJoYwlSW3DC7GBzYAFoE2PNnVLHngRHsBScI98GebalD4y1yw5P422aBhmEiDWHX88YAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728331140; c=relaxed/simple;
	bh=b9IArjcBH73LgeqlXwC/gNJ9v+KsPD1EO11b7+6s/FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj2ShTNc5O5DydGmMXnpFaT0XUqUuHnXMtaMyJyXO8vNUF8gILwMGjJ4HZqZ9KigRBQRUgH7XrHwdwKmJLVu/Ej5Ejhc8rtiPGB/DZoW11P0PP8ttXe+pzmq/8Q5V8fTP6An3bY1FbuJuOMmOLGSEeohqZjkqxa84nWVqPWKW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzqYqRe8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF017C4CEC6;
	Mon,  7 Oct 2024 19:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728331139;
	bh=b9IArjcBH73LgeqlXwC/gNJ9v+KsPD1EO11b7+6s/FE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nzqYqRe820TLi+eUjLITpI7hydsAWt54StmQOxEzUYev5VOo4CogvBBMiyC4k0XD+
	 1Mk4B3wt7lMzB8q0ozAwwxSbfVV67UeyPWJ2qvgi7lHdgj9RS+2vWHR9HFx48MQNYB
	 JT/7VD4LYQbKVklfoOxJIr3Vj0I85tlqW1bUWoOm3F4lUBKN+Dc7o/WiYbsTG653Jn
	 89aHMhUmuD/DuAwsJS48nl1ASt2VoTa3S3422OCFOHlHCwRKkFgt+aUf2pr6lwLuw8
	 vKSEh2LK4rNirzUWg5lvjbQtpmqSh0Ha7XJaurvRVlG7zw1ZHW5zqjmHRKTkHQL74n
	 RKP1wmsTLgwUA==
Date: Mon, 7 Oct 2024 14:58:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-amlogic@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: mmc: controller: move properties
 common with slot out to mmc-controller-common
Message-ID: <172833113823.2300723.18105672975796037901.robh@kernel.org>
References: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-0-ad4eb22c2a8d@linaro.org>
 <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-1-ad4eb22c2a8d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v3-1-ad4eb22c2a8d@linaro.org>


On Mon, 07 Oct 2024 16:03:37 +0200, Neil Armstrong wrote:
> Move the common MMC "slot" properties because they are shared by the
> single-slot or multi-slot controllers, and will help defining a simple
> mmc-slot bindings document with proper slot properties and nodename.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/mmc/mmc-controller-common.yaml        | 357 +++++++++++++++++++++
>  .../devicetree/bindings/mmc/mmc-controller.yaml    | 344 +-------------------
>  2 files changed, 360 insertions(+), 341 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


