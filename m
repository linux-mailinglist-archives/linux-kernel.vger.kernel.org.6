Return-Path: <linux-kernel+bounces-556843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E13CA5CF60
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 493A917241E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3272C264615;
	Tue, 11 Mar 2025 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEmzdN5H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7962641F5;
	Tue, 11 Mar 2025 19:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721341; cv=none; b=Cala7nNCSvgGoxGQ3WuMZP56+LYdlK07nQvtkodTp6L6tJ5SfueOP1jjStJ36VBpdKI49e9DZaDgyu2S3rL4j5l/li9Il417BLowropwJhXZWqpMKi7QWLhol6QFw92OPsvhK9djqlyP/cPGsiA7XJ7+tWfdv2EtSH5FdqJCgcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721341; c=relaxed/simple;
	bh=rnZvifO8Lr86AKQ53zV9O+jmy9mpPl//7AxgH0/4mzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jo6rYu2DvdPXkBCrvZWI53S3J4jgZ3rYdyhYGcuqqDwlVkD9z0bh4pRaM3TEE1wsZWezI+p9bjih1dXyjcinefJ1RX44lHDbXMxJoU/9eMEApn42iy6KgSX+peR9HZh+0KXjL5OwMydDxE1hB7LYlyH7pNUi3iuk589RBXBm34o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEmzdN5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A650AC4CEE9;
	Tue, 11 Mar 2025 19:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741721341;
	bh=rnZvifO8Lr86AKQ53zV9O+jmy9mpPl//7AxgH0/4mzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEmzdN5HT3sz3xDVmsbaOTbGrOIgc0maGqaMTrqrjgju+1K/gWeUVPzHyN0MKGN9D
	 ySidgE6YKyK8qYNSaRAHJZaHJEOmD2F7UWZK2o4Au3/eRSP71Ydb1P+WAX4vQPc+cY
	 g40g73j9zytqbqX8Y+LXQ5+kgegmTvWMUspAUg2CR3HzZMzP6LyP0S4Ipgj4LQhMcQ
	 sRX1cBHggK6sWvX1HHr6Y+E+AK+lQXlYnCSdR6k1mtd54VmyXZbx4gYoJ/NwwuUTVt
	 vay3VHdk1jG2YYKDgfT0nJOWAYmd8gjfLtMc5Ly4ezzjXNHW4bTkEVFA6OECS+53WU
	 AmQylG3JNqAWQ==
Date: Tue, 11 Mar 2025 14:28:59 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	linux-amlogic@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/6] ASoC: dt-bindings: meson: axg-fifo: claim support
 of A1 SoC family
Message-ID: <174172133877.4178691.16143200124324981216.robh@kernel.org>
References: <20250309182127.1322890-1-jan.dakinevich@salutedevices.com>
 <20250309182127.1322890-3-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309182127.1322890-3-jan.dakinevich@salutedevices.com>


On Sun, 09 Mar 2025 21:21:23 +0300, Jan Dakinevich wrote:
> Add "amlogic,a1-toddr" and "amlogic,a1-frddr" compatible string aliases
> to "amlogic,sm1-toddr" and "amlogic,sm1-frddr" respectevely.
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  .../devicetree/bindings/sound/amlogic,axg-fifo.yaml       | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


